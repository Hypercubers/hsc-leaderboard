pub mod auth;
pub mod program;
pub mod puzzle;
pub mod solve;
pub mod user;

#[derive(Debug)]
pub enum EditAuthorization {
    Moderator,
    IsSelf,
}
