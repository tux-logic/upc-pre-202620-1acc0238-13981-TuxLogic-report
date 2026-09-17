```{=typst}
#set page(
  paper: "a4",
  flipped: true,
  margin: (x: 2cm, top: 2.2cm, bottom: 2.2cm)
)

== 2.1. Competidores

=== 2.1.1. Análisis competitivo

#align(center)[#text(style: "italic", size: 9.5pt, fill: rgb("#64748b"))[Competitive Analysis Landscape]]

#let header-fill = rgb("#1e3a8a")
#let label-fill = rgb("#e2e8f0")
#let alt-fill = rgb("#f8fafc")
#let hcell(body) = text(fill: white, weight: "bold")[#body]
#let lbl(body) = text(weight: "bold")[#body]

#v(0.5em)
#table(
  columns: (11%, 13%, 1fr, 1fr, 1fr, 1fr),
  align: left,
  stroke: 0.4pt + rgb("#cbd5e1"),
  inset: (x: 6pt, y: 5pt),
  fill: (x, y) => if y == 0 and x >= 2 { rgb("#f8fafc") } else if y <= 1 { header-fill } else if x <= 1 { label-fill } else if calc.even(y) { alt-fill } else { white },

  // Fila 0 — motivo del análisis
  table.cell(colspan: 2)[#hcell[¿Por qué llevar a cabo este análisis?]],
  table.cell(colspan: 4)[#text(fill: rgb("#1e293b"), weight: "regular")[Buscamos entender si el problema de mantenimiento reactivo y falta de diagnóstico predictivo en talleres automotrices peruanos ya está siendo resuelto por otros actores, y en qué medida. El objetivo es identificar si existe una oferta real de mantenimiento predictivo basado en telemetría (hardware OBD) en el mercado peruano, o si los competidores actuales solo cubren la gestión administrativa del taller, para confirmar el espacio de diferenciación de ShiftIq.]],

  // Fila 1 — nombres de competidores
  table.cell(colspan: 2)[#hcell[Competidor]],
  [#align(center)[#hcell[ShiftIq]]],
  [
    #align(center)[
      #image("assets/chapter-2/competitors/Logo_GestionCAR.jpg", height: 28pt)
      #hcell[Competidor 1]
    ]
  ],
  [
    #align(center)[
      #image("assets/chapter-2/competitors/Logo_OK-Car.png", height: 28pt)
      #hcell[Competidor 2]
    ]
  ],
  [
    #align(center)[
      #image("assets/chapter-2/competitors/Logo_ERP.png", height: 28pt)
      #hcell[Competidor 3]
    ]
  ],

  // Perfil — Overview
  table.cell(rowspan: 2)[#lbl[Perfil]],
  [Overview],
  [TuxLogic es una startup peruana de base tecnológica, concebida y desarrollada por estudiantes de Ingeniería de Software de la UPC. Nuestro producto ShiftIq transforma el modelo operativo de los talleres automotrices, evolucionándolo de un enfoque reactivo a uno preventivo, predictivo e inteligente mediante dispositivos de diagnóstico a bordo (OBD) + procesamiento de telemetría en tiempo real + ecosistema web/móvil.],
  [Plataforma de gestión automotriz con fuerte presencia regional en Latinoamérica (opera en varios países, incluido Perú). Se posiciona como una "red de talleres" con módulos de comunicación por WhatsApp, IA aplicada a la transcripción de diagnósticos y una comunidad/academia de talleres (cursos, certificaciones, foro técnico).],
  [Plataforma peruana en la nube para la gestión integral de talleres mecánicos, enfocada en digitalizar la operación diaria (órdenes, inventario, facturación) de talleres multimarca independientes.],
  [ERP SICO es el producto desarrollado por *Soinfo Perú* ("Soluciones en Tecnología de Información"), orientado a concesionarios y talleres de autos y motos. Su diferenciador es la facturación electrónica SUNAT nativa y el control de historial de servicio por placa/mecánico. #emph[(Nota: SICO es el nombre del producto; Soinfo es la empresa que lo desarrolla y comercializa — no tiene un logo propio distinto al de la marca Soinfo.)]],

  // Perfil — Ventaja Competitiva
  [Ventaja Competitiva \ #emph[¿Qué valor ofrece a los clientes?]],
  [Somos de los pocos en el mercado peruano que integran hardware de diagnóstico a bordo (OBD) con procesamiento de telemetría en tiempo real para mantenimiento predictivo real, no solo recordatorios por kilometraje/tiempo. Complementamos esto con un ERP de taller y facturación SUNAT, además del respaldo académico de la UPC.],
  [Su ventaja es el efecto de red regional: al operar en múltiples países de LATAM, pueden invertir en funciones como IA de transcripción y una comunidad grande de talleres que comparte conocimiento, lo que genera fidelización más allá del software mismo.],
  [Su ventaja es ser una solución local, en la nube, con curva de aprendizaje simple para talleres pequeños y medianos que buscan dejar el papel/Excel sin una inversión grande.],
  [Su ventaja es la especialización en el cumplimiento normativo peruano (SUNAT) y el control operativo por placa, apuntando también a concesionarios (no solo talleres independientes).],

  // Perfil de Marketing — Mercado Objetivo
  table.cell(rowspan: 2)[#lbl[Perfil de Marketing]],
  [Mercado Objetivo],
  [Talleres multimarca independientes de pequeño y mediano tamaño en Lima Metropolitana (1–5 elevadores), que atienden vehículos particulares 2015+ (con puerto OBD accesible), buscando diferenciarse con mantenimiento preventivo/predictivo basado en datos.],
  [Talleres mecánicos de distintos tamaños en varios países de LATAM (incluye Perú), con foco en digitalización integral y comunidad/capacitación del rubro. #emph[(estimado)]],
  [Talleres multimarca independientes pequeños y medianos en Perú que buscan una gestión administrativa simple y accesible. #emph[(estimado)]],
  [Concesionarios y talleres de autos/motos en Perú que requieren cumplimiento tributario SUNAT integrado a la operación. #emph[(estimado)]],

  // Perfil de Marketing — Estrategias
  [Estrategias de Marketing],
  [Marketing digital B2B con demos en vivo del diagnóstico predictivo, alianzas con importadoras de repuestos para exhibir el dispositivo OBD, participación en ferias universitarias/automotrices, y programa de referidos.],
  [Marketing de comunidad: cursos y certificaciones, competencias entre talleres, foro de dudas técnicas y marketplace de servicios especializados, que generan retención más allá del software. #emph[(estimado en estrategia, basado en su web)]],
  [Marketing digital directo (SEO/redes) orientado a captar talleres pequeños con mensaje de simplicidad y bajo costo. #emph[(estimado)]],
  [Venta consultiva B2B enfocada en cumplimiento normativo, probablemente con referidos entre concesionarios. #emph[(estimado)]],

  // Perfil de Producto — Productos & Servicios
  table.cell(rowspan: 3)[#lbl[Perfil de Producto]],
  [Productos & Servicios],
  [Plataforma web + app móvil sincronizadas con dispositivo de diagnóstico a bordo: telemetría y códigos DTC en tiempo real, ERP de taller (órdenes, inventario, agenda), facturación electrónica SUNAT, alertas al conductor y al técnico.],
  [Software web/móvil de gestión: órdenes de trabajo con fotos, cotizaciones, control de calidad, productividad de mecánicos, inventario, facturación, recordatorios de mantención, notificaciones WhatsApp/email. *No incluye hardware OBD.*],
  [Software en la nube de gestión de taller: presupuestos, facturación, plantillas, decodificador VIN, seguimiento de vehículos/clientes, inventario. *No incluye hardware OBD.*],
  [ERP con control de órdenes de trabajo, inventario de repuestos, facturación electrónica SUNAT y seguimiento de reparaciones por placa/mecánico. *No incluye hardware OBD.*],

  // Perfil de Producto — Precios & Costos
  [Precios & Costos],
  [Modelo híbrido estimado: *suscripción mensual desde S/ 199/mes* (ERP + telemetría + SUNAT + app) y *hardware OBD desde S/ 499* (pago único) o en comodato mensual. #emph[(estimado, sujeto a validación en el plan de negocio)]],
  [Precio no publicado en su web; suele manejarse por cotización según volumen de talleres/módulos. #emph[(no publicado — estimado)]],
  [Precio no publicado en su web; sitios comparadores no listan tarifas exactas. #emph[(no publicado — estimado)]],
  [Precio no publicado en su web; probablemente por cotización según tamaño del concesionario/taller. #emph[(no publicado — estimado)]],

  // Perfil de Producto — Canales de distribución
  [Canales de distribución \ (Web y/o Móvil)],
  [Modelo híbrido SaaS + hardware propio: registro web, envío del dispositivo OBD en Lima, venta directa digital + alianzas con importadoras de repuestos.],
  [SaaS en la nube, venta directa digital con posible soporte de partners locales en cada país. #emph[(estimado)]],
  [SaaS en la nube, venta 100% digital. #emph[(estimado)]],
  [Venta directa/consultiva, típico de proveedores ERP locales para concesionarios. #emph[(estimado)]],

  // Análisis SWOT — Fortalezas
  table.cell(rowspan: 4)[#lbl[Análisis SWOT]],
  [Fortalezas],
  [Único con hardware OBD + telemetría real (no solo historial). Respaldo académico UPC. Enfoque dual taller-conductor (transparencia). Potencial de facturación SUNAT nativa integrada al flujo predictivo.],
  [
    - Presencia regional en varios países LATAM (economías de escala).
    - Comunidad activa de talleres (cursos, certificaciones, foro).
    - IA aplicada a transcripción de diagnósticos.
    - Notificaciones automáticas por WhatsApp.
  ],
  [
    - Solución simple y accesible para talleres pequeños.
    - Funciones completas de facturación/presupuestos/VIN.
    - Marca ya reconocida en comparadores de software (Capterra, ComparaSoftware).
  ],
  [
    - Facturación electrónica SUNAT nativa.
    - Enfoque también en concesionarios (mercado más amplio que solo talleres independientes).
    - Control de historial por placa y por mecánico.
  ],

  // Análisis SWOT — Debilidades
  [Debilidades],
  [Startup en etapa temprana, sin base instalada ni casos de éxito masivos. Dependencia de importación de hardware OBD (riesgo de cadena de suministro). Presupuesto de marketing limitado frente a competidores regionales.],
  [
    - Sin integración de hardware OBD (no hace diagnóstico predictivo real, depende de historial/recordatorios).
    - Al operar en varios países, su adaptación específica a normativa SUNAT peruana podría ser menos prioritaria que para un jugador 100% local.
  ],
  [
    - Sin integración OBD (predictivo, si existe, es por historial/kilometraje).
    - Enfocado en administración, no en diagnóstico técnico.
  ],
  [
    - Sin integración OBD ni mantenimiento predictivo real.
    - Enfoque fuertemente administrativo/tributario, no técnico.
  ],

  // Análisis SWOT — Oportunidades
  [Oportunidades],
  [Crecimiento de vehículos con puerto OBD accesible en el parque automotor peruano. Demanda de talleres por diferenciarse con "chequeo preventivo con tecnología". Alianzas con aseguradoras para talleres certificados. Fondos concursables para startups UPC. Expansión a flotas corporativas.],
  [
    - Podrían integrar hardware OBD de terceros para cerrar su brecha frente a soluciones predictivas reales.
    - Expandir su comunidad/academia como diferenciador adicional.
  ],
  [
    - Podrían sumar un módulo de diagnóstico OBD básico vía partnership.
    - Expandir a talleres de cadena en Perú.
  ],
  [
    - Podrían extender su ERP hacia mantenimiento predictivo si suman telemetría.
    - Crecimiento de concesionarios que buscan digitalización integral.
  ],

  // Análisis SWOT — Amenazas
  [Amenazas],
  [Entrada de competidores integrando hardware OBD de terceros para copiar el modelo (incluye actores como GestionCar u otros). Cambios normativos SUNAT que obliguen a reprogramar el módulo de facturación. Importadoras de scanners OBD lanzando software gratuito propio. Resistencia al cambio de dueños de talleres tradicionales.],
  [
    - Entrada de TuxLogic con OBD + telemetría real (propuesta de valor superior en diagnóstico).
    - Nuevos jugadores locales con foco 100% peruano.
  ],
  [
    - TuxLogic con hardware propio + SUNAT nativo.
    - Competidores regionales (GestionCar) con mayor escala.
  ],
  [
    - TuxLogic con modelo más ágil orientado también al conductor final.
    - Competidores SaaS más simples ganando talleres pequeños por precio/UX.
  ],
)
#v(0.5em)

=== 2.1.2. Estrategias y tácticas frente a competidores

#align(center)[#text(style: "italic", size: 9.5pt, fill: rgb("#64748b"))[Tabla de estrategias y tácticas frente a competidores]]

#v(0.5em)
#table(
  columns: (14%, 1fr, 1fr, 1fr),
  align: left,
  stroke: 0.4pt + rgb("#cbd5e1"),
  inset: (x: 6pt, y: 5pt),
  fill: (x, y) => if y == 0 { header-fill } else if calc.even(y) { alt-fill } else { white },
  table.header(
    [#hcell[Competidores]], [#hcell[Táctica diferenciadora]], [#hcell[Fortalezas del rival que enfrentamos]], [#hcell[Debilidad del rival que aprovecharemos]],
  ),

  [
    #align(center)[#image("assets/Logo_GestionCAR.jpg", height: 32pt)]
  ],
  [Se posicionan como *la red de talleres más grande de la región*: no venden solo software, venden pertenecer a una comunidad. Su gancho es la *comunidad activa* (cursos, certificaciones, foro técnico, marketplace de servicios) que hace que los talleres se queden por el ecosistema, no solo por las funciones del sistema.],
  [*Efecto de red regional*: al operar en varios países de LATAM acumulan miles de talleres, lo que les da economías de escala para invertir en funciones como IA de transcripción de diagnósticos y en mantener viva una comunidad de aprendizaje entre talleres. Esa base instalada grande genera confianza ("si tantos talleres lo usan, debe funcionar").],
  [*Su IA transcribe lo que el mecánico ya diagnosticó a mano*: la IA de GestionCar ayuda a redactar o pasar en limpio el reporte, pero *no lee el vehículo en tiempo real* — el mecánico sigue usando su escáner aparte y anotando manualmente. *Nuestra oportunidad:* nuestro dispositivo OBD2 envía la telemetría directo a la plataforma y nuestro motor de interpretación de códigos DTC genera la alerta y el nivel de criticidad al instante, sin que el mecánico tenga que redactar nada. Les ganamos en *velocidad de diagnóstico* y *prevención real de fallas*, no solo en documentarlas mejor.],

  [
    #align(center)[#image("assets/Logo_OK-Car.png", height: 32pt)]
  ],
  [Se venden como *la solución simple y accesible en la nube*: "digitaliza tu taller sin complicaciones". Su gancho es la *rapidez de adopción* y un set de funciones completo (presupuestos, VIN, facturación, seguimiento de clientes) para talleres pequeños que solo quieren dejar el papel y el Excel.],
  [*Simplicidad y reconocimiento en comparadores*: al aparecer bien posicionados en sitios como Capterra o ComparaSoftware, generan confianza inmediata en dueños de taller que buscan "el más recomendado" antes de decidir, sin necesidad de una fuerza de ventas agresiva.],
  [*Administran el papeleo, no el vehículo*: OK CAR no tiene ninguna integración con el auto — todo su valor está en organizar órdenes, presupuestos y facturas, pero el diagnóstico sigue dependiendo 100% del ojo del mecánico. *Nuestra oportunidad:* nuestras alertas nacen directamente de la lectura OBD2 del vehículo, con nivel de criticidad ya definido, antes de que el conductor note algo raro. Les ganamos en *tecnología de diagnóstico* y en darle al conductor una razón basada en datos reales del auto para confiar en el taller.],

  [
    #align(center)[#image("assets/Logo_ERP.png", height: 32pt)]
  ],
  [Se venden como *el ERP que cumple con todo lo que pide SUNAT*: "factura y controla tu taller o concesionario sin dolores de cabeza tributarios". Su gancho es el *cumplimiento normativo* y el control de historial por placa/mecánico, apuntando tanto a talleres como a concesionarios.],
  [*Especialización tributaria y alcance a concesionarios*: al enfocarse en la facturación electrónica SUNAT como eje central, generan confianza con negocios más grandes (concesionarios) que no pueden arriesgarse a errores de facturación, ampliando su mercado más allá del taller independiente.],
  [*Cumplen con SUNAT, pero no saben qué le pasa al auto*: ERP SICO es un sistema puramente administrativo/contable; no tiene ningún vínculo con el vehículo ni interpreta señales de diagnóstico. *Nuestra oportunidad:* ShiftIq también puede cubrir la facturación SUNAT, pero además traduce la telemetría del vehículo en alertas de mantenimiento preventivo en tiempo real. Les ganamos en *tecnología de diagnóstico* y en ofrecer una propuesta completa (cumplimiento + preventivo) donde ellos solo cubren la mitad administrativa.],
)
#v(0.5em)

#set page(
  paper: "a4",
  flipped: false,
  margin: (x: 2.5cm, top: 2.8cm, bottom: 2.5cm)
)
```