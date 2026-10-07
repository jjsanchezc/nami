# finance-tracker

A personal finance tracker (expenses + subscriptions) for a single user,
running locally on a self-managed Linux server.

This is the closing project of **Phase 1** of a 24-week roadmap toward a
junior infrastructure/SRE role. The point of the project isn't the app
itself — it's a vehicle to apply, hands-on, what each phase of the roadmap
covers (Linux fundamentals, bash + systemd, networking, git). See
`docs/adr/` for the reasoning behind every non-obvious decision made along
the way.

## Status

Phase 1 in progress. Right now the server-side infrastructure is done: an
idempotent setup script, and an automated nightly backup managed by
systemd. The CLI itself (`gasto add`, `suscripcion list`, etc.) is not built
yet — only the minimal database schema exists so far. See
`docs/fase-1-checklist.md` for the current state in detail.

## Requirements

- A Linux server managed with `systemd` (developed against Ubuntu Server).
- `sudo`/root access to run the setup script.
- `git`.

## Deploying

```bash
git clone <this-repo-url> nami
cd nami
sudo ./scripts/setup.sh
```

`setup.sh` is idempotent — safe to run again after pulling new code. It:

- Creates the `finance-svc` service account (no login shell) and the
  `finance` group, and adds both `finance-svc` and the interactive user to it.
- Creates `/opt/finance-tracker` with the correct shared permissions.
- Copies the app's code from this repo into `/opt/finance-tracker`, without
  touching real data (`data/`, `backups/`) or the virtual environment.
- Installs Python, creates the virtualenv, installs dependencies.
- Creates the database schema if it doesn't exist yet.
- Deploys and enables the `finance-backup.timer` systemd unit, which backs
  up `finance.db` every night.

## Project layout

```
nami/
├── src/            # application code (db.py: schema; more to come)
├── scripts/        # setup.sh, backup.sh
├── systemd/        # finance-backup.service, finance-backup.timer
├── docs/adr/       # design decisions, with reasoning
├── requirements.txt
└── LICENSE
```

At runtime, this gets deployed to `/opt/finance-tracker`, which also holds
`data/` (the live database), `backups/`, and `venv/` — none of which live in
this repo.

## Key decisions

Full reasoning lives in `docs/adr/`; short summary:

- **SQL over NoSQL, SQLite over Postgres** — the data is relational and the
  project deliberately avoids running an extra database service. See
  [ADR 001](docs/adr/001-databases.md).
- **SQLite's native backup API, scheduled with a systemd timer (not cron)** —
  safe to copy the database live, with logging and missed-run recovery for
  free. See [ADR 001.3](docs/adr/001-databases.md).
- **A dedicated, login-less service account + shared group**, instead of
  running automated tasks as root or as a personal user. See
  [ADR 002.1](docs/adr/002-deploy-and-setup.md).
- **Code is copied into `/opt/finance-tracker`, never symlinked** back to
  this repo — keeps a clear boundary between what's freely editable and
  what actually runs with real privileges. See
  [ADR 002.2](docs/adr/002-deploy-and-setup.md).

## License

Apache 2.0 — see [LICENSE](LICENSE).
