## 1.1. Startup Profile

### 1.1.1. Descripción de la Startup

TuxLogic es una iniciativa tecnológica concebida y desarrollada por estudiantes de la carrera de Ingeniería de Software de la Universidad Peruana de Ciencias Aplicadas (UPC). Nuestra propuesta se materializa a través de ShiftIq, un ecosistema digital diseñado para transformar el modelo operativo tradicional de los talleres automotrices en el Perú, impulsando una transición estructural desde un esquema de mantenimiento reactivo hacia un modelo predictivo, preventivo e inteligente.

Para articular esta propuesta de valor, ShiftIq integra una arquitectura multiplataforma compuesta por aplicaciones web y móviles sincronizadas con dispositivos de diagnóstico a bordo. A través de esta integración de hardware, el sistema recolecta telemetría y códigos de diagnóstico de fallas (DTC) en tiempo real, los cuales son procesados de manera segura para anticipar incidencias mecánicas, optimizar los cronogramas de intervención técnica y traducir métricas complejas en información comprensible tanto para el personal técnico como para el conductor.

**Misión:**
La misión de TuxLogic como empresa es innovar en sector del mantenimiento y servicio automotriz en el país mediante una plataforma tecnológica integral que facilite la transición hacia un mantenimiento preventivo y predictivo basado en datos. En TuxLogic buscamos profesionalizar la administración de los talleres mecánicos, optimizar sus procesos operativos y comerciales, y fortalecer la confianza y transparencia en la relación con los conductores.

**Visión:**
En TuxLogic, tenemos la visión de consolidarnos como la plataforma referente en el mercado nacional y regional en soluciones de software para la gestión de talleres mecánicos y el monitoreo vehicular inteligente, promoviendo la rentabilidad de las empresas del sector, la extensión de la vida útil del parque automotor y una mayor seguridad vial.


### 1.1.2. Perfiles de integrantes del equipo

```{=typst}
#v(0.5em)
#grid(
  columns: (1fr),
  gutter: 1.2em,

  // 1. Mamani Vilca, Alan Jaivi
  rect(
    width: 100%,
    fill: rgb("#f8fafc"),
    stroke: 0.6pt + rgb("#cbd5e1"),
    radius: 6pt,
    inset: 12pt,
    [
      #grid(
        columns: (60pt, 1fr),
        gutter: 12pt,
        align: (center + horizon, left + top),
        [
          #circle(radius: 24pt, fill: rgb("#e0e7ff"), stroke: 1.5pt + rgb("#1e3a8a"))[
            #align(center + horizon)[#text(size: 12pt, weight: "bold", fill: rgb("#1e3a8a"))[AM]]
          ]
        ],
        [
          #text(size: 12pt, weight: "bold", fill: rgb("#1e3a8a"))[Mamani Vilca, Alan Jaivi]
          #h(1fr)
          #text(size: 9.5pt, fill: rgb("#b91c1c"), weight: "bold")[u20241e299]
          #v(-4pt)
          #text(size: 9pt, style: "italic", fill: rgb("#64748b"))[Estudiante de Ingeniería de Software -- Desarrollo & UI/UX]
          #v(0.3em)
          #text(size: 10pt)[
            Estudiante de Ingeniería de Software de la Universidad Peruana de Ciencias Aplicadas (UPC). Enfocado en el diseño e implementación de interfaces de usuario intuitivas y el desarrollo frontend para aplicaciones móviles y plataformas web.
          ]
        ]
      )
    ]
  ),

  // 2. Machacca Soto, Aldo Jeanfranco
  rect(
    width: 100%,
    fill: rgb("#f8fafc"),
    stroke: 0.6pt + rgb("#cbd5e1"),
    radius: 6pt,
    inset: 12pt,
    [
      #grid(
        columns: (60pt, 1fr),
        gutter: 12pt,
        align: (center + horizon, left + top),
        [
          #circle(radius: 24pt, fill: rgb("#fee2e2"), stroke: 1.5pt + rgb("#b91c1c"))[
            #align(center + horizon)[#text(size: 12pt, weight: "bold", fill: rgb("#b91c1c"))[AM]]
          ]
        ],
        [
          #text(size: 12pt, weight: "bold", fill: rgb("#1e3a8a"))[Machacca Soto, Aldo Jeanfranco]
          #h(1fr)
          #text(size: 9.5pt, fill: rgb("#b91c1c"), weight: "bold")[u202419485]
          #v(-4pt)
          #text(size: 9pt, style: "italic", fill: rgb("#64748b"))[Estudiante de Ingeniería de Software -- Backend Developer & AI Architecture]
          #v(0.3em)
          #text(size: 10pt)[
            Estudiante de Ingeniería de Software centrado en el diseño, desarrollo y mantenimiento de soluciones tecnológicas eficientes, escalables y de calidad. Especializado en el desarrollo backend y la arquitectura de APIs bajo Domain-Driven Design (DDD) con Java (Spring Boot), Python, C++, JavaScript y TypeScript, junto con React y Next.js. Experiencia en gestión de bases de datos optimizadas, procesos de despliegue e integración de agentes de inteligencia artificial en flujos de trabajo.
          ]
        ]
      )
    ]
  ),

  // 3. Mallqui Vilca, Dhilsen Armil
  rect(
    width: 100%,
    fill: rgb("#f8fafc"),
    stroke: 0.6pt + rgb("#cbd5e1"),
    radius: 6pt,
    inset: 12pt,
    [
      #grid(
        columns: (60pt, 1fr),
        gutter: 12pt,
        align: (center + horizon, left + top),
        [
          #circle(radius: 24pt, fill: rgb("#e0e7ff"), stroke: 1.5pt + rgb("#1e3a8a"))[
            #align(center + horizon)[#text(size: 12pt, weight: "bold", fill: rgb("#1e3a8a"))[DM]]
          ]
        ],
        [
          #text(size: 12pt, weight: "bold", fill: rgb("#1e3a8a"))[Mallqui Vilca, Dhilsen Armil]
          #h(1fr)
          #text(size: 9.5pt, fill: rgb("#b91c1c"), weight: "bold")[U202319440]
          #v(-4pt)
          #text(size: 9pt, style: "italic", fill: rgb("#64748b"))[Estudiante de Ingeniería de Software -- QA & Análisis de Requerimientos]
          #v(0.3em)
          #text(size: 10pt)[
            Estudiante de Ingeniería de Software de la Universidad Peruana de Ciencias Aplicadas (UPC). Con habilidades orientadas al análisis de procesos, aseguramiento de la calidad de software (QA) y diseño funcional de soluciones tecnológicas orientadas al usuario.
          ]
        ]
      )
    ]
  ),

  // 4. Ramos Hinostroza, Diego Antonio
  rect(
    width: 100%,
    fill: rgb("#f8fafc"),
    stroke: 0.6pt + rgb("#cbd5e1"),
    radius: 6pt,
    inset: 12pt,
    [
      #grid(
        columns: (60pt, 1fr),
        gutter: 12pt,
        align: (center + horizon, left + top),
        [
          #circle(radius: 24pt, fill: rgb("#e0e7ff"), stroke: 1.5pt + rgb("#1e3a8a"))[
            #align(center + horizon)[#text(size: 12pt, weight: "bold", fill: rgb("#1e3a8a"))[DR]]
          ]
        ],
        [
          #text(size: 12pt, weight: "bold", fill: rgb("#1e3a8a"))[Ramos Hinostroza, Diego Antonio]
          #h(1fr)
          #text(size: 9.5pt, fill: rgb("#b91c1c"), weight: "bold")[u202224130]
          #v(-4pt)
          #text(size: 9pt, style: "italic", fill: rgb("#64748b"))[Estudiante de Ingeniería de Software -- Backend & DevOps]
          #v(0.3em)
          #text(size: 10pt)[
            Estudiante de sexto ciclo de Ingeniería de Software en la UPC. Cuenta con dominio en diseño de arquitectura, desarrollo backend y consumo de servicios web. Experiencia en construcción e integración de APIs REST utilizando Java (Spring Boot), C\# y Python, modelado de bases de datos relacionales y NoSQL, estructuración de comunicación cliente-servidor en apps móviles, Docker y Git.
          ]
        ]
      )
    ]
  ),

  // 5. Vidal Malaga, Jareth Beycker
  rect(
    width: 100%,
    fill: rgb("#f8fafc"),
    stroke: 0.6pt + rgb("#cbd5e1"),
    radius: 6pt,
    inset: 12pt,
    [
      #grid(
        columns: (60pt, 1fr),
        gutter: 12pt,
        align: (center + horizon, left + top),
        [
          #circle(radius: 24pt, fill: rgb("#e0e7ff"), stroke: 1.5pt + rgb("#1e3a8a"))[
            #align(center + horizon)[#text(size: 12pt, weight: "bold", fill: rgb("#1e3a8a"))[JV]]
          ]
        ],
        [
          #text(size: 12pt, weight: "bold", fill: rgb("#1e3a8a"))[Vidal Malaga, Jareth Beycker]
          #h(1fr)
          #text(size: 9.5pt, fill: rgb("#b91c1c"), weight: "bold")[u202316878]
          #v(-4pt)
          #text(size: 9pt, style: "italic", fill: rgb("#64748b"))[Estudiante de Ingeniería de Software -- Mobile & Frontend Developer]
          #v(0.3em)
          #text(size: 10pt)[
            Estudiante de Ingeniería de Software de la Universidad Peruana de Ciencias Aplicadas (UPC). Especializado en la implementación de aplicaciones móviles y soluciones de interacción para usuario en entornos multiplataforma.
          ]
        ]
      )
    ]
  )
)
```
