-- Remover se existirem
DROP TYPE IF EXISTS pokemon_type CASCADE;
DROP TABLE IF EXISTS pokemon_attacks CASCADE;
DROP TABLE IF EXISTS cards CASCADE;
DROP TABLE IF EXISTS collections CASCADE;

-- Criar novamente
CREATE TYPE pokemon_type AS ENUM (
    'Grass', 'Fire', 'Water', 'Lightning', 'Psychic', 'Fighting',
    'Darkness', 'Metal', 'Fairy', 'Dragon', 'Colorless'
);

CREATE TABLE collections (
    id SERIAL PRIMARY KEY,
    collection_set_name VARCHAR(100) UNIQUE NOT NULL,
    release_date DATE,
    total_cards_collection INTEGER
);

CREATE TABLE cards (
    id SERIAL PRIMARY KEY,
    hp INTEGER,
    name VARCHAR(100) NOT NULL,
    type pokemon_type,
    stage VARCHAR(20) CHECK (stage IN ('basic', 'stage 1', 'stage 2')),
    evolves_from VARCHAR(100),
    description TEXT,
    weakness VARCHAR(50),
    weakness_multiplier VARCHAR(10) DEFAULT 'x2',
    resistance VARCHAR(50),
    resistance_value VARCHAR(10),
    retreat_cost INTEGER,
    illustrator VARCHAR(100),
    collection_code VARCHAR(100),
    collection_id INTEGER REFERENCES collections(id),
    year INTEGER
);

CREATE TABLE pokemon_attacks (
    id SERIAL PRIMARY KEY,
    card_id INTEGER NOT NULL REFERENCES cards(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    cost VARCHAR(50),
    damage VARCHAR(20),
    description TEXT
);
