# ADR 001 Databases

# ADR 001.1 Database Type
## Status
Accepted
## Context
## Options
1. SQL:
  - Pros:
    - No that much of management
    - Consistency
    - Thanks to the project's nature, most of data is relational
  - Cons:
    - For logs, sessions cache (in that case is better to use NoSQL)
## Decision
Final decision: SQL, is chosen thanks to the project's nature and affinity with data that will be managed

# ADR 001.2 Database Engine
## Status
Accepted
## Context
We need to find the perfect database engine for the project, it should be easy to configure,manage,use due to the project ideology (the database engine is not the core of the SRE roadmap)

## Options
1. SQLite
  - Pro: 
    - The ideology of SQLite suits perfect to the project (focused on a "easy" database)
    - Easier to configure, manage, use
  - Cons:
    - Have less complete functions as a "normal" database engine
    - SQLite is an embedded database that lacks a client-server architecture, making it a poor choice for applications requiring high write concurrency, distributed multi-server setups, or granular database-level user permissions.
2. Postgres
  - Pro:
    - True Concurrency (No "Database Locked" Errors)
    - User Roles and Security
    - Seamless Scaling and Architecture Flexibility
  - Cons:
    - Is like killing a bug with a tank
    - At the point of the project I'm at there's no need to have a huge db engine with many features
## Decision
The Final decision is to use SQLite. Its ideology goes along with the one we're looking for the project.

# ADR 001.3 Database Backup Strategy
## Status
Accepted
## Context
This project is looking to simulate how real projects can/should/must do their backups, paying attention to each pro and cons that can cause.
The way a backup is done might be dangerous for data and user experience
## Options
1. Raw copy (cp/rsync):
  - Pros:
    - Fast to write and understand what it does
    - Not much management or hard to understand
  - Cons:
    - No secure in many cases (A sudden shut down, data concurrency might affect)
2. Stop the system:
  - Pros:
    - Not having data corruption problems
    - The safest way to don't have data problems.
  - Cons:
    - User experience is affected
    - Having to stop a system could cause losses in earnings
3. Native backup API of SQLite:
  - Pros:
    - Native tool that solves that specific problem
    - Easy to configure
  - Cons:
    - In case of migration might be difficult to switch the tool
## Decision
Option 3. This is thanks to the easy way to configure, use it; With the use of a timer it makes it easy to do the backup in a safe way without having to shut the server, and also having some disaster recovery procedures.
The use of a timer is thanks to the tools that have and the possibilities it gives than the ones the cron give.
