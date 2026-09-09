## 2.3. Needfinding

En esta sección se presentan los artefactos derivados del análisis de necesidades de los dos segmentos objetivo de ShiftIq: dueños o administradores de talleres automotrices independientes y conductores de vehículos particulares en Lima Metropolitana. El needfinding articula la investigación cualitativa con el diseño de una solución **móvil** (aplicaciones nativas y/o multiplataforma), de modo que las personas, tareas, journeys y mapas de empatía alimenten directamente los requerimientos de experiencia de usuario, conectividad, notificaciones y ética de datos que exige el curso de Aplicaciones para Dispositivos Móviles.

### 2.3.1. User Personas

Para desarrollar la propuesta de solución móvil se elabora un *User Persona* por cada segmento objetivo. Cada persona sintetiza motivaciones, frustraciones, hábitos digitales y contexto de uso del smartphone, de forma que el equipo de TuxLogic diseñe flujos nativos/cross-platform alineados a comportamientos reales y no a supuestos genéricos.

**Segmento Objetivo 1: Dueños o administradores de talleres automotrices independientes en Lima**

**Figura 8**  
*User persona — Felipe Hernández (dueño / administrador de taller)*

![](assets/user-persona-taller.png)

| Campo | Detalle |
| :--- | :--- |
| **Nombre** | Felipe Hernández |
| **Tipo** | Dueño de taller pragmático y precavido (≈ 45% del mercado objetivo) |
| **Edad / Distrito** | 46 años · San Martín de Porres, Lima |
| **Estado civil** | Casado |
| **Ocupación** | Dueño y administrador de un taller multimarca independiente (12 años de operación) |
| **Volumen** | Atiende entre 15 y 25 vehículos por semana |
| **Objetivo principal** | Reducir tiempos muertos, fidelizar clientes y pasar de un modelo reactivo a uno preventivo sin perder el control diario del taller |
| **Frustraciones** | Clientes solo llegan con falla grave; demanda irregular; olvidos por notas manuales; temor a software complicado; tiempos muertos que afectan ingresos |
| **Habilidades** | Alta en diagnóstico mecánico y atención al cliente; media en organización de citas; baja en software de gestión |
| **Uso de tecnología** | Android + Windows; Chrome; WhatsApp, teléfono, laptop, Facebook |
| **Marcas de referencia** | Autel, Toyota, Launch, Hyundai, Bosch |
| **Quote** | *«¡Si me avisan antes de que el auto se quede parado, yo llamo al cliente y lleno mi agenda!»* |

**Segmento Objetivo 2: Conductores de vehículos de Lima**

**Figura 9**  
*User persona — Raúl Jiménez (conductor particular)*

![](assets/user-persona-conductor.png)

| Campo | Detalle |
| :--- | :--- |
| **Nombre** | Raúl Jiménez |
| **Tipo** | Conductor particular práctico y preventivo (≈ 35% del mercado objetivo) |
| **Edad / Distrito** | 35 años · Los Olivos, Lima |
| **Estado civil** | Casado |
| **Ocupación** | Analista de operaciones; usa el auto a diario (casa–trabajo) y fines de semana |
| **Objetivo principal** | Mantener el vehículo seguro y operativo, evitar averías inesperadas y entender urgencias sin jerga técnica |
| **Frustraciones** | No entiende términos del mecánico; duda de presupuestos; olvida mantenimientos; no sabe urgencia de luces del tablero; llamadas largas para coordinar |
| **Habilidades** | Alta en uso de apps móviles y manejo; baja–media en identificación de fallas y gestión de mantenimiento |
| **Uso de tecnología** | Smartphone Android; Chrome; WhatsApp, Plin, Yape, Waze, Google Maps |
| **Quote** | *«Si sé qué tiene el auto y qué tan urgente es, puedo solucionarlo antes de que se convierta en un problema mayor.»* |

---

### 2.3.2. User Task Matrix

Se presenta la *User Task Matrix* de los segmentos objetivo. Cada tarea se evalúa según **importancia** y **frecuencia** para priorizar qué flujos deben resolverse primero en las aplicaciones móviles de ShiftIq (tablero del taller vs. app del conductor).

**Tabla 8**  
*User Task Matrix — ShiftIq*

<table>
  <thead>
    <tr>
      <th rowspan="2">Tareas (Task)</th>
      <th colspan="2">Felipe Hernández (Dueño / Admin. taller)</th>
      <th colspan="2">Raúl Jiménez (Conductor)</th>
    </tr>
    <tr>
      <th>Importancia</th>
      <th>Frecuencia</th>
      <th>Importancia</th>
      <th>Frecuencia</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Revisar estado general / salud del vehículo</td>
      <td>Alta</td>
      <td>Alta</td>
      <td>Alta</td>
      <td>Media</td>
    </tr>
    <tr>
      <td>Recibir y priorizar alertas DTC / telemetría en el móvil</td>
      <td>Alta</td>
      <td>Alta</td>
      <td>Alta</td>
      <td>Media</td>
    </tr>
    <tr>
      <td>Buscar o seleccionar taller de confianza</td>
      <td>N/A</td>
      <td>N/A</td>
      <td>Alta</td>
      <td>Media</td>
    </tr>
    <tr>
      <td>Agendar cita de mantenimiento desde el smartphone</td>
      <td>Alta</td>
      <td>Alta</td>
      <td>Alta</td>
      <td>Media</td>
    </tr>
    <tr>
      <td>Evitar averías inesperadas durante traslados</td>
      <td>Media</td>
      <td>Baja</td>
      <td>Alta</td>
      <td>Media</td>
    </tr>
    <tr>
      <td>Interpretar información técnica automotriz (sin jerga)</td>
      <td>Alta</td>
      <td>Media</td>
      <td>Alta</td>
      <td>Baja*</td>
    </tr>
    <tr>
      <td>Gestionar órdenes de trabajo y agenda del taller</td>
      <td>Alta</td>
      <td>Alta</td>
      <td>N/A</td>
      <td>N/A</td>
    </tr>
    <tr>
      <td>Comunicación taller–cliente (estado, presupuesto, entrega)</td>
      <td>Alta</td>
      <td>Alta</td>
      <td>Alta</td>
      <td>Alta</td>
    </tr>
    <tr>
      <td>Compra / control de repuestos e insumos</td>
      <td>Alta</td>
      <td>Media</td>
      <td>N/A</td>
      <td>N/A</td>
    </tr>
    <tr>
      <td>Seguimiento de historial de servicios del vehículo</td>
      <td>Alta</td>
      <td>Media</td>
      <td>Alta</td>
      <td>Baja</td>
    </tr>
    <tr>
      <td>Limpieza y mantenimiento básico del vehículo</td>
      <td>Media</td>
      <td>Media</td>
      <td>Media</td>
      <td>Alta</td>
    </tr>
    <tr>
      <td>Evaluar costos de combustible / operación del auto</td>
      <td>Baja</td>
      <td>Baja</td>
      <td>Alta</td>
      <td>Media</td>
    </tr>
  </tbody>
</table>

\*Hoy la frecuencia es baja porque el conductor evita o no entiende la información técnica; la app debe **elevar la frecuencia útil** al traducir DTC a lenguaje natural.

**Implicancia para el diseño móvil:** las tareas de alta importancia + alta frecuencia (alertas DTC, agenda, comunicación y órdenes) definen el MVP de las apps de ShiftIq y justifican una estrategia **multiplataforma (p. ej. Flutter)** o nativa, con notificaciones push, Material Design 3 / Human Interface Guidelines y persistencia local ante cortes de red.

---

### 2.3.3. User Journey Mapping

El *User Journey Mapping* visualiza el recorrido del usuario para alcanzar un objetivo, incluyendo acciones, touchpoints (sobre todo **móviles**), emociones y puntos de dolor. Sirve para detectar dónde ShiftIq debe intervenir con la app.

**Segmento Objetivo 1: Dueños o administradores de talleres**

**Objetivo del journey:** llenar la agenda con servicios preventivos y reducir la demanda solo-reactiva.

**Figura 10**  
*User journey mapping — Felipe Hernández (taller)*

![](assets/user-journey-taller.png)

| Etapa | Acciones actuales | Emoción | Pain points | Oportunidad ShiftIq (móvil) |
| :--- | :--- | :--- | :--- | :--- |
| 1. AWARE — Operación diaria | Gestiona espacio y demanda de forma reactiva | Rutina / aburrimiento | Tiempos muertos e ineficiencia | Tablero móvil de citas + alertas para aplanar picos |
| 2. JOIN — Llegada del cliente | Atiende walk-ins sin cita; recepción improvisada | Estrés / caos | Cotizaciones apresuradas y errores | Recepción digital: síntomas, fotos y presupuesto inicial |
| 3. USE — Diagnóstico y reparación | Inspección empírica; poco historial digital | Anticipación | Falta historial centralizado del vehículo | Historial + telemetría/DTC en la app |
| 4. DEVELOP — Entrega | Explica de palabra; cliente duda del trabajo | Aceptación | Desconfianza sobre lo reparado | Informe digital con evidencias y estimación |
| 5. POST-SERVICE | Espera que el cliente vuelva solo | Decepción | Baja lealtad; imagen de “taller de paso” | Alertas preventivas cada 30 días + métricas de recurrencia |

**Segmento Objetivo 2: Conductores de vehículos**

**Objetivo del journey:** prevenir una avería grave y agendar mantenimiento con confianza.

**Figura 11**  
*User journey mapping — Raúl Jiménez (conductor)*

![](assets/user-journey-conductor.png)

| Etapa | Acciones actuales | Emoción | Pain points | Oportunidad ShiftIq (móvil) |
| :--- | :--- | :--- | :--- | :--- |
| 1. AWARE — Uso diario | Conduce; usa navegación; recibe recordatorios | Estable / positivo | No monitorea salud del auto | Notificaciones proactivas de estado |
| 2. JOIN — Señal de problema | Luz en tablero, ruido, pérdida de potencia | Ansiedad (punto más bajo) | No sabe la gravedad; interrumpe el viaje | Diagnóstico preliminar in-app + significado claro de alertas |
| 3. USE — Búsqueda de ayuda | Abre ShiftIq; compara talleres, ratings y costos | Confusión | Miedo a estafas; talleres poco confiables | Filtro de talleres certificados + transparencia de precio/tiempo |
| 4. DEVELOP — Contacto y cita | Elige taller, fecha y confirma | Mejora | Esperas telefónicas; confirmación lenta | Reserva en tiempo real + recordatorios |
| 5. LEAVE — Servicio en taller | Deja el auto; aprueba extras | Alivio | Falta de avances; costos sorpresa | Tracking del servicio + aprobación digital de presupuestos |
| 6. STAGE — Post-servicio | Recoge, paga y califica | Satisfacción | Pagos lentos; boletas poco claras | Pago in-app, comprobante digital y fidelización |

---

### 2.3.4. Empathy Mapping

El *Empathy Mapping* profundiza en lo que cada persona **dice, piensa, hace y siente**, además de sus dolores (*pains*) y ganancias deseadas (*gains*). Orienta decisiones de UX móvil, tono de las notificaciones y ética de comunicación (transparencia, sin alarmismo engañoso).

**Segmento Objetivo 1: Dueño / administrador de taller**

**Figura 12**  
*Empathy Mapping — Felipe Hernández*

![](assets/empathy-map-taller.png)

| Cuadrante | Insights |
| :--- | :--- |
| **Quién** | Dueño de taller multimarca en SMP; pragmático, hábil en diagnóstico (Autel, Launch, Bosch), pero administra con cuaderno y WhatsApp |
| **Necesita hacer** | Pasar de reactivo a preventivo; centralizar citas, historial y diagnósticos; anticipar fallas para reducir tiempos muertos |
| **Ve** | Autos que solo llegan en emergencia; métodos rústicos; presión competitiva en Lima Norte |
| **Dice** | «Si me avisan antes de que el auto se quede parado, lleno mi agenda»; «WhatsApp se me desordena»; «El escáner solo sirve cuando el auto ya está aquí»; «Quiero modernizarme, pero temo una app complicada» |
| **Oye** | Quejas por “sorpresas” de precio; colegas que pierden dinero por mala coordinación; presión a digitalizarse |
| **Piensa / siente** | Quiere reducir tiempos muertos; prudencia ante software complejo; orgullo técnico; estrés por ingresos irregulares |
| **Pains** | Demanda irregular; dependencia de papel/WhatsApp; olvido de mantenimientos; miedo a invertir mal en tech |
| **Gains** | Agenda constante; alertas tempranas; fidelización; plataforma intuitiva centralizada; más ingresos planificados |

**Segmento Objetivo 2: Conductor**

**Figura 13**  
*Empathy Mapping — Raúl Jiménez*

![](assets/empathy-map-conductor.png)

| Cuadrante | Insights |
| :--- | :--- |
| **Quién** | Analista de operaciones en Los Olivos; usa Waze, WhatsApp, Yape y Plin; busca evitar gastos innecesarios |
| **Necesita hacer** | Monitorear el auto, entender alertas del tablero, saber urgencia real y agendar sin llamadas largas |
| **Ve** | Luces de advertencia inesperadas; mercado fragmentado de talleres; riesgo de quedarse en vía en Lima Norte |
| **Dice** | «Si sé qué tiene y qué tan urgente es, lo soluciono a tiempo»; «No entiendo la jerga del mecánico»; «Quiero saber si la reparación es necesaria»; «Prefiero coordinar y pagar por el celular» |
| **Oye** | Historias de cobros excesivos; consejos familiares de preventivo; recomendaciones de apps digitales |
| **Piensa / siente** | Ansiedad ante luces del tablero; desconfianza por falta de transparencia; alivio cuando tiene info clara en el móvil |
| **Pains** | Jerga técnica; duda de necesidad de reparaciones; costos ocultos; olvido de km; no conoce urgencia exacta |
| **Gains** | Auto seguro; menos emergencias; recordatorios por kilometraje; info no técnica; confianza en presupuestos |

**Consideración ética (curso):** las alertas móviles deben informar con precisión, evitar presión comercial engañosa, respetar privacidad de telemetría/ubicación y exponer términos claros de uso y tratamiento de datos en la app.

---

### 2.3.5. Big Picture EventStorming

El *Big Picture EventStorming* es una técnica colaborativa que ordena en una línea de tiempo los **eventos de dominio** (hechos en pasado) del negocio automotriz digitalizado por ShiftIq. Permite ver el flujo completo —desde la telemetría hasta la orden de trabajo— e identificar *hotspots* (fricciones, dudas o riesgos) antes de especificar requerimientos móviles.

**Figura 14**  
*Big Picture EventStorming — Segmento Objetivo 1 (flujo de servicio: presupuesto, pago, navegación y calificación)*

![](assets/big-picture-eventstorming-1.jpg)

**Figura 15**  
*Big Picture EventStorming — Segmento Objetivo 2 (flujo núcleo: vinculación OBD2, telemetría, diagnóstico, cita y gestión del taller)*

![](assets/big-picture-eventstorming-2.jpg)

#### Flujo macro de eventos de dominio (síntesis)

**Tablero 1 — servicio y cierre (Figura 14)**

1. **PresupuestoRecibido** — el conductor revisa en la app el desglose de costos sin jerga técnica.
2. **PagoProcesado** — aprueba el presupuesto y paga o adelanta vía pasarela (Yape, Plin o bancos).
3. **RutaAlTallerIniciada** — inicia navegación optimizada con Google Maps / Waze.
4. **ServicioFinalizadoYCalificado** — recoge el vehículo, califica el servicio y consulta historial/comprobante digital.

**Tablero 2 — monitoreo y operación (Figura 15)**

5. **VehiculoVinculado** — el conductor empareja el dongle OBD2 con la app móvil.
6. **TelemetriaRecibida** — el dispositivo envía velocidad, RPM, temperatura y códigos de error.
7. **CodigoDTCDetectado** / **SeveridadEvaluada** — diagnóstico automático; si es crítico, push inmediato.
8. **CitaReservada** — el conductor agenda mantenimiento en el calendario de bahías.
9. **AgendaGestionada** — el dueño/administrador del taller asigna bahías y registra el servicio.
10. **HistorialClinicoActualizado** — queda el historial de reparaciones, repuestos y mantenimientos.

#### Hotspots identificados

* Consumo excesivo de datos móviles al mantener telemetría continua.
* Conectividad inestable en zonas de Lima → necesidad de **cola offline** y sync diferido.
* Resistencia al cambio frente a sistemas de gestión complejos en el taller.
* Duda del conductor si no entiende ítems del presupuesto digital.
* Retrasos o inasistencia a la cita programada.
* Regla de aplanamiento de demanda: incentivos cuando el taller tiene baja ocupación.

---

### 2.3.6. Ubiquitous Language

Se define el glosario de términos del dominio ShiftIq / TuxLogic. Este *Ubiquitous Language* evita ambigüedades entre negocio, UX móvil y desarrollo (nativo o Flutter), y debe usarse de forma consistente en código, pantallas, historias de usuario y documentación.

**Tabla 9**  
*Ubiquitous Language — ecosistema ShiftIq*

| Término (EN) | Equivalente (ES) | Definición | Segmentos / contexto |
| :--- | :--- | :--- | :--- |
| **Workshop Owner** | Dueño del taller | Responsable de decisiones administrativas y operativas del taller independiente. | Taller |
| **Workshop Admin** | Administrador de taller | Usuario que gestiona agenda, órdenes y alertas desde la app/web del taller. | Taller |
| **Mechanic** | Mecánico | Técnico que ejecuta el servicio físico sobre el vehículo. | Taller / Operaciones |
| **Driver** | Conductor | Propietario o usuario habitual del vehículo que recibe alertas y agenda citas en la app móvil. | Conductor |
| **OBD2 Dongle / Scanner** | Dispositivo / escáner OBD2 | Hardware IoT conectado al puerto de diagnóstico del vehículo para capturar telemetría. | Telemetría |
| **Telemetry** | Telemetría | Datos técnicos transmitidos desde el vehículo (sensores, estado, códigos). | App móvil / Backend |
| **DTC** | Código de falla (DTC) | Código alfanumérico estandarizado que identifica una falla detectada por la ECU. | Diagnóstico |
| **Preventive Alert** | Alerta preventiva | Notificación push proactiva basada en telemetría/DTC, expresada en lenguaje natural. | Conductor / Taller |
| **Severity Level** | Nivel de severidad | Clasificación Bajo / Medio / Crítico asociada a una alerta. | UX móvil |
| **Work Order** | Orden de trabajo | Registro digital del servicio: hallazgos, repuestos, estado y responsables. | Taller |
| **Appointment** | Cita / agendamiento | Reserva de franja horaria para mantenimiento o reparación, creada desde la app. | Ambos |
| **Vehicle Health** | Salud del vehículo | Representación simplificada del estado general mostrada al conductor en la app. | Conductor |
| **Predictive Maintenance** | Mantenimiento predictivo | Intervención anticipada basada en datos antes de una avería crítica. | Dominio |
| **Service History** | Historial de servicio | Línea de tiempo de intervenciones y lecturas asociadas a un vehículo. | Ambos |
| **Offline Sync** | Sincronización offline | Persistencia local en el dispositivo móvil y envío diferido al restablecer conectividad. | App móvil |
| **Consent / Privacy** | Consentimiento / privacidad | Autorización explícita del usuario para recolectar y tratar telemetría y datos personales. | Ética / Términos |

Este lenguaje ubicuo alimenta las siguientes etapas del informe (especificación de requerimientos, DDD estratégico/táctico y diseño de la experiencia móvil), asegurando que taller y conductor hablen el mismo vocabulario que el equipo de ingeniería de TuxLogic.
