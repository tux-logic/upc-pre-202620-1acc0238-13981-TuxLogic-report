```{=typst}
== Project Report Collaboration Insights

Esta sección documenta la infraestructura de repositorios, la metodología de trabajo colaborativo, la distribución equitativa del esfuerzo del equipo *TuxLogic* y las métricas de contribución registradas en la organización de GitHub para la entrega del informe del proyecto (*ShiftIq*).

#v(0.5em)
=== 1. Enlaces a Repositorios Oficiales del Proyecto

El desarrollo del ecosistema *ShiftIq* se gestiona bajo la organización oficial en GitHub:  
#text(weight: "bold", fill: rgb("#1e3a8a"))[Organización de GitHub:] #link("https://github.com/tux-logic")[https://github.com/tux-logic]

#v(0.5em)
#table(
  columns: (22%, 38%, 40%),
  stroke: 0.4pt + rgb("#cbd5e1"),
  inset: (x: 8pt, y: 6pt),
  fill: (x, y) => if y == 0 { rgb("#1e3a8a") } else if calc.even(y) { rgb("#f8fafc") } else { white },
  table.header(
    [#text(fill: white, weight: "bold")[Repositorio]],
    [#text(fill: white, weight: "bold")[Descripción / Propósito]],
    [#text(fill: white, weight: "bold")[Enlace Público]],
  ),
  [*Project Report*], [Informe académico oficial en formato Markdown (GFM) y Typst PDF.], [#link("https://github.com/tux-logic/upc-pre-202620-1acc0238-13981-TuxLogic-report.git")[https://github.com/tux-logic/upc-pre-202620-1acc0238-13981-TuxLogic-report.git]],
  [*Landing Page*], [Sitio web comercial e informativo del producto ShiftIq.], [#link("https://github.com/tux-logic/Shiftiq-Landing-Page.git")[https://github.com/tux-logic/Shiftiq-Landing-Page.git]],
  [*Backend API*], [Plataforma backend orientada a microservicios bajo Domain-Driven Design (DDD).], [#link("https://github.com/tux-logic/shiftiq-platform.git")[https://github.com/tux-logic/shiftiq-platform.git]],
)
#v(0.5em)

=== 2. Explicación del Proceso de Colaboración y Metodología Git

Para garantizar una trazabilidad rigurosa, la elaboración del informe se rigió bajo las siguientes prácticas de ingeniería de software:

1. *Estrategia de Ramificación (Gitflow):*
   - `main`: Rama de producción donde residen únicamente versiones finales de entrega aprobadas (`v1.0`, `v1.12`).
   - `develop`: Rama principal de integración continua donde se consolidaron los avances del equipo.
   - Ramas de características (`feature/<nombre-caracteristica>`): Ramas aisladas para la redacción y diagramación de secciones específicas del informe.

2. *Control de Calidad mediante Pull Requests (PRs):*
   - Todo cambio hacia la rama `develop` fue sometido a revisión de pares (*Peer Code Review*) mediante solicitudes de extracción en GitHub.
   - Verificación automatizada de sintaxis y compilación sin errores del documento PDF resultante.

3. *Estándar de Commits (Conventional Commits):*
   - Todos los integrantes aplicaron mensajes estructurados con prefijos estandarizados (`feat`, `fix`, `docs`, `style`, `build`, `chore`), facilitando el seguimiento del proyecto.

#v(0.5em)
=== 3. Demostración de Participación y Aportes del Equipo

Los 5 integrantes del equipo *TuxLogic* han participado activamente en la construcción del informe, distribuyendo las responsabilidades según sus áreas de especialización:

#v(0.5em)
#table(
  columns: (22%, 14%, 20%, 44%),
  stroke: 0.4pt + rgb("#cbd5e1"),
  inset: (x: 8pt, y: 6pt),
  fill: (x, y) => if y == 0 { rgb("#1e3a8a") } else if calc.even(y) { rgb("#f8fafc") } else { white },
  table.header(
    [#text(fill: white, weight: "bold")[Estudiante]],
    [#text(fill: white, weight: "bold")[Código]],
    [#text(fill: white, weight: "bold")[Rol Principal]],
    [#text(fill: white, weight: "bold")[Aportes Principales al Informe (AV1 / TB1)]],
  ),
  [*Machacca Soto, Aldo Jeanfranco*], [u202419485], [Backend & Architecture], [Arquitectura DDD (Context Mapping, Bounded Contexts Tácticos), Modelado C4 (Contexto, Contenedores, Despliegue), Pipeline Typst y Automatización SVG.],
  [*Mamani Vilca, Alan Jaivi*], [u20241e299], [Frontend & UX Research], [Diseño y ejecución de entrevistas cualitativas, matriz de arquetipos B2B/B2C, EventStorming estratégico y Candidate Bounded Context Canvases.],
  [*Mallqui Vilca, Dhilsen Armil*], [U202319440], [QA & Requirements], [Investigación de Needfinding, Empathy Maps, User Personas e diagramación estructurada de Impact Mapping para ambos segmentos.],
  [*Ramos Hinostroza, Diego Antonio*], [u202224130], [Backend & DevOps], [Inicialización del repositorio, redacción del Startup Profile, Solution Profile (Lean UX, 5W's 2H's), Target Segments y registro de versiones inicial.],
  [*Vidal Malaga, Jareth Beycker*], [u202316878], [Mobile & Product Owner], [Análisis competitivo de mercado, matriz SWOT, estrategias/tácticas frente a competidores, catálogo de 60 User Stories y Product Backlog priorizado.],
)
#v(0.5em)

=== 4. Métricas de Colaboración y Analíticos de GitHub

A través de las herramientas de analítica de GitHub (*Insights / Contributors*), se constata la actividad constante del equipo durante el periodo de desarrollo de la entrega *TB1*:

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter1/collaboration/github-insights.svg", width: 95%),
    caption: [Analíticos de colaboración de GitHub e historial de contribuciones del equipo TuxLogic.]
  )
]
#v(0.5em)

==== Resumen de Actividad en GitHub (Hito TB1):
- *Total de Commits:* 370+ commits registrados a través de las ramas de desarrollo e integración.
- *Pull Requests Fusionados:* 16 solicitudes de extracción integradas a la rama `develop`.
- *Nivel de Participación:* 100% de los 5 miembros del equipo registran aportes significativos en código, artefactos y documentación.

#v(0.5em)
=== 5. Avance Acumulativo del Proyecto

La documentación del informe sigue un esquema de evolución incremental:
- *Entrega AV1 / Hito Inicial (30/08/2026 - 05/09/2026):* Definición de la startup, problemática inicial y primeros segmentos objetivo (`v1.0` -- `v1.1`).
- *Entrega TB1 / Hito Consolidado (06/09/2026 - 16/09/2026):* Expansión completa del Capítulo I y Capítulo II. Se integraron la investigación cualitativa de usuarios, catálogo de requerimientos con 60 historias de usuario, diagramas de Impact Mapping, modelado EventStorming, Bounded Context Canvases, Context Mapping, Arquitectura C4 y compilación nativa en Typst (`v1.2` -- `v1.12`).

#v(0.5em)
=== 6. Coherencia Interna con el Registro de Versiones

Toda la información expuesta en esta sección guarda una estricta alineación y coherencia con la tabla del *Registro de Versiones del Informe* (Sección 02), reflejando con exactitud los autores, fechas y descripciones de las modificaciones realizadas desde la versión `v1.0` hasta la versión `v1.12`.
```
