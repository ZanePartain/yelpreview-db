CREATE TABLE IF NOT EXISTS Category (
	id SERIAL PRIMARY KEY,
	type      TEXT   UNIQUE       NOT NULL
);