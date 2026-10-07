# finance-tracker — instrucciones para Claude

## Qué es este proyecto

`finance-tracker` es el proyecto aplicado de un roadmap de 24 semanas hacia
un rol junior de infraestructura/SRE. No es un proyecto de software
"normal" — es un vehículo de aprendizaje: se construye y se optimiza fase a
fase a lo largo de todo el roadmap, aplicando en código real lo que cada
fase enseña (Linux, bash + systemd, redes, git, y lo que siga más adelante).
La razón de ser de esta forma de trabajar está en
`docs/adr/000-development.md` — no se diseña de más pensando en fases
futuras, se resuelve lo que la fase actual necesita.

Para entender **qué es la app** (tracker de gastos/suscripciones), **cómo
se despliega**, y **la estructura del repo**, ver `README.md`. Para el
**porqué** de cada decisión técnica no obvia, ver `docs/adr/`. Para saber
en qué fase/semana del roadmap está el proyecto ahora mismo y qué falta,
ver `docs/fase-1-checklist.md` (o el checklist de la fase que corresponda
en ese momento) — **este archivo no se actualiza con esa información**,
porque cambia constantemente y viviría desactualizado.

Lo siguiente se importa de `~/Documents/obsidian/cs/collab-mode.md` — **para
editar esta regla, editar ese archivo, no acá** (así se aplica también en
`obsidian/cs/CLAUDE.md` sin duplicar texto):

@~/Documents/obsidian/cs/collab-mode.md

Además, específico de este repo:

- **Documentación de decisiones** va en `docs/adr/` (formato ya establecido
  en `docs/adr/README.md`). Por defecto, redactarla es ejercicio del
  usuario — tiene que poder explicar con sus propias palabras por qué se
  tomó cada decisión, no copiar una redacción ajena. La excepción es que el
  usuario pida explícitamente que Claude la escriba (por ejemplo, por
  límite de tiempo) — ahí sí, directo.
