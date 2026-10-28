# Steam database demo

## Folder layout

Keep this structure together:

```text
steam-db/
├── docker-compose.yml
├── README.md
└── initdb/
    ├── 01_schema.sql
    └── 02_seed.sql
```

Compose reads the YAML file at the project root. PostgreSQL automatically runs the SQL files in `initdb/` when it initializes an empty data directory. Keep the SQL files in that folder; do not copy them into the running container by hand.

## Start PostgreSQL and pgAdmin

Open a terminal in this `steam-db` folder and run:

```bash
docker compose up -d
```

Compose creates these containers and persistent volumes:

- PostgreSQL and pgAdmin containers: Compose-generated names beginning with `steam-db-`
- PostgreSQL data volume: `postgres_postgres_data`
- pgAdmin settings volume: `postgres_pgadmin_data`

The database is `steam_db`. The example local credentials are `postgres` / `postgres`.

Open pgAdmin at [http://localhost:8080](http://localhost:8080) and sign in with `admin@example.com` / `admin`.

## Connect pgAdmin to PostgreSQL

In pgAdmin, register a server. On the **General** tab, give it a name such as `Steam database`. On the **Connection** tab enter:

- **Host name/address:** `db`
- **Port:** `5432`
- **Maintenance database:** `steam_db`
- **Username:** `postgres`
- **Password:** `postgres`

Use `db` as the host because pgAdmin connects to PostgreSQL over the Compose network. `localhost` is for programs running on your computer, such as a local `psql` client.

## Check the setup

Check that both containers are running and PostgreSQL is healthy:

```bash
docker compose ps
```

Check the seeded table counts:

```bash
docker compose exec db psql -U postgres -d steam_db -c "SELECT 'users' AS table_name, count(*) FROM users UNION ALL SELECT 'games', count(*) FROM games UNION ALL SELECT 'companies', count(*) FROM companies UNION ALL SELECT 'genres', count(*) FROM genres UNION ALL SELECT 'game_details', count(*) FROM game_details UNION ALL SELECT 'game_companies', count(*) FROM game_companies UNION ALL SELECT 'game_genres', count(*) FROM game_genres UNION ALL SELECT 'library', count(*) FROM library UNION ALL SELECT 'achievements', count(*) FROM achievements UNION ALL SELECT 'user_achievements', count(*) FROM user_achievements UNION ALL SELECT 'reviews', count(*) FROM reviews ORDER BY table_name;"
```

Expected counts are: users 20, games 30, companies 10, genres 8, game_details 30, game_companies 60, game_genres 60, library 80, achievements 120, user_achievements 200, reviews 40.

Stop the containers while keeping the data:

```bash
docker compose down
```

To delete both data volumes and rebuild the database from the SQL files on next startup:

```bash
docker compose down -v
docker compose up -d
```

The volume deletion permanently removes the database contents and pgAdmin's saved settings. Initialization scripts run only when PostgreSQL starts with an empty data volume. If you already have a PostgreSQL container running, check `docker ps` first: it may already be using port `5432`. Stop the old container before starting this Compose setup if that port is occupied. Existing volumes with the specified names are reused, so inspect them with `docker volume ls` before resetting anything. Do not remove a volume unless you are certain you no longer need its data.
