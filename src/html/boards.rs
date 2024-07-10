pub use crate::db::solve::{LeaderboardSolve, PuzzleLeaderboard};
use crate::db::user::User;
use crate::error::AppError;
use crate::traits::{RequestBody, RequestResponse};
use crate::AppState;
use axum::response::Html;
use axum::response::IntoResponse;

fn render_time(time_cs: i32) -> String {
    let cs = time_cs % 100;
    let s = (time_cs / 100) % 60;
    let m = (time_cs / (100 * 60)) % 60;
    let h = (time_cs / (100 * 60 * 60)) % 24;
    let d = time_cs / (100 * 60 * 60 * 24);

    if d > 0 {
        format!("{d}:{h:0>2}:{m:0>2}:{s:0>2}.{cs:0>2}")
    } else if h > 0 {
        format!("{h}:{m:0>2}:{s:0>2}.{cs:0>2}")
    } else if m > 0 {
        format!("{m}:{s:0>2}.{cs:0>2}")
    } else {
        format!("{s}.{cs:0>2}")
    }
}

struct PuzzleLeaderboardResponse {
    request: PuzzleLeaderboard,
    name: String,
    solves: Vec<LeaderboardSolve>,
}

impl RequestBody for PuzzleLeaderboard {
    async fn request(
        self,
        state: AppState,
        _user: Option<User>,
    ) -> Result<impl RequestResponse, AppError> {
        let puzzle_name = state
            .get_puzzle(self.id)
            .await?
            .ok_or(AppError::InvalidQuery(format!(
                "Puzzle with id {} does not exist",
                self.id
            )))?
            .name;

        let mut solves = state.get_leaderboard_puzzle(self.clone()).await?;

        solves.sort_by_key(|solve| (solve.speed_cs, solve.upload_time));
        let solves = solves;

        Ok(PuzzleLeaderboardResponse {
            request: self,
            name: puzzle_name,
            solves,
        })
    }
}

impl RequestResponse for PuzzleLeaderboardResponse {
    async fn as_axum_response(self) -> impl IntoResponse {
        let mut name = self.name.clone();
        let mut table_rows = "".to_string();

        if self.request.blind.is_some() {
            name += "🙈";
        }
        if self.request.no_filters.is_none() {
            name += "⚗️";
        }
        if self.request.no_macros.is_none() {
            name += "👾";
        }

        table_rows += &format!(
            "<tr><td>{}</td><td>{}</td><td>{}</td><td>{}</td><td>{}</td></tr>",
            "Rank", "Solver", "Time", "Date", "Program"
        );

        for (n, solve) in self.solves.into_iter().enumerate() {
            let url = format!("/solver?id={}", solve.user_id);
            table_rows += &format!(
                "<tr><td>{}</td><td><a href='{}'>{}</a></td><td>{}</td><td>{}</td><td>{}</td></tr>",
                n + 1,
                url,
                solve.user_html_name(),
                render_time(solve.speed_cs.expect("not null")),
                solve.upload_time.date_naive(),
                solve.abbreviation
            );
        }

        Html(format!(
            include_str!("../../html/puzzle.html"),
            name = name,
            table_rows = table_rows
        ))
    }
}

#[derive(serde::Deserialize)]
pub struct SolverLeaderboard {
    id: i32,
}

struct SolverLeaderboardResponse {
    request: SolverLeaderboard,
    user: User,
    solves: Vec<(LeaderboardSolve, [[Option<i32>; 2]; 2])>,
}

impl RequestBody for SolverLeaderboard {
    async fn request(
        self,
        state: AppState,
        _user: Option<User>,
    ) -> Result<impl RequestResponse, AppError> {
        let user = state
            .get_user(self.id)
            .await?
            .ok_or(AppError::InvalidQuery(format!(
                "Solver with id {} does not exist",
                self.id
            )))?;

        let mut solves = state.get_leaderboard_solver(self.id).await?;

        solves.sort_by_key(|solve| solve.puzzle_name.clone()); // don't need to clone?

        let mut solves_new = vec![];
        for solve in solves {
            let mut ranks = [[None; 2]; 2];
            for uses_filters in [false, true] {
                for uses_macros in [false, true] {
                    if (!solve.uses_filters || uses_filters) && (!solve.uses_macros || uses_macros)
                    {
                        let rank = state
                            .get_rank(
                                solve.puzzle_id,
                                solve.blind,
                                uses_filters,
                                uses_macros,
                                solve.speed_cs.expect("should exist"),
                            )
                            .await?;

                        ranks[uses_filters as usize][uses_macros as usize] = Some(rank);
                    }
                }
            }

            solves_new.push((solve, ranks))
        }

        Ok(SolverLeaderboardResponse {
            request: self,
            user,
            solves: solves_new,
        })
    }
}

impl RequestResponse for SolverLeaderboardResponse {
    async fn as_axum_response(self) -> impl IntoResponse {
        let name = self.user.html_name();
        let mut table_rows = "".to_string();

        table_rows += &format!(
            "<tr><td>{}</td><td>{}</td><td>{}</td><td>{}</td><td>{}</td></tr>",
            "Puzzle", "Rank", "Time", "Date", "Program"
        );

        for (solve, ranks) in self.solves {
            let url = format!(
                "puzzle?id={}{}{}{}",
                solve.leaderboard.expect("not null"),
                if solve.blind { "&blind" } else { "" },
                if !solve.uses_filters {
                    "&no_filters"
                } else {
                    ""
                },
                if !solve.uses_macros { "&no_macros" } else { "" }
            );

            let puzzle_name = format!(
                "{}{}{}{}",
                solve.puzzle_name,
                if solve.blind { "🙈" } else { "" },
                if !solve.uses_filters { "" } else { "⚗️" },
                if !solve.uses_macros { "" } else { "👾" },
            );

            let in_primary_category = (!solve.uses_filters || solve.primary_filters)
                && (!solve.uses_macros || solve.primary_macros);

            let mut rank_strs = vec![];
            for uses_filters in [false, true] {
                for uses_macros in [false, true] {
                    if let Some(rank) = ranks[uses_filters as usize][uses_macros as usize] {
                        rank_strs.push(format!(
                            "{}{}{}",
                            rank,
                            if !uses_filters { "" } else { "⚗️" },
                            if !uses_macros { "" } else { "👾" },
                        ))
                    }
                }
            }

            let display_rank = if in_primary_category {
                ranks[solve.primary_filters as usize][solve.primary_macros as usize]
            } else {
                ranks[solve.uses_filters as usize][solve.uses_macros as usize]
            }
            .expect("must exist");

            table_rows += &format!(
                r#"<tr><td><a href='{}'>{}</td><td><span title="{}">{}{}</span></td><td>{}</td><td>{}</td><td>{}</td></tr>"#,
                url,
                puzzle_name,
                rank_strs.join("   |   "),
                display_rank,
                if in_primary_category { "" } else { "*" },
                render_time(solve.speed_cs.expect("not null")),
                solve.upload_time.date_naive(),
                solve.abbreviation
            );
        }

        Html(format!(
            include_str!("../../html/solver.html"),
            name = name,
            table_rows = table_rows
        ))
    }
}
