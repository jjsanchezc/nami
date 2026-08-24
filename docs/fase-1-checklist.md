# Fase 1 — Checklist de progreso (finance-tracker)

Referencia completa del día a día (teoría, horas, recursos): `fase-1-detalle-dia-a-dia.md`
en el vault de Obsidian. Este archivo es la parte accionable de este repo,
escrita como necesidades — no como instrucciones técnicas — para que decidas
vos cómo resolver cada una. Marcá los checks a medida que los vayas
resolviendo y contame en qué punto estamos cuando retomemos.

## Semana 1 — Linux (servidor base)

Se asume completada (servidor levantado, usuario SSH personal, permisos
básicos). No se hace seguimiento granular acá — si falta algo, avisá y lo
sumamos.

## Semana 2 — Shell scripting (bash) + systemd

### Setup del servidor — ya resuelto
- [x] Necesitábamos que el script se detenga temprano, con un mensaje claro,
      si alguien lo corre sin privilegios suficientes.
- [x] Necesitábamos un usuario dedicado a procesos automatizados, que nadie
      pueda usar para loguearse.
- [x] Necesitábamos que ese usuario y tu usuario personal compartieran acceso
      a los datos de la app, sin pisarse permisos entre sí.
- [x] Necesitábamos que la carpeta de la app quedara con los permisos
      correctos para que ambos puedan leer/escribir donde corresponde.
- [x] Necesitábamos que el servidor tuviera Python y un entorno aislado con
      las dependencias, sin pasos manuales.
- [x] Necesitábamos que correr el script una segunda vez no rompiera nada de
      lo ya hecho.
- [x] Necesitábamos que, si algo falla a mitad de camino, el script se
      detenga en vez de seguir de largo dejando un desastre a medias.

### Setup del servidor — pendiente
- [x] Necesitamos que el código del repo (no solo los datos y permisos)
      termine copiado en el lugar donde la app realmente corre — sin
      importar desde dónde se ejecute el script, y sin pisar los datos
      reales que ya existan ahí.
- [x] Una vez copiado el código, necesitamos que el esquema de la base se cree automáticamente, sin que nadie tenga que acordarse de correr algo a mano.

### Backup automático — pendiente (el ítem de "algo real corriendo como systemd")
- [x] Necesitamos que todas las noches, sin que nadie esté logueado, se
      genere una copia de la base de datos — de forma segura, sin
      arriesgarse a copiar el archivo a mitad de una escritura.
- [x] Necesitamos que cada copia quede identificada de alguna forma que no
      pise la de la noche anterior.
- [x] Necesitamos que ese backup corra como el usuario de servicio, no como
      root ni como vos.
- [x] Necesitamos que ese backup sea una tarea puntual que termina (no algo
      que quede corriendo indefinidamente).
- [x] Necesitamos algo que dispare esa tarea automáticamente, todas las
      noches, a una hora fija.
- [x] Necesitamos que, si el servidor estuvo apagado justo a esa hora, el
      backup se corra igual apenas vuelva a estar disponible, en vez de
      perderse esa noche.
- [x] Necesitamos que ese disparador quede activo solo con que el sistema
      arranque, sin que alguien tenga que iniciarlo a mano cada vez.
- [x] Una vez escrito, necesitamos que termine en el lugar donde el sistema
      realmente lee este tipo de configuración, y que se entere de que
      existe.
- [x] Necesitamos poder confirmar, sin adivinar, si está activo y cuándo fue
      (o va a ser) su próxima corrida.
- [ ] Necesitamos poder diagnosticar una falla del backup mirando
      únicamente los logs, sin conjeturar qué pasó.

### Repo — pendiente
- [x] Necesitamos que el archivo de dependencias exista en el repo, aunque
      hoy no haya ninguna que declarar todavía.
- [ ] Necesitamos que quede documentado, en un lugar que cualquiera pueda
      leer, qué decisiones se tomaron esta semana y por qué (usuario/grupo/
      permisos, por qué se eligió lo que se eligió para el backup automático,
      cómo se relaciona el repo con lo que corre en el servidor).

## Semana 3 — Redes (no empezada)

- [ ] Necesitamos que solo se pueda entrar al servidor con una llave, nunca
      con contraseña.
- [ ] Necesitamos que el servidor rechace cualquier conexión a un puerto que
      no sea estrictamente necesario.
- [ ] Necesitamos confirmar que la app sigue siendo alcanzable solo por lo
      que corresponde, ni más ni menos, después de endurecer lo anterior.
- [ ] Necesitamos que las decisiones de esta semana también queden
      documentadas con su porqué.

## Semana 4 — Git a fondo + cierre de Fase 1 (no empezada)

- [x] Necesitábamos que el proyecto estuviera versionado desde el arranque —
      ya lo está.
- [ ] Necesitamos práctica real de ramas, merge y resolución de conflictos
      (puede ser en un repo aparte, no necesariamente acá).
- [ ] Necesitamos confirmar, corriendo todo de punta a punta en un servidor
      limpio, que no hace falta ningún paso manual no documentado.
- [ ] Necesitamos repasar el checklist de cierre completo antes de dar la
      fase por terminada (abajo).

## Checklist de cierre de Fase 1

(igual al del plan general, para tenerlo todo en un solo lugar)

- [ ] Servidor accesible por SSH con configuración propia (no defaults, solo por llave)
- [ ] Script de setup automatizado, reproducible e idempotente
- [ ] Algo real corriendo, gestionado como servicio de systemd
- [ ] Firewall configurado con solo los puertos necesarios abiertos
- [ ] Todo el proyecto versionado en Git con historial limpio
- [ ] README con las decisiones tomadas y el porqué (mini-ADRs)
