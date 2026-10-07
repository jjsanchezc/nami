# ADR 002 Deployment and Server Setup

# ADR 002.1 Service Account and Permissions Model
## Status
Accepted
## Context
Automated tasks (the nightly backup) need to run without a human being logged
in, and need read/write access to the app's data. At the same time, the
interactive user (used to run the CLI by hand) needs that same access. Both
should be able to reach the shared data without duplicating permission
management per user, and without giving either of them more access than they
actually need.

## Options
1. Run automated tasks as root:
  - Pros:
    - Simplest, never runs into a permission error
  - Cons:
    - Violates least privilege — a bug in the backup script would have full
      system access instead of access to one directory
    - Massive overkill for a task that only needs to read/write one folder
2. Run automated tasks as the interactive user (jjsanchezc):
  - Pros:
    - No new account to create or manage
  - Cons:
    - Couples the app's operation to a personal account — breaks if that
      account is ever locked, renamed, or removed
    - No real separation between "a person" and "an automated process"
3. Dedicated service account (finance-svc, no login shell) + shared group
   (finance) with setgid on the app's shared directory:
  - Pros:
    - Least privilege: finance-svc can't be used to log in at all
      (`-s /usr/sbin/nologin`), it only exists so processes can run as it
    - Access is granted through group membership, not per-resource
      permissions — adding/removing an actor from the shared access only
      means adding/removing it from the `finance` group
    - setgid on the shared directory makes every new file/subdirectory
      inherit the `finance` group automatically, no manual `chgrp` needed
  - Cons:
    - More moving parts to set up than just running as root or as yourself
      (extra user, extra group, extra permission bits to get right)

## Decision
Option 3. The extra setup cost is small and one-time (it lives entirely in
`setup.sh`), while running as root or as a personal account are both real
security/maintainability liabilities that would stay for the life of the
project.

# ADR 002.2 Deployment Strategy: Repo vs. Runtime Location
## Status
Accepted
## Context
The project's source lives in a git repository (`nami`) that gets `git pull`ed
onto the server. Running the app requires deciding whether it executes
directly out of that checkout, or whether there's a separate, "installed"
location — the way real deployed software is usually separated from its own
source control checkout.

## Options
1. Run everything directly from the git checkout:
  - Pros:
    - Simplest, no extra copy step
  - Cons:
    - Doesn't reflect how real software is deployed
    - Couples the running app to wherever a specific person happened to
      clone the repo, instead of a fixed, predictable path
2. Symlink the runtime location's code folders back to the git checkout:
  - Pros:
    - Code updates reflect immediately, no explicit deploy step needed
  - Cons:
    - Breaks the trust boundary between the app's runtime and a personal,
      unprivileged, freely-writable checkout — anyone (or anything) that can
      write to the checkout can silently change what a privileged/automated
      process executes, with no deliberate "deploy" action in between
    - Risky if the checkout is ever mid-`git pull` (partial state) exactly
      when something tries to run
3. Copy the code (`src/`, `scripts/`, `systemd/`, `requirements.txt`) from the
   repo into a separate runtime path (`/opt/finance-tracker`), during
   `setup.sh`, without touching `data/`, `backups/` or `venv/`:
  - Pros:
    - Deploying is an explicit, deliberate action, not something that
      happens silently the moment someone edits a file in the checkout
    - The runtime code is decoupled from the personal account's write access
    - `/opt` matches the FHS convention for self-contained, non-package-
      manager-managed software
  - Cons:
    - Needs a re-run of `setup.sh` after every code change to take effect
      (mitigated by `setup.sh` itself being idempotent and safe to re-run)

## Decision
Option 3. Combined with 002.1, this keeps a clear line between "what a
developer can freely edit" and "what actually runs with real privileges" —
the same reasoning behind not running the backup as root or as a personal
account also applies to how the code that backup runs gets there in the
first place.
