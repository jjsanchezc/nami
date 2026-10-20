# Fase 2 — Checklist de progreso (finance-tracker)

Referencia completa del día a día (teoría, labs, recursos):
`~/Documents/obsidian/cs/fase-2-detalle-dia-a-dia.md`. Este archivo es la
parte accionable de este repo (y de la cuenta de AWS del proyecto), escrita
como necesidades — no como instrucciones técnicas — para que decidas tú cómo
resolver cada una. Los labs sueltos de cada día no se siguen aquí, solo lo que
deja algo en el proyecto. Marca los checks a medida que los vayas resolviendo
y avísame en qué punto estamos cuando retomemos.

**Para toda la fase:** se trabaja contra una cuenta real de AWS, así que cada
día de labs termina sin nada corriendo que cobre por hora. No es algo que se
resuelve una sola vez, por eso no tiene casilla.

## Semana 5 — Fundamentos de nube y AWS: cuenta, IAM, consola vs CLI

- [ ] Necesitamos que la cuenta nos avise si el gasto supera lo esperado —
      configurado antes de crear cualquier otro recurso.
- [ ] Necesitamos que la identidad "dueña de todo" de la cuenta quede
      protegida con algo más que una contraseña, y que no se use para el
      trabajo diario.
- [x] Necesitamos una identidad dedicada para el trabajo de esta fase, con
      solo los permisos que hacen falta — y que, si mañana se sumara otra
      persona, no haya que configurarle permisos uno por uno.
- [ ] Necesitamos poder operar la cuenta desde la terminal con esa identidad,
      y confirmar sin adivinar con qué identidad nos ve AWS.
- [x] Necesitamos una forma consistente de nombrar y etiquetar los recursos
      del proyecto, para no mezclarlos con labs ni con otra cosa de la cuenta.
- [x] Necesitamos que quede documentado por qué se trabaja con una identidad
      dedicada y no con la de la cuenta raíz.

## Semana 6 — Cómputo y redes en AWS: EC2, VPC, subnets, security groups

- [ ] Necesitamos un diseño de red propio para el proyecto (no el que trae la
      cuenta por defecto): qué partes quedan expuestas a internet, cuáles no,
      y por qué. En un diagrama, todavía no en código.
- [ ] Necesitamos decidir qué de lo que ya corre en el servidor de Fase 1
      tiene sentido llevar a esta infraestructura y qué no — solo diseño, se
      construye en las semanas 8-9.
- [ ] Necesitamos que quede documentado el diseño de red elegido y por qué.
- [ ] Necesitamos que, al cerrar la semana, no quede nada de lo armado a mano
      corriendo y cobrando.

## Semana 7 — Storage y bases de datos básicas: S3, RDS (conceptual)

- [ ] Necesitamos decidir dónde viven los datos y los backups del proyecto en
      la nube (si es que viven ahí), comparándolo con lo que ya resuelve el
      backup de Fase 1 — que sea una decisión, no un default.
- [ ] Necesitamos que cualquier almacenamiento que use el proyecto sea
      privado: accesible solo por la identidad que lo necesita, nunca público.
- [ ] Necesitamos que quede documentada la decisión de storage y por qué.
- [ ] Necesitamos borrar los recursos de prueba que ya no se usan.

## Semana 8 — Terraform: providers, resources, state

- [ ] Necesitamos que la infraestructura del proyecto empiece a existir como
      código en este repo, basada en el diseño de red (semana 6) y la
      decisión de storage (semana 7).
- [ ] Necesitamos que el registro de lo que Terraform cree que existe no viva
      solo en tu máquina ni termine versionado en git, y que dos ejecuciones
      al mismo tiempo no lo corrompan.
- [ ] Necesitamos que nada sensible ni generado por la herramienta termine en
      un commit.
- [ ] Necesitamos que los recursos que cree Terraform sigan la convención de
      `docs/conventions/` (semana 5).
- [ ] Necesitamos que quede documentado por qué Terraform y no otra
      herramienta ni la consola a mano.
- [ ] Necesitamos que los labs sueltos queden destruidos antes del fin de
      semana.

## Semana 9 (cierre) — Terraform: módulos + proyecto de cierre

- [ ] Necesitamos que el código de infraestructura esté organizado en piezas
      reutilizables con responsabilidades claras, no todo en un archivo.
- [ ] Necesitamos práctica real de ramas sobre este repo: un cambio a la
      infraestructura que pase por una rama antes de llegar a la principal.
- [ ] Necesitamos confirmar, levantando todo desde cero, que no hace falta
      ningún paso manual no documentado — mismo criterio de "servidor limpio"
      de Fase 1.
- [ ] Necesitamos que el README explique cómo se levanta la infraestructura y
      resuma las decisiones de las semanas 5-8.
- [ ] Necesitamos repasar el checklist de cierre completo antes de dar la
      fase por terminada (abajo).

## Checklist de cierre de Fase 2

(igual al del detalle de la fase, para tenerlo todo en un solo lugar)

- [ ] `terraform apply` levanta toda la infraestructura sin pasos manuales
- [ ] Estructura en módulos, no todo en un archivo
- [ ] VPC/red propia, no la default de la cuenta
- [ ] State remoto (no local, no versionado en git)
- [ ] README con las decisiones de diseño documentadas (mini-ADRs)
- [ ] Alarma de facturación configurada desde la semana 5
