## 2.2. Entrevistas

### 2.2.1. Diseño de entrevistas

El diseño metodológico de las entrevistas semiestructuradas desarrolladas por TuxLogic responde a la necesidad de investigar a profundidad las dinámicas operativas, hábitos, fricciones y expectativas de los dos actores clave del modelo de mercado bilateral (*two-sided market*) de **ShiftIQ**: el segmento oferente (Dueños o Administradores de Talleres Automotrices Independientes en Lima) y el segmento demandante (Conductores de Vehículos Particulares en Lima Metropolitana).

Para garantizar la rigurosidad científica y la validez empírica del estudio cualitativo, el guion de entrevista se formuló aplicando las siguientes buenas prácticas metodológicas:
* **Preguntas Abiertas y No Inducidas:** Se diseñaron interrogantes orientadas a la exploración narrativa (*"¿Cómo maneja actualmente...?"*, *"Describa la última vez que..."*), evitando sesgar las respuestas del entrevistado o forzar la validación prematura de la propuesta de valor.
* **Enfoque en Comportamientos Pasados y Presentes Reales (*The Mom Test*):** Se priorizó indagar sobre acciones, decisiones y costos reales experimentados en los últimos 6 a 12 meses, restringiendo las especulaciones futuras u opiniones hipotéticas sobre funcionalidades no construidas.
* **Secuencia Gradual de Entrevista:** El flujo conversacional se estructuró en cuatro fases sucesivas: (*Rapport* y datos demográficos, Hábitos y rutina diaria, Dolores, frustraciones y barreras, Disposición al cambio y evaluación de canales digitales/IoT).
* **Trazabilidad para la Construcción de Arquetipos (*User Personas*):** Cada bloque de preguntas está directamente calibrado para recolectar las dimensiones de información requeridas para los artefactos de Needfinding: variables demográficas (género, edad, distrito, estado civil, familia, ocupación), aspectos psicográficos (personalidad, metas, frustraciones), capacidades tecnológicas (habilidades digitales, dispositivos preferidos, aplicaciones en uso), influencias y afinidad de marcas (marcas de escáneres, vehículos, apps de banca o navegación) y biografía operativa.

---

#### a. Matriz de Información Requerida para Arquetipos de Usuarios

La siguiente matriz delimita el propósito de indagación de cada variable requerida para modelar los arquetipos de usuario de ShiftIQ (*Felipe Hernández* para el Taller y *Raúl Jiménez* para el Conductor):

| Dimensión del Arquetipo | Componentes Específicos a Recolectar | Propósito de Indagación en la Entrevista |
| :--- | :--- | :--- |
| **Datos Demográficos y Biografía** | Edad, género, distrito de residencia, estado civil, carga familiar, ocupación actual y años de experiencia en el rubro/manejo. | Delimitar el perfil sociocultural, nivel socioeconómico y contexto de vida cotidiana que enmarca las decisiones financieras y de gestión. |
| **Personalidad y Actitudes** | Tendencia pragmática, adversión al riesgo, apertura a la innovación, nivel de cautela en el gasto, nivel de desconfianza comercial. | Comprender la postura mental frente al cambio digital en la administración del taller o ante los diagnósticos mecánicos tradicionales. |
| **Habilidades y Competencias** | Habilidad en diagnóstico mecánico/empírico, nivel de alfabetización digital, experiencia en uso de smartphones y computadoras. | Diseñar interfaces de usuario (móvil y web) con la densidad de información y nivel de complejidad adecuados a su competencia real. |
| **Dispositivos y Canales Digitales** | Tipo de smartphone (Android/iOS), laptop/PC, aplicaciones de uso diario (WhatsApp, Chrome, Yape, Plin, Waze, Google Maps). | Identificar los ecosistemas de hardware y software donde el usuario pasa su tiempo para integrar notificaciones push y flujos de interacción naturales. |
| **Afinidad por Marcas e Influencias** | Marcas de vehículos (Toyota, Hyundai, Nissan), herramientas de diagnóstico (Autel, Launch, Bosch), marcas de repuestos y referencias de confianza. | Establecer el lenguaje visual, las alianzas de hardware (conectores OBD2 compatibles) y el posicionamiento de marca de ShiftIQ. |
| **Objetivos y Motivaciones** | Llenar agenda diaria, reducir tiempos muertos, prevenir averías críticas en ruta, transparencia presupuestal, mantener valor de reventa. | Diseñar las funcionalidades principales (*core features*) que entregan valor directo percibido en los primeros 14 a 30 días. |
| **Frustraciones y Dolores (*Pains*)** | Pérdidas del 30-40% por ineficiencia, cobros excesivos por sorpresa, desconfianza en la jerga técnica, desorden en WhatsApp y papel. | Justificar los requerimientos funcionales del MVP (alertas DTC en lenguaje natural, agendamiento in-app, orden de trabajo digital). |

---

#### b. Preguntas de Entrevistas dirigidas al Segmento Objetivo 1: Dueños o Administradores de Talleres Automotrices Independientes (B2B)

Este cuestionario busca comprender a fondo la dinámica administrativa y técnica de los microempresarios mecánicos, evaluando cómo gestionan sus clientes, citas, presupuestos e inventarios en su operación diaria en Lima.

##### Bloque 1: Perfil Demográfico, Biografía y Entorno Operativo (Arquetipo: Felipe Hernández)
* **Pregunta Principal 1.1:** Para comenzar, coméntenos sobre usted: ¿cuál es su edad, en qué distrito reside, su estado civil y qué rol desempeña actualmente en el taller?
  * *Pregunta Complementaria 1.1a:* ¿Cuántos años de experiencia tiene en el rubro automotriz y cómo se constituyó su taller?
  * *Pregunta Complementaria 1.1b:* ¿Cuántas personas integran su núcleo familiar y cómo equilibra el tiempo de trabajo en el taller con su vida personal?
* **Pregunta Principal 1.2:** Describa la estructura y capacidad operativa de su establecimiento.
  * *Pregunta Complementaria 1.2a:* ¿Con cuántos mecánicos o técnicos cuenta y cuántas bahías o rampas de atención tiene habilitadas?
  * *Pregunta Complementaria 1.2b:* En promedio, ¿cuántos vehículos atienden a la semana y cuáles son los servicios de mayor demanda?

##### Bloque 2: Procesos de Gestión, Dispositivos y Canales de Interacción
* **Pregunta Principal 2.1:** ¿Cómo organiza actualmente el flujo diario de trabajo, la asignación de citas y el seguimiento de los vehículos atendidos?
  * *Pregunta Complementaria 2.1a:* ¿Qué herramientas utiliza para registrar la información del cliente y la orden de servicio (cuaderno físico, hojas de cálculo, WhatsApp, software de gestión)?
  * *Pregunta Complementaria 2.1b:* ¿Qué dispositivos tecnológicos utiliza personalmente durante la jornada de trabajo (smartphone Android/iOS, tablet, laptop, PC de escritorio)?
* **Pregunta Principal 2.2:** ¿Qué canales de comunicación digital utiliza de forma habitual para interactuar con sus clientes y proveedores?
  * *Pregunta Complementaria 2.2a:* ¿Cómo gestiona la recepción de solicitudes por WhatsApp y qué problemas encuentra al coordinar por este medio?
  * *Pregunta Complementaria 2.2b:* ¿Qué aplicaciones móviles o páginas web utiliza con mayor frecuencia en su rutina diaria de negocio o personal?

##### Bloque 3: Frustraciones, Dolores Operativos y Relación con el Cliente (*Pains & Gains*)
* **Pregunta Principal 3.1:** ¿Cuáles son los principales obstáculos o ineficiencias que enfrenta en la gestión diaria que afectan la rentabilidad del taller?
  * *Pregunta Complementaria 3.1a:* ¿Ha experimentado periodos de tiempo muerto o baja ocupación de rampas durante el mes? ¿A qué cree que se deba y cómo lo soluciona?
  * *Pregunta Complementaria 3.1b:* ¿Cómo maneja el control de inventario de repuestos e insumos? ¿Ha tenido pérdidas por falta de stock o repuestos mal presupuestados?
* **Pregunta Principal 3.2:** En su experiencia, ¿por qué razón suelen regresar los clientes a su taller y cómo promueve que realicen mantenimientos preventivos regulares?
  * *Pregunta Complementaria 3.2a:* ¿Qué tan frecuente es que un cliente llegue únicamente cuando el vehículo ya presenta una avería grave o inmovilizante?
  * *Pregunta Complementaria 3.2b:* ¿Cómo reaccionan los clientes ante la presentación de presupuestos adicionales o reparaciones no planificadas?

##### Bloque 4: Afinidad por Marcas, Equipamiento Técnico y Evaluación de la Solución ShiftIQ
* **Pregunta Principal 4.1:** Al realizar diagnósticos en los vehículos, ¿qué marcas de escáneres automotrices o herramientas electrónicas prefiere o utiliza (Autel, Launch, Bosch, otros)?
  * *Pregunta Complementaria 4.1a:* ¿En qué etapa de la atención utiliza el escáner y qué limitaciones encuentra en los equipos diagnósticos actuales?
  * *Pregunta Complementaria 4.1b:* ¿Qué marcas de vehículos (Toyota, Hyundai, Nissan, Kia, etc.) atienden con mayor frecuencia y qué tan complejo es acceder a su información de fallas?
* **Pregunta Principal 4.2:** Si dispusiera de una plataforma móvil conectada a dispositivos telemáticos OBD2 que le enviara alertas de fallas electrónicas (DTC) de sus clientes antes de que lleguen al taller, ¿cómo transformaría eso su manera de agendar y ofrecer servicios?
  * *Pregunta Complementaria 4.2a:* ¿Qué tan dispuesto estaría a adoptar una aplicación móvil para enviar cotizaciones digitales y confirmar citas en tiempo real?
  * *Pregunta Complementaria 4.2b:* ¿Qué condiciones o facilidades requeriría para confiar e integrar una solución SaaS como ShiftIQ en su taller?

---

#### c. Preguntas de Entrevistas dirigidas al Segmento Objetivo 2: Conductores de Vehículos Particulares en Lima (B2C)

Este cuestionario busca explorar las conductas de mantenimiento, las barreras cognitivas/financieras, la asimetría informativa y la competencia digital de los propietarios de vehículos particulares en Lima Metropolitana.

##### Bloque 1: Perfil Demográfico, Biografía y Hábitos de Conducción (Arquetipo: Raúl Jiménez)
* **Pregunta Principal 1.1:** Para comenzar, coméntenos sobre usted: ¿cuál es su edad, en qué distrito reside, su estado civil y a qué se dedica profesionalmente?
  * *Pregunta Complementaria 1.1a:* ¿Cuántas personas dependen de usted o forman parte de su hogar y qué papel cumple el vehículo en su dinámica familiar?
  * *Pregunta Complementaria 1.1b:* ¿Qué modelo, marca y año de fabricación tiene su vehículo particular, y cuál es el uso principal que le da (traslado laboral, viajes de fin de semana, aplicativo)?
* **Pregunta Principal 1.2:** ¿Cómo describiría su rutina de conducción semanal y cuántos kilómetros recorre aproximadamente al día en Lima?

##### Bloque 2: Experiencia y Hábitos de Mantenimiento Vehicular
* **Pregunta Principal 2.1:** ¿Cómo maneja actualmente el cuidado y mantenimiento de su vehículo? ¿Sigue un plan preventivo o acude al taller cuando nota un problema específico?
  * *Pregunta Complementaria 2.1a:* Describa la última vez que su vehículo presentó una falla mecánica o una luz encendida en el tablero. ¿Cómo reaccionó y qué pasos siguió?
  * *Pregunta Complementaria 2.1b:* ¿Con qué frecuencia realiza cambios de aceite, revisión de frenos o alineación, y cómo recuerda las fechas o kilometrajes correspondientes?
* **Pregunta Principal 2.2:** ¿Qué factores o motivos le han llevado en alguna ocasión a postergar o posponer la revisión mecánica de su automóvil?
  * *Pregunta Complementaria 2.2a:* ¿Ha influido la falta de tiempo, la incertidumbre económica o la falta de claridad en los costos para postergar una atención técnica?

##### Bloque 3: Relación con el Taller, Asimetría Informativa y Frustraciones (*Pains & Gains*)
* **Pregunta Principal 3.1:** ¿Cómo elige el taller mecánico al que lleva su automóvil y qué tan transparente considera la información técnica y los presupuestos que recibe?
  * *Pregunta Complementaria 3.1a:* ¿Ha experimentado dificultades para comprender la terminología técnica o los códigos de falla expuestos por el mecánico? ¿Cómo le hizo sentir esa situación?
  * *Pregunta Complementaria 3.1b:* ¿Ha tenido experiencias donde el costo final del servicio superó de forma imprevista la cotización inicial?
* **Pregunta Principal 3.2:** ¿Qué es lo que más valora al momento de solicitar un servicio técnico vehicular y qué le haría sentir total confianza en un taller independiente?

##### Bloque 4: Canales Digitales, Dispositivos Preferidos, Afinidad por Apps y Aceptación de Telemetría IoT
* **Pregunta Principal 4.1:** ¿Qué modelo de teléfono smartphone utiliza (Android/iOS) y qué aplicaciones móviles utiliza con mayor frecuencia en su vida diaria?
  * *Pregunta Complementaria 4.1a:* ¿Utiliza habitualmente aplicaciones de navegación GPS (Waze, Google Maps), mensajería (WhatsApp) o banca/billeteras digitales (Yape, Plin)?
  * *Pregunta Complementaria 4.1b:* ¿Qué tan cómodo se siente recibiendo notificaciones push relativas al estado de sus servicios o pagos en su smartphone?
* **Pregunta Principal 4.2:** Si contara con un pequeño dispositivo de diagnóstico (OBD2) conectado a su auto que se comunique con su smartphone para explicarle en español sencillo el nivel de urgencia de una falla y le permita agendar cita en un clic, ¿qué opinión le merecería?
  * *Pregunta Complementaria 4.2a:* ¿Estaría dispuesto a mantener este dispositivo conectado continuamente a cambio de recibir alertas de seguridad y estimados de costo preventivos?
  * *Pregunta Complementaria 4.2b:* ¿Qué garantías de privacidad y transparencia en el uso de los datos de su vehículo consideraría indispensables para adoptar la aplicación ShiftIQ?


---

### 2.2.2. Registro de entrevistas

**Segmento objetivo 1:**

<table>
<thead>
  <tr>
    <th colspan="2">Entrevista #1<br></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Nombre</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Apellidos</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Edad</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Distrito</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Aplicaciones Usadas</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Tecnologías</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Browsers</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Entrevistador</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Evidencia</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Link</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Duración<br></td>
    <td>...</td>
  </tr>
  <tr>
    <td>Resumen</td>
    <td>...</td>
  </tr>
</tbody>
</table>

<table>
<thead>
  <tr>
    <th colspan="2">Entrevista #2<br></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Nombre</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Apellidos</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Edad</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Distrito</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Aplicaciones Usadas</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Tecnologías</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Browsers</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Entrevistador</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Evidencia</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Link</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Duración<br></td>
    <td>...</td>
  </tr>
  <tr>
    <td>Resumen</td>
    <td>...</td>
  </tr>
</tbody>
</table>

<table>
<thead>
  <tr>
    <th colspan="2">Entrevista #3<br></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Nombre</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Apellidos</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Edad</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Distrito</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Aplicaciones Usadas</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Tecnologías</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Browsers</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Entrevistador</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Evidencia</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Link</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Duración<br></td>
    <td>...</td>
  </tr>
  <tr>
    <td>Resumen</td>
    <td>...</td>
  </tr>
</tbody>
</table>

**Segmento objetivo 2:**

<table>
<thead>
  <tr>
    <th colspan="2">Entrevista #1<br></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Nombre</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Apellidos</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Edad</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Distrito</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Aplicaciones Usadas</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Tecnologías</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Browsers</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Entrevistador</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Evidencia</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Link</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Duración<br></td>
    <td>...</td>
  </tr>
  <tr>
    <td>Resumen</td>
    <td>...</td>
  </tr>
</tbody>
</table>

<table>
<thead>
  <tr>
    <th colspan="2">Entrevista #2<br></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Nombre</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Apellidos</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Edad</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Distrito</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Aplicaciones Usadas</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Tecnologías</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Browsers</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Entrevistador</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Evidencia</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Link</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Duración<br></td>
    <td>...</td>
  </tr>
  <tr>
    <td>Resumen</td>
    <td>...</td>
  </tr>
</tbody>
</table>

<table>
<thead>
  <tr>
    <th colspan="2">Entrevista #3<br></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Nombre</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Apellidos</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Edad</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Distrito</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Aplicaciones Usadas</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Tecnologías</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Browsers</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Entrevistador</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Evidencia</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Link</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Duración<br></td>
    <td>...</td>
  </tr>
  <tr>
    <td>Resumen</td>
    <td>...</td>
  </tr>
</tbody>
</table>

### 2.2.3. Análisis de entrevistas
