CREATE TABLE IF NOT EXISTS Business (
    id CHAR(22) PRIMARY KEY,
    name TEXT NOT NULL,
    state VARCHAR(2) NOT NULL,
    city TEXT NOT NULL
);