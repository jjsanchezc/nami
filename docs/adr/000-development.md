# ADR 000 Design and development

## ADR 000 application development

### Status
Accepted
### Context
I'm developing a finance application the goal is to make it optimized, reliable, usable and useful, nonetheless this application is a project for my [SRE / Infrastructure roadmap](#https://github.com/jjsanchezc/SRE-Roadmap/tree/dev/cs) meaning that I want to learn and understand the most of each phase.

### Options
1. Design every part of the application (all 24 weeks and all phases), looking forward to the most efficient and optimized app.
  - Pros:
    1. Wouldn't repeat everything in each phase
    2. In case of any modifications these would be small
  - Consequences:
    1. Take too long to make it.
    2. I don't know all the things in each phase

2. Design just the parts that have to be done just in the specific phase.
  - Pros:
    1. I have to apply most of the things I learn in the phase
    2. Relate the new knowledge to the previous phases
    3. Learn how to implement and adapt the current designs and implementations to the new knowledge without.
    4. In case of learning something new, acknowledge the differences that the change could make to the application
    5. New technologies could be learnt faster if I already know the "bases"(or core) of it.
  - Consequences:
    1. Will have to re-design some parts every time I finish a phase.
    2. The application in the beginning will be slow, might under-perform.

### Decision
The main reason of the project is to learn, thanks to that, the `Option.2` is the one. The trade-offs are worth.

