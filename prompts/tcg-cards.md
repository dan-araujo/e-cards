### create tables in postgresql

1. the first is a table to save a pokemon tcg cards
2. the second is a table to store the each pokemon's attacks
3. the third is a table to save collections set
4. create the database pokemon-tcg with encoding utf8 

generate the necessary foreign keys and their associated relationships
if a card is erased, it's attacks must also be erased
do not use comments in scripts
create a initial seed to all tables, with tcg pokemons and generate insert scripts with 25 records each

#### first table: cards
- id
- hp
- name
- type, divided with every pokemon tcg types
- stage, divided with the values: basic, stage 1 and stage 2
- evolves_from
- description
- weakness 
- weakness_multiplier with the default ×2 value
- resistance
- resistance_value
- retreat_cost
- illustrator
- collection_code that are a textual code
- collection_id
- year

#### second table: pokemon_attacks
- id
- card_id
- name
- cost
- damage
- description

#### third table: collections
- id
- collection_set_name
- release_date
- total_cards_collection

Consider the relational model for each of these tables and retrieve all the information, replacing the foreign key names with the given names. Then, save a view for each table in PostgreSQL.