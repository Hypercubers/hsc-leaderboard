use crate::AppState;
use axum::extract::State;
use axum::http::StatusCode;
use axum::Json;
use chrono::{DateTime, TimeDelta, Utc};
use rand::distributions::{Distribution, Uniform};
use rand::rngs::StdRng;
use rand::SeedableRng;

const OTP_DURATION: TimeDelta = TimeDelta::minutes(5);
const OTP_LENGTH: i32 = 6;

#[derive(Clone)]
pub struct Otp {
    code: String,
    expiry: DateTime<Utc>,
}

impl Otp {
    pub fn is_valid(&self) -> bool {
        self.expiry > Utc::now()
    }
}

#[derive(serde::Deserialize)]
pub struct UserRequestOtp {
    email: String,
    display_name: Option<String>,
}

#[derive(serde::Deserialize)]
pub struct UserRequestToken {
    email: String,
    otp_code: String,
}

fn generate_otp() -> Otp {
    let mut rng = StdRng::from_entropy();
    let between = Uniform::from('0'..'9');
    let code = String::from_iter((0..OTP_LENGTH).map(|_| between.sample(&mut rng)));
    Otp {
        code,
        expiry: Utc::now() + OTP_DURATION,
    }
}

impl AppState {
    fn create_otp(&self, user_id: i32) -> Otp {
        let otp = generate_otp();
        self.otps.lock().insert(user_id, otp.clone());
        otp
    }

    fn clean_otps(&self) {
        self.otps.lock().retain(|_id, otp| otp.is_valid());
    }
}

pub async fn user_request_otp(
    State(state): State<AppState>,
    Json(item): Json<UserRequestOtp>,
) -> Result<StatusCode, (StatusCode, String)> {
    let db_user = state
        .get_user(&item.email)
        .await
        .map_err(to_internal_error)?;
    let user;
    let created;
    match db_user {
        None => {
            created = true;
            user = state
                .create_user(item.email.clone(), item.display_name.clone())
                .await
                .map_err(to_internal_error)?
        }
        Some(user_) => {
            created = false;
            user = user_;
        }
    }

    let otp = state.create_otp(user.id);

    #[cfg(debug_assertions)]
    println!("{}", otp.code);

    // TODO: send an email here

    if created {
        Ok(StatusCode::CREATED)
    } else {
        Ok(StatusCode::ACCEPTED)
    }
}

#[derive(serde::Serialize)]
pub struct TokenReturn {
    token: String,
}

pub async fn user_request_token(
    State(state): State<AppState>,
    Json(item): Json<UserRequestToken>,
) -> Result<Json<TokenReturn>, (StatusCode, String)> {
    let user = state
        .get_user(&item.email)
        .await
        .map_err(to_internal_error)?
        .ok_or(internal_error("user does not exist"))?;

    let maybe_otp = state.otps.lock().get(&user.id).cloned(); // do not let it lock forever!
    state.clean_otps(); // remove all the expired ones
    if let Some(otp) = maybe_otp {
        if otp.is_valid() && item.otp_code == otp.code {
            // is_valid should be true if the state was cleaned
            // valid otp, remove it since it has been used
            state.otps.lock().remove(&user.id);
            let token = state.create_token(user.id).await;
            return Ok(Json(TokenReturn { token: token.token }));
        }
    }
    Err((StatusCode::UNAUTHORIZED, "invalid otp".to_string()))
}

/// Utility function for mapping any error into a `500 Internal Server Error`
/// response.
fn to_internal_error<E>(err: E) -> (StatusCode, String)
where
    E: std::error::Error,
{
    internal_error(&err.to_string())
}

/// Utility function for mapping any error into a `500 Internal Server Error`
/// response.
fn internal_error(msg: &str) -> (StatusCode, String) {
    (StatusCode::INTERNAL_SERVER_ERROR, msg.to_string())
}

#[cfg(test)]
mod tests {
    use super::*;
    use sqlx::PgPool;

    #[sqlx::test]
    fn login_successful(pool: PgPool) -> Result<(), (StatusCode, String)> {
        let email = "user@example.com".to_string();
        let display_name = "user 1".to_string();
        let state = State(AppState {
            pool,
            otps: Default::default(),
        });
        println!("email {}", email);

        user_request_otp(
            state.clone(),
            Json(UserRequestOtp {
                email: email.clone(),
                display_name: Some(display_name.clone()),
            }),
        )
        .await?;

        // not testing email here, just hack the otp database
        let user = state
            .get_user(&email)
            .await
            .map_err(to_internal_error)?
            .ok_or(internal_error("user does not exist"))?;
        println!("found user: id {}", user.id);
        let otp_code = state
            .otps
            .lock()
            .get(&user.id)
            .ok_or(internal_error("otp does not exist"))?
            .code
            .clone();
        println!("obtained otp: {}", otp_code);

        let _token_response = user_request_token(
            state.clone(),
            Json(UserRequestToken {
                email: email.clone(),
                otp_code,
            }),
        )
        .await?;
        println!("token: {}", _token_response.token);

        Ok(())
    }

    #[sqlx::test]
    fn login_unsuccessful(pool: PgPool) -> Result<(), (StatusCode, String)> {
        let email = "user@example.com".to_string();
        let display_name = "user 1".to_string();
        let state = State(AppState {
            pool,
            otps: Default::default(),
        });

        user_request_otp(
            state.clone(),
            Json(UserRequestOtp {
                email: email.clone(),
                display_name: Some(display_name.clone()),
            }),
        )
        .await?;

        let otp_code = "INVALID OTP".to_string(); // otp codes are always made of digits

        let token_response = user_request_token(
            state.clone(),
            Json(UserRequestToken {
                email: email.clone(),
                otp_code,
            }),
        )
        .await;

        match token_response {
            Ok(_) => Err(internal_error("login succeeded with incorrect otp")),
            Err(_) => Ok(()),
        }
    }
}
