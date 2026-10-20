# finance-tracker

A personal finance tracker (expenses + subscriptions) for a single user,
running locally on a self-managed Linux server.

This is the applied project of a 24-week roadmap toward a junior
infrastructure/SRE role, built and reworked phase by phase across the whole
roadmap. The point of the project isn't the app itself — it's a vehicle to
apply, hands-on, what each phase covers (Linux fundamentals, bash + systemd,
networking and git in Phase 1; cloud and infrastructure as code in Phase 2;
and so on). See `docs/adr/` for the reasoning behind every non-obvious
decision made along the way.

## Status

Phase 1 is complete: an idempotent setup script, an automated nightly
backup managed by systemd, SSH locked down to key-only auth on a non-default
port, and a firewall allowing only that port in. Phase 2 (AWS + Terraform)
is in progress. The CLI itself (`gasto add`, `suscripcion list`, etc.) is
not built yet — only the minimal database schema exists so far. See the
current phase's checklist (`docs/fase-<N>-checklist.md`) for the state in
detail.

## Requirements

- A Linux server managed with `systemd` (developed against Ubuntu Server).
- `sudo`/root access to run the setup script.
- `git`.

## Deploying

```bash
git clone <this-repo-url> nami
cd nami
sudo ./scripts/setup.sh
sudo ./scripts/firewall-setup.sh
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

`firewall-setup.sh` locks down network access to the server:

- Copies the `.conf` files in `scripts/conf/` into `/etc/ssh/sshd_config.d/`,
  disabling password login and moving SSH to a non-default port, then
  restarts `sshd`.
- Configures `ufw` to deny all incoming traffic by default, with a single
  explicit exception for the SSH port.

**Before you run it over an existing SSH connection:** don't close that
session until you've confirmed, from a separate terminal, that you can
connect on the new port with your key. If something is misconfigured and
you close your only session first, you can lose remote access to the
server entirely.

## Project layout

```
nami/
├── src/                 # application code (db.py: schema; more to come)
├── scripts/             # setup.sh, backup.sh, firewall-setup.sh
│   └── conf/            # sshd_config.d drop-ins deployed by firewall-setup.sh
├── systemd/             # finance-backup.service, finance-backup.timer
├── docs/
│   ├── adr/             # design decisions, with reasoning
│   ├── conventions/     # naming and tagging rules for cloud resources
│   ├── repository/      # commit message rules (Conventional Commits)
│   └── fase-N-checklist.md   # per-phase progress checklists
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
- **SSH: `ed25519` keys only, no password, on a non-default port.** See
  [ADR 003](docs/adr/003-server-connection.md) for the key type, how the
  `sshd` config is overridden without touching cloud-init's own file, the
  port change, and why password auth is disabled.
- **`ufw`, denying all incoming traffic except the SSH port.** See
  [ADR 004](docs/adr/004-server-security.md) for why `ufw` over `firewalld`/
  `nftables`, and the rules themselves.
- **AWS work runs through a dedicated IAM user, never the root user**, with
  permissions granted through IAM groups instead of per-user — limits
  accidental damage and the blast radius of leaked credentials. See
  [ADR 005](docs/adr/005-cloud-iam.md).
- **Cloud resources follow a `<project>-<environment>-<component>` naming
  scheme and a fixed set of tags** (`project`, `environment`, `managed-by`),
  so the project's resources never mix with labs or anything else in the
  account. See [`docs/conventions/naming-and-tagging.md`](docs/conventions/naming-and-tagging.md).

## License

Apache 2.0 — see [LICENSE](LICENSE).
