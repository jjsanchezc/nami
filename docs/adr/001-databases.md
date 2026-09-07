# ADR 001 Databases

# ADR 001.1 Database Type
## Status
Accepted
## Context
## Options
1. OptionA:
  - Pros:
  - Cons:
2. Option B:
  - Pros:
  - Cons:
## Decision
sql or NoSQL

# ADR 001.2 Database Engine
## Status
Accepted
## Context
We need to find the perfect database engine for the project, it should be easy to configure,manage,use due to the project ideology (the database engine is not the core of the SRE roadmap)

## Options
1. SQLite
  - Pro: 
    - Easier to configure, manage, use
  - Cons:
    - Have less complete functions as a "normal" database engine
2. Postgres
  - Pro:
  - Cons:
## Decision
The Final decision is to use SQLite. Its ideology goes along with the one we're looking for the project.

# ADR 001.3 Database Backup Strategy
## Status
Accepted
## Context
## Options
1. Option A:
  - Pros:
  - Cons:
2. Option B:
  - Pros:
  - Cons:
## Decision

sqlite3 "$i" ".backup '$new_name'" With a Timer and Service Unit



