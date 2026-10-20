# ADR 005 Cloud IAM
# ADR 005.1 Main user
## Context
With the creation of an AWS account and project, should I use the root user to manage, create modify and configure all the project.
## Status
Accepted
## Decision
The final decision is the creation of a dedicated IAM user to do all the job. And for better practices, create IAM groups with defined permissions and then associate them with the user.
Using root :
- Accidental damage: 
  - Maybe I run a command that I should not and cause irreversible damage
- Vulnerability exploitation:
  - If a service get hacked that service will be with the root account and might put in risk all the account
## Consequences
- Having just the needed groups(with its respective permissions) enables the ability to scale the users without giving each user specific permissions.
- Having to create a dedicated user will bring an extra configuration (creation of the user and groups, configuration of each group), maybe, will have to add new permissions to a group because there are things that right now I don't need or I don't know I need
- If I allow the dedicated user to modify its own permissions this could be in a real context a security risk, but I'm the only one who is in this project and I know what I do in terms of what permissions should I have for this account.
