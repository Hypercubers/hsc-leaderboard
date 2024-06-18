use crate::util::{internal_error, to_internal_error};
use crate::AppState;
use axum::extract::State;
use axum::http::StatusCode;
use axum::response::IntoResponse;
use axum::Json;
use axum_extra::extract::CookieJar;
use sqlx::query;

#[derive(serde::Deserialize)]
pub struct UploadSolve {
    log_file: String,
}

pub struct SolveData {
    log_file: String,
    puzzle_hsc_id: String,  // hsc puzzle id
    puzzle_version: String, // hsc puzzle version
    move_count: i32,
    uses_macros: bool,
    uses_filters: bool,
    speed_cs: Option<i32>,
    memo_cs: Option<i32>,
    blind: bool,
    scramble_seed: Option<String>,
    program_version: String, // hsc program version
    valid_solve: bool,
}

fn verify_log(log_file: String) -> SolveData {
    // dummy data
    SolveData {
        log_file,
        puzzle_hsc_id: "3x3x3".to_string(), // hsc puzzle id
        puzzle_version: "1.0".to_string(),  // hsc puzzle id
        move_count: 100,
        uses_macros: false,
        uses_filters: false,
        speed_cs: Some(1000),
        memo_cs: None,
        blind: false,
        scramble_seed: None,
        program_version: "2.0.0".to_string(), // hsc program version
        valid_solve: true,
    }
}

pub async fn upload_solve(
    State(state): State<AppState>,
    jar: CookieJar,
    Json(item): Json<UploadSolve>,
) -> Result<impl IntoResponse, (StatusCode, String)> {
    let Some(token) = jar.get("token") else {
        return Err((StatusCode::UNAUTHORIZED, "unauthorized".to_string()));
    };
    let token = token.value();
    let Some(user) = state.token_bearer(token).await.map_err(to_internal_error)? else {
        return Err((StatusCode::UNAUTHORIZED, "unauthorized".to_string()));
    };

    let solve_data = verify_log(item.log_file);

    let puzzle_id = query!(
        "SELECT PuzzleVersion.id
            FROM PuzzleVersion
            JOIN Puzzle
            ON Puzzle.id = PuzzleVersion.puzzle_id
            WHERE Puzzle.hsc_id = $1
            AND PuzzleVersion.version = $2",
        solve_data.puzzle_hsc_id,
        solve_data.puzzle_version
    )
    .fetch_optional(&state.pool)
    .await
    .map_err(to_internal_error)?
    .ok_or(internal_error("puzzle version does not exist"))?
    .id;

    let program_version_id = query!(
        "SELECT ProgramVersion.id
            FROM ProgramVersion
            JOIN Program
            ON Program.id = ProgramVersion.program_id
            WHERE Program.name = 'Hyperspeedcube'
            AND ProgramVersion.version = $1",
        solve_data.program_version
    )
    .fetch_optional(&state.pool)
    .await
    .map_err(to_internal_error)?
    .ok_or(internal_error("program version does not exist"))?
    .id;

    query!(
        "INSERT INTO Solve
                (log_file, user_id, puzzle_version_id, move_count,
                uses_macros, uses_filters, speed_cs, memo_cs,
                blind, scramble_seed, program_version_id, valid_solve) 
            VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12)
            RETURNING *",
        solve_data.log_file,
        user.id,
        puzzle_id,
        solve_data.move_count,
        solve_data.uses_macros,
        solve_data.uses_filters,
        solve_data.speed_cs,
        solve_data.memo_cs,
        solve_data.blind,
        solve_data.scramble_seed,
        program_version_id,
        solve_data.valid_solve
    )
    .fetch_optional(&state.pool)
    .await
    .map_err(to_internal_error)?
    .ok_or(internal_error("solve could not be inserted"))?;

    Ok("ok")
}

#[cfg(test)]
mod tests {
    use super::*;
    use axum_extra::extract::cookie::Cookie;
    use sqlx::PgPool;

    #[sqlx::test]
    fn upload_successful(pool: PgPool) -> Result<(), (StatusCode, String)> {
        let state = State(AppState {
            pool,
            otps: Default::default(),
        });
        let user = state
            .create_user("user@example.com".to_string(), Some("user 1".to_string()))
            .await
            .map_err(to_internal_error)?;
        let token = state.create_token(user.id).await;

        let cookie = Cookie::build(("token", token.token))
            .http_only(true)
            .secure(true);
        let jar = CookieJar::new().add(cookie);

        let puzzle_id =
            query!("INSERT INTO Puzzle (hsc_id, leaderboard) VALUES ('3x3x3', NULL) RETURNING id")
                .fetch_one(&state.pool)
                .await
                .map_err(to_internal_error)?
                .id;

        query!(
            "INSERT INTO PuzzleVersion (puzzle_id, version) VALUES ($1, '1.0')",
            puzzle_id
        )
        .execute(&state.pool)
        .await
        .map_err(to_internal_error)?;

        let program_id =
            query!("INSERT INTO Program (name, abbreviation) VALUES ('Hyperspeedcube', 'HSC') RETURNING id")
                .fetch_one(&state.pool)
                .await
                .map_err(to_internal_error)?
                .id;

        query!(
            "INSERT INTO ProgramVersion (program_id, version) VALUES ($1, '2.0.0')",
            program_id
        )
        .execute(&state.pool)
        .await
        .map_err(to_internal_error)?;

        upload_solve(
            state,
            jar,
            Json(UploadSolve {
                log_file: "dummy log file".to_string(),
            }),
        )
        .await?;

        Ok(())
    }
}
