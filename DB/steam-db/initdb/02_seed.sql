-- Deterministic generic seed data: 20 users, 30 games, 10 companies, 8 genres.
INSERT INTO users (name)
SELECT 'User ' || n FROM generate_series(1, 20) AS n;

INSERT INTO games (name)
SELECT 'Game ' || n FROM generate_series(1, 30) AS n;

INSERT INTO companies (name)
SELECT 'Company ' || n FROM generate_series(1, 10) AS n;

INSERT INTO genres (name)
SELECT 'Genre ' || n FROM generate_series(1, 8) AS n;

INSERT INTO game_details (game_id, price, release_date, description)
SELECT id,
       ((id * 137) % 6000) / 100.0,
       DATE '2015-01-01' + ((id * 47) % 3500),
       'Description for Game ' || id
FROM games;

INSERT INTO game_companies (game_id, company_id, role)
SELECT id, ((id - 1) % 10) + 1, 'developer' FROM games
UNION ALL
SELECT id, (id % 10) + 1, 'publisher' FROM games;

INSERT INTO game_genres (game_id, genre_id)
SELECT id, ((id - 1) % 8) + 1 FROM games
UNION ALL
SELECT id, ((id + 2) % 8) + 1 FROM games;

-- Four distinct games per user, for 80 library rows.
INSERT INTO library (user_id, game_id, purchased_at, hours_played)
SELECT ((n - 1) / 4) + 1,
       (((n - 1) * 7) % 30) + 1,
       TIMESTAMP '2022-01-01 00:00:00' + (n * INTERVAL '3 days'),
       ((n * 13) % 5000) / 100.0
FROM generate_series(1, 80) AS n;

-- Four achievements per game, for 120 rows.
INSERT INTO achievements (name, game_id)
SELECT 'Achievement ' || achievement_no, game_id
FROM games
CROSS JOIN generate_series(1, 4) AS achievement_no;

-- Select 200 distinct user/achievement pairs only from games in that user's library.
WITH eligible AS (
    SELECT l.user_id, a.id AS achievement_id,
           row_number() OVER (ORDER BY ((l.user_id * 97 + a.id * 31) % 997), l.user_id, a.id) AS rn
    FROM library AS l
    JOIN achievements AS a ON a.game_id = l.game_id
)
INSERT INTO user_achievements (user_id, achievement_id, unlocked_at)
SELECT user_id, achievement_id,
       TIMESTAMP '2023-01-01 00:00:00' + (rn * INTERVAL '1 hour')
FROM eligible
WHERE rn <= 200;

-- Forty reviews, all for games the reviewer owns.
INSERT INTO reviews (user_id, game_id, rating, text)
SELECT user_id, game_id,
       ((user_id + game_id) % 5) + 1,
       'Review by User ' || user_id || ' for Game ' || game_id
FROM (
    SELECT user_id, game_id,
           row_number() OVER (ORDER BY ((user_id * 37 + game_id * 19) % 101), user_id, game_id) AS rn
    FROM library
) AS owned_games
WHERE rn <= 40;
