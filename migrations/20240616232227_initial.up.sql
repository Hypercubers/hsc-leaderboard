CREATE TABLE IF NOT EXISTS Users (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    email varchar(255) NOT NULL,
    display_name varchar(255)
);

CREATE TABLE IF NOT EXISTS Tokens (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id INTEGER REFERENCES Users NOT NULL,
    token varchar(64) NOT NULL
);
