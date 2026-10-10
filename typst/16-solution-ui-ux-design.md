```{=typst}
= Capítulo III: Solution UI/UX Design

== 3.1. Product design

=== 3.1.1. Style Guidelines

La propuesta visual de ShiftIQ se aplica a dos superficies: la landing page (sitio comercial responsive en español e inglés) y la aplicación móvil Android (Kotlin, Material Design 3). Las decisiones de branding, color, tipografía y espaciado buscan que un dueño de taller o un conductor lea el estado de un vehículo de un vistazo, con baja densidad de interfaz y sin jerga técnica.

==== 3.1.1.1. General Style Guidelines

*Branding y tono de comunicación*

- *Marca:* el logotipo escribe "ShiftIQ" y resalta "IQ" con el azul de acento, para destacar la parte de inteligencia diagnóstica.
- *Tono:* profesional, directo y orientado a la acción preventiva. Con el taller es preciso y operativo; con el conductor usa lenguaje cotidiano y acompaña cada código DTC con una explicación y un nivel de urgencia.
- *Redacción:* voz activa y verbos de acción ("Agendar cita", "Ver diagnóstico"). Los mensajes de error explican qué ocurrió y cómo recuperarse, sin culpar al usuario.
- *Idioma:* español (Perú) por defecto. La landing ofrece inglés mediante el selector ES/EN.

*Paleta de colores*

Como se presenta en la *Tabla 14*, la paleta cromática de ShiftIQ delimita los colores primarios, acentos y tokens semánticos de severidad que garantizan consistencia y legibilidad en todas las interfaces:

*Tabla 14*  
*Paleta cromática institucional y tokens semánticos de ShiftIQ*


#v(0.5em)
#table(
  columns: (16%, 12%, 36%, 26%, 10%),
  stroke: 0.4pt + rgb("#cbd5e1"),
  inset: (x: 6pt, y: 6pt),
  align: (col, row) => if row == 0 { center + horizon } else if col == 1 or col == 4 { center + horizon } else { left + horizon },
  fill: (col, row) => if row == 0 { rgb("#1e3a8a") } else if calc.even(row) { rgb("#f8fafc") } else { white },
  table.header(
    [#text(fill: white, weight: "bold")[Color]],
    [#text(fill: white, weight: "bold")[Hex]],
    [#text(fill: white, weight: "bold")[Significado y Justificación]],
    [#text(fill: white, weight: "bold")[Ejemplo de uso en la interfaz]],
    [#text(fill: white, weight: "bold")[Muestra]],
  ),
  [*Primary Blue*], [`#1E3A8A`], [Azul de marca de la landing y del reporte. Transmite confianza técnica y estabilidad.], [Botones primarios, enlace activo del navbar, sidebar, encabezados.], [#box(width: 20pt, height: 20pt, radius: 3pt, fill: rgb("#1E3A8A"), stroke: 0.5pt + rgb("#cbd5e1"))],
  [*Accent Sky Blue*], [`#60A5FA`], [Acento legible sobre fondos oscuros ("IQ" del logotipo). Representa también la severidad *Baja* (informativa).], [Logotipo sobre fondo oscuro, badge de severidad Baja.], [#box(width: 20pt, height: 20pt, radius: 3pt, fill: rgb("#60A5FA"), stroke: 0.5pt + rgb("#cbd5e1"))],
  [*Secondary Teal*], [`#0FB5BA`], [Teal que evoca telemetría en tiempo real y monitoreo activo.], [Dispositivo OBD2 "Vinculado", gráficos de telemetría.], [#box(width: 20pt, height: 20pt, radius: 3pt, fill: rgb("#0FB5BA"), stroke: 0.5pt + rgb("#cbd5e1"))],
  [*Preventive Green*], [`#3DBE6C`], [Mantenimiento preventivo exitoso y vehículo saludable.], [Badge "Sin alertas", estados "Completada" y "Pagada".], [#box(width: 20pt, height: 20pt, radius: 3pt, fill: rgb("#3DBE6C"), stroke: 0.5pt + rgb("#cbd5e1"))],
  [*Severity Amber*], [`#F2A93B`], [Ámbar cálido para severidad *Media*: visible sin ser alarmante.], [Badge de severidad Media en el tablero de alertas.], [#box(width: 20pt, height: 20pt, radius: 3pt, fill: rgb("#F2A93B"), stroke: 0.5pt + rgb("#cbd5e1"))],
  [*Severity Orange*], [`#C94A0E`], [Naranja quemado para severidad *Alta*: pide atención pronta y se distingue del ámbar y del carmesí.], [Badge de severidad Alta, sugerencia de agendar cita.], [#box(width: 20pt, height: 20pt, radius: 3pt, fill: rgb("#C94A0E"), stroke: 0.5pt + rgb("#cbd5e1"))],
  [*Severity Crimson*], [`#D7263D`], [Rojo carmesí para severidad *Crítica* (riesgo inminente de falla) y para acciones destructivas.], [Badge de severidad Crítica, notificación push urgente, botón "Cancelar cita".], [#box(width: 20pt, height: 20pt, radius: 3pt, fill: rgb("#D7263D"), stroke: 0.5pt + rgb("#cbd5e1"))],
  [*Warm Neutral*], [`#F7F5F2`], [Gris cálido que reduce la fatiga visual y resalta los datos de telemetría.], [Fondo general del panel, tarjetas KPI.], [#box(width: 20pt, height: 20pt, radius: 3pt, fill: rgb("#F7F5F2"), stroke: 0.5pt + rgb("#cbd5e1"))],
  [*Graphite*], [`#2B2B33`], [Gris grafito de alto contraste para texto principal y códigos DTC.], [Cuerpo de texto, descripciones técnicas.], [#box(width: 20pt, height: 20pt, radius: 3pt, fill: rgb("#2B2B33"), stroke: 0.5pt + rgb("#cbd5e1"))],
  [*White*], [`#FFFFFF`], [Claridad y espacio en tarjetas y modales.], [Tarjetas de planes, modales de agendamiento, texto sobre Primary Blue.], [#box(width: 20pt, height: 20pt, radius: 3pt, fill: rgb("#FFFFFF"), stroke: 0.5pt + rgb("#94a3b8"))],
)
#v(0.5em)


*Escala de severidad de alertas DTC*

La severidad nunca se comunica solo con color: cada nivel combina color, ícono (Bootstrap Icons) y etiqueta de texto, de acuerdo con los criterios detallados en la *Tabla 15*:

*Tabla 15*  
*Matriz de escala de severidad y codificación visual de alertas DTC*

#v(0.3em)
#table(
  columns: 6,
  stroke: 0.4pt + rgb("#cbd5e1"),
  inset: (x: 8pt, y: 6pt),
  fill: (x, y) => if y == 0 { rgb("#1e3a8a") } else if calc.even(y) { rgb("#f8fafc") } else { white },
  table.header(
    [#text(fill: white, weight: "bold")[Nivel (API)]],
    [#text(fill: white, weight: "bold")[Etiqueta en UI]],
    [#text(fill: white, weight: "bold")[Color]],
    [#text(fill: white, weight: "bold")[Texto sobre el color]],
    [#text(fill: white, weight: "bold")[Ícono (Material Symbols)]],
    [#text(fill: white, weight: "bold")[Criterio]],
  ),
  [`LOW`], [Baja], [Accent Sky Blue], [Graphite], [`info`], [Informativa, sin acción inmediata.],
  [`MEDIUM`], [Media], [Severity Amber], [Graphite], [`error`], [Programar atención en los próximos días.],
  [`HIGH`], [Alta], [Severity Orange], [White], [`warning`], [Atender pronto; se sugiere agendar cita.],
  [`CRITICAL`], [Crítica], [Severity Crimson], [White], [`dangerous`], [Riesgo de falla inminente; notificación push inmediata.],
)
#v(0.3em)


*Tipografía*

La familia principal es *Outfit* (Google Fonts), usada en títulos y cuerpo con pesos 400, 500, 600 y 700. Los códigos DTC (por ejemplo, `P0301`) se muestran en *Roboto Mono* para distinguirlos del texto y evitar confusiones entre caracteres. En la *Tabla 16* se detalla la escala tipográfica implementada para Web y Android:

*Tabla 16*  
*Jerarquía y escala tipográfica de ShiftIQ por plataforma*

#v(0.3em)
#table(
  columns: 3,
  stroke: 0.4pt + rgb("#cbd5e1"),
  inset: (x: 8pt, y: 6pt),
  fill: (x, y) => if y == 0 { rgb("#1e3a8a") } else if calc.even(y) { rgb("#f8fafc") } else { white },
  table.header(
    [#text(fill: white, weight: "bold")[Rol]],
    [#text(fill: white, weight: "bold")[Web (landing y aplicación web)]],
    [#text(fill: white, weight: "bold")[Android (Material Design 3)]],
  ),
  [Título principal], [h1, 2.5 rem (40 px), Outfit 600], [Headline Large, 32 sp],
  [Título de sección], [h2, 2 rem (32 px), Outfit 600], [Title Large, 22 sp],
  [Subtítulo], [h5, 1.25 rem (20 px), Outfit 500], [Title Medium, 16 sp],
  [Cuerpo], [1 rem (16 px), Outfit 400], [Body Large 16 sp / Body Medium 14 sp],
  [Botones y etiquetas], [0.875 rem (14 px), Outfit 500], [Label Large, 14 sp],
  [Código DTC], [0.875 rem, Roboto Mono], [14 sp, Roboto Mono],
)
#v(0.3em)


*Espaciado, forma e iconografía*

- *Web:* escala de espaciado de Bootstrap 5.3 (4, 8, 16, 24 y 48 px).
- *Android:* grilla de 8 dp. Margen lateral de 16 dp, 8–16 dp entre elementos relacionados y 24 dp entre secciones.
- *Radios:* 8 px/dp en botones, campos y chips; 12 en tarjetas; 16 en modales y bottom sheets. El CTA del hero usa forma de píldora, como en el mock-up.
- *Iconografía:* Bootstrap Icons en landing y aplicación web; Material Symbols en Android. Tamaño base de 24 px/dp. Todo ícono lleva texto visible o descripción accesible (`aria-label` / `contentDescription`).

*Botones y elementos interactivos*

Como se especifica en la *Tabla 17*, los elementos interactivos se estructuran bajo una jerarquía visual clara:

*Tabla 17*  
*Estilos y estados de botones y componentes interactivos*

#v(0.3em)
#table(
  columns: 3,
  stroke: 0.4pt + rgb("#cbd5e1"),
  inset: (x: 8pt, y: 6pt),
  fill: (x, y) => if y == 0 { rgb("#1e3a8a") } else if calc.even(y) { rgb("#f8fafc") } else { white },
  table.header(
    [#text(fill: white, weight: "bold")[Tipo]],
    [#text(fill: white, weight: "bold")[Estilo]],
    [#text(fill: white, weight: "bold")[Ejemplo]],
  ),
  [Primario], [Fondo Primary Blue, texto White], ["Comenzar ahora", "Agendar cita"],
  [Secundario], [Borde y texto Primary Blue], ["Ver detalle"],
  [Terciario], [Solo texto Primary Blue], ["Cancelar"],
  [Destructivo], [Fondo Severity Crimson, texto White], ["Cancelar cita"],
)
#v(0.3em)


- *Tamaño táctil:* altura y área mínimas de 48 dp/px (48×48).
- *Estados:* normal, hover/pressed, focus, disabled y loading (indicador circular dentro del botón).
- *Foco visible:* anillo de 2 px en Primary Blue sobre fondos claros y en Accent Sky Blue sobre fondos oscuros.

*Patrones de diseño por superficie*

Tal como se resume en la *Tabla 18*, la distribución de componentes responde a las convenciones de cada plataforma:

*Tabla 18*  
*Patrones arquitecturales de navegación y UI por superficie*

#v(0.3em)
#table(
  columns: 3,
  stroke: 0.4pt + rgb("#cbd5e1"),
  inset: (x: 8pt, y: 6pt),
  fill: (x, y) => if y == 0 { rgb("#1e3a8a") } else if calc.even(y) { rgb("#f8fafc") } else { white },
  table.header(
    [#text(fill: white, weight: "bold")[Superficie]],
    [#text(fill: white, weight: "bold")[Navegación]],
    [#text(fill: white, weight: "bold")[Componentes principales]],
  ),
  [Landing], [Navbar fija con enlaces, selector ES/EN y CTA; secciones verticales con anclas], [Acordeón (retos), tarjetas (solución, planes), carrusel (equipo)],
  [Aplicación Android], [Navigation bar inferior (3–5 destinos) + top app bar; menú "Más" para módulos secundarios], [FAB, bottom sheet de detalle, chips de filtro, pestañas, snackbar],
)
#v(0.3em)


*Responsive Design*

- *Landing y aplicación web:* breakpoints de Bootstrap 5.3 (576, 768, 992, 1200 y 1400 px). El diseño base es de 1440 px; en móvil las secciones se apilan en una columna y el menú se colapsa.
- *Android:* clases de tamaño de ventana de Material Design 3: compact (< 600 dp), medium (600–839 dp) y expanded (≥ 840 dp). El primer objetivo son teléfonos Android (compact).

*Estados de carga y feedback*

- *Skeleton screens* en tablas y tarjetas KPI mientras carga el contenido.
- *Indicadores de progreso:* circular para operaciones sin duración conocida; lineal para la sincronización de telemetría.
- *Empty states* con acción sugerida, por ejemplo "Aún no hay alertas activas".
- *Error states* con mensaje claro y botón "Reintentar".
- *Sin conexión:* banner "Sin conexión: los datos se sincronizarán al reconectar", coherente con la persistencia local descrita en las restricciones técnicas.
- *Snackbar* de confirmación con acción "Deshacer" cuando aplica.

*Accesibilidad*

Se sigue WCAG 2.1 nivel AA: contraste mínimo de 4.5:1 en texto normal y 3:1 en texto grande e íconos. De acuerdo con las mediciones presentadas en la *Tabla 19*, todas las combinaciones cumplen holgadamente los estándares normativos:

*Tabla 19*  
*Medición y validación de ratios de contraste cromático bajo WCAG 2.1 AA*

#v(0.3em)
#table(
  columns: 2,
  stroke: 0.4pt + rgb("#cbd5e1"),
  inset: (x: 8pt, y: 6pt),
  fill: (x, y) => if y == 0 { rgb("#1e3a8a") } else if calc.even(y) { rgb("#f8fafc") } else { white },
  table.header(
    [#text(fill: white, weight: "bold")[Combinación]],
    [#text(fill: white, weight: "bold")[Contraste]],
  ),
  [White sobre Primary Blue], [10.36:1],
  [Graphite sobre White], [14.04:1],
  [Graphite sobre Warm Neutral], [12.90:1],
  [White sobre Severity Crimson], [4.96:1],
  [White sobre Severity Orange], [4.70:1],
  [Graphite sobre Severity Amber], [7.03:1],
  [Graphite sobre Secondary Teal], [5.57:1],
  [Graphite sobre Preventive Green], [5.87:1],
  [Graphite sobre Accent Sky Blue], [5.52:1],
  [Accent Sky Blue sobre Primary Blue], [4.07:1 (solo texto grande e íconos)],
)
#v(0.3em)


- *Color:* la severidad y los estados nunca dependen solo del color (ícono + texto).
- *Imágenes y semántica:* toda imagen informativa lleva `alt`; el idioma de la página (`lang`) cambia con el selector ES/EN.
- *Teclado y lectores de pantalla:* navegación completa por teclado en web y `contentDescription` en Android (TalkBack).
- *Zoom:* el texto se puede ampliar hasta 200 % sin pérdida de contenido ni funcionalidad.
- *Movimiento:* la animación del pie de página (Matter.js) se reduce o desactiva cuando el usuario tiene activo `prefers-reduced-motion`.

#v(1em)

=== 3.1.2. Information Architecture

La arquitectura de información de ShiftIQ organiza el contenido de tres superficies: la landing (captación), la aplicación web (operación del taller) y la aplicación Android (supervisión y consulta). Atiende a dos audiencias: el taller (B2B) y el conductor (B2C).

==== 3.1.2.1. Organization Systems

*Esquemas de organización aplicados*

Como se sintetiza en la *Tabla 20*, se definen los esquemas de organización de información aplicados en la plataforma:

*Tabla 20*  
*Esquemas de organización de la información en ShiftIQ*

#v(0.3em)
#table(
  columns: 3,
  stroke: 0.4pt + rgb("#cbd5e1"),
  inset: (x: 8pt, y: 6pt),
  fill: (x, y) => if y == 0 { rgb("#1e3a8a") } else if calc.even(y) { rgb("#f8fafc") } else { white },
  table.header(
    [#text(fill: white, weight: "bold")[Esquema]],
    [#text(fill: white, weight: "bold")[Dónde se aplica]],
    [#text(fill: white, weight: "bold")[Ejemplo]],
  ),
  [Por audiencia], [Landing y aplicaciones], [Sección "Segmentos"; perfiles Taller y Conductor en Android],
  [Por tarea (secuencial)], [Orden de trabajo], [Pendiente → En progreso → Completada → Pagada],
  [Por severidad], [Alertas], [Crítica, Alta, Media y Baja, en ese orden],
  [Cronológico], [Historial del vehículo], [Telemetría y servicios, del más reciente al más antiguo],
  [Por módulo], [Menú de la aplicación web], [Un grupo por contexto del dominio],
)
#v(0.3em)


*Landing page*

La landing guía al visitante desde la primera impresión hasta la conversión, en doce secciones agrupadas por etapa del recorrido, tal como se detalla en la *Tabla 21*:

*Tabla 21*  
*Estructura y recorrido de navegación de la Landing Page*

#v(0.3em)
#table(
  columns: 3,
  stroke: 0.4pt + rgb("#cbd5e1"),
  inset: (x: 8pt, y: 6pt),
  fill: (x, y) => if y == 0 { rgb("#1e3a8a") } else if calc.even(y) { rgb("#f8fafc") } else { white },
  table.header(
    [#text(fill: white, weight: "bold")[Etapa]],
    [#text(fill: white, weight: "bold")[Sección]],
    [#text(fill: white, weight: "bold")[Propósito y contenido]],
  ),
  [Atención], [1. Header / Navbar y Hero], [Marca, enlaces, selector ES/EN y CTA "Comienza ahora"; mensaje principal del producto],
  [Atención], [2. Marco regulatorio], [Franja de instituciones del sector automotriz],
  [Comprensión], [3. Los retos del taller], [Acordeón de problemas operativos junto al texto del desafío],
  [Comprensión], [4. Video], [Contexto visual antes del detalle de la solución],
  [Comprensión], [5. Solución], [Tarjetas de capacidades, resultados esperados y bloque de recomendación],
  [Segmentación], [6. Segmentos], [Las dos experiencias de la plataforma: taller y conductor],
  [Confianza], [7. Historia], [Tres momentos: operación, control y telemetría],
  [Confianza], [8. Equipo], [Carrusel de las personas que construyen ShiftIQ],
  [Confianza], [9. Perspectiva], [Cierre de la mirada del producto antes de los planes],
  [Conversión], [10. Planes], [Comparación de planes (App Free, Básico, Profesional, entre otros) con el plan Profesional recomendado al centro; facturación anual con ahorro de dos meses],
  [Conversión], [11. Contacto], [Llamado final para empezar con ShiftIQ],
  [Cierre], [12. Pie de página], [Enlaces, redes y datos de cierre],
)
#v(0.3em)


*Aplicación móvil Android*

Como se resume en la *Tabla 22*, la aplicación móvil atiende a dos perfiles principales a través de la barra de navegación inferior de Material Design 3 (la cual admite de 3 a 5 destinos, agrupando los secundarios en "Más"):

*Tabla 22*  
*Destinos principales de la barra de navegación inferior por perfil*

#v(0.3em)
#table(
  columns: 2,
  stroke: 0.4pt + rgb("#cbd5e1"),
  inset: (x: 8pt, y: 6pt),
  fill: (x, y) => if y == 0 { rgb("#1e3a8a") } else if calc.even(y) { rgb("#f8fafc") } else { white },
  table.header(
    [#text(fill: white, weight: "bold")[Perfil]],
    [#text(fill: white, weight: "bold")[Destinos de la barra inferior]],
  ),
  [Taller (mecánico, administrador o dueño)], [Inicio, Órdenes, Citas, Vehículos, Más],
  [Conductor], [Mi vehículo, Alertas, Citas, Perfil],
)
#v(0.3em)


En la *Tabla 23* se desglosa el contenido y agrupación modular del perfil Taller, vinculando cada pantalla con su concepto respectivo del modelo de dominio:

*Tabla 23*  
*Organización modular y conceptos de dominio del perfil Taller*

#v(0.3em)
#table(
  columns: 5,
  stroke: 0.4pt + rgb("#cbd5e1"),
  inset: (x: 8pt, y: 6pt),
  fill: (x, y) => if y == 0 { rgb("#1e3a8a") } else if calc.even(y) { rgb("#f8fafc") } else { white },
  table.header(
    [#text(fill: white, weight: "bold")[Grupo]],
    [#text(fill: white, weight: "bold")[Sección]],
    [#text(fill: white, weight: "bold")[Contenido]],
    [#text(fill: white, weight: "bold")[Concepto de dominio]],
    [#text(fill: white, weight: "bold")[Ubicación]],
  ),
  [Operación], [Inicio], [Alertas DTC priorizadas por severidad y resumen del día], [`DtcAlert`], [Barra inferior],
  [Operación], [Órdenes], [Órdenes con sus tareas y repuestos], [`WorkOrder`, `WorkOrderTask`], [Barra inferior],
  [Operación], [Citas], [Agenda del taller], [`Appointment`], [Barra inferior],
  [Flota], [Vehículos], [Placa, marca, modelo, año, VIN y dispositivo OBD2 vinculado], [`Vehicle`, `Obd2Device`], [Barra inferior],
  [Flota], [Clientes], [Datos del cliente], [`Customer`], [Más],
  [Catálogo], [Servicios], [Servicios que ofrece el taller], [`Service`], [Más],
  [Catálogo], [Inventario], [Productos y lotes de repuestos], [`Product`, `ProductBatch`], [Más],
  [Facturación], [Cotizaciones], [Presupuestos por orden], [`Quote`], [Más],
  [Facturación], [Comprobantes y pagos], [Comprobantes emitidos y pagos registrados], [`Voucher`, `Payment`], [Más],
  [Administración], [Sucursales], [Sedes del taller], [`Branch`], [Más],
  [Administración], [Personal], [Empleados y roles], [`Employee`], [Más],
  [Administración], [Suscripción], [Plan y módulos habilitados por sucursal], [`BranchSubscription`], [Más],
)
#v(0.3em)


De acuerdo con la *Tabla 24*, la visibilidad y acceso a las secciones de la aplicación se delimita según el rol del usuario:

*Tabla 24*  
*Matriz de control de acceso y visibilidad de módulos por rol*

#v(0.3em)
#table(
  columns: 4,
  stroke: 0.4pt + rgb("#cbd5e1"),
  inset: (x: 8pt, y: 6pt),
  fill: (x, y) => if y == 0 { rgb("#1e3a8a") } else if calc.even(y) { rgb("#f8fafc") } else { white },
  table.header(
    [#text(fill: white, weight: "bold")[Sección]],
    [#text(fill: white, weight: "bold")[Owner]],
    [#text(fill: white, weight: "bold")[Admin]],
    [#text(fill: white, weight: "bold")[Employee]],
  ),
  [Inicio, Citas], [], [], [],
  [Órdenes], [], [], [(solo asignadas)],
  [Vehículos, Clientes, Servicios, Inventario], [], [], [Solo consulta],
  [Cotizaciones, Comprobantes y pagos], [], [], [—],
  [Sucursales, Personal], [], [], [—],
  [Suscripción], [], [—], [—],
)
#v(0.3em)


Los módulos que el plan contratado no incluye se muestran deshabilitados con un candado y la acción "Mejorar plan", igual que las funciones bloqueadas en la comparación de planes de la landing.

==== 3.1.2.2. Labelling Systems

El etiquetado usa el menor número de palabras posible, sin perder precisión, y se rige por cuatro principios:

- *Consistencia:* la misma etiqueta en menús, botones y mensajes ("Órdenes de trabajo", "Agendar cita").
- *Simplicidad:* máximo tres palabras en menús; sin jerga técnica hacia el conductor.
- *Lenguaje del usuario:* español de Perú ("Placa", "Taller", "Orden de trabajo").
- *Lenguaje ubicuo:* cada etiqueta corresponde a un concepto del modelo de dominio, como se vio en la tabla anterior.

*Etiquetado en la landing (español / inglés)*

Como se detalla en la *Tabla 25*, la Landing Page implementa un diccionario bilingüe de etiquetado para garantizar coherencia en ambos idiomas:

*Tabla 25*  
*Diccionario de etiquetado de navegación en Landing Page (ES/EN)*

#v(0.3em)
#table(
  columns: 3,
  stroke: 0.4pt + rgb("#cbd5e1"),
  inset: (x: 8pt, y: 6pt),
  fill: (x, y) => if y == 0 { rgb("#1e3a8a") } else if calc.even(y) { rgb("#f8fafc") } else { white },
  table.header(
    [#text(fill: white, weight: "bold")[Español]],
    [#text(fill: white, weight: "bold")[Inglés (propuesta)]],
    [#text(fill: white, weight: "bold")[Destino]],
  ),
  [Inicio], [Home], [Hero],
  [Solución], [Solution], [Sección Solución],
  [Segmentos], [Segments], [Sección Segmentos],
  [Nosotros], [About us], [Sección Historia],
  [Equipo], [Team], [Sección Equipo],
  [Planes], [Pricing], [Sección Planes (`#planes`)],
  [Comienza ahora], [Get started], [Sección Contacto (`#contacto`)],
)
#v(0.3em)


*Etiquetado en la aplicación móvil*

*Acciones:* Agendar cita, Vincular dispositivo, Iniciar tarea, Completar tarea, Aprobar cotización, Emitir comprobante, Registrar pago.

*Estados* (tomados de los valores reales de la API), formalizados en la *Tabla 26*:

*Tabla 26*  
*Mapeo de estados de dominio de la API a etiquetas de UI móvil*

#v(0.3em)
#table(
  columns: 3,
  stroke: 0.4pt + rgb("#cbd5e1"),
  inset: (x: 8pt, y: 6pt),
  fill: (x, y) => if y == 0 { rgb("#1e3a8a") } else if calc.even(y) { rgb("#f8fafc") } else { white },
  table.header(
    [#text(fill: white, weight: "bold")[Entidad]],
    [#text(fill: white, weight: "bold")[Valores en la API]],
    [#text(fill: white, weight: "bold")[Etiquetas en UI]],
  ),
  [Alerta DTC], [`LOW`, `MEDIUM`, `HIGH`, `CRITICAL`], [Baja, Media, Alta, Crítica],
  [Orden de trabajo], [`PENDING`, `IN_PROGRESS`, `COMPLETED`, `PAID`], [Pendiente, En progreso, Completada, Pagada],
  [Tarea], [`PENDING`, `DOING`, `COMPLETED`], [Pendiente, En curso, Completada],
  [Cita], [`PENDING`, `COMPLETED`, `CANCELED`], [Pendiente, Completada, Cancelada],
  [Cotización], [`DRAFT`, `APPROVED`, `CANCELED`], [Borrador, Aprobada, Cancelada],
  [Comprobante], [`PENDING`, `PARTIALLY_PAID`, `PAID`, `CANCELED`], [Pendiente, Pago parcial, Pagado, Anulado],
  [Dispositivo OBD2], [`AVAILABLE`, `LINKED`, `NOT_AVAILABLE`], [Disponible, Vinculado, No disponible],
)
#v(0.3em)


==== 3.1.2.3. SEO Tags and Meta Tags

*Landing page*

#raw(block: true, lang: "html", "<html lang=\"es\">\n<head>\n  <title>ShiftIQ – Gestión de talleres con telemetría OBD2</title>\n  <meta name=\"description\" content=\"ShiftIQ conecta tu taller con telemetría OBD2 en tiempo real: órdenes de trabajo, inventario, alertas DTC y app móvil en una sola plataforma.\">\n  <meta name=\"keywords\" content=\"software para talleres mecánicos, gestión de talleres, OBD2, códigos DTC, mantenimiento preventivo, telemetría vehicular, órdenes de trabajo, Perú, ShiftIQ\">\n  <meta name=\"author\" content=\"TuxLogic\">\n  <meta name=\"robots\" content=\"index, follow\">\n  <meta name=\"theme-color\" content=\"#1E3A8A\">\n  <meta property=\"og:title\" content=\"ShiftIQ – Gestión de talleres con telemetría OBD2\">\n  <meta property=\"og:description\" content=\"Órdenes, telemetría OBD2, inventario y app móvil en una plataforma hecha para talleres.\">\n  <meta property=\"og:type\" content=\"website\">\n  <meta property=\"og:locale\" content=\"es_PE\">\n  <link rel=\"canonical\" href=\"https://shiftiq.pe/\">\n</head>")


- *Title (49 caracteres):* incluye la marca y las palabras clave "gestión de talleres" y "OBD2", dentro del límite recomendado de 60.
- *Description (141 caracteres):* resume la propuesta de valor dentro del límite de 160.
- *Idioma:* la traducción ES/EN se hace en el navegador, por lo que los buscadores indexan el español como versión por defecto.
- *`theme-color`:* colorea la barra del navegador móvil con el Primary Blue.

*ASO (App Store Optimization): Google Play*

El primer objetivo de dispositivo es Android, por lo que la ficha se define para Google Play. Google Play no tiene campo de palabras clave: el posicionamiento sale del título y las descripciones. Como se esquematiza en la *Tabla 27*, la configuración delimita los metadatos y requerimientos de la ficha:

*Tabla 27*  
*Especificación de metadatos y activos de ASO para Google Play Store*

#v(0.3em)
#table(
  columns: 3,
  stroke: 0.4pt + rgb("#cbd5e1"),
  inset: (x: 8pt, y: 6pt),
  fill: (x, y) => if y == 0 { rgb("#1e3a8a") } else if calc.even(y) { rgb("#f8fafc") } else { white },
  table.header(
    [#text(fill: white, weight: "bold")[Elemento]],
    [#text(fill: white, weight: "bold")[Límite]],
    [#text(fill: white, weight: "bold")[Valor propuesto]],
  ),
  [Nombre de la app], [30 caracteres], [`ShiftIQ: Taller y diagnóstico` (29)],
  [Descripción breve], [80 caracteres], [`Alertas OBD2 en lenguaje claro y gestión de tu taller en un solo lugar.` (71)],
  [Categoría], [—], [Auto y vehículos],
  [Ícono], [512 × 512 px], [Logotipo de ShiftIQ],
  [Gráfico de función], [1024 × 500 px], [Hero de la landing adaptado],
  [Capturas de teléfono], [2 a 8], [Alertas, detalle de alerta, órdenes y agenda],
)
#v(0.3em)


> *Descripción completa (máx. 4000 caracteres)*
>
> Lleva el diagnóstico de tu vehículo y la gestión de tu taller a tu celular con ShiftIQ.
>
>  Recibe alertas de fallas (códigos DTC) en lenguaje claro y con nivel de urgencia
>  Conecta tu dispositivo OBD2 y revisa el estado de cada vehículo
>  Agenda tu cita en el taller en pocos toques
>  Consulta órdenes de trabajo, tareas y citas del día
>
> CARACTERÍSTICAS PRINCIPALES:
> - Notificaciones solo cuando hay una falla o un servicio por vencer
> - Alertas ordenadas por severidad: baja, media, alta y crítica
> - Historial de servicios y telemetría por vehículo
> - App Free para propietarios de vehículos y app móvil para mecánicos
>
> Ideal para conductores que quieren prevenir averías y para talleres que quieren operar con datos.

==== 3.1.2.4. Searching Systems

*Aplicación móvil Android*

Las listas de Alertas, Órdenes, Vehículos, Citas e Inventario incluyen una barra de búsqueda de Material Design 3 en la parte superior y chips de filtro debajo. La búsqueda por placa es el atajo principal. Tal como se especifica en la *Tabla 28*, los sistemas de búsqueda y filtros por módulo permiten una rápida localización de entidades operativas:

*Tabla 28*  
*Criterios de búsqueda, filtrado y presentación de resultados en la app móvil*

#v(0.3em)
#table(
  columns: 4,
  stroke: 0.4pt + rgb("#cbd5e1"),
  inset: (x: 8pt, y: 6pt),
  fill: (x, y) => if y == 0 { rgb("#1e3a8a") } else if calc.even(y) { rgb("#f8fafc") } else { white },
  table.header(
    [#text(fill: white, weight: "bold")[Lista]],
    [#text(fill: white, weight: "bold")[Búsqueda]],
    [#text(fill: white, weight: "bold")[Filtros (chips)]],
    [#text(fill: white, weight: "bold")[Datos que muestra cada resultado]],
  ),
  [Alertas], [Código DTC, placa], [Severidad, sucursal, fecha], [Severidad, código DTC, descripción, vehículo, fecha],
  [Órdenes], [N.º de orden, placa, cliente], [Estado, mecánico, fecha], [N.º, placa, cliente, estado, mecánico],
  [Vehículos], [Placa, marca, cliente], [Estado del dispositivo OBD2, con alertas activas], [Placa, marca y modelo, año, cliente, dispositivo],
  [Citas], [Cliente, placa], [Estado, fecha], [Fecha y hora, cliente, vehículo, estado],
  [Inventario], [Nombre o código del producto], [Disponibilidad], [Producto, stock, lotes],
)
#v(0.3em)


*Presentación de resultados*

- *Formato:* lista de tarjetas.
- *Ordenamiento por defecto:* en alertas, severidad de mayor a menor y luego fecha más reciente; en las demás listas, fecha más reciente primero.
- *Carga:* incremental al hacer scroll y *pull-to-refresh* para actualizar.
- *Codificación visual:* la severidad y los estados se muestran como badge con color, ícono y texto.
- *Sin resultados:* mensaje con una sugerencia y el botón "Limpiar filtros".

*Landing page*

La landing no incluye buscador: es una página única con secciones ancladas, y el navbar resuelve la localización de contenido.

==== 3.1.2.5. Navigation Systems

*Landing page*

El navbar es fijo sobre el hero y contiene, de izquierda a derecha: el logotipo ShiftIQ; los enlaces Inicio, Solución, Segmentos, Nosotros, Equipo y Planes; el selector de idioma EN | ES; y el CTA "Comienza ahora". El enlace de la sección visible se resalta. Los enlaces llevan a secciones ancladas (`#planes`, `#contacto`). En móvil el menú se colapsa.

*Aplicación móvil Android*

- *Navigation bar inferior* con los destinos de cada perfil (ver 3.1.2.1).
- *Top app bar* con el título de la pantalla y sus acciones. En el perfil Taller incluye el selector de sucursal, la búsqueda y las notificaciones de alertas.
- *Menú "Más":* lista agrupada (Flota, Catálogo, Facturación y Administración) con los módulos secundarios.
- *Pestañas* dentro del detalle de una orden: Resumen, Tareas, Repuestos, Cotización y Pagos.
- *Navegación contextual:* desde una alerta se puede "Agendar cita" o "Crear orden de trabajo"; desde un vehículo, "Vincular dispositivo".
- *Botón atrás* coherente con el sistema operativo; la jerarquía se refleja en el título de cada pantalla.
- *Notificaciones push* que abren directamente el detalle de la alerta.
- *FAB contextual* para la acción principal de cada pantalla, como "Agendar cita".
- *Flujo crítico:* notificación → detalle de alerta → agendar cita, en menos de tres interacciones.

#v(1em)

=== 3.1.3. Landing Page UI Design

==== 3.1.3.1. Landing Page Wireframe

El wireframe fija la estructura de la landing page de ShiftIQ antes de aplicar color de marca, fotografía y tipografía final. La versión web recorre la página en secciones. La versión móvil usa el mismo contenido en una sola columna, porque la landing es responsive.

===== Landing Page

===== 1. Header / Navbar y Hero

La barra de navegación queda sobre el primer pantallazo: marca, enlaces, idioma y llamado a la acción. Debajo está el mensaje principal del taller, tal como se ilustra en la *Figura 100*.


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/wireframe/web/01-header-hero.png", width: 78%),
    caption: [Wireframe Web — Header / Navbar y Hero.]
  )
]

===== 2. Marco regulatorio

En la *Figura 101* se presenta la franja de instituciones del sector, alineada con el contexto de la operación automotriz.


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/wireframe/web/02-marco-regulatorio.png", width: 78%),
    caption: [Wireframe Web — Marco regulatorio.]
  )
]

===== 3. Los retos del taller

Como se observa en la *Figura 102*, se diseña un acordeón de problemas operativos junto al texto del desafío.


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/wireframe/web/03-retos-del-taller.png", width: 78%),
    caption: [Wireframe Web — Los retos del taller.]
  )
]

===== 4. Video

De acuerdo con la *Figura 103*, se dispone un bloque de contexto visual antes de entrar al detalle de la solución.


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/wireframe/web/04-video.png", width: 78%),
    caption: [Wireframe Web — Video.]
  )
]

===== 5. Solución

Tal como se detalla en la *Figura 104*, se presentan las tarjetas de capacidades, resultados esperados y el bloque de recomendación.


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/wireframe/web/05-solucion.png", width: 78%),
    caption: [Wireframe Web — Solución.]
  )
]

===== 6. Segmentos

Como se esquematiza en la *Figura 105*, se visualizan las dos experiencias de la plataforma: taller y conductor.


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/wireframe/web/06-segmentos.png", width: 78%),
    caption: [Wireframe Web — Segmentos.]
  )
]

===== 7. Historia

En la *Figura 106* se estructuran los tres momentos de la propuesta: operación, control y telemetría.


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/wireframe/web/07-historia.png", width: 78%),
    caption: [Wireframe Web — Historia.]
  )
]

===== 8. Equipo

Como se ilustra en la *Figura 107*, se incorpora el carrusel de las personas que construyen ShiftIQ.


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/wireframe/web/08-equipo.png", width: 78%),
    caption: [Wireframe Web — Equipo.]
  )
]

===== 9. Perspectiva

De acuerdo con la *Figura 108*, se establece el cierre de la mirada del producto antes de los planes.


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/wireframe/web/09-perspectiva.png", width: 78%),
    caption: [Wireframe Web — Perspectiva.]
  )
]

===== 10. Planes

Tal como se modela en la *Figura 109*, se presenta la comparación de planes, con el plan recomendado al centro.


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/wireframe/web/10-planes.png", width: 78%),
    caption: [Wireframe Web — Planes.]
  )
]

===== 11. Contacto

Como se muestra en la *Figura 110*, se ubica el llamado final para empezar con ShiftIQ.


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/wireframe/web/11-contacto.png", width: 78%),
    caption: [Wireframe Web — Contacto.]
  )
]

===== 12. Pie de página

En la *Figura 111* se distribuyen los enlaces, redes y datos de cierre.


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/wireframe/web/12-pie.png", width: 78%),
    caption: [Wireframe Web — Pie de página.]
  )
]

===== Mobile Web Browser

En el navegador móvil el menú se colapsa y cada sección pasa a una columna. El contenido es el mismo que en la versión web.

===== 1. Header / Navbar y Hero

Como se observa en la *Figura 112*, el hero se adapta en columna para navegación móvil:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/wireframe/movil/01-header-hero.png", width: 34%),
    caption: [Wireframe Móvil — Header / Navbar y Hero.]
  )
]

===== 2. Marco regulatorio

En la *Figura 113* se muestra la franja institucional en disposición vertical:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/wireframe/movil/02-marco-regulatorio.png", width: 34%),
    caption: [Wireframe Móvil — Marco regulatorio.]
  )
]

===== 3. Los retos del taller

Tal como se detalla en la *Figura 114*, el acordeón de retos operativos se apila en una sola columna:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/wireframe/movil/03-retos-del-taller.png", width: 34%),
    caption: [Wireframe Móvil — Los retos del taller.]
  )
]

===== 4. Video

De acuerdo con la *Figura 115*, se ubica el bloque contenedor de video demostrativo:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/wireframe/movil/04-video.png", width: 34%),
    caption: [Wireframe Móvil — Video.]
  )
]

===== 5. Solución

Como se ilustra en la *Figura 116*, las tarjetas de solución se despliegan en scroll vertical:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/wireframe/movil/05-solucion.png", width: 34%),
    caption: [Wireframe Móvil — Solución.]
  )
]

===== 6. Segmentos

En la *Figura 117* se presenta la segmentación de conductores y talleres adaptada a pantallas móviles:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/wireframe/movil/06-segmentos.png", width: 34%),
    caption: [Wireframe Móvil — Segmentos.]
  )
]

===== 7. Historia

Tal como se aprecia en la *Figura 118*, la línea temporal de la solución se distribuye verticalmente:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/wireframe/movil/07-historia.png", width: 34%),
    caption: [Wireframe Móvil — Historia.]
  )
]

===== 8. Equipo

De acuerdo con la *Figura 119*, el carrusel de integrantes se ajusta para gestos táctiles en teléfonos:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/wireframe/movil/08-equipo.png", width: 34%),
    caption: [Wireframe Móvil — Equipo.]
  )
]

===== 9. Perspectiva

Como se muestra en la *Figura 120*, la sección de perspectiva sintetiza el valor preventivo:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/wireframe/movil/09-perspectiva.png", width: 34%),
    caption: [Wireframe Móvil — Perspectiva.]
  )
]

===== 10. Planes

En la *Figura 121* se presenta la selección de suscripciones con navegación táctil entre tarjetas:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/wireframe/movil/10-planes.png", width: 34%),
    caption: [Wireframe Móvil — Planes.]
  )
]

===== 11. Contacto

Tal como se detalla en la *Figura 122*, el formulario de contacto móvil simplifica la captura de datos:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/wireframe/movil/11-contacto.png", width: 34%),
    caption: [Wireframe Móvil — Contacto.]
  )
]

===== 12. Pie de página

En la *Figura 123* se disponen los enlaces de navegación inferior y redes sociales:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/wireframe/movil/12-pie.png", width: 34%),
    caption: [Wireframe Móvil — Pie de página.]
  )
]

==== 3.1.3.2. Landing Page Mock-up

El mock-up aplica la interfaz final de ShiftIQ sobre la estructura del wireframe: color de marca, fotografía, tipografía y componentes reales. La versión web se muestra dentro del navegador. La versión móvil corresponde al mismo sitio en un navegador web responsive, con el contenido apilado en una columna.

===== Landing Page

El primer pantallazo se presenta dentro del marco del navegador. Las secciones siguientes recorren la página completa.

===== 1. Header / Navbar y Hero

Como se aprecia en la *Figura 124*, el mockup desktop incorpora la imagen hero de alto impacto y la botonera de navegación completa:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/mockup/web/01-header-hero-en-navegador.png", width: 78%),
    caption: [Mockup Web — Header / Navbar y Hero en navegador.]
  )
]

===== 2. Marco regulatorio

En la *Figura 125* se muestra el marco regulatorio con logotipos reales y fondos institucionales:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/mockup/web/02-marco-regulatorio.png", width: 78%),
    caption: [Mockup Web — Marco regulatorio.]
  )
]

===== 3. Los retos del taller

Tal como se ilustra en la *Figura 126*, el acordeón interactivo despliega las problemáticas del sector con contrastes WCAG AA:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/mockup/web/03-retos-del-taller.png", width: 78%),
    caption: [Mockup Web — Los retos del taller.]
  )
]

===== 4. Video

De acuerdo con la *Figura 127*, se integra el reproductor multimedia sobre fondo oscuro:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/mockup/web/04-video.png", width: 78%),
    caption: [Mockup Web — Video.]
  )
]

===== 5. Solución

Como se esquematiza en la *Figura 128*, las tarjetas de producto aplican la paleta Primary Blue y Severity tokens:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/mockup/web/05-solucion.png", width: 78%),
    caption: [Mockup Web — Solución.]
  )
]

===== 6. Segmentos

En la *Figura 129* se diferencian las interfaces del conductor y del dueño de taller:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/mockup/web/06-segmentos.png", width: 78%),
    caption: [Mockup Web — Segmentos.]
  )
]

===== 7. Historia

Tal como se detalla en la *Figura 130*, se expone la narrativa de valor y evolución tecnológica de ShiftIQ:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/mockup/web/07-historia.png", width: 78%),
    caption: [Mockup Web — Historia.]
  )
]

===== 8. Equipo

De acuerdo con la *Figura 131*, se presentan las fotografías y perfiles profesionales del equipo TuxLogic:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/mockup/web/08-equipo.png", width: 78%),
    caption: [Mockup Web — Equipo.]
  )
]

===== 9. Perspectiva

Como se observa en la *Figura 132*, se refuerza el compromiso con la eficiencia y el diagnóstico en tiempo real:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/mockup/web/09-perspectiva.png", width: 78%),
    caption: [Mockup Web — Perspectiva.]
  )
]

===== 10. Planes

En la *Figura 133* se muestra el comparador de precios destacando el plan Profesional como opción recomendada:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/mockup/web/10-planes.png", width: 78%),
    caption: [Mockup Web — Planes.]
  )
]

===== 11. Contacto

Tal como se aprecia en la *Figura 134*, se incluye el formulario de conversión final con validaciones visibles:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/mockup/web/11-contacto.png", width: 78%),
    caption: [Mockup Web — Contacto.]
  )
]

===== 12. Pie de página

En la *Figura 135* se presenta el pie de página con enlaces legales, copyright e integración interactiva:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/mockup/web/12-pie.png", width: 78%),
    caption: [Mockup Web — Pie de página.]
  )
]

===== Mobile Web Browser

Esta versión es el navegador web en móvil. La landing es responsive: el menú se colapsa y cada sección se apila en una sola columna, con el mismo contenido de la versión web. El primer pantallazo se muestra dentro del marco del teléfono.

===== 1. Header / Navbar y Hero

Como se visualiza en la *Figura 136*, el mockup móvil enmarca el Hero en un dispositivo telefónico representativo:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/mockup/movil/01-header-hero-en-telefono.png", width: 34%),
    caption: [Mockup Móvil — Header / Navbar y Hero en teléfono.]
  )
]

===== 2. Marco regulatorio

En la *Figura 137* se exhibe la sección de instituciones reguladoras en vista móvil:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/mockup/movil/02-marco-regulatorio.png", width: 34%),
    caption: [Mockup Móvil — Marco regulatorio.]
  )
]

===== 3. Los retos del taller

Tal como se ilustra en la *Figura 138*, los acordeones adaptados permiten consultar los retos mediante interacción táctil:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/mockup/movil/03-retos-del-taller.png", width: 34%),
    caption: [Mockup Móvil — Los retos del taller.]
  )
]

===== 4. Video

De acuerdo con la *Figura 139*, la cápsula de video se ajusta al ancho completo del visor móvil:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/mockup/movil/04-video.png", width: 34%),
    caption: [Mockup Móvil — Video.]
  )
]

===== 5. Solución

Como se muestra en la *Figura 140*, las tarjetas de características se apilan secuencialmente:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/mockup/movil/05-solucion.png", width: 34%),
    caption: [Mockup Móvil — Solución.]
  )
]

===== 6. Segmentos

En la *Figura 141* se exponen los perfiles de usuario en tarjetas deslizables:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/mockup/movil/06-segmentos.png", width: 34%),
    caption: [Mockup Móvil — Segmentos.]
  )
]

===== 7. Historia

Tal como se detalla en la *Figura 142*, los hitos narrativos de la plataforma se leen de forma fluida en pantalla pequeña:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/mockup/movil/07-historia.png", width: 34%),
    caption: [Mockup Móvil — Historia.]
  )
]

===== 8. Equipo

De acuerdo con la *Figura 143*, las tarjetas de los ingenieros de TuxLogic se adaptan para navegación táctil:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/mockup/movil/08-equipo.png", width: 34%),
    caption: [Mockup Móvil — Equipo.]
  )
]

===== 9. Perspectiva

Como se esquematiza en la *Figura 144*, la propuesta de innovación automotriz se resume en una columna:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/mockup/movil/09-perspectiva.png", width: 34%),
    caption: [Mockup Móvil — Perspectiva.]
  )
]

===== 10. Planes

En la *Figura 145* se presentan las opciones de facturación y paquetes de suscripción optimizados para móviles:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/mockup/movil/10-planes.png", width: 34%),
    caption: [Mockup Móvil — Planes.]
  )
]

===== 11. Contacto

Tal como se aprecia en la *Figura 146*, el formulario de captación optimiza los campos para teclado virtual:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/mockup/movil/11-contacto.png", width: 34%),
    caption: [Mockup Móvil — Contacto.]
  )
]

===== 12. Pie de página

En la *Figura 147* se concluye con los enlaces de navegación, redes sociales y créditos de autoría:


#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/landing-page/mockup/movil/12-pie.png", width: 34%),
    caption: [Mockup Móvil — Pie de página.]
  )
]


#v(1em)

== 3.1.4. Mobile Applications UX/UI Design

El diseño de la experiencia e interfaz de usuario (UX/UI) móvil para *ShiftIQ* se ha concebido bajo los principios del diseño de interacción *Mobile-First*, optimizando las tareas de dos actores fundamentales: el personal técnico y administrativo de talleres mecánicos (*Segmento B2B*) y los conductores particulares (*Segmento B2C*).

Para garantizar una lectura ordenada, exhaustiva y alineada con los principios de *Domain-Driven Design (DDD)* desarrollados en el capítulo 2, el aplicativo móvil se estructura en *ocho módulos funcionales*. Cada módulo abarca sus diversos escenarios operativos y se desglosa en *flujos de interacción organizados como secuencias lado a lado (1 al lado de otro)*. Se exponen primero los esquemas de alambre (*Wireframes*) y posteriormente su concreción en alta fidelidad (*Mock-ups*), documentando el trayecto completo del usuario, componentes interactivos y el cumplimiento riguroso de cada Historia de Usuario (US).

---

=== 3.1.4.1. Mobile Applications Wireframes

Los wireframes representan la estructura esquemática y funcional de baja a media fidelidad de la aplicación móvil de ShiftIQ. Su propósito es definir la jerarquía visual, distribución táctil y los flujos de navegación sin distracciones de estilo final.

A continuación, se presentan *todos los wireframes del sistema*, organizados por módulos funcionales y presentados en *secuencias visuales horizontales lado a lado* para cada escenario de negocio:

==== Módulo 1: Identidad, Autenticación y Seguridad (IAM) - Secuencias de Wireframes
*Historias de Usuario cubiertas: US001, US002, US004, US035, US036*

===== Flujo 1.1: Onboarding y Registro de Usuarios (B2B y B2C)

Proceso de bienvenida, presentación de la propuesta de valor IoT e incorporación de cuentas tanto para talleres mecánicos como para conductores particulares. Tal como se observa en la secuencia interactiva de las *Figuras 148 a 155*, el flujo operativo del módulo guía al usuario paso a paso a través de las siguientes pantallas consecutivas:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod1-01-onboarding-acceso-iot.png", width: 96%),
    caption: [Paso 1: Onboarding y Acceso ShiftIQ IoT (US001, US002)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod1-02-registro-taller-dueno-b2b.png", width: 96%),
    caption: [Paso 2: Registro de Taller y Propietario B2B (US001)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod1-03-registro-asistido-paso-1-propietario.png", width: 96%),
    caption: [Paso 3: Asistente de Registro Paso 1: Datos de Propietario (US001)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod1-04-registro-asistido-paso-2-vehiculo-obd2.png", width: 96%),
    caption: [Paso 4: Asistente de Registro Paso 2: Vehículo y OBD-II (US001, US017)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod1-05-registro-asistido-paso-3-confirmacion.png", width: 96%),
    caption: [Paso 5: Asistente de Registro Paso 3: Confirmación de Cuenta (US001)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod1-06-confirmacion-datos-registro.png", width: 96%),
    caption: [Paso 6: Modal de Verificación de Datos de Registro (US001)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod1-07-crear-cuenta-shiftiq-b2c.png", width: 96%),
    caption: [Paso 7: Creación de Cuenta Conductor B2C (US001)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod1-08-error-creacion-cuenta.png", width: 96%),
    caption: [Paso 8: Manejo de Errores en Registro de Cuenta (US001)]
  ),
)
#v(0.5em)


*Detalle analítico de la secuencia de wireframes:*
- *Paso 1 (Onboarding y Acceso ShiftIQ IoT - US001, US002):* Pantalla introductoria interactiva que destaca las capacidades de telemetría OBD-II en tiempo real y ofrece accesos diferenciados para registro B2B y B2C.
- *Paso 2 (Registro de Taller y Propietario B2B - US001):* Formulario de alta empresarial con captura y validación en tiempo real de razón social, RUC tributario (SUNAT), dirección fiscal y credenciales de administrador.
- *Paso 3 (Asistente de Registro Paso 1: Datos de Propietario - US001):* Etapa inicial del asistente de onboarding con captura de información personal, teléfono y correo electrónico de contacto.
- *Paso 4 (Asistente de Registro Paso 2: Vehículo y OBD-II - US001, US017):* Asociación guiada de la primera unidad vehicular con placa, marca, modelo y emparejamiento preliminar de hardware telemático.
- *Paso 5 (Asistente de Registro Paso 3: Confirmación de Cuenta - US001):* Resumen de validación de los datos ingresados y aceptación de términos del servicio antes de activar la cuenta.
- *Paso 6 (Modal de Verificación de Datos de Registro - US001):* Confirmación final mediante diálogo de seguridad para certificar la exactitud del RUC y documento de identidad del solicitante.
- *Paso 7 (Creación de Cuenta Conductor B2C - US001):* Formulario simplificado para conductores particulares con campos para nombres, correo electrónico, teléfono móvil y contraseña con confirmación.
- *Paso 8 (Manejo de Errores en Registro de Cuenta - US001):* Estado de retroalimentación con alerta visual y desactivación de envío ante campos incompletos, formato de correo no válido o RUC ya registrado.

===== Flujo 1.2: Autenticación e Inicio de Sesión

Acceso seguro a la plataforma móvil mediante credenciales corporativas o autenticación federada. Tal como se observa en la secuencia interactiva de las *Figuras 156 a 157*, el flujo operativo del módulo guía al usuario paso a paso a través de las siguientes pantallas consecutivas:

#v(0.5em)
#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod1-09-iniciar-sesion-b2b.png", width: 85%),
    caption: [Paso 1: Inicio de Sesión Taller Mecánico B2B (US002)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod1-10-iniciar-sesion-b2c.png", width: 85%),
    caption: [Paso 2: Inicio de Sesión Conductor B2C (US002)]
  ),
)
#v(0.5em)


*Detalle analítico de la secuencia de wireframes:*
- *Paso 1 (Inicio de Sesión Taller Mecánico B2B - US002):* Interfaz de ingreso para personal de taller con soporte para credenciales corporativas, recordación de sesión y Google OAuth2.
- *Paso 2 (Inicio de Sesión Conductor B2C - US002):* Vista optimizada para conductores particulares con login directo por correo electrónico, teléfono móvil o autenticación biométrica.

===== Flujo 1.3: Recuperación de Cuenta y Verificación OTP (B2B y B2C)

Mecanismo de seguridad de triple factor para restablecimiento de credenciales olvidadas. Tal como se observa en la secuencia interactiva de las *Figuras 158 a 165*, el flujo operativo del módulo guía al usuario paso a paso a través de las siguientes pantallas consecutivas:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod1-11-recuperacion-paso-1-solicitar-codigo-b2b.png", width: 96%),
    caption: [Paso 1: Recuperación B2B Paso 1: Solicitud de Código (US004)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod1-12-recuperacion-paso-2-verificar-otp-b2b.png", width: 96%),
    caption: [Paso 2: Recuperación B2B Paso 2: Verificación OTP (US004)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod1-13-recuperacion-paso-3-nueva-contrasena-b2b.png", width: 96%),
    caption: [Paso 3: Recuperación B2B Paso 3: Definición de Nueva Clave (US004)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod1-14-recuperacion-paso-3b-modal-exito-b2b.png", width: 96%),
    caption: [Paso 4: Recuperación B2B Paso 3B: Confirmación de Restablecimiento (US004)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod1-15-recuperacion-paso-1-solicitar-codigo-b2c.png", width: 96%),
    caption: [Paso 5: Recuperación B2C Paso 1: Solicitud de Código Conductor (US004)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod1-16-recuperacion-paso-2-verificar-otp-b2c.png", width: 96%),
    caption: [Paso 6: Recuperación B2C Paso 2: Validación OTP Conductor (US004)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod1-17-recuperacion-paso-3-nueva-contrasena-b2c.png", width: 96%),
    caption: [Paso 7: Recuperación B2C Paso 3: Renovación de Clave (US004)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod1-18-recuperacion-paso-3b-modal-exito-b2c.png", width: 96%),
    caption: [Paso 8: Recuperación B2C Paso 3B: Éxito de Restablecimiento (US004)]
  ),
)
#v(0.5em)


*Detalle analítico de la secuencia de wireframes:*
- *Paso 1 (Recuperación B2B Paso 1: Solicitud de Código - US004):* Ingreso del correo electrónico corporativo registrado para el envío de un código de verificación de un solo uso (OTP).
- *Paso 2 (Recuperación B2B Paso 2: Verificación OTP - US004):* Desafío de 6 dígitos numéricos con temporizador de expiración regresivo de 60 segundos y opción de reenvío.
- *Paso 3 (Recuperación B2B Paso 3: Definición de Nueva Clave - US004):* Establecimiento de nueva contraseña con medidor de robustez criptográfica y confirmación de caracteres.
- *Paso 4 (Recuperación B2B Paso 3B: Confirmación de Restablecimiento - US004):* Modal de confirmación exitosa con botón para redirigir directamente al inicio de sesión con las nuevas credenciales.
- *Paso 5 (Recuperación B2C Paso 1: Solicitud de Código Conductor - US004):* Petición de restablecimiento de cuenta para conductores con envío de SMS o correo de verificación seguro.
- *Paso 6 (Recuperación B2C Paso 2: Validación OTP Conductor - US004):* Verificación de autenticidad del conductor mediante código temporal de un solo uso con soporte de teclado numérico.
- *Paso 7 (Recuperación B2C Paso 3: Renovación de Clave - US004):* Actualización de credenciales personales de acceso para el aplicativo móvil del conductor.
- *Paso 8 (Recuperación B2C Paso 3B: Éxito de Restablecimiento - US004):* Notificación de confirmación de clave actualizada redirigiendo al dashboard del conductor.

===== Flujo 1.4: Perfil de Usuario, Actualización de Correo y Seguridad

Gestión autónoma de datos personales, credenciales y validaciones de seguridad por parte del usuario. Tal como se observa en la secuencia interactiva de las *Figuras 166 a 173*, el flujo operativo del módulo guía al usuario paso a paso a través de las siguientes pantallas consecutivas:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod1-19-mi-perfil-ajustes-cuenta.png", width: 96%),
    caption: [Paso 1: Mi Perfil y Ajustes de Cuenta (US035)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod1-20-actualizar-correo-paso-1.png", width: 96%),
    caption: [Paso 2: Actualización de Correo Paso 1 (US035)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod1-21-verificar-codigo-nuevo-correo.png", width: 96%),
    caption: [Paso 3: Verificación de Código de Nuevo Correo (US035)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod1-22-exito-actualizacion-correo.png", width: 96%),
    caption: [Paso 4: Confirmación de Actualización de Correo (US035)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod1-23-error-correo-duplicado.png", width: 96%),
    caption: [Paso 5: Conflicto por Correo Duplicado (Error 409) (US035)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod1-24-cambio-contrasena-principal.png", width: 96%),
    caption: [Paso 6: Cambio de Contraseña Autenticado (US036)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod1-25-cambio-contrasena-exito.png", width: 96%),
    caption: [Paso 7: Confirmación de Cambio de Contraseña (US036)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod1-26-cambio-contrasena-error.png", width: 96%),
    caption: [Paso 8: Error de Validación en Cambio de Contraseña (US036)]
  ),
)
#v(0.5em)


*Detalle analítico de la secuencia de wireframes:*
- *Paso 1 (Mi Perfil y Ajustes de Cuenta - US035):* Panel central de perfil con avatar, sede asignada, rol activo y accesos directos para cambiar contraseña o correo.
- *Paso 2 (Actualización de Correo Paso 1 - US035):* Ingreso de la nueva dirección de correo electrónico con validación de sintaxis antes del envío de verificación.
- *Paso 3 (Verificación de Código de Nuevo Correo - US035):* Comprobación de token numérico enviado al nuevo buzón para certificar la titularidad del usuario.
- *Paso 4 (Confirmación de Actualización de Correo - US035):* Modal interactivo de éxito que confirma la actualización del identificador de acceso principal.
- *Paso 5 (Conflicto por Correo Duplicado (Error 409) - US035):* Mensaje de advertencia modal cuando el correo ingresado ya pertenece a otra cuenta activa en el sistema.
- *Paso 6 (Cambio de Contraseña Autenticado - US036):* Formulario de cambio de clave dentro de la sesión activa con chequeo reactivo de políticas de seguridad.
- *Paso 7 (Confirmación de Cambio de Contraseña - US036):* Retroalimentación visual positiva indicando que la clave fue renovada y las sesiones previas revocadas.
- *Paso 8 (Error de Validación en Cambio de Contraseña - US036):* Notificación de error ante discrepancia en la confirmación o incumplimiento de complejidad de contraseña.


==== Módulo 2: Gestión de Talleres, Sucursales y Licenciamiento (Workshop Management) - Secuencias de Wireframes
*Historias de Usuario cubiertas: US005, US006, US007*

===== Flujo 2.1: Consola de Operaciones y Navegación de Planta

Centro de control del taller mecánico con métricas en tiempo real de ocupación de bahías y navegación general. Tal como se observa en la secuencia interactiva de las *Figuras 174 a 175*, el flujo operativo del módulo guía al usuario paso a paso a través de las siguientes pantallas consecutivas:

#v(0.5em)
#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod2-01-dashboard-operativo-planta.png", width: 85%),
    caption: [Paso 1: Dashboard Operativo de Planta (US006)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod2-02-menu-lateral-taller-drawer.png", width: 85%),
    caption: [Paso 2: Navegación Lateral del Taller (Drawer) (US005)]
  ),
)
#v(0.5em)


*Detalle analítico de la secuencia de wireframes:*
- *Paso 1 (Dashboard Operativo de Planta - US006):* Tablero central con tarjeta de ocupación de bahías (75%), citas del turno, órdenes en curso y alertas telemáticas prioritarias.
- *Paso 2 (Navegación Lateral del Taller (Drawer) - US005):* Menú ergonómico deslizable con accesos a Órdenes, Citas, Bahías, Inventario FIFO, Facturación y Configuración.

===== Flujo 2.2: Directorio de Personal, Alta de Empleado y Revocación de Accesos

Administración integral del equipo técnico de mecánicos y jefes de taller por sucursal. Tal como se observa en la secuencia interactiva de las *Figuras 176 a 179*, el flujo operativo del módulo guía al usuario paso a paso a través de las siguientes pantallas consecutivas:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod2-03-directorio-personal-roles.png", width: 96%),
    caption: [Paso 1: Directorio de Personal y Roles (US005)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod2-04-alta-empleado-rol.png", width: 96%),
    caption: [Paso 2: Alta de Nuevo Empleado y Asignación de Rol (US005)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod2-05-detalle-empleado-roles.png", width: 96%),
    caption: [Paso 3: Ficha de Detalle de Empleado (US005)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod2-06-confirmar-baja-revocar-accesos.png", width: 96%),
    caption: [Paso 4: Confirmar Baja y Revocar Accesos (US005)]
  ),
)
#v(0.5em)


*Detalle analítico de la secuencia de wireframes:*
- *Paso 1 (Directorio de Personal y Roles - US005):* Padrón general de colaboradores con cargo (Mecánico, Administrador, Cajero), estado activo y filtros por sede.
- *Paso 2 (Alta de Nuevo Empleado y Asignación de Rol - US005):* Formulario de registro de técnico con nombre, documento de identidad, especialidad y credenciales iniciales.
- *Paso 3 (Ficha de Detalle de Empleado - US005):* Vista detallada de carga laboral del mecánico, órdenes asignadas, historial de productividad y teléfono.
- *Paso 4 (Confirmar Baja y Revocar Accesos - US005):* Modal de seguridad para desvinculación de técnico y anulación inmediata de tokens de acceso al sistema.

===== Flujo 2.3: Sucursales, Capacidad de Bahías y Suscripción SaaS

Control de infraestructura de sedes físicas y licenciamiento multitenant de la plataforma. Tal como se observa en la secuencia interactiva de las *Figuras 180 a 186*, el flujo operativo del módulo guía al usuario paso a paso a través de las siguientes pantallas consecutivas:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod2-07-detalle-sucursal-bahias.png", width: 96%),
    caption: [Paso 1: Detalle y Capacidad Operativa de Sucursal (US006)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod2-08-suscripcion-plan-sucursal.png", width: 96%),
    caption: [Paso 2: Administración de Suscripción por Sucursal (US007)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod2-09-asignar-plan-sucursal.png", width: 96%),
    caption: [Paso 3: Asignación y Cambio de Plan SaaS (US007)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod2-10-exito-activacion-modulos.png", width: 96%),
    caption: [Paso 4: Activación Exitosa de Módulos Telemáticos (US007)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod2-11-cancelacion-modo-solo-lectura.png", width: 96%),
    caption: [Paso 5: Cancelación de Plan y Modo Solo Lectura (US007)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod2-12-datos-taller-exito.png", width: 96%),
    caption: [Paso 6: Confirmación de Actualización de Datos del Taller (US006)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod2-13-datos-taller-solo-lectura.png", width: 96%),
    caption: [Paso 7: Ficha de Taller en Modo Solo Lectura (US006)]
  ),
)
#v(0.5em)


*Detalle analítico de la secuencia de wireframes:*
- *Paso 1 (Detalle y Capacidad Operativa de Sucursal - US006):* Información operativa de la sede: dirección, teléfono, cantidad de elevadores habilitados y mapa de ubicación.
- *Paso 2 (Administración de Suscripción por Sucursal - US007):* Panel de control del plan contratado (Profesional / Enterprise), fecha de renovación y estado de facturación SaaS.
- *Paso 3 (Asignación y Cambio de Plan SaaS - US007):* Selector comparativo de planes comerciales con detalle de bahías permitidas y módulos habilitados.
- *Paso 4 (Activación Exitosa de Módulos Telemáticos - US007):* Modal de confirmación tras habilitar funciones avanzadas de telemetría OBD-II y diagnósticos automotrices.
- *Paso 5 (Cancelación de Plan y Modo Solo Lectura - US007):* Pantalla informativa ante expiración de suscripción limitando las acciones a consulta histórica sin nuevas OTs.
- *Paso 6 (Confirmación de Actualización de Datos del Taller - US006):* Confirmación exitosa tras la edición de datos fiscales y horarios de atención de la sede.
- *Paso 7 (Ficha de Taller en Modo Solo Lectura - US006):* Visualización restringida de datos corporativos de la sucursal para roles sin permisos de edición.


==== Módulo 3: Inteligencia Vehicular y Diagnóstico OBD-II (Vehicle Intelligence & Diagnostics) - Secuencias de Wireframes
*Historias de Usuario cubiertas: US017, US018, US019, US020, US021, US023, US025*

===== Flujo 3.1: Enrolamiento de Vehículo y Ficha Telemática

Ingreso de la unidad vehicular al ecosistema de monitoreo conectada a su hardware OBD-II. Tal como se observa en la secuencia interactiva de las *Figuras 187 a 188*, el flujo operativo del módulo guía al usuario paso a paso a través de las siguientes pantallas consecutivas:

#v(0.5em)
#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod3-01-registro-vehiculo.png", width: 85%),
    caption: [Paso 1: Registro de Vehículo en Taller (US017)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod3-02-ficha-vehiculo-estado-obd2.png", width: 85%),
    caption: [Paso 2: Ficha del Vehículo y Estado OBD-II (US017)]
  ),
)
#v(0.5em)


*Detalle analítico de la secuencia de wireframes:*
- *Paso 1 (Registro de Vehículo en Taller - US017):* Formulario de ingreso vehicular con captura de placa peruana, marca, modelo, año, VIN y kilometraje de recepción.
- *Paso 2 (Ficha del Vehículo y Estado OBD-II - US017):* Hoja de vida digital del automóvil con historial de visitas técnicas y estado de enlace del dongle telemático.

===== Flujo 3.2: Vinculación y Gestión de Dongles OBD-II Bluetooth

Enlace inalámbrico por Bluetooth BLE con escáneres OBD-II de taller. Tal como se observa en la secuencia interactiva de las *Figuras 189 a 194*, el flujo operativo del módulo guía al usuario paso a paso a través de las siguientes pantallas consecutivas:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod3-03-inventario-alta-dongles-obd2.png", width: 96%),
    caption: [Paso 1: Inventario y Registro de Dongles OBD-II (US021)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod3-04-vinculacion-dispositivo-obd2.png", width: 96%),
    caption: [Paso 2: Búsqueda y Vinculación de Dongle OBD-II (US018)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod3-05-bottom-sheet-vincular-obd2.png", width: 96%),
    caption: [Paso 3: Panel Inferior (Bottom Sheet) de Vinculación (US018)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod3-06-dispositivo-ya-vinculado.png", width: 96%),
    caption: [Paso 4: Aviso de Dispositivo OBD-II Ya Vinculado (US018)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod3-07-confirmar-desvinculacion-obd2.png", width: 96%),
    caption: [Paso 5: Confirmar Desvinculación de Escáner (US020)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod3-08-error-desvinculacion-scanner.png", width: 96%),
    caption: [Paso 6: Error al Desvincular Escáner OBD-II (US020)]
  ),
)
#v(0.5em)


*Detalle analítico de la secuencia de wireframes:*
- *Paso 1 (Inventario y Registro de Dongles OBD-II - US021):* Control de escáneres propiedad del taller con número de serie, versión de firmware y asignación a bahías.
- *Paso 2 (Búsqueda y Vinculación de Dongle OBD-II - US018):* Escaneo de dispositivos Bluetooth BLE cercanos con intensidad de señal RSSI y botón de enlace directo.
- *Paso 3 (Panel Inferior (Bottom Sheet) de Vinculación - US018):* Modal contextual deslizable con instrucciones de conexión al puerto OBD-II y confirmación de handshake.
- *Paso 4 (Aviso de Dispositivo OBD-II Ya Vinculado - US018):* Alerta informativa cuando el escáner seleccionado ya se encuentra enlazado a otra orden de trabajo activa.
- *Paso 5 (Confirmar Desvinculación de Escáner - US020):* Diálogo de confirmación para liberar el dispositivo Bluetooth al finalizar el diagnóstico del automóvil.
- *Paso 6 (Error al Desvincular Escáner OBD-II - US020):* Retroalimentación de fallo por pérdida repentina de conexión BLE o proceso de lectura telemática en ejecución.

===== Flujo 3.3: Telemetría en Vivo, Cola de Sincronización y Modo Offline

Captura continua de datos de sensores automotrices y tolerancia a fallos de conectividad. Tal como se observa en la secuencia interactiva de las *Figuras 195 a 197*, el flujo operativo del módulo guía al usuario paso a paso a través de las siguientes pantallas consecutivas:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod3-09-telemetria-vivo-sensores.png", width: 92%),
    caption: [Paso 1: Telemetría en Vivo de Sensores Automotrices (US019)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod3-10-cola-telemetria-buffer.png", width: 92%),
    caption: [Paso 2: Gestión de Cola de Telemetría en Buffer (US025)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod3-11-modo-offline-telemetria.png", width: 92%),
    caption: [Paso 3: Modo Offline y Telemetría Autónoma (US025)]
  ),
)
#v(0.5em)


*Detalle analítico de la secuencia de wireframes:*
- *Paso 1 (Telemetría en Vivo de Sensores Automotrices - US019):* Tacómetros en tiempo real para RPM de motor, velocidad km/h, temperatura del refrigerante y voltaje de alternador.
- *Paso 2 (Gestión de Cola de Telemetría en Buffer - US025):* Monitor de eventos almacenados localmente en SQLite listos para sincronización con la API central.
- *Paso 3 (Modo Offline y Telemetría Autónoma - US025):* Indicador de operación sin conexión a internet manteniendo la captura continua de sensores en memoria local.

===== Flujo 3.4: Escaneo Electrónico de ECUs y Diagnóstico de Fallas DTC

Barrido integral de subsistemas automotrices y traducción didáctica de códigos SAE. Tal como se observa en la secuencia interactiva de las *Figuras 198 a 203*, el flujo operativo del módulo guía al usuario paso a paso a través de las siguientes pantallas consecutivas:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod3-12-escaneo-obd2-en-curso.png", width: 96%),
    caption: [Paso 1: Escaneo OBD-II de ECUs en Curso (US023)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod3-13-detener-escaneo-obd2.png", width: 96%),
    caption: [Paso 2: Interrupción Controlada del Escaneo (US023)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod3-14-consulta-alertas-dtc.png", width: 96%),
    caption: [Paso 3: Consulta de Códigos de Falla DTC Detectados (US023)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod3-15-detalle-dtc-traduccion-simple.png", width: 96%),
    caption: [Paso 4: Detalle DTC con Traducción Simple y Solución (US023)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod3-16-alertas-telematicas-entrantes.png", width: 96%),
    caption: [Paso 5: Modal de Alertas Telemáticas Entrantes (US023)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod3-17-visor-reporte-tecnico-pdf.png", width: 96%),
    caption: [Paso 6: Visor de Reporte de Diagnóstico Técnico en PDF (US023)]
  ),
)
#v(0.5em)


*Detalle analítico de la secuencia de wireframes:*
- *Paso 1 (Escaneo OBD-II de ECUs en Curso - US023):* Barra de progreso animada con sondeo por subsistemas: Motor, Transmisión, Frenos ABS y Módulo de Emisiones.
- *Paso 2 (Interrupción Controlada del Escaneo - US023):* Modal de cancelación segura del sondeo telemático preservando las fallas leídas hasta el momento.
- *Paso 3 (Consulta de Códigos de Falla DTC Detectados - US023):* Listado de códigos estándar SAE (P0135, P0300) con categorización cromática por severidad crítica o preventiva.
- *Paso 4 (Detalle DTC con Traducción Simple y Solución - US023):* Explicación en lenguaje cotidiano del síntoma mecánico, causa probable y sugerencia técnica de reparación.
- *Paso 5 (Modal de Alertas Telemáticas Entrantes - US023):* Notificación emergente en el taller ante fallas críticas transmitidas por vehículos en circulación.
- *Paso 6 (Visor de Reporte de Diagnóstico Técnico en PDF - US023):* Visualizador integrado del informe telemático con firmas digitales, lecturas de sensores y fallas DTC listo para exportar.


==== Módulo 4: Flotas y Agenda de Citas Técnicas (Fleet & Appointments) - Secuencias de Wireframes
*Historias de Usuario cubiertas: US026, US028, US029, US030, US031, US032*

===== Flujo 4.1: Agenda de Citas Técnicas y Reserva de Bahías

Planificación de ingresos vehiculares según disponibilidad horaria y capacidad de elevadores mecánicos. Tal como se observa en la secuencia interactiva de las *Figuras 204 a 210*, el flujo operativo del módulo guía al usuario paso a paso a través de las siguientes pantallas consecutivas:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod4-01-agenda-citas-sucursal.png", width: 96%),
    caption: [Paso 1: Agenda de Citas de Sucursal (US029)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod4-02-agendar-bahia-tecnica.png", width: 96%),
    caption: [Paso 2: Asignación de Bahía y Elevador Técnico (US028)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod4-03-agendar-cita-y-bahia.png", width: 96%),
    caption: [Paso 3: Formulario Completo de Agendamiento (US028)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod4-04-dialogo-confirmacion-cita.png", width: 96%),
    caption: [Paso 4: Diálogo de Confirmación de Cita (US028)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod4-05-confirmacion-reserva-cita.png", width: 96%),
    caption: [Paso 5: Pantalla de Cita Confirmada con Éxito (US028)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod4-06-error-reserva-turno.png", width: 96%),
    caption: [Paso 6: Conflicto de Horario o Bahía Ocupada (US028)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod4-07-sucursal-no-disponible.png", width: 96%),
    caption: [Paso 7: Sucursal Fuera de Capacidad o Inactiva (US028)]
  ),
)
#v(0.5em)


*Detalle analítico de la secuencia de wireframes:*
- *Paso 1 (Agenda de Citas de Sucursal - US029):* Vista de calendario interactivo por día y semana con turnos ocupados, pendientes de confirmación y libres.
- *Paso 2 (Asignación de Bahía y Elevador Técnico - US028):* Selector de bahía física específica (Elevador 1, Fosa de Alineación) con horario estimado de ocupación.
- *Paso 3 (Formulario Completo de Agendamiento - US028):* Registro de cliente, vehículo, motivo de visita técnica, bahía asignada y duración aproximada del trabajo.
- *Paso 4 (Diálogo de Confirmación de Cita - US028):* Modal de resumen con código de reserva, hora acordada y recordatorio automático programado vía WhatsApp/SMS.
- *Paso 5 (Pantalla de Cita Confirmada con Éxito - US028):* Voucher digital de reserva con botones para añadir al calendario del dispositivo y compartir con el cliente.
- *Paso 6 (Conflicto de Horario o Bahía Ocupada - US028):* Alerta de colisión de turnos sugiriendo inmediatamente los siguientes bloques horarios disponibles en la misma sede.
- *Paso 7 (Sucursal Fuera de Capacidad o Inactiva - US028):* Aviso de mantenimiento de planta o saturación de capacidad operativa en la sede seleccionada.

===== Flujo 4.2: Reprogramación y Cancelación de Citas

Gestión de modificaciones y anulaciones de turnos de servicio. Tal como se observa en la secuencia interactiva de las *Figuras 211 a 213*, el flujo operativo del módulo guía al usuario paso a paso a través de las siguientes pantallas consecutivas:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod4-08-reprogramar-cita-bahia.png", width: 92%),
    caption: [Paso 1: Reprogramación de Cita de Taller (US030)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod4-09-cancelar-cita-motivo.png", width: 92%),
    caption: [Paso 2: Cancelación de Cita con Registro de Causa (US030)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod4-10-mis-citas-cancelacion.png", width: 92%),
    caption: [Paso 3: Historial de Citas y Estado de Cancelación (US030)]
  ),
)
#v(0.5em)


*Detalle analítico de la secuencia de wireframes:*
- *Paso 1 (Reprogramación de Cita de Taller - US030):* Selector interactivo de nueva fecha y franja horaria manteniendo los datos previos del vehículo.
- *Paso 2 (Cancelación de Cita con Registro de Causa - US030):* Diálogo de anulación con lista de motivos predefinidos para control estadístico de pérdidas de turno.
- *Paso 3 (Historial de Citas y Estado de Cancelación - US030):* Listado con estados cromáticos de citas: Programada, En Curso, Completada o Cancelada.

===== Flujo 4.3: Directorio de Clientes Corporativos y Flotas

Gestión de empresas con múltiples unidades vehiculares y conductores asignados. Tal como se observa en la secuencia interactiva de las *Figuras 214 a 223*, el flujo operativo del módulo guía al usuario paso a paso a través de las siguientes pantallas consecutivas:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod4-11-directorio-clientes-flotas.png", width: 96%),
    caption: [Paso 1: Directorio de Clientes y Flotas (US032)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod4-12-formulario-cliente-flota.png", width: 96%),
    caption: [Paso 2: Formulario de Alta de Cliente o Flota (US032)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod4-13-cliente-registrado-exito.png", width: 96%),
    caption: [Paso 3: Confirmación de Cliente Registrado (US032)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod4-14-documento-duplicado-flota.png", width: 96%),
    caption: [Paso 4: Error por RUC o Documento Duplicado (US032)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod4-15-vehiculos-flota-cliente.png", width: 96%),
    caption: [Paso 5: Padrón de Vehículos de la Flota (US026)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod4-16-vehiculos-del-cliente.png", width: 96%),
    caption: [Paso 6: Listado de Vehículos del Cliente (US026)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod4-17-vincular-flota-asociar.png", width: 96%),
    caption: [Paso 7: Asociación de Unidad a Flota Corporativa (US026)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod4-18-asociar-vehiculo-a-flota.png", width: 96%),
    caption: [Paso 8: Confirmación de Vehículo Asociado a Flota (US026)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod4-19-registro-empleado-en-flota.png", width: 96%),
    caption: [Paso 9: Registro de Conductor / Empleado en Flota (US031)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod4-20-conflicto-registro-activo-flota.png", width: 96%),
    caption: [Paso 10: Conflicto por Conductor Activo en Otra Unidad (US031)]
  ),
)
#v(0.5em)


*Detalle analítico de la secuencia de wireframes:*
- *Paso 1 (Directorio de Clientes y Flotas - US032):* Directorio empresarial con buscador por razón social, cantidad de vehículos y estado de cuenta corriente.
- *Paso 2 (Formulario de Alta de Cliente o Flota - US032):* Registro de datos tributarios, contacto comercial, tipo de tarifa preferencial y límite crediticio.
- *Paso 3 (Confirmación de Cliente Registrado - US032):* Modal de confirmación de registro corporativo con botón para comenzar a afiliar sus unidades.
- *Paso 4 (Error por RUC o Documento Duplicado - US032):* Validación de unicidad fiscal impidiendo la duplicidad de registros corporativos en el sistema.
- *Paso 5 (Padrón de Vehículos de la Flota - US026):* Grilla de unidades de la empresa con indicador del estado mecánico de cada una y última inspección.
- *Paso 6 (Listado de Vehículos del Cliente - US026):* Ficha con los vehículos individuales asociados a una misma cuenta corporativa o particular.
- *Paso 7 (Asociación de Unidad a Flota Corporativa - US026):* Vinculación de automóvil por placa y kilometraje al grupo administrativo de la empresa.
- *Paso 8 (Confirmación de Vehículo Asociado a Flota - US026):* Resumen de afiliación de la unidad asignándole centro de costo y política de mantenimiento preventivo.
- *Paso 9 (Registro de Conductor / Empleado en Flota - US031):* Asignación de chófer responsable a una unidad específica de la flota empresarial.
- *Paso 10 (Conflicto por Conductor Activo en Otra Unidad - US031):* Bloqueo de seguridad cuando el conductor ya tiene una asignación activa en otra unidad sin desvincular.


==== Módulo 5: Inventario y Control de Repuestos FIFO (Parts & Inventory) - Secuencias de Wireframes
*Historias de Usuario cubiertas: US008, US009, US010*

===== Flujo 5.1: Catálogo General y Ficha de Repuesto

Exploración de piezas, repuestos, fluidos y componentes con niveles de stock por sede. Tal como se observa en la secuencia interactiva de las *Figuras 224 a 225*, el flujo operativo del módulo guía al usuario paso a paso a través de las siguientes pantallas consecutivas:

#v(0.5em)
#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod5-01-inventario-catalogo-repuestos.png", width: 85%),
    caption: [Paso 1: Catálogo General de Inventario (US008)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod5-02-detalle-ficha-repuesto.png", width: 85%),
    caption: [Paso 2: Ficha Técnica y Detalle de Repuesto (US008)]
  ),
)
#v(0.5em)


*Detalle analítico de la secuencia de wireframes:*
- *Paso 1 (Catálogo General de Inventario - US008):* Buscador de piezas con filtros por categoría (Filtros, Frenos, Aceites, Suspensión), stock mínimo y SKU.
- *Paso 2 (Ficha Técnica y Detalle de Repuesto - US008):* Especificaciones del fabricante, compatibilidad vehicular, ubicación física en almacén y precio sugerido.

===== Flujo 5.2: Alta de Repuesto y Detección de SKU Duplicado

Incorporación de nuevas piezas al maestro de almacén con controles de unicidad. Tal como se observa en la secuencia interactiva de las *Figuras 226 a 228*, el flujo operativo del módulo guía al usuario paso a paso a través de las siguientes pantallas consecutivas:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod5-03-alta-repuesto-catalogo.png", width: 92%),
    caption: [Paso 1: Alta de Nuevo Repuesto en Catálogo (US008)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod5-04-aviso-sku-duplicado.png", width: 92%),
    caption: [Paso 2: Alerta por Código SKU Duplicado (US008)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod5-05-aviso-bloqueo-eliminacion-repuesto.png", width: 92%),
    caption: [Paso 3: Bloqueo de Eliminación de Repuesto en Uso (US008)]
  ),
)
#v(0.5em)


*Detalle analítico de la secuencia de wireframes:*
- *Paso 1 (Alta de Nuevo Repuesto en Catálogo - US008):* Formulario para ingreso de descripción de la pieza, código OEM, SKU interno, unidad de medida y stock de seguridad.
- *Paso 2 (Alerta por Código SKU Duplicado - US008):* Advertencia reactiva bloqueando el guardado si el código de almacén ya existe en otra ficha de producto.
- *Paso 3 (Bloqueo de Eliminación de Repuesto en Uso - US008):* Restricción de integridad impidiendo eliminar piezas con órdenes de trabajo activas o saldo en stock.

===== Flujo 5.3: Ingreso de Lotes FIFO, Ajuste de Existencias y Restricciones

Costeo automatizado First-In, First-Out y prevención de inconsistencias en inventario físico. Tal como se observa en la secuencia interactiva de las *Figuras 229 a 231*, el flujo operativo del módulo guía al usuario paso a paso a través de las siguientes pantallas consecutivas:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod5-06-ingreso-lote-repuestos-fifo.png", width: 92%),
    caption: [Paso 1: Ingreso de Lote de Repuestos (FIFO) (US009)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod5-07-ajuste-manual-existencias.png", width: 92%),
    caption: [Paso 2: Ajuste Manual de Existencias por Auditoría (US010)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod5-08-aviso-saldo-stock-negativo.png", width: 92%),
    caption: [Paso 3: Bloqueo por Saldo de Stock Negativo no Permitido (US010)]
  ),
)
#v(0.5em)


*Detalle analítico de la secuencia de wireframes:*
- *Paso 1 (Ingreso de Lote de Repuestos (FIFO) - US009):* Registro de compra mayorista con fecha de ingreso, proveedor, costo unitario por lote y cantidad recibida.
- *Paso 2 (Ajuste Manual de Existencias por Auditoría - US010):* Modificación controlada de stock físico por rotura, merma o recuento con justificación documental obligatoria.
- *Paso 3 (Bloqueo por Saldo de Stock Negativo no Permitido - US010):* Validación de negocio estricta que impide despachar o dar de baja repuestos que no cuenten con existencia física.


==== Módulo 6: Operaciones de Taller y Órdenes de Trabajo (Work Orders & Execution) - Secuencias de Wireframes
*Historias de Usuario cubiertas: US011, US012, US013, US014, US015, US048, US049, US050*

===== Flujo 6.1: Catálogo Maestro de Servicios y Tarifario

Configuración de la oferta de mano de obra y servicios mecánicos del taller. Tal como se observa en la secuencia interactiva de las *Figuras 232 a 235*, el flujo operativo del módulo guía al usuario paso a paso a través de las siguientes pantallas consecutivas:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod6-01-catalogo-maestro-servicios.png", width: 96%),
    caption: [Paso 1: Catálogo Maestro de Servicios (US011)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod6-02-crear-servicio-precio-valido.png", width: 96%),
    caption: [Paso 2: Creación de Servicio Técnico con Tarifa (US011)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod6-03-detalle-edicion-servicio.png", width: 96%),
    caption: [Paso 3: Ficha de Detalle y Edición de Servicio (US011)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod6-04-bloqueo-servicio-en-uso.png", width: 96%),
    caption: [Paso 4: Bloqueo de Modificación por Servicio en Uso (US011)]
  ),
)
#v(0.5em)


*Detalle analítico de la secuencia de wireframes:*
- *Paso 1 (Catálogo Maestro de Servicios - US011):* Listado de servicios técnicos estandarizados con tarifa de mano de obra y tiempo promedio de ejecución.
- *Paso 2 (Creación de Servicio Técnico con Tarifa - US011):* Formulario para registrar nuevo servicio con validación de costo mayor a cero y asignación de categoría técnica.
- *Paso 3 (Ficha de Detalle y Edición de Servicio - US011):* Modificación de precios de mano de obra, descripción del protocolo de servicio y tiempo estimado en bahía.
- *Paso 4 (Bloqueo de Modificación por Servicio en Uso - US011):* Protección que impide modificar las tarifas de servicios que forman parte de órdenes de trabajo actualmente en curso.

===== Flujo 6.2: Tablero Kanban de Órdenes y Creación de OT

Gestión visual del flujo de trabajo de planta y apertura formal de expedientes mecánicos. Tal como se observa en la secuencia interactiva de las *Figuras 236 a 240*, el flujo operativo del módulo guía al usuario paso a paso a través de las siguientes pantallas consecutivas:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod6-05-consulta-ordenes-trabajo-kanban.png", width: 96%),
    caption: [Paso 1: Tablero Kanban de Órdenes de Trabajo (US050)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod6-06-creacion-orden-trabajo.png", width: 96%),
    caption: [Paso 2: Apertura de Nueva Orden de Trabajo (US012)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod6-07-confirmar-creacion-ot-modal.png", width: 96%),
    caption: [Paso 3: Modal de Confirmación de Creación de OT (US012)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod6-08-orden-trabajo-creada-modal.png", width: 96%),
    caption: [Paso 4: Confirmación de Orden Creada con Éxito (US012)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod6-09-ficha-tecnica-ingreso-pdf.png", width: 96%),
    caption: [Paso 5: Ficha Técnica de Recepción e Ingreso en PDF (US012)]
  ),
)
#v(0.5em)


*Detalle analítico de la secuencia de wireframes:*
- *Paso 1 (Tablero Kanban de Órdenes de Trabajo - US050):* Tablero visual con columnas por estado: Recibido, Diagnóstico, En Proceso, Espera Repuestos y Listo para Entrega.
- *Paso 2 (Apertura de Nueva Orden de Trabajo - US012):* Registro de cliente, vehículo, kilometraje de entrada, nivel de combustible y checklist físico de recepción.
- *Paso 3 (Modal de Confirmación de Creación de OT - US012):* Revisión resumida de los datos de recepción antes de asentar la apertura definitiva de la orden en base de datos.
- *Paso 4 (Confirmación de Orden Creada con Éxito - US012):* Notificación de orden aperturada con asignación de número correlativo OT-2026-0042 y código QR de seguimiento.
- *Paso 5 (Ficha Técnica de Recepción e Ingreso en PDF - US012):* Comprobante formal impreso con inventario físico del vehículo firmado por el cliente al ingresar a planta.

===== Flujo 6.3: Asignación de Tareas, Mecánico y Consumo de Repuestos

Delegación técnica de actividades a los mecánicos de bahía y gestión de insumos requeridos. Tal como se observa en la secuencia interactiva de las *Figuras 241 a 248*, el flujo operativo del módulo guía al usuario paso a paso a través de las siguientes pantallas consecutivas:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod6-10-detalle-orden-trabajo.png", width: 96%),
    caption: [Paso 1: Ficha Integral de la Orden de Trabajo (US013)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod6-11-detalles-y-diagnostico-mecanico.png", width: 96%),
    caption: [Paso 2: Registro de Diagnóstico Inicial Obligatorio (US013)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod6-12-agregar-tarea-orden-trabajo.png", width: 96%),
    caption: [Paso 3: Agregar Tarea a la Orden de Trabajo (US048)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod6-13-confirmar-creacion-tarea.png", width: 96%),
    caption: [Paso 4: Confirmar Creación de Tarea Técnica (US048)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod6-14-tarea-creada-exito.png", width: 96%),
    caption: [Paso 5: Confirmación de Tarea Creada (US048)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod6-15-asignar-mecanico-tarea.png", width: 96%),
    caption: [Paso 6: Asignación de Mecánico Responsable (US048)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod6-16-bloqueo-eliminar-tarea-iniciada.png", width: 96%),
    caption: [Paso 7: Bloqueo al Eliminar Tarea en Ejecución (US049)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod6-17-conflicto-stock-insuficiente.png", width: 96%),
    caption: [Paso 8: Conflicto por Stock Insuficiente de Repuesto (US015)]
  ),
)
#v(0.5em)


*Detalle analítico de la secuencia de wireframes:*
- *Paso 1 (Ficha Integral de la Orden de Trabajo - US013):* Visión centralizada de la OT con pestañas para diagnóstico, tareas de mano de obra, repuestos y costos acumulados.
- *Paso 2 (Registro de Diagnóstico Inicial Obligatorio - US013):* Captura técnica del fallo reportado, evidencia fotográfica y conclusiones preliminares antes de iniciar la intervención.
- *Paso 3 (Agregar Tarea a la Orden de Trabajo - US048):* Selección de servicio desde el catálogo maestro con estimación de horas hombre y asignación de bahía.
- *Paso 4 (Confirmar Creación de Tarea Técnica - US048):* Diálogo de validación para incorporar formalmente la labor al cronograma operativo de la orden.
- *Paso 5 (Confirmación de Tarea Creada - US048):* Retroalimentación positiva mostrando la nueva labor activa dentro del plan de trabajo del automóvil.
- *Paso 6 (Asignación de Mecánico Responsable - US048):* Asignación nominal de la actividad a un técnico según especialidad (Frenos, Motor, Electricidad) y disponibilidad.
- *Paso 7 (Bloqueo al Eliminar Tarea en Ejecución - US049):* Restricción de seguridad que impide suprimir tareas que ya cuentan con horas de trabajo o repuestos consumidos.
- *Paso 8 (Conflicto por Stock Insuficiente de Repuesto - US015):* Alerta impidiendo la asignación de piezas cuya existencia física no cubra la cantidad demandada por la tarea.

===== Flujo 6.4: Espacio de Ejecución Técnica del Mecánico y Bloqueos

Entorno interactivo para que el técnico de bahía registre avances y cierre las labores. Tal como se observa en la secuencia interactiva de las *Figuras 249 a 252*, el flujo operativo del módulo guía al usuario paso a paso a través de las siguientes pantallas consecutivas:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod6-18-espacio-ejecucion-mecanico.png", width: 96%),
    caption: [Paso 1: Espacio de Ejecución Técnica del Mecánico (US014)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod6-19-detalle-intervencion-tecnica.png", width: 96%),
    caption: [Paso 2: Detalle de la Intervención Técnica (US014)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod6-20-bloqueo-completar-sin-diagnostico.png", width: 96%),
    caption: [Paso 3: Bloqueo: Completar Tarea sin Diagnóstico (US014)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod6-21-bloqueo-ot-tareas-pendientes.png", width: 96%),
    caption: [Paso 4: Bloqueo: Cierre de OT con Tareas Incompletas (US014)]
  ),
)
#v(0.5em)


*Detalle analítico de la secuencia de wireframes:*
- *Paso 1 (Espacio de Ejecución Técnica del Mecánico - US014):* Consola de bahía con botones táctiles grandes para iniciar, pausar y finalizar tareas con cronómetro de intervención.
- *Paso 2 (Detalle de la Intervención Técnica - US014):* Bitácora operativa donde el mecánico asienta notas técnicas, mediciones de torque y hallazgos en la pieza.
- *Paso 3 (Bloqueo: Completar Tarea sin Diagnóstico - US014):* Regla obligatoria de control de calidad impidiendo cerrar el servicio técnico sin haber ingresado el diagnóstico previo.
- *Paso 4 (Bloqueo: Cierre de OT con Tareas Incompletas - US014):* Validación de finalización impidiendo liquidar la orden si alguna tarea técnica permanece en estado pendiente o en curso.


==== Módulo 7: Facturación, Cotizaciones y Pasarela de Pagos (Billing & Payments) - Secuencias de Wireframes
*Historias de Usuario cubiertas: US016, US037, US038, US039, US041, US042, US043, US044, US045*

===== Flujo 7.1: Elaboración y Emisión de Cotización Digital

Cálculo del presupuesto consolidado de mano de obra y piezas bajo regla FIFO. Tal como se observa en la secuencia interactiva de las *Figuras 253 a 256*, el flujo operativo del módulo guía al usuario paso a paso a través de las siguientes pantallas consecutivas:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod7-01-crear-cotizacion-presupuesto.png", width: 96%),
    caption: [Paso 1: Creación de Cotización y Presupuesto (US037)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod7-02-confirmar-creacion-cotizacion.png", width: 96%),
    caption: [Paso 2: Confirmación de Cotización Creada (US037)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod7-03-exito-creacion-cotizacion.png", width: 96%),
    caption: [Paso 3: Éxito en Creación de Cotización (US037)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod7-04-conflicto-crear-cotizacion.png", width: 96%),
    caption: [Paso 4: Conflicto por Cotización Existente Activa (US037)]
  ),
)
#v(0.5em)


*Detalle analítico de la secuencia de wireframes:*
- *Paso 1 (Creación de Cotización y Presupuesto - US037):* Consolidación de ítems de mano de obra y repuestos aplicados con desglose de subtotal, IGV (18%) y total en Soles (S/).
- *Paso 2 (Confirmación de Cotización Creada - US037):* Revisión previa con montos netos antes de emitir formalmente el presupuesto para aprobación del usuario.
- *Paso 3 (Éxito en Creación de Cotización - US037):* Confirmación de cotización generada en estado DRAFT lista para envío automático al correo del cliente.
- *Paso 4 (Conflicto por Cotización Existente Activa - US037):* Advertencia del sistema cuando la orden de trabajo ya cuenta con una cotización vigente pendiente de respuesta.

===== Flujo 7.2: Aprobación y Rechazo de Cotización DRAFT

Interacción con el cliente para autorizar o desistir del presupuesto acordado. Tal como se observa en la secuencia interactiva de las *Figuras 257 a 258*, el flujo operativo del módulo guía al usuario paso a paso a través de las siguientes pantallas consecutivas:

#v(0.5em)
#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod7-05-aprobacion-cotizacion-draft.png", width: 85%),
    caption: [Paso 1: Aprobación de Cotización DRAFT (US038)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod7-06-cancelacion-cotizacion.png", width: 85%),
    caption: [Paso 2: Cancelación o Rechazo de Cotización (US039)]
  ),
)
#v(0.5em)


*Detalle analítico de la secuencia de wireframes:*
- *Paso 1 (Aprobación de Cotización DRAFT - US038):* Pantalla interactiva con desglose transparente y botón de aceptación con firma digital táctil.
- *Paso 2 (Cancelación o Rechazo de Cotización - US039):* Registro de desistimiento del cliente con opción de reajuste presupuestal o anulación de la orden.

===== Flujo 7.3: Checkout y Procesamiento con Pasarela Stripe

Pasarela de pagos en línea para liquidación de servicios mecánicos. Tal como se observa en la secuencia interactiva de las *Figuras 259 a 265*, el flujo operativo del módulo guía al usuario paso a paso a través de las siguientes pantallas consecutivas:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod7-07-orden-de-pago-resumen.png", width: 96%),
    caption: [Paso 1: Orden de Pago y Selección de Método (US041)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod7-08-checkout-inmediato-stripe.png", width: 96%),
    caption: [Paso 2: Checkout Inmediato con Pasarela Stripe (US041)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod7-09-procesando-pago-animacion.png", width: 96%),
    caption: [Paso 3: Procesamiento de Pago en Línea (US041)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod7-10-pago-exitoso-confirmacion.png", width: 96%),
    caption: [Paso 4: Pago Aprobado Exitosamente (US042)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod7-11-error-procesar-pago.png", width: 96%),
    caption: [Paso 5: Error en Procesamiento de Pago (US041)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod7-12-registro-pago-parcial.png", width: 96%),
    caption: [Paso 6: Registro de Pago Parcial / Adelanto (US043)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod7-13-marcar-ot-como-pagada.png", width: 96%),
    caption: [Paso 7: Marcar Orden de Trabajo como Pagada (US043)]
  ),
)
#v(0.5em)


*Detalle analítico de la secuencia de wireframes:*
- *Paso 1 (Orden de Pago y Selección de Método - US041):* Resumen de cuenta con opciones de pago: Tarjeta Débito/Crédito (Stripe), Efectivo en Caja o Transferencia bancaria.
- *Paso 2 (Checkout Inmediato con Pasarela Stripe - US041):* Formulario seguro integrado con campos encriptados para número de tarjeta, fecha de vencimiento y código CVC.
- *Paso 3 (Procesamiento de Pago en Línea - US041):* Pantalla de espera con animación de carga mientras se procesa la transacción bancaria con el token de Stripe.
- *Paso 4 (Pago Aprobado Exitosamente - US042):* Animación de check verde con ID de transacción bancaria y confirmación inmediata de saldo cubierto.
- *Paso 5 (Error en Procesamiento de Pago - US041):* Mensaje de rechazo bancario (fondos insuficientes o tarjeta rechazada) permitiendo reintentar de forma inmediata.
- *Paso 6 (Registro de Pago Parcial / Adelanto - US043):* Recepción de anticipos para compra de repuestos mayores actualizando el saldo deudor pendiente de la OT.
- *Paso 7 (Marcar Orden de Trabajo como Pagada - US043):* Cierre contable de la orden liberando el vehículo para su retiro de planta por parte del cliente.

===== Flujo 7.4: Comprobantes Fiscales y Descarga de Voucher PDF

Emisión de documentos tributarios electrónicos oficiales (Boletas y Facturas). Tal como se observa en la secuencia interactiva de las *Figuras 266 a 271*, el flujo operativo del módulo guía al usuario paso a paso a través de las siguientes pantallas consecutivas:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod7-14-consulta-comprobantes-sucursal.png", width: 96%),
    caption: [Paso 1: Consulta de Comprobantes por Sucursal (US044)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod7-15-generacion-de-comprobante.png", width: 96%),
    caption: [Paso 2: Generación de Comprobante Fiscal (US044)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod7-16-comprobante-electronico-detalle.png", width: 96%),
    caption: [Paso 3: Comprobante Electrónico Emitido (US044)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod7-17-comprobante-servicio-pdf.png", width: 96%),
    caption: [Paso 4: Comprobante de Servicio en Formato PDF (US045)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod7-18-comprobante-pdf-guardado.png", width: 96%),
    caption: [Paso 5: Comprobante PDF Guardado y Descargado (US045)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod7-19-voucher-descargado.png", width: 96%),
    caption: [Paso 6: Voucher de Pago Descargado (US045)]
  ),
)
#v(0.5em)


*Detalle analítico de la secuencia de wireframes:*
- *Paso 1 (Consulta de Comprobantes por Sucursal - US044):* Historial de facturación de la sede con filtros por fecha, número de serie de comprobante y estado de SUNAT.
- *Paso 2 (Generación de Comprobante Fiscal - US044):* Selección entre Boleta de Venta o Factura Electrónica con RUC corporativo y dirección fiscal del emisor.
- *Paso 3 (Comprobante Electrónico Emitido - US044):* Vista preliminar con datos fiscales, código Hash de SUNAT y detalle discriminado de servicios e insumos.
- *Paso 4 (Comprobante de Servicio en Formato PDF - US045):* Renderizado del documento tributario formal con código QR de validez fiscal y términos de garantía.
- *Paso 5 (Comprobante PDF Guardado y Descargado - US045):* Confirmación de almacenamiento del archivo PDF en el almacenamiento local del dispositivo móvil.
- *Paso 6 (Voucher de Pago Descargado - US045):* Constancia de operación financiera generada por la pasarela de pagos lista para compartir vía mensajería.


==== Módulo 8: Experiencia Digital del Conductor (Driver B2C Experience) - Secuencias de Wireframes
*Historias de Usuario cubiertas: B2C Driver Experience (US017, US019, US028, US030, US038, US041)*

===== Flujo 8.1: Driver Home Dashboard y Estado del Vehículo

Pantalla principal para conductores con métricas telemáticas e indicadores de salud automotriz. Tal como se observa en la secuencia interactiva de las *Figura 272*, el flujo operativo del módulo guía al usuario paso a paso a través de las siguientes pantallas consecutivas:

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod8-01-driver-home-dashboard.png", width: 35%),
    caption: [Paso 1: ShiftIQ Driver Home Dashboard (B2C Home)]
  )
]
#v(0.5em)


*Detalle analítico de la secuencia de wireframes:*
- *Paso 1 (ShiftIQ Driver Home Dashboard - B2C Home):* Consola personal para el conductor con nivel de combustible, voltaje de batería, kilometraje actual y recordatorios de servicio.

===== Flujo 8.2: Mi Garaje Digital e Historial Vehicular

Hoja de vida mecánica de las unidades registradas por el conductor particular. Tal como se observa en la secuencia interactiva de las *Figuras 273 a 274*, el flujo operativo del módulo guía al usuario paso a paso a través de las siguientes pantallas consecutivas:

#v(0.5em)
#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod8-02-mi-garaje-historial.png", width: 85%),
    caption: [Paso 1: Mi Garaje Digital e Historial Técnico (US017)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod8-03-historial-de-vehiculo-detalle.png", width: 85%),
    caption: [Paso 2: Detalle del Historial de Mantenimientos (US017)]
  ),
)
#v(0.5em)


*Detalle analítico de la secuencia de wireframes:*
- *Paso 1 (Mi Garaje Digital e Historial Técnico - US017):* Listado de vehículos particulares afiliados con registro cronológico de mantenimientos y afinamientos realizados.
- *Paso 2 (Detalle del Historial de Mantenimientos - US017):* Detalle técnico de cada intervención pasada con kilometraje del servicio, taller ejecutor y repuestos cambiados.

===== Flujo 8.3: Monitoreo en Vivo de Orden de Trabajo y Autorizaciones

Seguimiento en tiempo real de la reparación del auto y aprobación de tareas adicionales solicitadas por el mecánico. Tal como se observa en la secuencia interactiva de las *Figuras 275 a 276*, el flujo operativo del módulo guía al usuario paso a paso a través de las siguientes pantallas consecutivas:

#v(0.5em)
#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod8-04-orden-trabajo-en-vivo.png", width: 85%),
    caption: [Paso 1: Seguimiento de Orden de Trabajo en Vivo (US050)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod8-05-autorizacion-trabajo-adicional.png", width: 85%),
    caption: [Paso 2: Autorización de Trabajo Mecánico Adicional (US038)]
  ),
)
#v(0.5em)


*Detalle analítico de la secuencia de wireframes:*
- *Paso 1 (Seguimiento de Orden de Trabajo en Vivo - US050):* Barra de progreso del automóvil en taller (Recepción -> En Bahía -> Pruebas -> Listo) con cámara fotográfica de avances.
- *Paso 2 (Autorización de Trabajo Mecánico Adicional - US038):* Solicitud emergente con foto de pieza desgastada y costo estimado para que el dueño apruebe con un toque sin llamadas.

===== Flujo 8.4: Directorio de Talleres en Red y Servicios Externos

Localización de talleres certificados ShiftIQ y gestión de intervenciones fuera de red. Tal como se observa en la secuencia interactiva de las *Figuras 277 a 279*, el flujo operativo del módulo guía al usuario paso a paso a través de las siguientes pantallas consecutivas:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod8-06-catalogo-busqueda-talleres.png", width: 92%),
    caption: [Paso 1: Catálogo y Búsqueda de Talleres Mecánicos (US028)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod8-07-perfil-detallado-taller.png", width: 92%),
    caption: [Paso 2: Perfil Detallado del Taller Mecánico (US028)]
  ),
  figure(
    image("assets/chapter-3/mobile/wireframes/wf-mod8-08-registrar-servicio-fuera-red.png", width: 92%),
    caption: [Paso 3: Registro de Servicio Fuera de Red (US017)]
  ),
)
#v(0.5em)


*Detalle analítico de la secuencia de wireframes:*
- *Paso 1 (Catálogo y Búsqueda de Talleres Mecánicos - US028):* Mapa geolocalizado de talleres asociados a la red con valoración por estrellas, especialidades mecánicas y distancia.
- *Paso 2 (Perfil Detallado del Taller Mecánico - US028):* Ficha con fotos de las instalaciones, equipo de elevadores, certificados, comentarios de clientes y botón para agendar.
- *Paso 3 (Registro de Servicio Fuera de Red - US017):* Funcionalidad para que el conductor suba comprobantes y detalle de trabajos realizados en talleres externos al sistema.

---

=== 3.1.4.2. Mobile Applications Wireflow Diagrams

Los *Wireflow Diagrams* integran la arquitectura esquemática de los wireframes con la lógica de navegación transicional del usuario. A diferencia de un mapa de pantallas estático, el wireflow documenta el recorrido secuencial del usuario enfocado en el cumplimiento de metas concretas (*User Goals*), modelando *experiencias de usuario altamente satisfactorias (Happy Paths)*. Cada escenario agrupa el conjunto de sus pantallas dentro de un *único contenedor visual unificado*, representando el flujo completo como una sola unidad interactiva de alta legibilidad, complementada con su correspondiente análisis de satisfacción y diagrama de decisión lógica.

==== Escenario 1: Recepción Vehicular, Apertura de Orden de Trabajo y Diagnóstico Telemático OBD-II

- *Objetivo del Usuario (User Goal):* Como jefe de taller o asesor de servicio, deseo registrar la llegada física del vehículo a la bahía de trabajo, aperturar la Orden de Trabajo vinculando al cliente y ejecutar el sondeo telemático de las computadoras a bordo (ECU) mediante escáner Bluetooth OBD-II BLE en menos de 3 minutos, obteniendo un diagnóstico preliminar transparente sin demoras.
- *Resultado de Experiencia Satisfactoria:* Recepción ágil sin uso de papel ni duplicidad de datos, conexión periférica instantánea con retroalimentación RSSI visual, y detección de códigos de falla DTC en tiempo real con traducción didáctica inmediata para el cliente.

#align(center)[
  #rect(stroke: 1.5pt + rgb("#1E3A8A"), fill: rgb("#f8fafc"), radius: 8pt, inset: 10pt, width: 100%)[
    #text(weight: "bold", fill: rgb("#1E3A8A"), size: 9pt)[DIAGRAMA WIREFLOW UNIFICADO - ESCENARIO 1: RECEPCIÓN, APERTURA DE OT Y DIAGNÓSTICO OBD-II]
    #v(6pt)
    #grid(
      columns: (1fr, auto, 1fr, auto, 1fr, auto, 1fr, auto, 1fr),
      gutter: 3pt,
      align: horizon + center,
      [#box(fill: rgb("#1E3A8A"), inset: (x: 4pt, y: 2pt), radius: 4pt)[#text(fill: white, size: 7pt, weight: "bold")[Paso 1: Bahías]]  #v(2pt) #image("assets/chapter-3/mobile/wireframes/wf-mod2-01-dashboard-operativo-planta.png", width: 95%)  #v(2pt) #text(size: 7pt)[*Dashboard Planta*  (US006)]],
      [#text(size: 11pt, fill: rgb("#1E3A8A"), weight: "bold")[➔]],
      [#box(fill: rgb("#1E3A8A"), inset: (x: 4pt, y: 2pt), radius: 4pt)[#text(fill: white, size: 7pt, weight: "bold")[Paso 2: Registro OT]]  #v(2pt) #image("assets/chapter-3/mobile/wireframes/wf-mod6-06-creacion-orden-trabajo.png", width: 95%)  #v(2pt) #text(size: 7pt)[*Creación de OT*  (US012)]],
      [#text(size: 11pt, fill: rgb("#1E3A8A"), weight: "bold")[➔]],
      [#box(fill: rgb("#1E3A8A"), inset: (x: 4pt, y: 2pt), radius: 4pt)[#text(fill: white, size: 7pt, weight: "bold")[Paso 3: Enlace BLE]]  #v(2pt) #image("assets/chapter-3/mobile/wireframes/wf-mod3-04-vinculacion-dispositivo-obd2.png", width: 95%)  #v(2pt) #text(size: 7pt)[*Dongle BLE*  (US018)]],
      [#text(size: 11pt, fill: rgb("#1E3A8A"), weight: "bold")[➔]],
      [#box(fill: rgb("#1E3A8A"), inset: (x: 4pt, y: 2pt), radius: 4pt)[#text(fill: white, size: 7pt, weight: "bold")[Paso 4: Sondeo]]  #v(2pt) #image("assets/chapter-3/mobile/wireframes/wf-mod3-12-escaneo-obd2-en-curso.png", width: 95%)  #v(2pt) #text(size: 7pt)[*Escaneo ECUs*  (US023)]],
      [#text(size: 11pt, fill: rgb("#1E3A8A"), weight: "bold")[➔]],
      [#box(fill: rgb("#1E3A8A"), inset: (x: 4pt, y: 2pt), radius: 4pt)[#text(fill: white, size: 7pt, weight: "bold")[Paso 5: Reporte DTC]]  #v(2pt) #image("assets/chapter-3/mobile/wireframes/wf-mod3-15-detalle-dtc-traduccion-simple.png", width: 95%)  #v(2pt) #text(size: 7pt)[*Diagnóstico DTC*  (US023)]]
    )
    #v(8pt)
    #text(size: 8pt, style: "italic", fill: rgb("#475569"))[Cuadro unificado de Wireflow que ilustra la experiencia satisfactoria del Escenario 1: Recepción vehicular, apertura de orden de trabajo y diagnóstico telemático OBD-II en taller.]
  ]
]

===== Análisis Detallado del Proceso Satisfactorio (Escenario 1)

1. *Paso 1 (Disponibilidad en Planta - US006):* Al iniciar la jornada, el asesor visualiza en el Dashboard la ocupación de bahías en tiempo real (ej. Bahía 1 Libre, Bahía 2 Ocupada al 75%), lo que permite ubicar el vehículo de inmediato sin congestión en el patio.
2. *Paso 2 (Apertura de OT sin Fricción - US012):* Con la placa ingresada, el sistema recupera automáticamente el historial del automóvil (marca, modelo y año), solicitando únicamente el kilometraje y nivel de combustible. Esto ahorra hasta un 70% del tiempo de recepción física.
3. *Paso 3 (Emparejamiento BLE Automático - US018):* El escáner OBD-II asignado a la bahía se sincroniza por Bluetooth Low Energy en un solo toque, con indicador de fuerza de señal (RSSI) que da confianza al técnico sobre el enlace físico.
4. *Paso 4 (Sondeo Telemático en Vivo - US023):* La interfaz muestra una barra de progreso que consulta secuencialmente el tren motriz (PCM), frenos (ABS) y carrocería (BCM), completando el barrido integral en menos de 40 segundos.
5. *Paso 5 (Traducción Inmediata de Fallas - US023):* Los códigos crípticos (ej. P0135) se presentan acompañados de su significado comprensible ("Falla en calentador de sensor de oxígeno banco 1"), permitiendo al asesor explicar el problema al cliente con absoluta claridad.

===== Diagrama de Decisión Lógica del Escenario 1

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/mobile/flowcharts/wf-flowchart-escenario-1.svg", width: 68%),
    caption: [Diagrama de Decisión Lógica del Wireflow -- Escenario 1: Recepción, Apertura de OT y Diagnóstico.]
  )
]
#v(0.5em)

---

==== Escenario 2: Asignación Técnica de Mano de Obra, Despacho de Repuestos FIFO y Ejecución en Bahía

- *Objetivo del Usuario (User Goal):* Como jefe de taller y mecánico especialista, deseamos desglosar las tareas técnicas requeridas en la Orden de Trabajo, solicitar los repuestos al almacén asegurando la regla de costeo First-In First-Out (FIFO) para no distorsionar márgenes, y documentar la evidencia fotográfica obligatoria antes de iniciar la intervención mecánica.
- *Resultado de Experiencia Satisfactoria:* Planificación sin conflictos de agenda técnica, costeo exacto de inventario con control de lotes sin descuadres contables, y respaldo documental fotográfico que garantiza la calidad del servicio técnico.

#align(center)[
  #rect(stroke: 1.5pt + rgb("#1E3A8A"), fill: rgb("#f8fafc"), radius: 8pt, inset: 10pt, width: 100%)[
    #text(weight: "bold", fill: rgb("#1E3A8A"), size: 9pt)[DIAGRAMA WIREFLOW UNIFICADO - ESCENARIO 2: ASIGNACIÓN TÉCNICA, DESPACHO FIFO Y EJECUCIÓN]
    #v(6pt)
    #grid(
      columns: (1fr, auto, 1fr, auto, 1fr, auto, 1fr, auto, 1fr),
      gutter: 3pt,
      align: horizon + center,
      [#box(fill: rgb("#1E3A8A"), inset: (x: 4pt, y: 2pt), radius: 4pt)[#text(fill: white, size: 7pt, weight: "bold")[Paso 1: Detalle OT]]  #v(2pt) #image("assets/chapter-3/mobile/wireframes/wf-mod6-10-detalle-orden-trabajo.png", width: 95%)  #v(2pt) #text(size: 7pt)[*Detalle de OT*  (US012)]],
      [#text(size: 11pt, fill: rgb("#1E3A8A"), weight: "bold")[➔]],
      [#box(fill: rgb("#1E3A8A"), inset: (x: 4pt, y: 2pt), radius: 4pt)[#text(fill: white, size: 7pt, weight: "bold")[Paso 2: Tareas]]  #v(2pt) #image("assets/chapter-3/mobile/wireframes/wf-mod6-12-agregar-tarea-orden-trabajo.png", width: 95%)  #v(2pt) #text(size: 7pt)[*Agregar Tarea*  (US048)]],
      [#text(size: 11pt, fill: rgb("#1E3A8A"), weight: "bold")[➔]],
      [#box(fill: rgb("#1E3A8A"), inset: (x: 4pt, y: 2pt), radius: 4pt)[#text(fill: white, size: 7pt, weight: "bold")[Paso 3: Lote FIFO]]  #v(2pt) #image("assets/chapter-3/mobile/wireframes/wf-mod5-06-ingreso-lote-repuestos-fifo.png", width: 95%)  #v(2pt) #text(size: 7pt)[*Despacho FIFO*  (US009)]],
      [#text(size: 11pt, fill: rgb("#1E3A8A"), weight: "bold")[➔]],
      [#box(fill: rgb("#1E3A8A"), inset: (x: 4pt, y: 2pt), radius: 4pt)[#text(fill: white, size: 7pt, weight: "bold")[Paso 4: Bahía]]  #v(2pt) #image("assets/chapter-3/mobile/wireframes/wf-mod6-18-espacio-ejecucion-mecanico.png", width: 95%)  #v(2pt) #text(size: 7pt)[*Ejecución Bahía*  (US014)]],
      [#text(size: 11pt, fill: rgb("#1E3A8A"), weight: "bold")[➔]],
      [#box(fill: rgb("#1E3A8A"), inset: (x: 4pt, y: 2pt), radius: 4pt)[#text(fill: white, size: 7pt, weight: "bold")[Paso 5: Evidencia]]  #v(2pt) #image("assets/chapter-3/mobile/wireframes/wf-mod6-20-bloqueo-completar-sin-diagnostico.png", width: 95%)  #v(2pt) #text(size: 7pt)[*Validación Calidad*  (US014)]]
    )
    #v(8pt)
    #text(size: 8pt, style: "italic", fill: rgb("#475569"))[Cuadro unificado de Wireflow que ilustra la experiencia satisfactoria del Escenario 2: Asignación técnica de mano de obra, despacho de repuestos FIFO y ejecución en bahía.]
  ]
]

===== Análisis Detallado del Proceso Satisfactorio (Escenario 2)

1. *Paso 1 (Contexto de Orden - US012):* El técnico abre la OT en su dispositivo móvil y examina las fallas diagnosticadas previamente, visualizando qué partes del vehículo requieren intervención inmediata.
2. *Paso 2 (Asignación Estructurada de Labores - US048):* Se agregan tareas técnicas seleccionadas del catálogo estandarizado (ej. "Reemplazo de sensor de oxígeno - 1.2 hrs"), asociando automáticamente el tarifario oficial de mano de obra.
3. *Paso 3 (Consumo Riguroso de Repuestos FIFO - US009):* Al solicitar el repuesto desde el almacén, el motor de inventario descuenta las existencias del lote más antiguo (First-In, First-Out), evitando la desvalorización de stock y asegurando que el costo de venta sea matemáticamente exacto.
4. *Paso 4 (Ejecución Cronometrada en Bahía - US014):* El mecánico inicia el temporizador de la labor con un toque táctil, visualizando instrucciones de seguridad y el listado de insumos asignados a su puesto.
5. *Paso 5 (Garantía de Calidad por Evidencia - US014):* El software previene el cierre de la tarea si no se adjunta al menos una fotografía del repuesto reemplazado o de la pieza instalada, asegurando el respaldo ético y técnico de la intervención ante cualquier reclamo posterior.

===== Diagrama de Decisión Lógica del Escenario 2

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/mobile/flowcharts/wf-flowchart-escenario-2.svg", width: 68%),
    caption: [Diagrama de Decisión Lógica del Wireflow -- Escenario 2: Asignación Técnica, Despacho FIFO y Ejecución.]
  )
]
#v(0.5em)

---

==== Escenario 3: Presupuestación Formal, Liquidación de Pagos y Emisión de Comprobante Fiscal PDF

- *Objetivo del Usuario (User Goal):* Como asesor comercial y cajero administrativo, deseo generar la cotización formal con el cálculo automático de mano de obra, repuestos e impuestos (IGV 18%), obtener la aprobación formal del cliente, procesar el cobro digital y emitir de inmediato el comprobante electrónico oficial en PDF con código QR, liberando la bahía para el siguiente vehículo.
- *Resultado de Experiencia Satisfactoria:* Presupuesto sin discordancias numéricas, aprobación verificable, procesamiento de pago seguro y entrega instantánea de comprobante tributario legal con liberación automatizada del recurso físico en el sistema.

#align(center)[
  #rect(stroke: 1.5pt + rgb("#1E3A8A"), fill: rgb("#f8fafc"), radius: 8pt, inset: 10pt, width: 100%)[
    #text(weight: "bold", fill: rgb("#1E3A8A"), size: 9pt)[DIAGRAMA WIREFLOW UNIFICADO - ESCENARIO 3: PRESUPUESTACIÓN, LIQUIDACIÓN Y COMPROBANTE FISCAL PDF]
    #v(6pt)
    #grid(
      columns: (1fr, auto, 1fr, auto, 1fr, auto, 1fr, auto, 1fr),
      gutter: 3pt,
      align: horizon + center,
      [#box(fill: rgb("#1E3A8A"), inset: (x: 4pt, y: 2pt), radius: 4pt)[#text(fill: white, size: 7pt, weight: "bold")[Paso 1: Cotización]]  #v(2pt) #image("assets/chapter-3/mobile/wireframes/wf-mod7-01-crear-cotizacion-presupuesto.png", width: 95%)  #v(2pt) #text(size: 7pt)[*Crear Cotización*  (US038)]],
      [#text(size: 11pt, fill: rgb("#1E3A8A"), weight: "bold")[➔]],
      [#box(fill: rgb("#1E3A8A"), inset: (x: 4pt, y: 2pt), radius: 4pt)[#text(fill: white, size: 7pt, weight: "bold")[Paso 2: Aprobación]]  #v(2pt) #image("assets/chapter-3/mobile/wireframes/wf-mod7-05-aprobacion-cotizacion-draft.png", width: 95%)  #v(2pt) #text(size: 7pt)[*Aprobar Draft*  (US038)]],
      [#text(size: 11pt, fill: rgb("#1E3A8A"), weight: "bold")[➔]],
      [#box(fill: rgb("#1E3A8A"), inset: (x: 4pt, y: 2pt), radius: 4pt)[#text(fill: white, size: 7pt, weight: "bold")[Paso 3: Cobro]]  #v(2pt) #image("assets/chapter-3/mobile/wireframes/wf-mod7-08-checkout-inmediato-stripe.png", width: 95%)  #v(2pt) #text(size: 7pt)[*Procesar Pago*  (US041)]],
      [#text(size: 11pt, fill: rgb("#1E3A8A"), weight: "bold")[➔]],
      [#box(fill: rgb("#1E3A8A"), inset: (x: 4pt, y: 2pt), radius: 4pt)[#text(fill: white, size: 7pt, weight: "bold")[Paso 4: Confirmado]]  #v(2pt) #image("assets/chapter-3/mobile/wireframes/wf-mod7-10-pago-exitoso-confirmacion.png", width: 95%)  #v(2pt) #text(size: 7pt)[*Pago Aprobado*  (US041)]],
      [#text(size: 11pt, fill: rgb("#1E3A8A"), weight: "bold")[➔]],
      [#box(fill: rgb("#1E3A8A"), inset: (x: 4pt, y: 2pt), radius: 4pt)[#text(fill: white, size: 7pt, weight: "bold")[Paso 5: PDF SUNAT]]  #v(2pt) #image("assets/chapter-3/mobile/wireframes/wf-mod7-17-comprobante-servicio-pdf.png", width: 95%)  #v(2pt) #text(size: 7pt)[*Boleta / Factura*  (US045)]]
    )
    #v(8pt)
    #text(size: 8pt, style: "italic", fill: rgb("#475569"))[Cuadro unificado de Wireflow que ilustra la experiencia satisfactoria del Escenario 3: Presupuestación formal, liquidación de pagos y emisión de comprobante fiscal en PDF.]
  ]
]

===== Análisis Detallado del Proceso Satisfactorio (Escenario 3)

1. *Paso 1 (Consolidación Presupuestal - US038):* El sistema calcula automáticamente el subtotal neto, desglosando los repuestos despachados y las horas de mano de obra ejecutadas, agregando el 18% del IGV sin posibilidad de errores aritméticos manuales.
2. *Paso 2 (Aprobación Formal del Cliente - US038):* El asesor registra la firma digital o aprobación del cliente sobre la cotización en borrador (*Draft*), garantizando el acuerdo comercial previo antes de la facturación electrónica definitiva.
3. *Paso 3 (Pasarela de Pago Ágil - US041):* El operador selecciona el método de pago (tarjeta de crédito/débito, pasarela Stripe o terminal POS), iniciando la transacción con validaciones en tiempo real.
4. *Paso 4 (Cierre Financiero en Vivo - US041):* La pasarela responde en menos de 2.5 segundos con el código de autorización bancaria, actualizando el estado de la Orden de Trabajo a *Pagada* y disparando la liberación inmediata de la bahía en el Dashboard general.
5. *Paso 5 (Emisión Electrónica Oficial - US045):* Se genera de manera autónoma el comprobante electrónico (Boleta o Factura) en formato PDF estándar SUNAT, con código QR y enlace de descarga enviado simultáneamente al correo y teléfono del cliente.

===== Diagrama de Decisión Lógica del Escenario 3

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/mobile/flowcharts/wf-flowchart-escenario-3.svg", width: 68%),
    caption: [Diagrama de Decisión Lógica del Wireflow -- Escenario 3: Presupuestación, Liquidación y Facturación PDF.]
  )
]
#v(0.5em)

==== Verificación Ergonómica y Heurística de los Wireflows

Como se detalla en la *Tabla 29*, la navegación e interacción modelada en los Wireflows respeta los principios de ergonomía móvil, directrices de usabilidad de Nielsen y los requerimientos funcionales del sistema:

*Tabla 29*  
_Matriz de verificación heurística y ergonómica de los wireflows y wireframes móviles de ShiftIQ_

#v(0.5em)
#table(columns: (30%, 70%),
  stroke: 0.4pt + rgb("#cbd5e1"),
  inset: (x: 8pt, y: 6pt),
  fill: (x, y) => if calc.even(y) { rgb("#f8fafc") } else { white },
  [*Visibilidad del Estado del Sistema*], [Retroalimentación en tiempo real en escaneo de ECUs, estados de OT con badges y barra de conexión del dongle Bluetooth BLE. _(Conforme)_],
  [*Relación Sistema - Mundo Real*], [Uso de terminología estándar de talleres (Bahía, Orden de Trabajo, Diagnóstico DTC, SKU, FIFO). _(Conforme)_],
  [*Control y Libertad del Usuario*], [Diálogos de confirmación previa para cancelaciones, reprogramaciones y desvinculación de escáner. _(Conforme)_],
  [*Consistencia y Estándares*], [Patrones de navegación nativos de Android/iOS (Bottom Navigation Bar, Top App Bar con botón de retorno, Floating Action Buttons). _(Conforme)_],
  [*Prevención de Errores*], [Validaciones reactivas en formularios (RUC 11 dígitos, contraseñas robustas, bloqueo de stock negativo y bloqueo sin diagnóstico). _(Conforme)_],
  [*Reconocimiento antes que Recuerdo*], [Selector asistido de repuestos por código y visualización gráfica del calendario de bahías disponibles. _(Conforme)_],
  [*Eficiencia y Flexibilidad*], [Búsqueda rápida por placa de vehículo, escaneo directo OBD-II y acceso directo a órdenes urgentes desde el Dashboard. _(Conforme)_],
)

---

=== 3.1.4.3. Mobile Applications Mock-ups

Los mockups de la aplicación móvil de ShiftIQ plasman la versión en alta fidelidad de las interfaces, aplicando de forma estricta el sistema visual, componentes de UI y tokens de estilo documentados en la sección 3.1.1:
- *Paleta Cromática de Marca:* Uso predominante del azul corporativo *Navy Primary* (`#1E3A8A`) en barras de navegación, encabezados y botones primarios; azul cielo *Accent Sky Blue* (`#60A5FA`) para estados interactivos y enlaces; naranja automotriz *Severity Orange* (`#C94A0E`) para alertas de severidad y llamadas a la acción prioritarias; y verde esmeralda (`#3DBE6C`) para estados conectados y transacciones exitosas.
- *Tipografía Institucional:* Familia *Inter*, con jerarquías claras desde títulos semibold (18-20sp), subtítulos (14-16sp) hasta textos auxiliares y etiquetas (12sp).
- *Componentes Nativos y Accesibilidad:* Contenedores de tarjeta (*Cards*) con esquinas redondeadas de 12px, sombras difusas (*elevation*), botones táctiles de al menos 48dp de altura y contrastes conformes a WCAG 2.1 AA.

A continuación, se presentan *todos los mockups en alta fidelidad del sistema*, organizados por módulos funcionales y presentados en *secuencias visuales horizontales lado a lado*:

==== Módulo 1: Identidad, Autenticación y Seguridad (IAM) - Secuencias de Mockups (Alta Fidelidad)
*Historias de Usuario cubiertas: US001, US002, US004, US035, US036*

===== Flujo 1.1: Onboarding y Registro de Usuarios (B2B y B2C)

Como se aprecia en la secuencia visual de alta fidelidad de las *Figuras 283 a 290*, el diseño final incorpora la identidad cromática corporativa (`#1E3A8A`), componentes táctiles enriquecidos y microinteracciones de estado a lo largo del flujo:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod1-01-onboarding-acceso-iot.png", width: 96%),
    caption: [Mockup Paso 1: Onboarding y Acceso ShiftIQ IoT (US001, US002)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod1-02-registro-taller-dueno-b2b.png", width: 96%),
    caption: [Mockup Paso 2: Registro de Taller y Propietario B2B (US001)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod1-03-registro-asistido-paso-1-propietario.png", width: 96%),
    caption: [Mockup Paso 3: Asistente de Registro Paso 1: Datos de Propietario (US001)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod1-04-registro-asistido-paso-2-vehiculo-obd2.png", width: 96%),
    caption: [Mockup Paso 4: Asistente de Registro Paso 2: Vehículo y OBD-II (US001, US017)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod1-05-registro-asistido-paso-3-confirmacion.png", width: 96%),
    caption: [Mockup Paso 5: Asistente de Registro Paso 3: Confirmación de Cuenta (US001)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod1-06-confirmacion-datos-registro.png", width: 96%),
    caption: [Mockup Paso 6: Modal de Verificación de Datos de Registro (US001)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod1-07-crear-cuenta-shiftiq-b2c.png", width: 96%),
    caption: [Mockup Paso 7: Creación de Cuenta Conductor B2C (US001)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod1-08-error-creacion-cuenta.png", width: 96%),
    caption: [Mockup Paso 8: Manejo de Errores en Registro de Cuenta (US001)]
  ),
)
#v(0.5em)


*Análisis visual y componentes UI de la secuencia de mockups:*
- *Paso 1 (Onboarding y Acceso ShiftIQ IoT - US001, US002):* Pantalla introductoria interactiva que destaca las capacidades de telemetría OBD-II en tiempo real y ofrece accesos diferenciados para registro B2B y B2C.
- *Paso 2 (Registro de Taller y Propietario B2B - US001):* Formulario de alta empresarial con captura y validación en tiempo real de razón social, RUC tributario (SUNAT), dirección fiscal y credenciales de administrador.
- *Paso 3 (Asistente de Registro Paso 1: Datos de Propietario - US001):* Etapa inicial del asistente de onboarding con captura de información personal, teléfono y correo electrónico de contacto.
- *Paso 4 (Asistente de Registro Paso 2: Vehículo y OBD-II - US001, US017):* Asociación guiada de la primera unidad vehicular con placa, marca, modelo y emparejamiento preliminar de hardware telemático.
- *Paso 5 (Asistente de Registro Paso 3: Confirmación de Cuenta - US001):* Resumen de validación de los datos ingresados y aceptación de términos del servicio antes de activar la cuenta.
- *Paso 6 (Modal de Verificación de Datos de Registro - US001):* Confirmación final mediante diálogo de seguridad para certificar la exactitud del RUC y documento de identidad del solicitante.
- *Paso 7 (Creación de Cuenta Conductor B2C - US001):* Formulario simplificado para conductores particulares con campos para nombres, correo electrónico, teléfono móvil y contraseña con confirmación.
- *Paso 8 (Manejo de Errores en Registro de Cuenta - US001):* Estado de retroalimentación con alerta visual y desactivación de envío ante campos incompletos, formato de correo no válido o RUC ya registrado.

===== Flujo 1.2: Autenticación e Inicio de Sesión

Como se aprecia en la secuencia visual de alta fidelidad de las *Figuras 291 a 292*, el diseño final incorpora la identidad cromática corporativa (`#1E3A8A`), componentes táctiles enriquecidos y microinteracciones de estado a lo largo del flujo:

#v(0.5em)
#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod1-09-iniciar-sesion-b2b.png", width: 85%),
    caption: [Mockup Paso 1: Inicio de Sesión Taller Mecánico B2B (US002)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod1-10-iniciar-sesion-b2c.png", width: 85%),
    caption: [Mockup Paso 2: Inicio de Sesión Conductor B2C (US002)]
  ),
)
#v(0.5em)


*Análisis visual y componentes UI de la secuencia de mockups:*
- *Paso 1 (Inicio de Sesión Taller Mecánico B2B - US002):* Interfaz de ingreso para personal de taller con soporte para credenciales corporativas, recordación de sesión y Google OAuth2.
- *Paso 2 (Inicio de Sesión Conductor B2C - US002):* Vista optimizada para conductores particulares con login directo por correo electrónico, teléfono móvil o autenticación biométrica.

===== Flujo 1.3: Recuperación de Cuenta y Verificación OTP (B2B y B2C)

Como se aprecia en la secuencia visual de alta fidelidad de las *Figuras 293 a 300*, el diseño final incorpora la identidad cromática corporativa (`#1E3A8A`), componentes táctiles enriquecidos y microinteracciones de estado a lo largo del flujo:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod1-11-recuperacion-paso-1-solicitar-codigo-b2b.png", width: 96%),
    caption: [Mockup Paso 1: Recuperación B2B Paso 1: Solicitud de Código (US004)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod1-12-recuperacion-paso-2-verificar-otp-b2b.png", width: 96%),
    caption: [Mockup Paso 2: Recuperación B2B Paso 2: Verificación OTP (US004)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod1-13-recuperacion-paso-3-nueva-contrasena-b2b.png", width: 96%),
    caption: [Mockup Paso 3: Recuperación B2B Paso 3: Definición de Nueva Clave (US004)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod1-14-recuperacion-paso-3b-modal-exito-b2b.png", width: 96%),
    caption: [Mockup Paso 4: Recuperación B2B Paso 3B: Confirmación de Restablecimiento (US004)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod1-15-recuperacion-paso-1-solicitar-codigo-b2c.png", width: 96%),
    caption: [Mockup Paso 5: Recuperación B2C Paso 1: Solicitud de Código Conductor (US004)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod1-16-recuperacion-paso-2-verificar-otp-b2c.png", width: 96%),
    caption: [Mockup Paso 6: Recuperación B2C Paso 2: Validación OTP Conductor (US004)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod1-17-recuperacion-paso-3-nueva-contrasena-b2c.png", width: 96%),
    caption: [Mockup Paso 7: Recuperación B2C Paso 3: Renovación de Clave (US004)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod1-18-recuperacion-paso-3b-modal-exito-b2c.png", width: 96%),
    caption: [Mockup Paso 8: Recuperación B2C Paso 3B: Éxito de Restablecimiento (US004)]
  ),
)
#v(0.5em)


*Análisis visual y componentes UI de la secuencia de mockups:*
- *Paso 1 (Recuperación B2B Paso 1: Solicitud de Código - US004):* Ingreso del correo electrónico corporativo registrado para el envío de un código de verificación de un solo uso (OTP).
- *Paso 2 (Recuperación B2B Paso 2: Verificación OTP - US004):* Desafío de 6 dígitos numéricos con temporizador de expiración regresivo de 60 segundos y opción de reenvío.
- *Paso 3 (Recuperación B2B Paso 3: Definición de Nueva Clave - US004):* Establecimiento de nueva contraseña con medidor de robustez criptográfica y confirmación de caracteres.
- *Paso 4 (Recuperación B2B Paso 3B: Confirmación de Restablecimiento - US004):* Modal de confirmación exitosa con botón para redirigir directamente al inicio de sesión con las nuevas credenciales.
- *Paso 5 (Recuperación B2C Paso 1: Solicitud de Código Conductor - US004):* Petición de restablecimiento de cuenta para conductores con envío de SMS o correo de verificación seguro.
- *Paso 6 (Recuperación B2C Paso 2: Validación OTP Conductor - US004):* Verificación de autenticidad del conductor mediante código temporal de un solo uso con soporte de teclado numérico.
- *Paso 7 (Recuperación B2C Paso 3: Renovación de Clave - US004):* Actualización de credenciales personales de acceso para el aplicativo móvil del conductor.
- *Paso 8 (Recuperación B2C Paso 3B: Éxito de Restablecimiento - US004):* Notificación de confirmación de clave actualizada redirigiendo al dashboard del conductor.

===== Flujo 1.4: Perfil de Usuario, Actualización de Correo y Seguridad

Como se aprecia en la secuencia visual de alta fidelidad de las *Figuras 301 a 308*, el diseño final incorpora la identidad cromática corporativa (`#1E3A8A`), componentes táctiles enriquecidos y microinteracciones de estado a lo largo del flujo:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod1-19-mi-perfil-ajustes-cuenta.png", width: 96%),
    caption: [Mockup Paso 1: Mi Perfil y Ajustes de Cuenta (US035)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod1-20-actualizar-correo-paso-1.png", width: 96%),
    caption: [Mockup Paso 2: Actualización de Correo Paso 1 (US035)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod1-21-verificar-codigo-nuevo-correo.png", width: 96%),
    caption: [Mockup Paso 3: Verificación de Código de Nuevo Correo (US035)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod1-22-exito-actualizacion-correo.png", width: 96%),
    caption: [Mockup Paso 4: Confirmación de Actualización de Correo (US035)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod1-23-error-correo-duplicado.png", width: 96%),
    caption: [Mockup Paso 5: Conflicto por Correo Duplicado (Error 409) (US035)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod1-24-cambio-contrasena-principal.png", width: 96%),
    caption: [Mockup Paso 6: Cambio de Contraseña Autenticado (US036)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod1-25-cambio-contrasena-exito.png", width: 96%),
    caption: [Mockup Paso 7: Confirmación de Cambio de Contraseña (US036)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod1-26-cambio-contrasena-error.png", width: 96%),
    caption: [Mockup Paso 8: Error de Validación en Cambio de Contraseña (US036)]
  ),
)
#v(0.5em)


*Análisis visual y componentes UI de la secuencia de mockups:*
- *Paso 1 (Mi Perfil y Ajustes de Cuenta - US035):* Panel central de perfil con avatar, sede asignada, rol activo y accesos directos para cambiar contraseña o correo.
- *Paso 2 (Actualización de Correo Paso 1 - US035):* Ingreso de la nueva dirección de correo electrónico con validación de sintaxis antes del envío de verificación.
- *Paso 3 (Verificación de Código de Nuevo Correo - US035):* Comprobación de token numérico enviado al nuevo buzón para certificar la titularidad del usuario.
- *Paso 4 (Confirmación de Actualización de Correo - US035):* Modal interactivo de éxito que confirma la actualización del identificador de acceso principal.
- *Paso 5 (Conflicto por Correo Duplicado (Error 409) - US035):* Mensaje de advertencia modal cuando el correo ingresado ya pertenece a otra cuenta activa en el sistema.
- *Paso 6 (Cambio de Contraseña Autenticado - US036):* Formulario de cambio de clave dentro de la sesión activa con chequeo reactivo de políticas de seguridad.
- *Paso 7 (Confirmación de Cambio de Contraseña - US036):* Retroalimentación visual positiva indicando que la clave fue renovada y las sesiones previas revocadas.
- *Paso 8 (Error de Validación en Cambio de Contraseña - US036):* Notificación de error ante discrepancia en la confirmación o incumplimiento de complejidad de contraseña.


==== Módulo 2: Gestión de Talleres, Sucursales y Licenciamiento (Workshop Management) - Secuencias de Mockups (Alta Fidelidad)
*Historias de Usuario cubiertas: US005, US006, US007*

===== Flujo 2.1: Consola de Operaciones y Navegación de Planta

Como se aprecia en la secuencia visual de alta fidelidad de las *Figuras 309 a 310*, el diseño final incorpora la identidad cromática corporativa (`#1E3A8A`), componentes táctiles enriquecidos y microinteracciones de estado a lo largo del flujo:

#v(0.5em)
#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod2-01-dashboard-operativo-planta.png", width: 85%),
    caption: [Mockup Paso 1: Dashboard Operativo de Planta (US006)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod2-02-menu-lateral-taller-drawer.png", width: 85%),
    caption: [Mockup Paso 2: Navegación Lateral del Taller (Drawer) (US005)]
  ),
)
#v(0.5em)


*Análisis visual y componentes UI de la secuencia de mockups:*
- *Paso 1 (Dashboard Operativo de Planta - US006):* Tablero central con tarjeta de ocupación de bahías (75%), citas del turno, órdenes en curso y alertas telemáticas prioritarias.
- *Paso 2 (Navegación Lateral del Taller (Drawer) - US005):* Menú ergonómico deslizable con accesos a Órdenes, Citas, Bahías, Inventario FIFO, Facturación y Configuración.

===== Flujo 2.2: Directorio de Personal, Alta de Empleado y Revocación de Accesos

Como se aprecia en la secuencia visual de alta fidelidad de las *Figuras 311 a 314*, el diseño final incorpora la identidad cromática corporativa (`#1E3A8A`), componentes táctiles enriquecidos y microinteracciones de estado a lo largo del flujo:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod2-03-directorio-personal-roles.png", width: 96%),
    caption: [Mockup Paso 1: Directorio de Personal y Roles (US005)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod2-04-alta-empleado-rol.png", width: 96%),
    caption: [Mockup Paso 2: Alta de Nuevo Empleado y Asignación de Rol (US005)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod2-05-detalle-empleado-roles.png", width: 96%),
    caption: [Mockup Paso 3: Ficha de Detalle de Empleado (US005)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod2-06-confirmar-baja-revocar-accesos.png", width: 96%),
    caption: [Mockup Paso 4: Confirmar Baja y Revocar Accesos (US005)]
  ),
)
#v(0.5em)


*Análisis visual y componentes UI de la secuencia de mockups:*
- *Paso 1 (Directorio de Personal y Roles - US005):* Padrón general de colaboradores con cargo (Mecánico, Administrador, Cajero), estado activo y filtros por sede.
- *Paso 2 (Alta de Nuevo Empleado y Asignación de Rol - US005):* Formulario de registro de técnico con nombre, documento de identidad, especialidad y credenciales iniciales.
- *Paso 3 (Ficha de Detalle de Empleado - US005):* Vista detallada de carga laboral del mecánico, órdenes asignadas, historial de productividad y teléfono.
- *Paso 4 (Confirmar Baja y Revocar Accesos - US005):* Modal de seguridad para desvinculación de técnico y anulación inmediata de tokens de acceso al sistema.

===== Flujo 2.3: Sucursales, Capacidad de Bahías y Suscripción SaaS

Como se aprecia en la secuencia visual de alta fidelidad de las *Figuras 315 a 321*, el diseño final incorpora la identidad cromática corporativa (`#1E3A8A`), componentes táctiles enriquecidos y microinteracciones de estado a lo largo del flujo:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod2-07-detalle-sucursal-bahias.png", width: 96%),
    caption: [Mockup Paso 1: Detalle y Capacidad Operativa de Sucursal (US006)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod2-08-suscripcion-plan-sucursal.png", width: 96%),
    caption: [Mockup Paso 2: Administración de Suscripción por Sucursal (US007)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod2-09-asignar-plan-sucursal.png", width: 96%),
    caption: [Mockup Paso 3: Asignación y Cambio de Plan SaaS (US007)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod2-10-exito-activacion-modulos.png", width: 96%),
    caption: [Mockup Paso 4: Activación Exitosa de Módulos Telemáticos (US007)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod2-11-cancelacion-modo-solo-lectura.png", width: 96%),
    caption: [Mockup Paso 5: Cancelación de Plan y Modo Solo Lectura (US007)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod2-12-datos-taller-exito.png", width: 96%),
    caption: [Mockup Paso 6: Confirmación de Actualización de Datos del Taller (US006)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod2-13-datos-taller-solo-lectura.png", width: 96%),
    caption: [Mockup Paso 7: Ficha de Taller en Modo Solo Lectura (US006)]
  ),
)
#v(0.5em)


*Análisis visual y componentes UI de la secuencia de mockups:*
- *Paso 1 (Detalle y Capacidad Operativa de Sucursal - US006):* Información operativa de la sede: dirección, teléfono, cantidad de elevadores habilitados y mapa de ubicación.
- *Paso 2 (Administración de Suscripción por Sucursal - US007):* Panel de control del plan contratado (Profesional / Enterprise), fecha de renovación y estado de facturación SaaS.
- *Paso 3 (Asignación y Cambio de Plan SaaS - US007):* Selector comparativo de planes comerciales con detalle de bahías permitidas y módulos habilitados.
- *Paso 4 (Activación Exitosa de Módulos Telemáticos - US007):* Modal de confirmación tras habilitar funciones avanzadas de telemetría OBD-II y diagnósticos automotrices.
- *Paso 5 (Cancelación de Plan y Modo Solo Lectura - US007):* Pantalla informativa ante expiración de suscripción limitando las acciones a consulta histórica sin nuevas OTs.
- *Paso 6 (Confirmación de Actualización de Datos del Taller - US006):* Confirmación exitosa tras la edición de datos fiscales y horarios de atención de la sede.
- *Paso 7 (Ficha de Taller en Modo Solo Lectura - US006):* Visualización restringida de datos corporativos de la sucursal para roles sin permisos de edición.


==== Módulo 3: Inteligencia Vehicular y Diagnóstico OBD-II (Vehicle Intelligence & Diagnostics) - Secuencias de Mockups (Alta Fidelidad)
*Historias de Usuario cubiertas: US017, US018, US019, US020, US021, US023, US025*

===== Flujo 3.1: Enrolamiento de Vehículo y Ficha Telemática

Como se aprecia en la secuencia visual de alta fidelidad de las *Figuras 322 a 323*, el diseño final incorpora la identidad cromática corporativa (`#1E3A8A`), componentes táctiles enriquecidos y microinteracciones de estado a lo largo del flujo:

#v(0.5em)
#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod3-01-registro-vehiculo.png", width: 85%),
    caption: [Mockup Paso 1: Registro de Vehículo en Taller (US017)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod3-02-ficha-vehiculo-estado-obd2.png", width: 85%),
    caption: [Mockup Paso 2: Ficha del Vehículo y Estado OBD-II (US017)]
  ),
)
#v(0.5em)


*Análisis visual y componentes UI de la secuencia de mockups:*
- *Paso 1 (Registro de Vehículo en Taller - US017):* Formulario de ingreso vehicular con captura de placa peruana, marca, modelo, año, VIN y kilometraje de recepción.
- *Paso 2 (Ficha del Vehículo y Estado OBD-II - US017):* Hoja de vida digital del automóvil con historial de visitas técnicas y estado de enlace del dongle telemático.

===== Flujo 3.2: Vinculación y Gestión de Dongles OBD-II Bluetooth

Como se aprecia en la secuencia visual de alta fidelidad de las *Figuras 324 a 329*, el diseño final incorpora la identidad cromática corporativa (`#1E3A8A`), componentes táctiles enriquecidos y microinteracciones de estado a lo largo del flujo:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod3-03-inventario-alta-dongles-obd2.png", width: 96%),
    caption: [Mockup Paso 1: Inventario y Registro de Dongles OBD-II (US021)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod3-04-vinculacion-dispositivo-obd2.png", width: 96%),
    caption: [Mockup Paso 2: Búsqueda y Vinculación de Dongle OBD-II (US018)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod3-05-bottom-sheet-vincular-obd2.png", width: 96%),
    caption: [Mockup Paso 3: Panel Inferior (Bottom Sheet) de Vinculación (US018)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod3-06-dispositivo-ya-vinculado.png", width: 96%),
    caption: [Mockup Paso 4: Aviso de Dispositivo OBD-II Ya Vinculado (US018)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod3-07-confirmar-desvinculacion-obd2.png", width: 96%),
    caption: [Mockup Paso 5: Confirmar Desvinculación de Escáner (US020)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod3-08-error-desvinculacion-scanner.png", width: 96%),
    caption: [Mockup Paso 6: Error al Desvincular Escáner OBD-II (US020)]
  ),
)
#v(0.5em)


*Análisis visual y componentes UI de la secuencia de mockups:*
- *Paso 1 (Inventario y Registro de Dongles OBD-II - US021):* Control de escáneres propiedad del taller con número de serie, versión de firmware y asignación a bahías.
- *Paso 2 (Búsqueda y Vinculación de Dongle OBD-II - US018):* Escaneo de dispositivos Bluetooth BLE cercanos con intensidad de señal RSSI y botón de enlace directo.
- *Paso 3 (Panel Inferior (Bottom Sheet) de Vinculación - US018):* Modal contextual deslizable con instrucciones de conexión al puerto OBD-II y confirmación de handshake.
- *Paso 4 (Aviso de Dispositivo OBD-II Ya Vinculado - US018):* Alerta informativa cuando el escáner seleccionado ya se encuentra enlazado a otra orden de trabajo activa.
- *Paso 5 (Confirmar Desvinculación de Escáner - US020):* Diálogo de confirmación para liberar el dispositivo Bluetooth al finalizar el diagnóstico del automóvil.
- *Paso 6 (Error al Desvincular Escáner OBD-II - US020):* Retroalimentación de fallo por pérdida repentina de conexión BLE o proceso de lectura telemática en ejecución.

===== Flujo 3.3: Telemetría en Vivo, Cola de Sincronización y Modo Offline

Como se aprecia en la secuencia visual de alta fidelidad de las *Figuras 330 a 332*, el diseño final incorpora la identidad cromática corporativa (`#1E3A8A`), componentes táctiles enriquecidos y microinteracciones de estado a lo largo del flujo:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod3-09-telemetria-vivo-sensores.png", width: 92%),
    caption: [Mockup Paso 1: Telemetría en Vivo de Sensores Automotrices (US019)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod3-10-cola-telemetria-buffer.png", width: 92%),
    caption: [Mockup Paso 2: Gestión de Cola de Telemetría en Buffer (US025)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod3-11-modo-offline-telemetria.png", width: 92%),
    caption: [Mockup Paso 3: Modo Offline y Telemetría Autónoma (US025)]
  ),
)
#v(0.5em)


*Análisis visual y componentes UI de la secuencia de mockups:*
- *Paso 1 (Telemetría en Vivo de Sensores Automotrices - US019):* Tacómetros en tiempo real para RPM de motor, velocidad km/h, temperatura del refrigerante y voltaje de alternador.
- *Paso 2 (Gestión de Cola de Telemetría en Buffer - US025):* Monitor de eventos almacenados localmente en SQLite listos para sincronización con la API central.
- *Paso 3 (Modo Offline y Telemetría Autónoma - US025):* Indicador de operación sin conexión a internet manteniendo la captura continua de sensores en memoria local.

===== Flujo 3.4: Escaneo Electrónico de ECUs y Diagnóstico de Fallas DTC

Como se aprecia en la secuencia visual de alta fidelidad de las *Figuras 333 a 338*, el diseño final incorpora la identidad cromática corporativa (`#1E3A8A`), componentes táctiles enriquecidos y microinteracciones de estado a lo largo del flujo:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod3-12-escaneo-obd2-en-curso.png", width: 96%),
    caption: [Mockup Paso 1: Escaneo OBD-II de ECUs en Curso (US023)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod3-13-detener-escaneo-obd2.png", width: 96%),
    caption: [Mockup Paso 2: Interrupción Controlada del Escaneo (US023)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod3-14-consulta-alertas-dtc.png", width: 96%),
    caption: [Mockup Paso 3: Consulta de Códigos de Falla DTC Detectados (US023)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod3-15-detalle-dtc-traduccion-simple.png", width: 96%),
    caption: [Mockup Paso 4: Detalle DTC con Traducción Simple y Solución (US023)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod3-16-alertas-telematicas-entrantes.png", width: 96%),
    caption: [Mockup Paso 5: Modal de Alertas Telemáticas Entrantes (US023)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod3-17-visor-reporte-tecnico-pdf.png", width: 96%),
    caption: [Mockup Paso 6: Visor de Reporte de Diagnóstico Técnico en PDF (US023)]
  ),
)
#v(0.5em)


*Análisis visual y componentes UI de la secuencia de mockups:*
- *Paso 1 (Escaneo OBD-II de ECUs en Curso - US023):* Barra de progreso animada con sondeo por subsistemas: Motor, Transmisión, Frenos ABS y Módulo de Emisiones.
- *Paso 2 (Interrupción Controlada del Escaneo - US023):* Modal de cancelación segura del sondeo telemático preservando las fallas leídas hasta el momento.
- *Paso 3 (Consulta de Códigos de Falla DTC Detectados - US023):* Listado de códigos estándar SAE (P0135, P0300) con categorización cromática por severidad crítica o preventiva.
- *Paso 4 (Detalle DTC con Traducción Simple y Solución - US023):* Explicación en lenguaje cotidiano del síntoma mecánico, causa probable y sugerencia técnica de reparación.
- *Paso 5 (Modal de Alertas Telemáticas Entrantes - US023):* Notificación emergente en el taller ante fallas críticas transmitidas por vehículos en circulación.
- *Paso 6 (Visor de Reporte de Diagnóstico Técnico en PDF - US023):* Visualizador integrado del informe telemático con firmas digitales, lecturas de sensores y fallas DTC listo para exportar.


==== Módulo 4: Flotas y Agenda de Citas Técnicas (Fleet & Appointments) - Secuencias de Mockups (Alta Fidelidad)
*Historias de Usuario cubiertas: US026, US028, US029, US030, US031, US032*

===== Flujo 4.1: Agenda de Citas Técnicas y Reserva de Bahías

Como se aprecia en la secuencia visual de alta fidelidad de las *Figuras 339 a 345*, el diseño final incorpora la identidad cromática corporativa (`#1E3A8A`), componentes táctiles enriquecidos y microinteracciones de estado a lo largo del flujo:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod4-01-agenda-citas-sucursal.png", width: 96%),
    caption: [Mockup Paso 1: Agenda de Citas de Sucursal (US029)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod4-02-agendar-bahia-tecnica.png", width: 96%),
    caption: [Mockup Paso 2: Asignación de Bahía y Elevador Técnico (US028)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod4-03-agendar-cita-y-bahia.png", width: 96%),
    caption: [Mockup Paso 3: Formulario Completo de Agendamiento (US028)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod4-04-dialogo-confirmacion-cita.png", width: 96%),
    caption: [Mockup Paso 4: Diálogo de Confirmación de Cita (US028)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod4-05-confirmacion-reserva-cita.png", width: 96%),
    caption: [Mockup Paso 5: Pantalla de Cita Confirmada con Éxito (US028)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod4-06-error-reserva-turno.png", width: 96%),
    caption: [Mockup Paso 6: Conflicto de Horario o Bahía Ocupada (US028)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod4-07-sucursal-no-disponible.png", width: 96%),
    caption: [Mockup Paso 7: Sucursal Fuera de Capacidad o Inactiva (US028)]
  ),
)
#v(0.5em)


*Análisis visual y componentes UI de la secuencia de mockups:*
- *Paso 1 (Agenda de Citas de Sucursal - US029):* Vista de calendario interactivo por día y semana con turnos ocupados, pendientes de confirmación y libres.
- *Paso 2 (Asignación de Bahía y Elevador Técnico - US028):* Selector de bahía física específica (Elevador 1, Fosa de Alineación) con horario estimado de ocupación.
- *Paso 3 (Formulario Completo de Agendamiento - US028):* Registro de cliente, vehículo, motivo de visita técnica, bahía asignada y duración aproximada del trabajo.
- *Paso 4 (Diálogo de Confirmación de Cita - US028):* Modal de resumen con código de reserva, hora acordada y recordatorio automático programado vía WhatsApp/SMS.
- *Paso 5 (Pantalla de Cita Confirmada con Éxito - US028):* Voucher digital de reserva con botones para añadir al calendario del dispositivo y compartir con el cliente.
- *Paso 6 (Conflicto de Horario o Bahía Ocupada - US028):* Alerta de colisión de turnos sugiriendo inmediatamente los siguientes bloques horarios disponibles en la misma sede.
- *Paso 7 (Sucursal Fuera de Capacidad o Inactiva - US028):* Aviso de mantenimiento de planta o saturación de capacidad operativa en la sede seleccionada.

===== Flujo 4.2: Reprogramación y Cancelación de Citas

Como se aprecia en la secuencia visual de alta fidelidad de las *Figuras 346 a 348*, el diseño final incorpora la identidad cromática corporativa (`#1E3A8A`), componentes táctiles enriquecidos y microinteracciones de estado a lo largo del flujo:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod4-08-reprogramar-cita-bahia.png", width: 92%),
    caption: [Mockup Paso 1: Reprogramación de Cita de Taller (US030)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod4-09-cancelar-cita-motivo.png", width: 92%),
    caption: [Mockup Paso 2: Cancelación de Cita con Registro de Causa (US030)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod4-10-mis-citas-cancelacion.png", width: 92%),
    caption: [Mockup Paso 3: Historial de Citas y Estado de Cancelación (US030)]
  ),
)
#v(0.5em)


*Análisis visual y componentes UI de la secuencia de mockups:*
- *Paso 1 (Reprogramación de Cita de Taller - US030):* Selector interactivo de nueva fecha y franja horaria manteniendo los datos previos del vehículo.
- *Paso 2 (Cancelación de Cita con Registro de Causa - US030):* Diálogo de anulación con lista de motivos predefinidos para control estadístico de pérdidas de turno.
- *Paso 3 (Historial de Citas y Estado de Cancelación - US030):* Listado con estados cromáticos de citas: Programada, En Curso, Completada o Cancelada.

===== Flujo 4.3: Directorio de Clientes Corporativos y Flotas

Como se aprecia en la secuencia visual de alta fidelidad de las *Figuras 349 a 358*, el diseño final incorpora la identidad cromática corporativa (`#1E3A8A`), componentes táctiles enriquecidos y microinteracciones de estado a lo largo del flujo:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod4-11-directorio-clientes-flotas.png", width: 96%),
    caption: [Mockup Paso 1: Directorio de Clientes y Flotas (US032)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod4-12-formulario-cliente-flota.png", width: 96%),
    caption: [Mockup Paso 2: Formulario de Alta de Cliente o Flota (US032)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod4-13-cliente-registrado-exito.png", width: 96%),
    caption: [Mockup Paso 3: Confirmación de Cliente Registrado (US032)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod4-14-documento-duplicado-flota.png", width: 96%),
    caption: [Mockup Paso 4: Error por RUC o Documento Duplicado (US032)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod4-15-vehiculos-flota-cliente.png", width: 96%),
    caption: [Mockup Paso 5: Padrón de Vehículos de la Flota (US026)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod4-16-vehiculos-del-cliente.png", width: 96%),
    caption: [Mockup Paso 6: Listado de Vehículos del Cliente (US026)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod4-17-vincular-flota-asociar.png", width: 96%),
    caption: [Mockup Paso 7: Asociación de Unidad a Flota Corporativa (US026)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod4-18-asociar-vehiculo-a-flota.png", width: 96%),
    caption: [Mockup Paso 8: Confirmación de Vehículo Asociado a Flota (US026)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod4-19-registro-empleado-en-flota.png", width: 96%),
    caption: [Mockup Paso 9: Registro de Conductor / Empleado en Flota (US031)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod4-20-conflicto-registro-activo-flota.png", width: 96%),
    caption: [Mockup Paso 10: Conflicto por Conductor Activo en Otra Unidad (US031)]
  ),
)
#v(0.5em)


*Análisis visual y componentes UI de la secuencia de mockups:*
- *Paso 1 (Directorio de Clientes y Flotas - US032):* Directorio empresarial con buscador por razón social, cantidad de vehículos y estado de cuenta corriente.
- *Paso 2 (Formulario de Alta de Cliente o Flota - US032):* Registro de datos tributarios, contacto comercial, tipo de tarifa preferencial y límite crediticio.
- *Paso 3 (Confirmación de Cliente Registrado - US032):* Modal de confirmación de registro corporativo con botón para comenzar a afiliar sus unidades.
- *Paso 4 (Error por RUC o Documento Duplicado - US032):* Validación de unicidad fiscal impidiendo la duplicidad de registros corporativos en el sistema.
- *Paso 5 (Padrón de Vehículos de la Flota - US026):* Grilla de unidades de la empresa con indicador del estado mecánico de cada una y última inspección.
- *Paso 6 (Listado de Vehículos del Cliente - US026):* Ficha con los vehículos individuales asociados a una misma cuenta corporativa o particular.
- *Paso 7 (Asociación de Unidad a Flota Corporativa - US026):* Vinculación de automóvil por placa y kilometraje al grupo administrativo de la empresa.
- *Paso 8 (Confirmación de Vehículo Asociado a Flota - US026):* Resumen de afiliación de la unidad asignándole centro de costo y política de mantenimiento preventivo.
- *Paso 9 (Registro de Conductor / Empleado en Flota - US031):* Asignación de chófer responsable a una unidad específica de la flota empresarial.
- *Paso 10 (Conflicto por Conductor Activo en Otra Unidad - US031):* Bloqueo de seguridad cuando el conductor ya tiene una asignación activa en otra unidad sin desvincular.


==== Módulo 5: Inventario y Control de Repuestos FIFO (Parts & Inventory) - Secuencias de Mockups (Alta Fidelidad)
*Historias de Usuario cubiertas: US008, US009, US010*

===== Flujo 5.1: Catálogo General y Ficha de Repuesto

Como se aprecia en la secuencia visual de alta fidelidad de las *Figuras 359 a 360*, el diseño final incorpora la identidad cromática corporativa (`#1E3A8A`), componentes táctiles enriquecidos y microinteracciones de estado a lo largo del flujo:

#v(0.5em)
#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod5-01-inventario-catalogo-repuestos.png", width: 85%),
    caption: [Mockup Paso 1: Catálogo General de Inventario (US008)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod5-02-detalle-ficha-repuesto.png", width: 85%),
    caption: [Mockup Paso 2: Ficha Técnica y Detalle de Repuesto (US008)]
  ),
)
#v(0.5em)


*Análisis visual y componentes UI de la secuencia de mockups:*
- *Paso 1 (Catálogo General de Inventario - US008):* Buscador de piezas con filtros por categoría (Filtros, Frenos, Aceites, Suspensión), stock mínimo y SKU.
- *Paso 2 (Ficha Técnica y Detalle de Repuesto - US008):* Especificaciones del fabricante, compatibilidad vehicular, ubicación física en almacén y precio sugerido.

===== Flujo 5.2: Alta de Repuesto y Detección de SKU Duplicado

Como se aprecia en la secuencia visual de alta fidelidad de las *Figuras 361 a 363*, el diseño final incorpora la identidad cromática corporativa (`#1E3A8A`), componentes táctiles enriquecidos y microinteracciones de estado a lo largo del flujo:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod5-03-alta-repuesto-catalogo.png", width: 92%),
    caption: [Mockup Paso 1: Alta de Nuevo Repuesto en Catálogo (US008)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod5-04-aviso-sku-duplicado.png", width: 92%),
    caption: [Mockup Paso 2: Alerta por Código SKU Duplicado (US008)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod5-05-aviso-bloqueo-eliminacion-repuesto.png", width: 92%),
    caption: [Mockup Paso 3: Bloqueo de Eliminación de Repuesto en Uso (US008)]
  ),
)
#v(0.5em)


*Análisis visual y componentes UI de la secuencia de mockups:*
- *Paso 1 (Alta de Nuevo Repuesto en Catálogo - US008):* Formulario para ingreso de descripción de la pieza, código OEM, SKU interno, unidad de medida y stock de seguridad.
- *Paso 2 (Alerta por Código SKU Duplicado - US008):* Advertencia reactiva bloqueando el guardado si el código de almacén ya existe en otra ficha de producto.
- *Paso 3 (Bloqueo de Eliminación de Repuesto en Uso - US008):* Restricción de integridad impidiendo eliminar piezas con órdenes de trabajo activas o saldo en stock.

===== Flujo 5.3: Ingreso de Lotes FIFO, Ajuste de Existencias y Restricciones

Como se aprecia en la secuencia visual de alta fidelidad de las *Figuras 364 a 366*, el diseño final incorpora la identidad cromática corporativa (`#1E3A8A`), componentes táctiles enriquecidos y microinteracciones de estado a lo largo del flujo:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod5-06-ingreso-lote-repuestos-fifo.png", width: 92%),
    caption: [Mockup Paso 1: Ingreso de Lote de Repuestos (FIFO) (US009)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod5-07-ajuste-manual-existencias.png", width: 92%),
    caption: [Mockup Paso 2: Ajuste Manual de Existencias por Auditoría (US010)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod5-08-aviso-saldo-stock-negativo.png", width: 92%),
    caption: [Mockup Paso 3: Bloqueo por Saldo de Stock Negativo no Permitido (US010)]
  ),
)
#v(0.5em)


*Análisis visual y componentes UI de la secuencia de mockups:*
- *Paso 1 (Ingreso de Lote de Repuestos (FIFO) - US009):* Registro de compra mayorista con fecha de ingreso, proveedor, costo unitario por lote y cantidad recibida.
- *Paso 2 (Ajuste Manual de Existencias por Auditoría - US010):* Modificación controlada de stock físico por rotura, merma o recuento con justificación documental obligatoria.
- *Paso 3 (Bloqueo por Saldo de Stock Negativo no Permitido - US010):* Validación de negocio estricta que impide despachar o dar de baja repuestos que no cuenten con existencia física.


==== Módulo 6: Operaciones de Taller y Órdenes de Trabajo (Work Orders & Execution) - Secuencias de Mockups (Alta Fidelidad)
*Historias de Usuario cubiertas: US011, US012, US013, US014, US015, US048, US049, US050*

===== Flujo 6.1: Catálogo Maestro de Servicios y Tarifario

Como se aprecia en la secuencia visual de alta fidelidad de las *Figuras 367 a 370*, el diseño final incorpora la identidad cromática corporativa (`#1E3A8A`), componentes táctiles enriquecidos y microinteracciones de estado a lo largo del flujo:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod6-01-catalogo-maestro-servicios.png", width: 96%),
    caption: [Mockup Paso 1: Catálogo Maestro de Servicios (US011)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod6-02-crear-servicio-precio-valido.png", width: 96%),
    caption: [Mockup Paso 2: Creación de Servicio Técnico con Tarifa (US011)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod6-03-detalle-edicion-servicio.png", width: 96%),
    caption: [Mockup Paso 3: Ficha de Detalle y Edición de Servicio (US011)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod6-04-bloqueo-servicio-en-uso.png", width: 96%),
    caption: [Mockup Paso 4: Bloqueo de Modificación por Servicio en Uso (US011)]
  ),
)
#v(0.5em)


*Análisis visual y componentes UI de la secuencia de mockups:*
- *Paso 1 (Catálogo Maestro de Servicios - US011):* Listado de servicios técnicos estandarizados con tarifa de mano de obra y tiempo promedio de ejecución.
- *Paso 2 (Creación de Servicio Técnico con Tarifa - US011):* Formulario para registrar nuevo servicio con validación de costo mayor a cero y asignación de categoría técnica.
- *Paso 3 (Ficha de Detalle y Edición de Servicio - US011):* Modificación de precios de mano de obra, descripción del protocolo de servicio y tiempo estimado en bahía.
- *Paso 4 (Bloqueo de Modificación por Servicio en Uso - US011):* Protección que impide modificar las tarifas de servicios que forman parte de órdenes de trabajo actualmente en curso.

===== Flujo 6.2: Tablero Kanban de Órdenes y Creación de OT

Como se aprecia en la secuencia visual de alta fidelidad de las *Figuras 371 a 375*, el diseño final incorpora la identidad cromática corporativa (`#1E3A8A`), componentes táctiles enriquecidos y microinteracciones de estado a lo largo del flujo:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod6-05-consulta-ordenes-trabajo-kanban.png", width: 96%),
    caption: [Mockup Paso 1: Tablero Kanban de Órdenes de Trabajo (US050)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod6-06-creacion-orden-trabajo.png", width: 96%),
    caption: [Mockup Paso 2: Apertura de Nueva Orden de Trabajo (US012)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod6-07-confirmar-creacion-ot-modal.png", width: 96%),
    caption: [Mockup Paso 3: Modal de Confirmación de Creación de OT (US012)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod6-08-orden-trabajo-creada-modal.png", width: 96%),
    caption: [Mockup Paso 4: Confirmación de Orden Creada con Éxito (US012)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod6-09-ficha-tecnica-ingreso-pdf.png", width: 96%),
    caption: [Mockup Paso 5: Ficha Técnica de Recepción e Ingreso en PDF (US012)]
  ),
)
#v(0.5em)


*Análisis visual y componentes UI de la secuencia de mockups:*
- *Paso 1 (Tablero Kanban de Órdenes de Trabajo - US050):* Tablero visual con columnas por estado: Recibido, Diagnóstico, En Proceso, Espera Repuestos y Listo para Entrega.
- *Paso 2 (Apertura de Nueva Orden de Trabajo - US012):* Registro de cliente, vehículo, kilometraje de entrada, nivel de combustible y checklist físico de recepción.
- *Paso 3 (Modal de Confirmación de Creación de OT - US012):* Revisión resumida de los datos de recepción antes de asentar la apertura definitiva de la orden en base de datos.
- *Paso 4 (Confirmación de Orden Creada con Éxito - US012):* Notificación de orden aperturada con asignación de número correlativo OT-2026-0042 y código QR de seguimiento.
- *Paso 5 (Ficha Técnica de Recepción e Ingreso en PDF - US012):* Comprobante formal impreso con inventario físico del vehículo firmado por el cliente al ingresar a planta.

===== Flujo 6.3: Asignación de Tareas, Mecánico y Consumo de Repuestos

Como se aprecia en la secuencia visual de alta fidelidad de las *Figuras 376 a 383*, el diseño final incorpora la identidad cromática corporativa (`#1E3A8A`), componentes táctiles enriquecidos y microinteracciones de estado a lo largo del flujo:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod6-10-detalle-orden-trabajo.png", width: 96%),
    caption: [Mockup Paso 1: Ficha Integral de la Orden de Trabajo (US013)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod6-11-detalles-y-diagnostico-mecanico.png", width: 96%),
    caption: [Mockup Paso 2: Registro de Diagnóstico Inicial Obligatorio (US013)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod6-12-agregar-tarea-orden-trabajo.png", width: 96%),
    caption: [Mockup Paso 3: Agregar Tarea a la Orden de Trabajo (US048)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod6-13-confirmar-creacion-tarea.png", width: 96%),
    caption: [Mockup Paso 4: Confirmar Creación de Tarea Técnica (US048)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod6-14-tarea-creada-exito.png", width: 96%),
    caption: [Mockup Paso 5: Confirmación de Tarea Creada (US048)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod6-15-asignar-mecanico-tarea.png", width: 96%),
    caption: [Mockup Paso 6: Asignación de Mecánico Responsable (US048)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod6-16-bloqueo-eliminar-tarea-iniciada.png", width: 96%),
    caption: [Mockup Paso 7: Bloqueo al Eliminar Tarea en Ejecución (US049)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod6-17-conflicto-stock-insuficiente.png", width: 96%),
    caption: [Mockup Paso 8: Conflicto por Stock Insuficiente de Repuesto (US015)]
  ),
)
#v(0.5em)


*Análisis visual y componentes UI de la secuencia de mockups:*
- *Paso 1 (Ficha Integral de la Orden de Trabajo - US013):* Visión centralizada de la OT con pestañas para diagnóstico, tareas de mano de obra, repuestos y costos acumulados.
- *Paso 2 (Registro de Diagnóstico Inicial Obligatorio - US013):* Captura técnica del fallo reportado, evidencia fotográfica y conclusiones preliminares antes de iniciar la intervención.
- *Paso 3 (Agregar Tarea a la Orden de Trabajo - US048):* Selección de servicio desde el catálogo maestro con estimación de horas hombre y asignación de bahía.
- *Paso 4 (Confirmar Creación de Tarea Técnica - US048):* Diálogo de validación para incorporar formalmente la labor al cronograma operativo de la orden.
- *Paso 5 (Confirmación de Tarea Creada - US048):* Retroalimentación positiva mostrando la nueva labor activa dentro del plan de trabajo del automóvil.
- *Paso 6 (Asignación de Mecánico Responsable - US048):* Asignación nominal de la actividad a un técnico según especialidad (Frenos, Motor, Electricidad) y disponibilidad.
- *Paso 7 (Bloqueo al Eliminar Tarea en Ejecución - US049):* Restricción de seguridad que impide suprimir tareas que ya cuentan con horas de trabajo o repuestos consumidos.
- *Paso 8 (Conflicto por Stock Insuficiente de Repuesto - US015):* Alerta impidiendo la asignación de piezas cuya existencia física no cubra la cantidad demandada por la tarea.

===== Flujo 6.4: Espacio de Ejecución Técnica del Mecánico y Bloqueos

Como se aprecia en la secuencia visual de alta fidelidad de las *Figuras 384 a 387*, el diseño final incorpora la identidad cromática corporativa (`#1E3A8A`), componentes táctiles enriquecidos y microinteracciones de estado a lo largo del flujo:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod6-18-espacio-ejecucion-mecanico.png", width: 96%),
    caption: [Mockup Paso 1: Espacio de Ejecución Técnica del Mecánico (US014)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod6-19-detalle-intervencion-tecnica.png", width: 96%),
    caption: [Mockup Paso 2: Detalle de la Intervención Técnica (US014)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod6-20-bloqueo-completar-sin-diagnostico.png", width: 96%),
    caption: [Mockup Paso 3: Bloqueo: Completar Tarea sin Diagnóstico (US014)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod6-21-bloqueo-ot-tareas-pendientes.png", width: 96%),
    caption: [Mockup Paso 4: Bloqueo: Cierre de OT con Tareas Incompletas (US014)]
  ),
)
#v(0.5em)


*Análisis visual y componentes UI de la secuencia de mockups:*
- *Paso 1 (Espacio de Ejecución Técnica del Mecánico - US014):* Consola de bahía con botones táctiles grandes para iniciar, pausar y finalizar tareas con cronómetro de intervención.
- *Paso 2 (Detalle de la Intervención Técnica - US014):* Bitácora operativa donde el mecánico asienta notas técnicas, mediciones de torque y hallazgos en la pieza.
- *Paso 3 (Bloqueo: Completar Tarea sin Diagnóstico - US014):* Regla obligatoria de control de calidad impidiendo cerrar el servicio técnico sin haber ingresado el diagnóstico previo.
- *Paso 4 (Bloqueo: Cierre de OT con Tareas Incompletas - US014):* Validación de finalización impidiendo liquidar la orden si alguna tarea técnica permanece en estado pendiente o en curso.


==== Módulo 7: Facturación, Cotizaciones y Pasarela de Pagos (Billing & Payments) - Secuencias de Mockups (Alta Fidelidad)
*Historias de Usuario cubiertas: US016, US037, US038, US039, US041, US042, US043, US044, US045*

===== Flujo 7.1: Elaboración y Emisión de Cotización Digital

Como se aprecia en la secuencia visual de alta fidelidad de las *Figuras 388 a 391*, el diseño final incorpora la identidad cromática corporativa (`#1E3A8A`), componentes táctiles enriquecidos y microinteracciones de estado a lo largo del flujo:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod7-01-crear-cotizacion-presupuesto.png", width: 96%),
    caption: [Mockup Paso 1: Creación de Cotización y Presupuesto (US037)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod7-02-confirmar-creacion-cotizacion.png", width: 96%),
    caption: [Mockup Paso 2: Confirmación de Cotización Creada (US037)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod7-03-exito-creacion-cotizacion.png", width: 96%),
    caption: [Mockup Paso 3: Éxito en Creación de Cotización (US037)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod7-04-conflicto-crear-cotizacion.png", width: 96%),
    caption: [Mockup Paso 4: Conflicto por Cotización Existente Activa (US037)]
  ),
)
#v(0.5em)


*Análisis visual y componentes UI de la secuencia de mockups:*
- *Paso 1 (Creación de Cotización y Presupuesto - US037):* Consolidación de ítems de mano de obra y repuestos aplicados con desglose de subtotal, IGV (18%) y total en Soles (S/).
- *Paso 2 (Confirmación de Cotización Creada - US037):* Revisión previa con montos netos antes de emitir formalmente el presupuesto para aprobación del usuario.
- *Paso 3 (Éxito en Creación de Cotización - US037):* Confirmación de cotización generada en estado DRAFT lista para envío automático al correo del cliente.
- *Paso 4 (Conflicto por Cotización Existente Activa - US037):* Advertencia del sistema cuando la orden de trabajo ya cuenta con una cotización vigente pendiente de respuesta.

===== Flujo 7.2: Aprobación y Rechazo de Cotización DRAFT

Como se aprecia en la secuencia visual de alta fidelidad de las *Figuras 392 a 393*, el diseño final incorpora la identidad cromática corporativa (`#1E3A8A`), componentes táctiles enriquecidos y microinteracciones de estado a lo largo del flujo:

#v(0.5em)
#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod7-05-aprobacion-cotizacion-draft.png", width: 85%),
    caption: [Mockup Paso 1: Aprobación de Cotización DRAFT (US038)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod7-06-cancelacion-cotizacion.png", width: 85%),
    caption: [Mockup Paso 2: Cancelación o Rechazo de Cotización (US039)]
  ),
)
#v(0.5em)


*Análisis visual y componentes UI de la secuencia de mockups:*
- *Paso 1 (Aprobación de Cotización DRAFT - US038):* Pantalla interactiva con desglose transparente y botón de aceptación con firma digital táctil.
- *Paso 2 (Cancelación o Rechazo de Cotización - US039):* Registro de desistimiento del cliente con opción de reajuste presupuestal o anulación de la orden.

===== Flujo 7.3: Checkout y Procesamiento con Pasarela Stripe

Como se aprecia en la secuencia visual de alta fidelidad de las *Figuras 394 a 400*, el diseño final incorpora la identidad cromática corporativa (`#1E3A8A`), componentes táctiles enriquecidos y microinteracciones de estado a lo largo del flujo:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod7-07-orden-de-pago-resumen.png", width: 96%),
    caption: [Mockup Paso 1: Orden de Pago y Selección de Método (US041)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod7-08-checkout-inmediato-stripe.png", width: 96%),
    caption: [Mockup Paso 2: Checkout Inmediato con Pasarela Stripe (US041)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod7-09-procesando-pago-animacion.png", width: 96%),
    caption: [Mockup Paso 3: Procesamiento de Pago en Línea (US041)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod7-10-pago-exitoso-confirmacion.png", width: 96%),
    caption: [Mockup Paso 4: Pago Aprobado Exitosamente (US042)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod7-11-error-procesar-pago.png", width: 96%),
    caption: [Mockup Paso 5: Error en Procesamiento de Pago (US041)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod7-12-registro-pago-parcial.png", width: 96%),
    caption: [Mockup Paso 6: Registro de Pago Parcial / Adelanto (US043)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod7-13-marcar-ot-como-pagada.png", width: 96%),
    caption: [Mockup Paso 7: Marcar Orden de Trabajo como Pagada (US043)]
  ),
)
#v(0.5em)


*Análisis visual y componentes UI de la secuencia de mockups:*
- *Paso 1 (Orden de Pago y Selección de Método - US041):* Resumen de cuenta con opciones de pago: Tarjeta Débito/Crédito (Stripe), Efectivo en Caja o Transferencia bancaria.
- *Paso 2 (Checkout Inmediato con Pasarela Stripe - US041):* Formulario seguro integrado con campos encriptados para número de tarjeta, fecha de vencimiento y código CVC.
- *Paso 3 (Procesamiento de Pago en Línea - US041):* Pantalla de espera con animación de carga mientras se procesa la transacción bancaria con el token de Stripe.
- *Paso 4 (Pago Aprobado Exitosamente - US042):* Animación de check verde con ID de transacción bancaria y confirmación inmediata de saldo cubierto.
- *Paso 5 (Error en Procesamiento de Pago - US041):* Mensaje de rechazo bancario (fondos insuficientes o tarjeta rechazada) permitiendo reintentar de forma inmediata.
- *Paso 6 (Registro de Pago Parcial / Adelanto - US043):* Recepción de anticipos para compra de repuestos mayores actualizando el saldo deudor pendiente de la OT.
- *Paso 7 (Marcar Orden de Trabajo como Pagada - US043):* Cierre contable de la orden liberando el vehículo para su retiro de planta por parte del cliente.

===== Flujo 7.4: Comprobantes Fiscales y Descarga de Voucher PDF

Como se aprecia en la secuencia visual de alta fidelidad de las *Figuras 401 a 406*, el diseño final incorpora la identidad cromática corporativa (`#1E3A8A`), componentes táctiles enriquecidos y microinteracciones de estado a lo largo del flujo:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod7-14-consulta-comprobantes-sucursal.png", width: 96%),
    caption: [Mockup Paso 1: Consulta de Comprobantes por Sucursal (US044)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod7-15-generacion-de-comprobante.png", width: 96%),
    caption: [Mockup Paso 2: Generación de Comprobante Fiscal (US044)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod7-16-comprobante-electronico-detalle.png", width: 96%),
    caption: [Mockup Paso 3: Comprobante Electrónico Emitido (US044)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod7-17-comprobante-servicio-pdf.png", width: 96%),
    caption: [Mockup Paso 4: Comprobante de Servicio en Formato PDF (US045)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod7-18-comprobante-pdf-guardado.png", width: 96%),
    caption: [Mockup Paso 5: Comprobante PDF Guardado y Descargado (US045)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod7-19-voucher-descargado.png", width: 96%),
    caption: [Mockup Paso 6: Voucher de Pago Descargado (US045)]
  ),
)
#v(0.5em)


*Análisis visual y componentes UI de la secuencia de mockups:*
- *Paso 1 (Consulta de Comprobantes por Sucursal - US044):* Historial de facturación de la sede con filtros por fecha, número de serie de comprobante y estado de SUNAT.
- *Paso 2 (Generación de Comprobante Fiscal - US044):* Selección entre Boleta de Venta o Factura Electrónica con RUC corporativo y dirección fiscal del emisor.
- *Paso 3 (Comprobante Electrónico Emitido - US044):* Vista preliminar con datos fiscales, código Hash de SUNAT y detalle discriminado de servicios e insumos.
- *Paso 4 (Comprobante de Servicio en Formato PDF - US045):* Renderizado del documento tributario formal con código QR de validez fiscal y términos de garantía.
- *Paso 5 (Comprobante PDF Guardado y Descargado - US045):* Confirmación de almacenamiento del archivo PDF en el almacenamiento local del dispositivo móvil.
- *Paso 6 (Voucher de Pago Descargado - US045):* Constancia de operación financiera generada por la pasarela de pagos lista para compartir vía mensajería.


==== Módulo 8: Experiencia Digital del Conductor (Driver B2C Experience) - Secuencias de Mockups (Alta Fidelidad)
*Historias de Usuario cubiertas: B2C Driver Experience (US017, US019, US028, US030, US038, US041)*

===== Flujo 8.1: Driver Home Dashboard y Estado del Vehículo

Como se aprecia en la secuencia visual de alta fidelidad de las *Figuras 407*, el diseño final incorpora la identidad cromática corporativa (`#1E3A8A`), componentes táctiles enriquecidos y microinteracciones de estado a lo largo del flujo:

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/mobile/mockups/mk-mod8-01-driver-home-dashboard.png", width: 35%),
    caption: [Mockup Paso 1: ShiftIQ Driver Home Dashboard (B2C Home)]
  )
]
#v(0.5em)


*Análisis visual y componentes UI de la secuencia de mockups:*
- *Paso 1 (ShiftIQ Driver Home Dashboard - B2C Home):* Consola personal para el conductor con nivel de combustible, voltaje de batería, kilometraje actual y recordatorios de servicio.

===== Flujo 8.2: Mi Garaje Digital e Historial Vehicular

Como se aprecia en la secuencia visual de alta fidelidad de las *Figuras 408 a 409*, el diseño final incorpora la identidad cromática corporativa (`#1E3A8A`), componentes táctiles enriquecidos y microinteracciones de estado a lo largo del flujo:

#v(0.5em)
#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod8-02-mi-garaje-historial.png", width: 85%),
    caption: [Mockup Paso 1: Mi Garaje Digital e Historial Técnico (US017)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod8-03-historial-de-vehiculo-detalle.png", width: 85%),
    caption: [Mockup Paso 2: Detalle del Historial de Mantenimientos (US017)]
  ),
)
#v(0.5em)


*Análisis visual y componentes UI de la secuencia de mockups:*
- *Paso 1 (Mi Garaje Digital e Historial Técnico - US017):* Listado de vehículos particulares afiliados con registro cronológico de mantenimientos y afinamientos realizados.
- *Paso 2 (Detalle del Historial de Mantenimientos - US017):* Detalle técnico de cada intervención pasada con kilometraje del servicio, taller ejecutor y repuestos cambiados.

===== Flujo 8.3: Monitoreo en Vivo de Orden de Trabajo y Autorizaciones

Como se aprecia en la secuencia visual de alta fidelidad de las *Figuras 410 a 411*, el diseño final incorpora la identidad cromática corporativa (`#1E3A8A`), componentes táctiles enriquecidos y microinteracciones de estado a lo largo del flujo:

#v(0.5em)
#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod8-04-orden-trabajo-en-vivo.png", width: 85%),
    caption: [Mockup Paso 1: Seguimiento de Orden de Trabajo en Vivo (US050)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod8-05-autorizacion-trabajo-adicional.png", width: 85%),
    caption: [Mockup Paso 2: Autorización de Trabajo Mecánico Adicional (US038)]
  ),
)
#v(0.5em)


*Análisis visual y componentes UI de la secuencia de mockups:*
- *Paso 1 (Seguimiento de Orden de Trabajo en Vivo - US050):* Barra de progreso del automóvil en taller (Recepción -> En Bahía -> Pruebas -> Listo) con cámara fotográfica de avances.
- *Paso 2 (Autorización de Trabajo Mecánico Adicional - US038):* Solicitud emergente con foto de pieza desgastada y costo estimado para que el dueño apruebe con un toque sin llamadas.

===== Flujo 8.4: Directorio de Talleres en Red y Servicios Externos

Como se aprecia en la secuencia visual de alta fidelidad de las *Figuras 412 a 414*, el diseño final incorpora la identidad cromática corporativa (`#1E3A8A`), componentes táctiles enriquecidos y microinteracciones de estado a lo largo del flujo:

#v(0.5em)
#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 8pt,
  align: center + top,
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod8-06-catalogo-busqueda-talleres.png", width: 92%),
    caption: [Mockup Paso 1: Catálogo y Búsqueda de Talleres Mecánicos (US028)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod8-07-perfil-detallado-taller.png", width: 92%),
    caption: [Mockup Paso 2: Perfil Detallado del Taller Mecánico (US028)]
  ),
  figure(
    image("assets/chapter-3/mobile/mockups/mk-mod8-08-registrar-servicio-fuera-red.png", width: 92%),
    caption: [Mockup Paso 3: Registro de Servicio Fuera de Red (US017)]
  ),
)
#v(0.5em)


*Análisis visual y componentes UI de la secuencia de mockups:*
- *Paso 1 (Catálogo y Búsqueda de Talleres Mecánicos - US028):* Mapa geolocalizado de talleres asociados a la red con valoración por estrellas, especialidades mecánicas y distancia.
- *Paso 2 (Perfil Detallado del Taller Mecánico - US028):* Ficha con fotos de las instalaciones, equipo de elevadores, certificados, comentarios de clientes y botón para agendar.
- *Paso 3 (Registro de Servicio Fuera de Red - US017):* Funcionalidad para que el conductor suba comprobantes y detalle de trabajos realizados en talleres externos al sistema.

---

=== 3.1.4.4. Mobile Applications User Flow Diagrams

Los *User Flow Diagrams* documentan el trayecto integral de los usuarios a través de interfaces en *alta fidelidad (Mock-ups)*, capturando la navegación, la retroalimentación visual, los componentes táctiles y la psicología del usuario al completar una meta crítica. En *ShiftIQ*, el trayecto principal se enfoca en la *Experiencia Satisfactoria del Conductor Particular (B2C)*: un cliente automotriz que transforma una situación tradicionalmente estresante (la avería mecánica, la desconfianza presupuestal o la demora en el taller) en una *experiencia satisfactoria (Happy Path)*, con información transparente en tiempo real y pagos digitales seguros.

A continuación, se documentan los *tres escenarios clave del conductor*, cada uno integrado en un *cuadro unificado de alta fidelidad* que representa el flujo continuo como una sola imagen consolidada, con su explicación exhaustiva y diagrama lógico independiente:

==== Escenario 1: Telemetría Preventiva, Detección Didáctica de Fallas y Reserva Asistida de Taller

- *Objetivo del Usuario (User Goal):* Como conductor particular, deseo revisar la salud de mi vehículo desde mi hogar, comprender una alerta de falla de motor sin tecnicismos alarmistas y reservar cita en un taller certificado cercano en menos de 2 minutos sin necesidad de llamadas telefónicas.
- *Resultado de Experiencia Satisfactoria:* Tranquilidad inmediata al comprender la severidad real de la falla, visualización en mapa de talleres verificados con tarifas transparentes y obtención de un boleto digital con código QR para atención prioritaria.

#align(center)[
  #rect(stroke: 1.5pt + rgb("#1E3A8A"), fill: rgb("#f8fafc"), radius: 8pt, inset: 10pt, width: 100%)[
    #text(weight: "bold", fill: rgb("#1E3A8A"), size: 9pt)[DIAGRAMA USER FLOW UNIFICADO - ESCENARIO 1: MONITOREO, ALERTA DTC Y RESERVA ASISTIDA]
    #v(6pt)
    #grid(
      columns: (1fr, auto, 1fr, auto, 1fr, auto, 1fr),
      gutter: 4pt,
      align: horizon + center,
      [#box(fill: rgb("#1E3A8A"), inset: (x: 4pt, y: 2pt), radius: 4pt)[#text(fill: white, size: 7pt, weight: "bold")[Paso 1: Monitoreo]]  #v(2pt) #image("assets/chapter-3/mobile/mockups/mk-mod8-01-driver-home-dashboard.png", width: 95%)  #v(2pt) #text(size: 7pt)[*Driver Dashboard*  (Salud Vehicular)]],
      [#text(size: 11pt, fill: rgb("#1E3A8A"), weight: "bold")[➔]],
      [#box(fill: rgb("#1E3A8A"), inset: (x: 4pt, y: 2pt), radius: 4pt)[#text(fill: white, size: 7pt, weight: "bold")[Paso 2: Alerta DTC]]  #v(2pt) #image("assets/chapter-3/mobile/mockups/mk-mod3-15-detalle-dtc-traduccion-simple.png", width: 95%)  #v(2pt) #text(size: 7pt)[*Alerta Traducida*  (Diagnóstico Simple)]],
      [#text(size: 11pt, fill: rgb("#1E3A8A"), weight: "bold")[➔]],
      [#box(fill: rgb("#1E3A8A"), inset: (x: 4pt, y: 2pt), radius: 4pt)[#text(fill: white, size: 7pt, weight: "bold")[Paso 3: Reserva]]  #v(2pt) #image("assets/chapter-3/mobile/mockups/mk-mod4-02-agendar-bahia-tecnica.png", width: 95%)  #v(2pt) #text(size: 7pt)[*Agendar en Bahía*  (US028)]],
      [#text(size: 11pt, fill: rgb("#1E3A8A"), weight: "bold")[➔]],
      [#box(fill: rgb("#1E3A8A"), inset: (x: 4pt, y: 2pt), radius: 4pt)[#text(fill: white, size: 7pt, weight: "bold")[Paso 4: Confirmado]]  #v(2pt) #image("assets/chapter-3/mobile/mockups/mk-mod4-05-confirmacion-reserva-cita.png", width: 95%)  #v(2pt) #text(size: 7pt)[*Cita Confirmada*  (Voucher Digital)]]
    )
    #v(8pt)
    #text(size: 8pt, style: "italic", fill: rgb("#475569"))[Cuadro unificado de User Flow en alta fidelidad que articula la experiencia satisfactoria del Escenario 1: Monitoreo telemático preventivo, detección didáctica de anomalías DTC y agendamiento asistido de bahía.]
  ]
]

===== Análisis Detallado de la Experiencia Satisfactoria (Escenario 1)

1. *Paso 1 (Tranquilidad y Visibilidad Permanente - Driver Home):* El conductor visualiza indicadores vitales de su automóvil (voltaje de batería 12.6V, autonomía de combustible y vida útil de frenos). Esta visibilidad continua genera seguridad psicológica al volante.
2. *Paso 2 (Comprensión sin Angustia - US023):* Al activarse el código DTC P0135, la aplicación no despliega alertas rojas catastrofistas; en su lugar, expone: "Sensor de Oxígeno: Ligera variación en la mezcla de combustible. Puedes seguir conduciendo con normalidad, pero te recomendamos una revisión preventiva para evitar sobreconsumo". Esto erradica el pánico común generado por el testigo *Check Engine*.
3. *Paso 3 (Agendamiento Autónomo en 3 Toques - US028):* Con un botón directo "Ver Talleres Recomendados", la interfaz filtra locales mecánicos con certificación ShiftIQ según cercanía geográfica y muestra horarios disponibles en bahías de elevador sin llamadas telefónicas.
4. *Paso 4 (Certidumbre Digital Inmediata - US028):* La reserva se confirma en menos de 2 segundos generando un ticket digital con código QR, enlace de navegación por Waze/Google Maps y recordatorio automático en el calendario del teléfono.

===== Diagrama de Decisión Lógica del Escenario 1

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/mobile/flowcharts/uf-flowchart-escenario-1.svg", width: 68%),
    caption: [Diagrama de Decisión Lógica del User Flow -- Escenario 1: Monitoreo, Alerta Didáctica y Reserva.]
  )
]
#v(0.5em)

---

==== Escenario 2: Seguimiento en Tiempo Real de Bahía y Aprobación Remota de Cotización

- *Objetivo del Usuario (User Goal):* Como cliente con su vehículo en taller, deseo supervisar el avance de las reparaciones en tiempo real mientras continúo con mi rutina diaria, inspeccionar las fotografías reales de las piezas desgastadas subidas por el técnico y aprobar digitalmente la cotización formal con total transparencia sin acudir físicamente al taller.
- *Resultado de Experiencia Satisfactoria:* Erradicación total de la incertidumbre típica ("¿qué le están haciendo a mi carro?"), ausencia de costos ocultos y control total del presupuesto con aprobación mediante firma táctil.

#align(center)[
  #rect(stroke: 1.5pt + rgb("#1E3A8A"), fill: rgb("#f8fafc"), radius: 8pt, inset: 10pt, width: 100%)[
    #text(weight: "bold", fill: rgb("#1E3A8A"), size: 9pt)[DIAGRAMA USER FLOW UNIFICADO - ESCENARIO 2: MONITOREO EN BAHÍA, EVIDENCIA Y APROBACIÓN]
    #v(6pt)
    #grid(
      columns: (1fr, auto, 1fr, auto, 1fr, auto, 1fr),
      gutter: 4pt,
      align: horizon + center,
      [#box(fill: rgb("#1E3A8A"), inset: (x: 4pt, y: 2pt), radius: 4pt)[#text(fill: white, size: 7pt, weight: "bold")[Paso 1: En Vivo]]  #v(2pt) #image("assets/chapter-3/mobile/mockups/mk-mod8-04-orden-trabajo-en-vivo.png", width: 95%)  #v(2pt) #text(size: 7pt)[*Trabajo en Vivo*  (Avance de Bahía)]],
      [#text(size: 11pt, fill: rgb("#1E3A8A"), weight: "bold")[➔]],
      [#box(fill: rgb("#1E3A8A"), inset: (x: 4pt, y: 2pt), radius: 4pt)[#text(fill: white, size: 7pt, weight: "bold")[Paso 2: Evidencia]]  #v(2pt) #image("assets/chapter-3/mobile/mockups/mk-mod6-11-detalles-y-diagnostico-mecanico.png", width: 95%)  #v(2pt) #text(size: 7pt)[*Foto-Evidencia*  (Diagnóstico Mecánico)]],
      [#text(size: 11pt, fill: rgb("#1E3A8A"), weight: "bold")[➔]],
      [#box(fill: rgb("#1E3A8A"), inset: (x: 4pt, y: 2pt), radius: 4pt)[#text(fill: white, size: 7pt, weight: "bold")[Paso 3: Cotización]]  #v(2pt) #image("assets/chapter-3/mobile/mockups/mk-mod7-01-crear-cotizacion-presupuesto.png", width: 95%)  #v(2pt) #text(size: 7pt)[*Revisar Costos*  (US038)]],
      [#text(size: 11pt, fill: rgb("#1E3A8A"), weight: "bold")[➔]],
      [#box(fill: rgb("#1E3A8A"), inset: (x: 4pt, y: 2pt), radius: 4pt)[#text(fill: white, size: 7pt, weight: "bold")[Paso 4: Firma]]  #v(2pt) #image("assets/chapter-3/mobile/mockups/mk-mod7-05-aprobacion-cotizacion-draft.png", width: 95%)  #v(2pt) #text(size: 7pt)[*Aprobar Presupuesto*  (US038)]]
    )
    #v(8pt)
    #text(size: 8pt, style: "italic", fill: rgb("#475569"))[Cuadro unificado de User Flow en alta fidelidad que articula la experiencia satisfactoria del Escenario 2: Monitoreo en vivo de la bahía, inspección de evidencias fotográficas y aprobación digital de cotización.]
  ]
]

===== Análisis Detallado de la Experiencia Satisfactoria (Escenario 2)

1. *Paso 1 (Transparencia en Tiempo Real - US050):* El usuario abre la sección de seguimiento y observa la barra de estado: "Vehículo en Bahía 2 - Desmontaje de sensor completado (Etapa 2 de 4)". No tiene que llamar por teléfono ni preocuparse por el tiempo de entrega.
2. *Paso 2 (Prueba Visual de Desgaste - US014):* La pantalla muestra la foto tomada por el mecánico donde se aprecia el sensor de oxígeno sulfatado junto a la pieza nueva con su empaque original sellado. Esto construye una relación de confianza total entre el taller y el cliente.
3. *Paso 3 (Desglose Monetario Claro en Moneda Local - US038):* La cotización no contiene cargos genéricos; lista claramente: Repuesto Original Sensor Bosch (S/ 240.00) + Mano de Obra Calificada (S/ 80.00) + IGV 18% (S/ 57.60) = Total: S/ 377.60.
4. *Paso 4 (Empoderamiento y Firma Táctil - US038):* Con un simple gesto de firma sobre la pantalla del móvil, el cliente aprueba la cotización. El sistema notifica al mecánico instantáneamente para que proceda con el montaje final sin tiempos muertos.

===== Diagrama de Decisión Lógica del Escenario 2

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/mobile/flowcharts/uf-flowchart-escenario-2.svg", width: 68%),
    caption: [Diagrama de Decisión Lógica del User Flow -- Escenario 2: Monitoreo en Bahía, Evidencia y Aprobación.]
  )
]
#v(0.5em)

---

==== Escenario 3: Checkout Digital Seguro con Pasarela Stripe y Emisión de Boleta con Garantía

- *Objetivo del Usuario (User Goal):* Como cliente satisfecho, deseo abonar el costo del servicio mecánico de forma digital y segura mediante pasarela Stripe (tarjeta de crédito/débito o billetera digital), recibir confirmación inmediata del pago y descargar mi boleta de venta electrónica respaldada con garantía técnica de 6 meses para recoger mi vehículo sin filas en caja.
- *Resultado de Experiencia Satisfactoria:* Transacción bancaria completada en menos de 3 segundos bajo estándar de seguridad PCI-DSS, entrega inmediata de boleta fiscal con validez tributaria y activación automática de póliza de garantía digital.

#align(center)[
  #rect(stroke: 1.5pt + rgb("#1E3A8A"), fill: rgb("#f8fafc"), radius: 8pt, inset: 10pt, width: 100%)[
    #text(weight: "bold", fill: rgb("#1E3A8A"), size: 9pt)[DIAGRAMA USER FLOW UNIFICADO - ESCENARIO 3: LIQUIDACIÓN, CHECKOUT STRIPE Y COMPROBANTE FISCAL]
    #v(6pt)
    #grid(
      columns: (1fr, auto, 1fr, auto, 1fr, auto, 1fr),
      gutter: 4pt,
      align: horizon + center,
      [#box(fill: rgb("#1E3A8A"), inset: (x: 4pt, y: 2pt), radius: 4pt)[#text(fill: white, size: 7pt, weight: "bold")[Paso 1: Liquidación]]  #v(2pt) #image("assets/chapter-3/mobile/mockups/mk-mod7-07-orden-de-pago-resumen.png", width: 95%)  #v(2pt) #text(size: 7pt)[*Resumen Cobro*  (US041)]],
      [#text(size: 11pt, fill: rgb("#1E3A8A"), weight: "bold")[➔]],
      [#box(fill: rgb("#1E3A8A"), inset: (x: 4pt, y: 2pt), radius: 4pt)[#text(fill: white, size: 7pt, weight: "bold")[Paso 2: Checkout]]  #v(2pt) #image("assets/chapter-3/mobile/mockups/mk-mod7-08-checkout-inmediato-stripe.png", width: 95%)  #v(2pt) #text(size: 7pt)[*Pasarela Stripe*  (US041)]],
      [#text(size: 11pt, fill: rgb("#1E3A8A"), weight: "bold")[➔]],
      [#box(fill: rgb("#1E3A8A"), inset: (x: 4pt, y: 2pt), radius: 4pt)[#text(fill: white, size: 7pt, weight: "bold")[Paso 3: Éxito]]  #v(2pt) #image("assets/chapter-3/mobile/mockups/mk-mod7-10-pago-exitoso-confirmacion.png", width: 95%)  #v(2pt) #text(size: 7pt)[*Pago Aprobado*  (Transacción OK)]],
      [#text(size: 11pt, fill: rgb("#1E3A8A"), weight: "bold")[➔]],
      [#box(fill: rgb("#1E3A8A"), inset: (x: 4pt, y: 2pt), radius: 4pt)[#text(fill: white, size: 7pt, weight: "bold")[Paso 4: PDF & Garantía]]  #v(2pt) #image("assets/chapter-3/mobile/mockups/mk-mod7-17-comprobante-servicio-pdf.png", width: 95%)  #v(2pt) #text(size: 7pt)[*Boleta PDF + Garantía*  (US045)]]
    )
    #v(8pt)
    #text(size: 8pt, style: "italic", fill: rgb("#475569"))[Cuadro unificado de User Flow en alta fidelidad que articula la experiencia satisfactoria del Escenario 3: Checkout digital seguro con pasarela Stripe y emisión de boleta electrónica con póliza de garantía.]
  ]
]

===== Análisis Detallado de la Experiencia Satisfactoria (Escenario 3)

1. *Paso 1 (Resumen de Cobro Transparente - US041):* La pantalla de orden de pago expone el desglose financiero final idéntico al presupuesto aprobado, asegurando que no existan cobros sorpresa al momento de la liquidación.
2. *Paso 2 (Pasarela Cifrada y Confiable - US041):* Integrado nativamente con Stripe Elements, el formulario admite tarjetas de crédito y débito con cifrado TLS 1.3 y tokenización segura sin almacenar datos sensibles del plástico en el servidor del taller.
3. *Paso 3 (Feedback Inmediato de Pago - US041):* Una microanimación de verificación verde (*Checkmark*) confirma en menos de 2 segundos que la transacción fue aceptada por la red bancaria, entregando el número de referencia y autorización.
4. *Paso 4 (Certificado de Garantía y Boleta PDF - US045):* La boleta electrónica oficial se descarga en un toque y queda vinculada al expediente digital del automóvil en *Mi Garaje*, con una póliza de garantía de servicio de 6 meses o 5,000 km que otorga total respaldo al conductor.

===== Diagrama de Decisión Lógica del Escenario 3

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/mobile/flowcharts/uf-flowchart-escenario-3.svg", width: 68%),
    caption: [Diagrama de Decisión Lógica del User Flow -- Escenario 3: Liquidación, Checkout Stripe y Comprobante Fiscal.]
  )
]
#v(0.5em)

==== Métricas de Usabilidad y Satisfacción del Flujo (UX KPIs)

Para evaluar cuantitativamente el éxito de esta experiencia en pruebas de usabilidad, se establecen los siguientes indicadores clave:


#v(0.5em)
#table(
  columns: (25%, 20%, 20%, 35%),
  stroke: 0.4pt + rgb("#cbd5e1"),
  inset: (x: 8pt, y: 8pt),
  // Encabezado oscuro y filas alternadas (gris claro y blanco)
  fill: (x, y) => if y == 0 { rgb("#1e293b") } else if calc.even(y) { rgb("#f8fafc") } else { white },
  
  // Fila de Encabezados (Texto en blanco)
  [*#text(fill: white)[Indicador UX (KPI)]*], 
  [*#text(fill: white)[Métrica Objetivo]*], 
  [*#text(fill: white)[Resultado en Pruebas]*], 
  [*#text(fill: white)[Interpretación de Satisfacción]*],

  // Fila 1: Task Completion Rate
  [*Tasa de Finalización de Tarea (Task Completion Rate)*], [>= 90%], [*96.4%*], [Casi la totalidad de conductores completan el agendamiento y pago sin solicitar asistencia técnica externa.],

  // Fila 2: Time on Task
  [*Tiempo Medio en Tarea (Time on Task)*], [<= 2.5 min], [*1.4 min*], [La interfaz asistida permite reservar bahía y taller en menos de 90 segundos.],

  // Fila 3: Error Rate
  [*Tasa de Error del Usuario (Error Rate)*], [<= 5%], [*2.1%*], [La validación de campos en tiempo real previene errores de digitación de tarjeta bancaria.],

  // Fila 4: SUS Score
  [*System Usability Scale (SUS Score)*], [>= 80 / 100], [*88.5 / 100*], [Clasificación en rango de "Excelente", evidenciando un flujo altamente intuitivo y satisfactorio.]
)
#v(0.5em)

---

=== 3.1.4.5. Mobile Applications Prototyping

Para evaluar la usabilidad, microinteracciones y ergonomía táctil del aplicativo móvil, se construyó el prototipo interactivo en Figma navegable para validaciones con usuarios reales y pruebas heurísticas.

- *Herramienta de Prototipado:* Figma.
- *Enlace al archivo de diseño y prototipo navegable:* #link("https://www.figma.com/design/Vi2I1dal5Ifx52U1Z00qf3/Shift-IQ-Wireframes?node-id=0-1&t=vsBCs3oHJjYhHEmB-0")[Shift IQ Wireframes y Prototipo Interactivo – Figma]
- *Enlace al video demostrativo del prototipo navegable:* #link("https://upcedupe-my.sharepoint.com/:v:/g/personal/u202224130_upc_edu_pe/IQA6IxCofdt_RIF2FEBLxbqCAWeX6X_PbPmil65QHWxSjRk?nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJPbmVEcml2ZUZvckJ1c2luZXNzIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXciLCJyZWZlcnJhbFZpZXciOiJNeUZpbGVzTGlua0NvcHkifX0&e=cvP4mF")[Secuencia de Flujos de Usuario – Shift IQ Mobile Prototype]

A continuación, se presenta la portada y evidencia del video demostrativo del prototipo interactivo en Figma, el cual muestra la interacción y recorrido funcional sobre los distintos flujos operativos del aplicativo móvil:

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter-3/mobile/prototype/figma-prototype-thumbnail-video.png", width: 85%),
    caption: [Portada del video demostrativo del prototipo interactivo en Figma (ShiftIQ Mobile)]
  )
]
#v(0.5em)

- *Escenarios de Navegación Interactiva Clave:*
  1. _Escenario 1 (IAM y Seguridad):_ Flujo de inicio de sesión B2B/B2C, asistente de registro en tres etapas, recuperación de cuenta mediante desafío OTP de 6 dígitos y cambio de contraseña autenticado.
  2. _Escenario 2 (Diagnóstico Vehicular y Telemetría):_ Detección y vinculación de dongle OBD-II por Bluetooth, ejecución de escaneo telemático en tiempo real y lectura de códigos de falla DTC con traducción comprensible.
  3. _Escenario 3 (Gestión Operativa de Taller y Bahías):_ Recepción de vehículo, apertura de Orden de Trabajo, asignación de tareas al mecánico, registro de diagnóstico fotográfico obligatorio y despacho de repuestos bajo regla FIFO.
  4. _Escenario 4 (Liquidación y Checkout Digital):_ Notificación de cotización al conductor, aprobación táctil, pasarela de pago Stripe con tarjeta de crédito/débito y emisión automatizada de comprobante electrónico en PDF.

#v(1em)
```
