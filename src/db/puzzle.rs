use crate::AppState;
use sqlx::query;
use sqlx::query_as;
use std::cmp::Ordering;

#[derive(PartialEq, Clone, Eq, Hash, Debug)]
pub struct Puzzle {
    pub id: i32,
    pub name: String,
    pub primary_flags: PuzzleCategoryFlags,
}

impl AppState {
    pub async fn get_puzzle(&self, id: i32) -> sqlx::Result<Option<Puzzle>> {
        Ok(query!("SELECT * FROM Puzzle WHERE id = $1", id)
            .fetch_optional(&self.pool)
            .await?
            .map(|row| Puzzle {
                id: row.id,
                name: row.name,
                primary_flags: PuzzleCategoryFlags {
                    uses_filters: row.primary_filters,
                    uses_macros: row.primary_macros,
                },
            }))
    }

    pub async fn get_all_puzzles(&self) -> sqlx::Result<Vec<Puzzle>> {
        Ok(query!("SELECT * FROM Puzzle")
            .fetch_all(&self.pool)
            .await?
            .into_iter()
            .map(|row| Puzzle {
                id: row.id,
                name: row.name,
                primary_flags: PuzzleCategoryFlags {
                    uses_filters: row.primary_filters,
                    uses_macros: row.primary_macros,
                },
            })
            .collect())
    }
}

#[derive(PartialEq, Debug, Eq, Hash, Clone)]
pub struct PuzzleCategory {
    pub base: PuzzleCategoryBase,
    pub flags: PuzzleCategoryFlags,
}

impl PuzzleCategory {
    pub fn subcategories(&self) -> Vec<Self> {
        self.flags
            .subcategories()
            .into_iter()
            .map(|flags| Self {
                flags,
                ..self.clone()
            })
            .collect()
    }

    pub fn supercategories(&self) -> Vec<Self> {
        self.flags
            .supercategories()
            .into_iter()
            .map(|flags| Self {
                flags,
                ..self.clone()
            })
            .collect()
    }
}

#[derive(PartialEq, Debug, Eq, Hash, Clone)]
pub struct PuzzleCategoryBase {
    pub puzzle: Puzzle,
    pub blind: bool,
}

#[derive(PartialEq, Debug, Eq, Hash, Clone)]
pub struct PuzzleCategoryFlags {
    pub uses_filters: bool,
    pub uses_macros: bool,
}

impl PartialOrd<Self> for PuzzleCategoryFlags {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        if self.uses_filters == other.uses_filters && self.uses_macros == self.uses_macros {
            return Some(Ordering::Equal);
        }
        if (!self.uses_filters || other.uses_filters) && (!self.uses_macros || other.uses_macros) {
            return Some(Ordering::Less);
        }
        if (self.uses_filters || !other.uses_filters) && (self.uses_macros || !other.uses_macros) {
            return Some(Ordering::Greater);
        }
        None
    }
}

fn to_true(a: bool) -> Vec<bool> {
    if a {
        vec![true]
    } else {
        vec![false, true]
    }
}

fn to_false(a: bool) -> Vec<bool> {
    if a {
        vec![false, true]
    } else {
        vec![false]
    }
}

impl PuzzleCategoryFlags {
    pub fn subcategories(&self) -> Vec<Self> {
        let mut out = vec![];
        for uses_filters in to_false(self.uses_filters) {
            for uses_macros in to_false(self.uses_macros) {
                out.push(PuzzleCategoryFlags {
                    uses_filters,
                    uses_macros,
                });
            }
        }
        out
    }

    pub fn supercategories(&self) -> Vec<Self> {
        let mut out = vec![];
        for uses_filters in to_true(self.uses_filters) {
            for uses_macros in to_true(self.uses_macros) {
                out.push(PuzzleCategoryFlags {
                    uses_filters,
                    uses_macros,
                });
            }
        }
        out
    }

    pub fn format_modifiers(&self) -> String {
        let mut name = "".to_string();
        if self.uses_filters {
            name += "⚗️";
        }
        if self.uses_macros {
            name += "👾";
        }
        name
    }
}
