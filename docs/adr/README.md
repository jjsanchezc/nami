# ADRs

In this directory are all the Architectural Decision Records (ADR's), but first things first. Which requirements does these ASR have to fulfill?

## Structure of ADRs
The structure of each ADR file is based on the [Decision Record Template by Michael Nygard](https://github.com/architecture-decision-record/architecture-decision-record/blob/main/locales/en/templates/decision-record-template-by-michael-nygard/index.md). With some subtle changes. 

This file consists of:
### Title
The document have names that are short nun phrases with it corresponding ADR number

### Status
- What is the status, such as:
  - proposed
  - accepted
  - rejected
  - deprecated
  - superseded
  - etc...

- A decision may be "proposed" if the project stakeholders haven't agreed with it yet, or "accepted" once it is agreed. If a later ADR changes or reverses a decision, it may be marked as "deprecated" or "superposed" with a reference to its replacement

### Context
- This section describes the forces at play, including:
  - technological 
  - political
  - social
  - project local
These forces are probably in tension, and should be called out as such.

- What is the issue that we're seeing that is motivating this decision or change? 

- The language in this section is value-neutral. It simply describing facts

### Decision <option1>
What is the change that we're proposing and/or doing?
### Options <option2>
Which options/solutions/changes are taken in consideration for solving the problem.
> [!NOTE]
> Inside of each option must have pros and cons

### Consequences
What becomes easier or more difficult to do because of this change?
> [!NOTE]
> If the <option2> is chosen then this part should NOT exist

### Decision
Final decision with its explanation
> [!NOTE]
> If the <otption2> is chosen this part MUST exist

## Requirements
1. This is an education project so, more than the final app is learning
2. At the end of the development, the application Must be resilient.

## Table of ADRs
0.[Design and development](./000-development.md)
1.[Databases](./001-databases.md)
2.[Deployment and Server Setup](./002-deploy-and-setup.md)
3.[Server Connection](./003-server-connection.md)
4.[Server security](./004-server-security.md)

### Design and development
All decisions that've been taken before starting writing any code.

### Databases
Database type, engine, and backup strategy for `finance.db`.

### Deployment and Server Setup
The service account/permissions model used to run automated tasks, and how
code gets from the git repo to where it actually runs on the server.

### Server connection
All things that changed in the server to provide connection to the client

### Server security
All decisions that have been made to the server in terms of security
