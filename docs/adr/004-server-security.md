# ADR 004 Server Security

# ADR 004.1 choosing Firewall
## Context
For the project we need to choose a firewall program/tool, most of them have its own perks. Remember, for this project I need something I can handle, manage and works fine for the current scale, complexity, stage of the project

## Status
Accepted

## Options
- nftables
  - Pros:
    - Can customize whatever I want
    - Have more tools for every task
  - Cons:
    - With that level of customization, comes with much more configuration than other options
- ufw
  - Pros:
    - It hides the complex syntax of the underlying backend.
    - Have huge impact with easy commands
    - Native in Ubuntu
  - Cons:
    - Don't have the tools or customization of other options.
- firewalld:
  - Pros:
    - Changes can be done immediately in the runtime environment. No restart of the service or daemon is needed
    - With the firewall D-Bus interface its is simple for services.
  - Cons:
    - higher learning curve than ufw
    - Simple tasks often require longer, less intuitive command strings compared to UFW
## Decision
`ufw`. The current state of the project makes ufw perfect for the job, due to the current size and complexity of the project and the possibilities that ufw allow me to do


# ADR 004.2 ufw rules
## Context
Using ufw comes with an important decision, and that decision is "which rules do I need in this project?".I have to take in consideration of the requirements, and those are:
- Creating the rules just for the current tools and needs

## Status
Accepted

## Decision
- Default policy: Deny every incoming traffic
- Create an exception/explicit rule to that policy: allow incoming traffic in port 1222 TCP 
## Consequences
Have more control on the incoming traffic, more security in the server.
In the future there is a high possibility that more of those exception/explicit rules for every port needed
