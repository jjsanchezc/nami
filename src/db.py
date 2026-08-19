"""Minimal SQLite schema bootstrap for finance-tracker.

Owns the single point of configuration for the database path (see
docs/adr/000-design-and-development.md) so the future CLI and the backup
script both import DB_PATH from here instead of hardcoding it themselves.
"""

import sqlite3
from pathlib import Path

DB_PATH = Path("/opt/finance-tracker/data/finance.db")

SCHEMA = """
CREATE TABLE IF NOT EXISTS expenses (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date TEXT NOT NULL,        -- YYYY-MM-DD
    amount REAL NOT NULL,
    category TEXT NOT NULL,
    description TEXT
);

CREATE TABLE IF NOT EXISTS subscriptions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    amount REAL NOT NULL,
    billing_day INTEGER NOT NULL,
    active INTEGER NOT NULL DEFAULT 1
);
"""


def init_db(db_path: Path = DB_PATH) -> None:
    """Create the database file and tables if they don't exist yet."""
    conn = sqlite3.connect(db_path)
    try:
        conn.executescript(SCHEMA)
        conn.commit()
    finally:
        conn.close()


if __name__ == "__main__":
    init_db()
    print(f"Schema ready at {DB_PATH}")
