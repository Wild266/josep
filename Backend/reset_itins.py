import os
import psycopg2

# --- DB CONFIG (same style as your user script) ---
DB_HOST = "planitdb.c30c2ai28fyz.us-east-2.rds.amazonaws.com"
DB_NAME = "postgres"
DB_USER = "PlanItDB"
DB_PASSWORD = "dixie123"
DB_PORT = 5432

# --- DDL: create tables if they don't exist ---
# Using integer/bigint IDs to match your users(0,1). No enums to keep it simple & runnable.
CREATE_ITINS_SQL = """
CREATE TABLE IF NOT EXISTS itins (
  id          BIGSERIAL PRIMARY KEY,
  user_id     INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  name        TEXT,
  location    TEXT,
  starts_on   DATE,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
"""

CREATE_ITIN_STOPS_SQL = """
CREATE TABLE IF NOT EXISTS itin_stops (
  id          BIGSERIAL PRIMARY KEY,
  itin_id     BIGINT NOT NULL REFERENCES itins(id) ON DELETE CASCADE,
  item_kind   TEXT NOT NULL CHECK (item_kind IN ('event','restaurant','poi')),
  item_id     BIGINT NOT NULL,
  start_time  TIMESTAMPTZ NOT NULL,
  end_time    TIMESTAMPTZ,
  position    INT,
  notes       TEXT,
  UNIQUE (itin_id, item_kind, item_id, start_time)
);
"""

# Helpful indexes
CREATE_INDEXES_SQL = """
CREATE INDEX IF NOT EXISTS idx_itin_stops_itin_time ON itin_stops (itin_id, start_time);
CREATE INDEX IF NOT EXISTS idx_itin_stops_item      ON itin_stops (item_kind, item_id);
"""

# --- WIPE existing data (child first or cascade from parent) ---
WIPE_SQL = """
TRUNCATE TABLE itins RESTART IDENTITY CASCADE;
"""

# --- SAMPLE DATA ---
# Two itins: one for user 0, one for user 1
INSERT_ITINS_SQL = """
INSERT INTO itins (user_id, name, starts_on)
VALUES
  (0, 'NYC Weekend', '2025-08-09'),
  (1, 'Chicago Day Trip', '2025-08-10')
RETURNING id;
"""

# For demo, we’ll pretend item_ids are arbitrary numeric IDs from your items tables.
# Adjust item_kind/item_id/start_time as needed.
INSERT_STOPS_SQL = """
INSERT INTO itin_stops (itin_id, item_kind, item_id, start_time, end_time, position, notes)
VALUES
  (%s, 'restaurant', 101, '2025-08-09 19:00-04', '2025-08-09 20:30-04', 1, 'Dinner at Joe''s'),
  (%s, 'event',      202, '2025-08-09 21:00-04', '2025-08-09 23:00-04', 2, 'Comedy show'),

  (%s, 'poi',        301, '2025-08-10 10:00-04', NULL,                    1, 'Morning at the Bean'),
  (%s, 'restaurant', 102, '2025-08-10 12:30-04', '2025-08-10 13:30-04',  2, 'Lunch near the river');
"""

def main():
    try:
        conn = psycopg2.connect(
            host=DB_HOST,
            dbname=DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD,
            port=DB_PORT,
            sslmode="require"  # keep if your RDS requires SSL
        )
        conn.autocommit = True
        cur = conn.cursor()

        # Create tables & indexes
        cur.execute(CREATE_ITINS_SQL)
        cur.execute(CREATE_ITIN_STOPS_SQL)
        cur.execute(CREATE_INDEXES_SQL)
        print("Tables ensured / indexes created.")

        # Wipe data
        cur.execute(WIPE_SQL)
        print("Itinerary tables wiped (identity reset).")

        # Insert sample itins and capture the two ids
        cur.execute(INSERT_ITINS_SQL)
        rows = cur.fetchall()
        if len(rows) != 2:
            raise RuntimeError("Expected 2 itinerary IDs back; got %d" % len(rows))
        itin1_id, itin2_id = rows[0][0], rows[1][0]
        print(f"Inserted itins: {itin1_id}, {itin2_id}")

        '''# Insert stops for each itin
        cur.execute(INSERT_STOPS_SQL, (itin1_id, itin1_id, itin2_id, itin2_id))
        print("Sample itinerary stops inserted.")'''

        cur.close()
        conn.close()

    except Exception as e:
        print("Error:", e)

if __name__ == "__main__":
    main()