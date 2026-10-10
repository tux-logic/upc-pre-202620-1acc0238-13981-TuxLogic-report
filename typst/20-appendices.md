```{=typst}
= Anexos

=== Anexo A: Enlaces a Repositorios Oficiales y Despliegues de la Plataforma ShiftIQ

Como se muestra en la *Tabla 1*, a continuación se presentan los repositorios oficiales y enlaces de despliegue en producción de la organización *TuxLogic* en GitHub, que concentran el código fuente, la infraestructura de backend en la nube, el sitio web comercial y la documentación académica del proyecto:

#v(0.3em)
#align(center)[
  #text(weight: "bold")[Tabla 1] \
  #text(style: "italic")[Repositorios oficiales y despliegues en producción de la plataforma ShiftIQ]
]
#v(0.3em)
#table(
  columns: (24%, 38%, 38%),
  stroke: 0.4pt + rgb("#cbd5e1"),
  inset: (x: 8pt, y: 6pt),
  fill: (x, y) => if y == 0 { rgb("#1e3a8a") } else if calc.even(y) { rgb("#f8fafc") } else { white },
  table.header(
    [#text(fill: white, weight: "bold")[Componente / Producto]],
    [#text(fill: white, weight: "bold")[Descripción / Propósito]],
    [#text(fill: white, weight: "bold")[Enlace Público Oficial]],
  ),
  [*Project Report*], [Informe académico oficial del proyecto en formato Markdown y Typst PDF.], [#link("https://github.com/tux-logic/upc-pre-202620-1acc0238-13981-TuxLogic-report.git")[Repositorio Reporte]],
  [*Landing Page (Código)*], [Código fuente del sitio web comercial e informativo (HTML5, CSS3, JS).], [#link("https://github.com/tux-logic/Shiftiq-Landing-Page.git")[Repositorio Landing Page]],
  [*Landing Page (Despliegue)*], [Despliegue en producción en la nube de Vercel (100% operativo y responsive).], [#link("https://shiftiq-landing-page.vercel.app/")[shiftiq-landing-page.vercel.app]],
  [*Backend API Platform (Código)*], [Microservicios RESTful con Spring Boot 3.5.5, Java 21, PostgreSQL y DDD.], [#link("https://github.com/tux-logic/shiftiq-platform.git")[Repositorio shiftiq-platform]],
  [*Backend API (Despliegue)*], [Despliegue público en producción del servicio Backend RESTful en Render Cloud.], [#link("https://shiftiq-platform.onrender.com/")[shiftiq-platform.onrender.com]],
  [*Swagger UI / OpenAPI*], [Documentación interactiva y ejecución pública de endpoints REST en Render Cloud.], [#link("https://shiftiq-platform.onrender.com/swagger-ui/index.html")[Swagger UI en Render]],
  [*Mobile App (Código)*], [Aplicación móvil cliente en Flutter / Kotlin Multiplatform para usuarios y talleres.], [#link("https://github.com/tux-logic/shiftiq-mobile-app.git")[Repositorio shiftiq-mobile-app]],
  [*Organización GitHub*], [Espacio organizacional oficial que reúne todos los repositorios de TuxLogic.], [#link("https://github.com/tux-logic")[https://github.com/tux-logic]],
)

#v(0.6em)
=== Anexo B: Registros de Entrevistas Cualitativas (Fase de Needfinding)

De acuerdo con lo detallado en la *Tabla 2*, se presentan los registros de las entrevistas cualitativas realizadas durante la fase inicial de investigación a representantes de talleres automotrices independientes y conductores particulares:

#v(0.3em)
#align(center)[
  #text(weight: "bold")[Tabla 2] \
  #text(style: "italic")[Registro de entrevistas cualitativas de la fase de Needfinding]
]
#v(0.3em)
#table(
  columns: (20%, 42%, 18%, 20%),
  stroke: 0.4pt + rgb("#cbd5e1"),
  inset: (x: 8pt, y: 6pt),
  fill: (x, y) => if y == 0 { rgb("#1e3a8a") } else if calc.even(y) { rgb("#f8fafc") } else { white },
  table.header(
    [#text(fill: white, weight: "bold")[Entrevista]],
    [#text(fill: white, weight: "bold")[Rol del Entrevistado]],
    [#text(fill: white, weight: "bold")[Entrevistador]],
    [#text(fill: white, weight: "bold")[Grabación]],
  ),
  [*Entrevista #1*], [Gerente General de Taller Automotriz (Roberto Silva)], [Alan Mamani], [#link("https://upcedupe-my.sharepoint.com/:v:/g/personal/u20241e299_upc_edu_pe/IQDGi2mwibUOTri_qnCNOE9XAWbkwqGy7kLorGVW-DinwjI?e=jtY4c4")[Ver Grabación 1]],
  [*Entrevista #2*], [Administrador de Taller Automotriz Independiente (Sebastián Rojas)], [Alan Mamani], [#link("https://upcedupe-my.sharepoint.com/:v:/g/personal/u20241e299_upc_edu_pe/IQCP18HU1eTaRpL0g71UYN7UAb1Z9zEjcHkiVFpKXGfQdR0?e=InyIAk")[Ver Grabación 2]],
  [*Entrevista #3*], [Conductora Particular - Perfil Femenino (Fátima Trujillo)], [Jareth Vidal], [#link("https://upcedupe-my.sharepoint.com/:v:/g/personal/u202316878_upc_edu_pe/IQD30_In5tm1RpfV1t5KuupVATa1nIF_ByDb9ye56ItupVE?e=LN696c&nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJTdHJlYW1XZWJBcHAiLCJyZWZlcnJhbFZpZXciOiJTaGFyZURpYWxvZy1MaW5rIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXcifX0%3D")[Ver Grabación 3]],
  [*Entrevista #4*], [Conductor Particular - Perfil Masculino (Aldo Huamán)], [Diego Ramos], [#link("https://upcedupe-my.sharepoint.com/:v:/g/personal/u202224130_upc_edu_pe/IQA6IxCofdt_RIF2FEBLxbqCAcZXLQW-W7Xq_AbzuLo5uxQ?nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJPbmVEcml2ZUZvckJ1c2luZXNzIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXciLCJyZWZlcnJhbFZpZXciOiJNeUZpbGVzTGlua0NvcHkifX0&e=L1qbEP")[Ver Grabación 4]],
)

#v(0.6em)
=== Anexo C: Gestión Ágil y Modelado Colaborativo (Jira Software y Miro)

Como se describe en la *Tabla 3*, las actividades de modelado estratégico DDD y gestión ágil del proyecto se gestionan en las plataformas oficiales siguientes:

#v(0.3em)
#align(center)[
  #text(weight: "bold")[Tabla 3] \
  #text(style: "italic")[Tableros de gestión ágil y modelado visual]
]
#v(0.3em)
#table(
  columns: (24%, 18%, 38%, 20%),
  stroke: 0.4pt + rgb("#cbd5e1"),
  inset: (x: 8pt, y: 6pt),
  fill: (x, y) => if y == 0 { rgb("#1e3a8a") } else if calc.even(y) { rgb("#f8fafc") } else { white },
  table.header(
    [#text(fill: white, weight: "bold")[Artefacto]],
    [#text(fill: white, weight: "bold")[Plataforma]],
    [#text(fill: white, weight: "bold")[Descripción del Contenido]],
    [#text(fill: white, weight: "bold")[Enlace Directo]],
  ),
  [*Tablero Scrum Sprint 1*], [Jira Software], [Proyecto `SHIFTIQ` con 6 Épicas, 11 Historias (`US-01` a `US-08`, `TS-01` a `TS-03`), 18 tareas técnicas y 45 Story Points completados en *Done*.], [#link("https://tuxlogic.atlassian.net/jira/software/projects/SHIFTIQ/boards/1/backlog")[Tablero Jira]],
  [*Tablero EventStorming*], [Miro], [Dinámicas de Big Picture EventStorming, Domain Events, Process Modelling, Context Discovery y Bounded Contexts.], [#link("https://miro.com/app/board/uXjVHoedhIo=/?share_link_id=281932799218")[Tablero en Miro]],
)

#v(0.6em)
=== Anexo D: Diseño de Interfaces y Prototipado en Figma (Landing Page y Aplicación Móvil)

De acuerdo con lo establecido en la *Tabla 4*, el equipo centraliza la arquitectura de interfaces, guías de estilos, wireframes y prototipos interactivos en los archivos de Figma oficiales:

#v(0.3em)
#align(center)[
  #text(weight: "bold")[Tabla 4] \
  #text(style: "italic")[Archivos de diseño y prototipado interactivo en Figma]
]
#v(0.3em)
#table(
  columns: (28%, 24%, 32%, 16%),
  stroke: 0.4pt + rgb("#cbd5e1"),
  inset: (x: 8pt, y: 6pt),
  fill: (x, y) => if y == 0 { rgb("#1e3a8a") } else if calc.even(y) { rgb("#f8fafc") } else { white },
  table.header(
    [#text(fill: white, weight: "bold")[Artefacto UI/UX]],
    [#text(fill: white, weight: "bold")[Componente]],
    [#text(fill: white, weight: "bold")[Descripción / Alcance]],
    [#text(fill: white, weight: "bold")[Enlace]],
  ),
  [*ShiftIQ Landing Page*], [Sitio Web Comercial], [Guía de estilo, paleta cromática, wireframes y mockups desktop y mobile.], [#link("https://www.figma.com/design/lPYkoOHRmUky6IlMzqHFQX/ShiftIQ-Landing-Page?node-id=1-3&t=cq27eb1l0QqEWQwj-1")[Abrir Figma]],
  [*Shift IQ Mobile App*], [Aplicación Móvil], [Wireframes, wireflows funcionales, mockups y prototipo interactivo.], [#link("https://www.figma.com/design/Vi2I1dal5Ifx52U1Z00qf3/Shift-IQ-Wireframes?node-id=0-1&t=vsBCs3oHJjYhHEmB-0")[Abrir Figma]],
)
```
