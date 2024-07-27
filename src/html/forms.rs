use crate::db::user::User;
use crate::error::AppError;
use crate::AppState;
use crate::RequestBody;
use axum::response::Html;

#[derive(serde::Deserialize)]
pub struct UploadSolveExternal {}

impl RequestBody for UploadSolveExternal {
    type Response = Html<String>;

    async fn request(
        self,
        state: AppState,
        user: Option<User>,
    ) -> Result<Self::Response, AppError> {
        if user.is_none() {
            return Err(AppError::NotLoggedIn);
        }

        let mut puzzles = state.get_all_puzzles().await?;
        puzzles.sort_by_key(|p| p.name.clone());

        let mut program_versions = state.get_all_program_versions().await?;
        program_versions.sort_by_key(|p| (p.name()));

        Ok(Html(
            crate::hbs!()
                .render(
                    "upload-external.html",
                    &serde_json::json!({
                        "puzzles": puzzles,
                        "program_versions": program_versions,
                    }),
                )
                .expect("render error"),
        ))
    }
}

#[derive(serde::Deserialize)]
pub struct UpdateProfile {}

impl RequestBody for UpdateProfile {
    type Response = Html<String>;

    async fn request(
        self,
        _state: AppState,
        user: Option<User>,
    ) -> Result<Self::Response, AppError> {
        if user.is_none() {
            return Err(AppError::NotLoggedIn);
        }

        Ok(Html(
            include_str!("../../html/update-profile.html").to_string(),
        ))
    }
}
