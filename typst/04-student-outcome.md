```{=typst}
#set page(
  paper: "a4",
  flipped: true,
  margin: (x: 1.8cm, top: 2cm, bottom: 2cm)
)

== Student Outcome

El curso contribuye al cumplimiento del Student Outcome ABET:

#v(0.5em)
#text(weight: "bold", fill: rgb("#1e3a8a"))[ABET -- EAC -- Student Outcome 7]

#text(weight: "bold")[Criterio:] La capacidad de adquirir y aplicar nuevos conocimientos según sea necesario, utilizando estrategias de aprendizaje apropiadas.

En el siguiente cuadro se describen las acciones realizadas y los enunciados de conclusiones por parte del grupo, que permiten sustentar el haber alcanzado el logro del *ABET -- EAC -- Student Outcome 7* a lo largo de las entregas del proyecto (*AV1* y *TB1*). Como se muestra en la Tabla 1, se detallan por cada participante sus acciones específicas por entrega y las conclusiones acumuladas del equipo:

#v(0.4em)
#align(center)[
  #text(weight: "bold")[Tabla 1] \
  #text(style: "italic")[Matriz de Student Outcomes por Participante y Entrega (Hitos AV1 y TB1)]
]
#v(0.3em)
#table(
  columns: (20%, 58%, 22%),
  stroke: 0.4pt + rgb("#cbd5e1"),
  inset: (x: 8pt, y: 6pt),
  fill: (x, y) => if y == 0 { rgb("#1e3a8a") } else if calc.even(y) { rgb("#f8fafc") } else { white },
  table.header(
    [#text(fill: white, weight: "bold")[Criterio específico]],
    [#text(fill: white, weight: "bold")[Acciones realizadas por integrante (AV1 y TB1)]],
    [#text(fill: white, weight: "bold")[Conclusiones acumuladas]],
  ),
  [
    *Criterio 1:* \
    Actualiza conceptos y conocimientos necesarios para su desarrollo profesional y en especial para su proyecto en soluciones de software.
  ],
  [
    *Mamani Vilca, Alan Jaivi:* \
    - *AV1:* Diseñó, ejecutó y registró las entrevistas cualitativas de investigación del segmento de dueños y administradores de talleres automotrices, investigó y aplicó principios de UX Research, estructuración de EventStorming estratégico, Candidate Bounded Context Canvases, Context Mapping, flujos de mensajes de dominio y el diseño del modelo de arquitectura de software C4 para el producto ShiftIQ.
    - *TB1:* Actualizó conceptos y conocimientos en gestión ágil de proyectos bajo el marco Scrum, liderando la sesión de Sprint Planning con la formulación formal del Sprint Goal estructurado en tres partes, la asignación técnica de líderes de aspectos y colaboradores, la descomposición y estimación del backlog en Jira Software con cuarenta y cinco puntos de historia y tareas técnicas de trabajo, así como el seguimiento y análisis de métricas de productividad y colaboración del equipo. \ \

    *Machacca Soto, Aldo Jeanfranco:* \
    - *AV1:* Profundizó en patrones de arquitectura Domain-Driven Design estratégico y táctico, modelado de arquitectura C4 y la automatización del pipeline de documentos usando Typst y gráficos vectoriales SVG.
    - *TB1:* Adquirió y aplicó conocimientos avanzados en verificación continua de software backend, documentando las evidencias de desarrollo mediante control de versiones en GitFlow con Conventional Commits, la ejecución de la suite automatizada de pruebas unitarias con JUnit 5 y Mockito logrando cuarenta y dos pruebas exitosas, las evidencias de ejecución de endpoints REST y la especificación de contratos de servicios web bajo el estándar OpenAPI y Swagger UI. \ \

    *Ramos Hinostroza, Diego Antonio:* \
    - *AV1:* Actualizó conocimientos en desarrollo DevOps, inicialización de repositorios estandarizados, metodología GitFlow y definición de perfiles de startup y solución bajo principios Lean UX.
    - *TB1:* Adquirió y aplicó conocimientos especializados en diseño de interfaces y experiencia de usuario para aplicaciones móviles, desarrollando wireframes en baja y media fidelidad, diagramas de flujo de pantallas wireflow, mockups en alta fidelidad, diagramas de flujo de interacción de usuario y la construcción del prototipo interactivo navegable en Figma orientado a conductores y administradores de talleres. \ \

    *Mallqui Vilca, Dhilsen Armil:* \
    - *AV1:* Investigó metodologías de Needfinding, diseño de mapas de empatía y la técnica de Impact Mapping para alinear requerimientos técnicos con objetivos de negocio de ambos segmentos.
    - *TB1:* Actualizó conocimientos en diseño visual de sitios web y gestión de configuración de software. Diseñó los wireframes y mockups responsive para escritorio y dispositivos móviles de la Landing Page comercial. Asimismo, en la gestión de configuración de software, especificó el entorno de desarrollo, las políticas de control de versiones bajo GitFlow, las guías de estilo de código y configuró los despliegues continuos en la nube en Vercel y contenedores Docker. \ \

    *Vidal Malaga, Jareth Beycker:* \
    - *AV1:* Aplicó técnicas de análisis competitivo de mercado, matrices comparativas, priorización del Product Backlog y definición de sesenta historias de usuario bajo el formato INVEST.
    - *TB1:* Profundizó en fundamentos de diseño de producto y sistemas de diseño visual, formulando las guías de estilo generales de marca, paleta de colores corporativos, tipografía e iconografía. De igual modo, investigó e implementó la arquitectura de información completa, definiendo sistemas de organización, sistemas de etiquetado, optimización y metadatos para motores de búsqueda y redes sociales, sistemas de búsqueda y esquemas de navegación global.
  ],
  [
    *AV1:* El equipo demostró capacidad de autoaprendizaje continuo al adoptar metodologías y herramientas de vanguardia (DDD, Typst, C4, EventStorming, Impact Mapping), permitiendo estructurar un informe técnico riguroso y una arquitectura de software alineada a la industria. \ \
    *TB1:* Durante la ejecución del Segundo Hito, el equipo consolidó la aplicación de nuevos conocimientos en diseño de interfaces de usuario (guías de estilo, arquitectura de información, wireframes, mockups y prototipos interactivos en Figma), gestión de configuración de software (GitFlow, Conventional Commits y despliegues en Vercel y Render) y la gestión y verificación del Sprint 1 (Scrum en Jira, suites de pruebas JUnit 5 y documentación OpenAPI). El aprendizaje permanente y multidisciplinario permitió articular armónicamente el frontend, backend y diseño móvil bajo estándares profesionales.
  ],
  [
    *Criterio 2:* \
    Reconoce la necesidad del aprendizaje permanente para el desempeño profesional y el desarrollo de proyectos en soluciones de software.
  ],
  [
    *Mamani Vilca, Alan Jaivi:* \
    - *AV1:* Reconoció la necesidad del aprendizaje permanente en metodologías de UX Research y entrevistas cualitativas de campo con actores clave del sector automotriz, manteniendo un ciclo continuo de aprendizaje en herramientas de prototipado e ingeniería de software para iterar las soluciones de ShiftIQ.
    - *TB1:* Comprendió la necesidad de capacitarse continuamente en marcos de trabajo ágiles bajo Scrum y herramientas de gestión colaborativa como Jira Software, reconociendo que la gestión eficaz del backlog, la correcta estimación de velocidad del equipo y el seguimiento de métricas de colaboración son competencias profesionales indispensables para liderar proyectos de software escalables en la industria. \ \

    *Machacca Soto, Aldo Jeanfranco:* \
    - *AV1:* Reconoció la importancia de profundizar continuamente en patrones emergentes de microservicios, seguridad en arquitecturas distribuidas y herramientas de compilación documental eficientes.
    - *TB1:* Reconoció la trascendencia del aprendizaje continuo en aseguramiento de calidad, pruebas automatizadas y estándares de documentación de APIs bajo OpenAPI y Swagger, comprendiendo que mantenerse actualizado en técnicas de testing unitario y testing de integración es fundamental para mitigar la deuda técnica y garantizar contratos estables en el desarrollo profesional de backend. \ \

    *Ramos Hinostroza, Diego Antonio:* \
    - *AV1:* Comprendió la necesidad de capacitarse constantemente en prácticas de integración y entrega continua, automatización de infraestructura y gestión ágil para acelerar el ciclo de entregas de software.
    - *TB1:* Reconoció la necesidad de actualización constante en principios de diseño de interacción móvil, pautas de accesibilidad y diseño centrado en el usuario mediante Figma, valorando que el aprendizaje continuo en herramientas de diseño permite traducir requerimientos de usuario complejos en interfaces móviles fluidas y ergonómicas. \ \

    *Mallqui Vilca, Dhilsen Armil:* \
    - *AV1:* Reconoció la relevancia del aprendizaje continuo en ingeniería de requerimientos, aseguramiento de calidad y metodologías ágiles centradas en el valor del cliente.
    - *TB1:* Comprendió que la gestión de configuración de software, la estandarización de convenciones de código y la automatización de despliegues en la nube en plataformas como Vercel y Docker son áreas de evolución constante, haciendo imperativo el autoaprendizaje continuo para mantener flujos de desarrollo modernos y confiables. \ \

    *Vidal Malaga, Jareth Beycker:* \
    - *AV1:* Valoró la importancia del aprendizaje permanente en gestión de producto, análisis del mercado tecnológico y estrategia digital para mantener la competitividad de las soluciones móviles.
    - *TB1:* Reconoció la necesidad de capacitarse de manera sostenida en sistemas de diseño escalables, estándares web de accesibilidad y posicionamiento orgánico en motores de búsqueda, entendiendo que la arquitectura de información evoluciona constantemente a la par de los hábitos de navegación del usuario digital.
  ],
  [
    *AV1:* El desarrollo de la entrega evidenció que el aprendizaje continuo es un pilar indispensable para afrontar desafíos complejos de software, garantizando adaptabilidad, calidad técnica y crecimiento profesional permanente en el equipo. \ \
    *TB1:* El avance hacia el Segundo Hito reafirmó que el aprendizaje permanente es esencial para responder con rapidez a cambios tecnológicos en el desarrollo móvil y backend, garantizando que el equipo mantenga altos estándares de calidad, colaboración ágil y resiliencia profesional ante requerimientos técnicos crecientes.
  ]
)
#v(0.5em)

#set page(
  paper: "a4",
  flipped: false,
  margin: (x: 2.5cm, top: 2.8cm, bottom: 2.5cm)
)
```
