# Naming
- Always on lowercase (kebab-case)
```
<project>-<scope>-[<role>-]<type>
```
`project`: Project the resource belongs to.
`scope`: Where the resource lives inside the project — the environment for
`nami`, the lab id for `labs`.
`role`: What the resource does (`public`, `private`, `app`, ...). Omitted when
the resource is the only one of its type in its scope (e.g. a single VPC or
Internet Gateway).
`type`: What the resource is (see the list of values below).

examples:
```
nami-prod-vpc
nami-prod-app-ec2
labs-w06-public-subnet
labs-w06-nat-eip        # the Elastic IP *of* the NAT: role = nat
```

## Project list of values
- `nami`
- `labs`

## Scope list of values
- `nami` → the environment:
  - `prod`: Production
  - `dev`: Development
  - `test`: Testing
- `labs` → the lab id: `w` + the roadmap week, two digits (`w06`, `w07`...),
  so labs sort in order.

## Type list of values
Same abbreviation AWS uses as the resource ID prefix, when there is one.

| Type     | Resource         | AWS ID prefix |
| -------- | ---------------- | ------------- |
| `vpc`    | VPC              | `vpc-`        |
| `subnet` | Subnet           | `subnet-`     |
| `igw`    | Internet Gateway | `igw-`        |
| `nat`    | NAT Gateway      | `nat-`        |
| `eip`    | Elastic IP       | `eipalloc-`   |
| `rtb`    | Route table      | `rtb-`        |
| `sg`     | Security group   | `sg-`         |
| `ec2`    | EC2 instance     | `i-` (`ec2` used instead, more readable) |

New resource types get added here as they show up.

# Tagging
- Always on lowercase (kebab-case), except the `Name` key: AWS uses `Name`
  (capital N) as the resource's display name in the console.

## Mandatory tags (every resource)
```
Name        : <the resource name, following the naming rule>
project     : [nami, labs]
environment : [prod, dev, test, sandbox]   # labs are always sandbox
managed-by  : [manual, terraform]
```

## Labs-only tags
```
lab     : <lab id, same as the name's scope>   # e.g. w06
expires : <date the lab gets destroyed>       # YYYY-MM-DD
```

example (lab):
```
Name        : labs-w06-vpc
project     : labs
environment : sandbox
managed-by  : manual
lab         : w06
expires     : 2026-10-23
```
example (nami):
```
Name        : nami-prod-vpc
project     : nami
environment : prod
managed-by  : terraform
```

# Why
- **One name shape for every project**, with different values per project:
  a single shape can be filtered and validated the same way everywhere
  (including from Terraform). Only the meaning of `scope` changes.
- **`type` stays in the name, even if it's partly redundant.** AWS already
  knows the type (ID prefix, console section), but without it names collide:
  VPC, IGW and NAT would all be `labs-w06`; subnet, route table, security
  group and instance would all be `labs-w06-public`. Names are also read
  outside the console (tickets, chats, diagrams, notes), where the ID prefix
  isn't there.
- **Temporary resources get an `expires` date tag, not a word in the name.**
  "tmp" says *that* something is temporary; a date says *when* to delete it.
- **Name and tags, both.** The name is for people to read; tags are for AWS
  to filter: cleanup (`lab = w06` in Tag Editor) and cost per project
  (`project` as a cost allocation tag).

Sources:
- [AWS — Best Practices for Tagging AWS Resources](https://docs.aws.amazon.com/whitepapers/latest/tagging-best-practices/tagging-best-practices.html)
  (Table 6 uses `Prod, Dev, Test, Sandbox` as environment values).
- [AWS — Cost allocation tags](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html)
- [Azure — Resource naming](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming)
  (AWS doesn't define a naming convention; Azure's official one includes a
  resource type abbreviation).
