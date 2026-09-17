```{=typst}
== Registro de Versiones

#v(0.5em)
#table(
  columns: (10%, 14%, 26%, 1fr),
  stroke: 0.4pt + rgb("#cbd5e1"),
  inset: (x: 8pt, y: 6pt),
  fill: (x, y) => if y == 0 { rgb("#1e3a8a") } else if calc.even(y) { rgb("#f8fafc") } else { white },
  table.header(
    [#text(fill: white, weight: "bold")[Versión]],
    [#text(fill: white, weight: "bold")[Fecha]],
    [#text(fill: white, weight: "bold")[Autor]],
    [#text(fill: white, weight: "bold")[Descripción de modificación]],
  ),
  [1.0], [30/08/2026], [Diego Antonio Ramos Hinostroza], [Estructura inicial del informe y repositorio para el proyecto ShiftIq (TuxLogic).],
  [1.1], [05/09/2026], [Diego Antonio Ramos Hinostroza], [Incorporación del Capítulo I completo: Startup Profile, Solution Profile y Target Segments.],
  [1.2], [07/09/2026], [Dhilsen Armil Mallqui Vilca], [Documentación de la sección de Needfinding, Empathy Maps y definición de User Personas.],
  [1.3], [08/09/2026], [Aldo Jeanfranco Machacca Soto], [Reorganización de la estructura modular del reporte e implementación del pipeline de compilación PDF con Typst.],
  [1.4], [09/09/2026], [Aldo Jeanfranco Machacca Soto], [Integración del artefacto Big Picture EventStorming en el capítulo de Needfinding.],
  [1.5], [10/09/2026], [Alan Jaivi Mamani Vilca], [Ejecución y registro de las Entrevistas #1 y #2 (Segmento 1 - Talleres Automotrices B2B) y estructuración de la matriz de arquetipos.],
  [1.6], [11/09/2026], [Jareth Beycker Vidal Malaga], [Análisis competitivo de mercado, matriz SWOT y tabla de estrategias y tácticas frente a competidores.],
  [1.7], [15/09/2026], [Alan Jaivi Mamani Vilca], [Documentación de EventStorming estratégico (Collect, Refine, Track Causes) y Candidate Bounded Context Canvases.],
  [1.8], [15/09/2026], [Alan Jaivi Mamani Vilca], [Desarrollo y diseño del Modelo de Arquitectura de Software C4 (Contexto, Contenedores y Despliegue), Context Mapping y Modelado de Flujos de Mensajes de Dominio.],
  [1.9], [16/09/2026], [Aldo Jeanfranco Machacca Soto], [Especificación técnica de los Bounded Contexts de Dominio Táctico (IAM, Inventory, Operations, Core, Fleet, Billing y Shared).],
  [1.10], [16/09/2026], [Jareth Beycker Vidal Malaga], [Incorporación del catálogo completo de Historias de Usuario (User Stories) y Product Backlog priorizado con estimación de Story Points.],
  [1.11], [16/09/2026], [Dhilsen Armil Mallqui Vilca], [Inclusión de diagramas de Impact Mapping estructurados para los segmentos de talleres automotrices y conductores.],
  [1.12], [16/09/2026], [Aldo Jeanfranco Machacca Soto], [Optimización tipográfica en Typst, tablas en formato horizontal (Landscape), gráficos vectoriales SVG (Mermaid C4) e imágenes del equipo.],
)
#v(0.5em)
```
