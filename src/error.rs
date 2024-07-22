use axum::body::Body;
use axum::extract::multipart::MultipartError;
use axum::http::StatusCode;
use axum::response::IntoResponse;
use axum::response::Response;
use serenity::prelude::SerenityError;
use std::fmt::Display;

#[derive(Debug)]
pub enum AppError {
    SqlError(sqlx::Error),
    UserDoesNotExist,
    InvalidOtp,
    InvalidToken,
    InvalidDiscordAccount,
    PuzzleVersionDoesNotExist,
    ProgramVersionDoesNotExist,
    CouldNotInsertSolve,
    MultipartError(MultipartError),
    NoLogFile,
    NotLoggedIn,
    InvalidQuery(String),
    DiscordError(SerenityError),
    NotAuthorized,
    InvalidSolve,

    #[allow(dead_code)]
    Other(String),
}

impl AppError {
    pub fn message(&self) -> String {
        match self {
            Self::SqlError(err) => format!("Internal SQL error: {}", err),
            Self::UserDoesNotExist => "User does not exist".to_string(),
            Self::InvalidOtp => "Invalid OTP".to_string(),
            Self::InvalidToken => "Invalid Token".to_string(),
            Self::InvalidDiscordAccount => "Invalid Discord account".to_string(),
            Self::PuzzleVersionDoesNotExist => "Puzzle version does not exist".to_string(),
            Self::ProgramVersionDoesNotExist => "Program version does not exist".to_string(),
            Self::CouldNotInsertSolve => "Could not upload solve".to_string(),
            Self::MultipartError(err) => format!("Multipart error: {}", err),
            Self::NoLogFile => "No log file provided".to_string(),
            Self::NotLoggedIn => "Not logged in".to_string(),
            Self::InvalidQuery(err) => format!("Invalid query: {}", err),
            Self::DiscordError(err) => format!("Discord error: {}", err),
            Self::NotAuthorized => "Not authorized".to_string(),
            Self::InvalidSolve => "Invalid solve".to_string(),

            Self::Other(msg) => msg.to_string(),
        }
    }

    fn status_code(&self) -> StatusCode {
        match self {
            Self::SqlError(_) => StatusCode::INTERNAL_SERVER_ERROR,
            Self::UserDoesNotExist => StatusCode::UNAUTHORIZED,
            Self::InvalidOtp => StatusCode::UNAUTHORIZED,
            Self::InvalidToken => StatusCode::UNAUTHORIZED,
            Self::InvalidDiscordAccount => StatusCode::UNAUTHORIZED,
            Self::PuzzleVersionDoesNotExist => StatusCode::BAD_REQUEST,
            Self::ProgramVersionDoesNotExist => StatusCode::BAD_REQUEST,
            Self::CouldNotInsertSolve => StatusCode::BAD_REQUEST,
            Self::MultipartError(err) => err.status(),
            Self::NoLogFile => StatusCode::BAD_REQUEST,
            Self::NotLoggedIn => StatusCode::UNAUTHORIZED,
            Self::InvalidQuery(_err) => StatusCode::BAD_REQUEST,
            Self::DiscordError(_err) => StatusCode::INTERNAL_SERVER_ERROR,
            Self::NotAuthorized => StatusCode::UNAUTHORIZED,
            Self::InvalidSolve => StatusCode::BAD_REQUEST,

            Self::Other(_) => StatusCode::INTERNAL_SERVER_ERROR,
        }
    }
}

impl IntoResponse for AppError {
    fn into_response(self) -> Response<Body> {
        (self.status_code(), self.message()).into_response()
    }
}

impl From<sqlx::Error> for AppError {
    fn from(err: sqlx::Error) -> AppError {
        AppError::SqlError(err)
    }
}

impl From<MultipartError> for AppError {
    fn from(err: MultipartError) -> AppError {
        AppError::MultipartError(err)
    }
}

impl From<SerenityError> for AppError {
    fn from(err: SerenityError) -> AppError {
        AppError::DiscordError(err)
    }
}

impl Display for AppError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> Result<(), std::fmt::Error> {
        write!(f, "{}", self.message())
    }
}
