use std::collections::HashMap;

use axum::body::Body;
use axum::response::{IntoResponse, Response};
use itertools::Itertools;

use crate::db::{
    Category, CategoryQuery, Event, MainPageCategory, MainPageQuery, ProgramQuery, Puzzle,
    PuzzleId, RankedFullSolve, User, UserId, VariantId, VariantQuery,
};
use crate::error::AppError;
use crate::traits::RequestBody;
use crate::AppState;

use super::global_leaderboard::{
    GlobalLeaderboardQuery, GlobalLeaderboardTable, LeaderboardEvent, LeaderboardTableColumns,
    LeaderboardTableResponse, LeaderboardTableRows, SolveTableRow,
};

#[derive(serde::Deserialize, Debug, Clone)]
pub struct SolverLeaderboardTable {
    pub id: UserId,

    pub event: Option<LeaderboardEvent>,
    pub filters: Option<bool>,
    pub macros: Option<bool>,

    pub variant: Option<VariantQuery>,
    pub program: Option<ProgramQuery>,

    #[serde(default)]
    pub history: bool,
}

impl RequestBody for SolverLeaderboardTable {
    type Response = LeaderboardTableResponse;

    async fn request(
        self,
        state: AppState,
        _user: Option<User>,
    ) -> Result<Self::Response, AppError> {
        let global = GlobalLeaderboardTable {
            event: self.event,
            filters: self.filters,
            macros: self.macros,
            variant: self.variant,
            program: self.program,
        };
        let GlobalLeaderboardQuery::Category(category_query) = global.global_leaderboard_query()
        else {
            return Err(AppError::InvalidQuery("bad category".to_string()));
        };
        let total_solvers: HashMap<MainPageCategory, i64> = state
            .get_all_puzzles_counts(&category_query)
            .await?
            .into_iter()
            .collect();
        // let puzzle = state.get_puzzle(self.id).await?.ok_or(AppError::NotFound)?;

        let solves = state.get_solver_pbs(self.id, &category_query).await?;

        let solve_rows = solves
            .into_iter()
            .sorted_by_key(|(category, _)| *total_solvers.get(category).unwrap_or(&0))
            .map(|(category, RankedFullSolve { rank, solve })| {
                let event = Event {
                    puzzle: solve.puzzle.clone(),
                    category: match &category_query {
                        CategoryQuery::Speed {
                            average,
                            blind,
                            filters,
                            macros,
                            one_handed,
                            variant,
                            program,
                        } => {
                            let default_filters = match &solve.variant {
                                Some(v) => v.primary_filters,
                                None => solve.puzzle.primary_filters,
                            };
                            let default_macros = match &solve.variant {
                                Some(v) => v.primary_macros,
                                None => solve.puzzle.primary_macros,
                            };
                            Category::Speed {
                                average: *average,
                                blind: *blind,
                                filters: filters.unwrap_or(default_filters),
                                macros: macros.unwrap_or(default_macros),
                                one_handed: *one_handed,
                                variant: solve.variant.clone(),
                                material: solve.program.material,
                            }
                        }

                        CategoryQuery::Fmc { computer_assisted } => Category::Fmc {
                            computer_assisted: *computer_assisted,
                        },
                    },
                };
                SolveTableRow::new(&event, &solve, Some(rank), None, &category_query)
            })
            .collect();

        Ok(LeaderboardTableResponse {
            table_rows: LeaderboardTableRows::Solves(solve_rows),

            columns: LeaderboardTableColumns {
                event: true,
                rank: !self.history,
                solver: false,
                record_holder: false,
                speed_cs: matches!(category_query, CategoryQuery::Speed { .. }),
                move_count: matches!(category_query, CategoryQuery::Fmc { .. }),
                date: true,
                program: true,
                total_solvers: false,
                score: false,
            },
        })
    }
}
