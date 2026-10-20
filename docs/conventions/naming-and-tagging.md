# Naming
- Always on lowercase (kebab-case)
```
<project>-<environment>-<component>
```
`project`: Name of the project
`environment`: Environment that the service is managing
`component`: Role that this service have.

example:
```
nami-prod-backup
```

## Project list of values
- `nami`
- `labs`

## Environment list of values
- `prod`: production 
- `test`: Testing
- `dev`: Development

# Tagging
- Always on lowercase (kebab-case)
```
project : [nami,labs]
environment : [prod,dev,test]
managed-by : [manual, terraform]
```
example
```
project : nami
environment : dev
managed-by : terraform
```
