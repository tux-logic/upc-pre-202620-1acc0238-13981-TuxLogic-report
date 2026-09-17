```{=typst}
== 2.5. Strategic-Level Domain-Driven Design

=== 2.5.1. EventStorming

Para el diseño estratégico de ShiftIq se empleó *EventStorming* como técnica para explorar y estructurar el dominio del sistema a partir de los acontecimientos relevantes del negocio. Esta actividad permitió pasar de una visión general del dominio hacia una identificación progresiva de eventos, causas, procesos y límites de responsabilidad.

El proceso se desarrolló tomando como punto de partida el *Big Picture EventStorming* realizado anteriormente en la etapa de Needfinding. En dicho análisis ya se habían identificado acontecimientos relacionados con la vinculación del vehículo, recepción de telemetría, detección de códigos DTC, evaluación de severidad, reserva de citas, gestión del taller y actualización del historial de servicio.

Para profundizar este análisis en el nivel estratégico de DDD, el EventStorming se organizó en tres actividades: *Collect Domain Events*, *Refine Domain* y *Track Causes (Process Modelling)*. Los resultados de estas actividades fueron utilizados posteriormente para identificar los *Candidate Bounded Contexts*, establecer sus interacciones mediante *Domain Message Flows* y formalizar cada contexto mediante *Bounded Context Canvases*.

#v(0.5em)
==== Collect Domain Events

En la primera actividad se recopilaron los principales *Domain Events* asociados con las actividades del dominio automotriz de ShiftIq. El objetivo fue obtener una visión amplia de los hechos relevantes que ocurren durante los diferentes procesos del sistema, sin establecer inicialmente límites entre contextos.

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter2/strategic-level-DDD/event-storming/event_storming_s1.jpg", width: 95%),
    caption: [Collect Domain Events -- Identificación de eventos de dominio de ShiftIq.]
  )
]
#v(0.5em)

La actividad permitió reunir acontecimientos relacionados con identidad, gestión del taller, vehículos, telemetría, diagnóstico, citas, órdenes de trabajo, inventario, cotizaciones y pagos. Esta recopilación constituye la materia prima para el posterior refinamiento del dominio.

#v(0.5em)
==== Refine Domain

A continuación, los eventos recopilados fueron revisados y refinados para distinguir los acontecimientos relevantes del negocio de acciones, datos o elementos que no representan hechos de dominio. También se consolidaron eventos relacionados y se estableció una nomenclatura orientada al lenguaje del dominio.

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter2/strategic-level-DDD/event-storming/event_storming_s2.jpg", width: 95%),
    caption: [Refine Domain -- Refinamiento y organización de los eventos del dominio.]
  )
]
#v(0.5em)

El refinamiento permitió obtener un conjunto de eventos más consistente y representativo de los procesos principales de ShiftIq. Esta etapa es importante porque proporciona una base común para posteriormente identificar agrupaciones de responsabilidades.

#v(0.5em)
==== Track Causes (Process Modelling)

Finalmente, se realizó el seguimiento de las causas y consecuencias de los eventos mediante *Process Modelling*. En esta actividad se relacionaron los elementos del EventStorming, principalmente *Actor, Command, Event, Business Process/Policy, Aggregate, External System y Hotspot*.

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter2/strategic-level-DDD/event-storming/event_storming_s3.jpg", width: 95%),
    caption: [Track Causes (Process Modelling) -- Relación causal de comandos, eventos y procesos.]
  )
]
#v(0.5em)

El modelado permitió comprender cómo una acción ejecutada por un actor genera un comando que modifica el estado de un agregado y produce un evento. Asimismo, permitió identificar interacciones con sistemas externos y puntos de incertidumbre o riesgo (*hotspots*).

Entre los principales problemas identificados previamente se encuentran la conectividad inestable, el consumo de datos de telemetría, los retrasos o inasistencias a las citas, la incertidumbre respecto a los presupuestos y la necesidad de simplificar la gestión del taller.

El resultado de estas tres actividades constituyó la base para la siguiente etapa: *Candidate Context Discovery*.

#v(0.5em)
==== 2.5.1.1. Candidate Context Discovery

El *Candidate Context Discovery* tuvo como objetivo identificar agrupaciones coherentes de responsabilidades dentro del dominio. Para ello se analizaron conjuntamente los eventos refinados, comandos, actores, agregados, modelos de lectura, políticas y relaciones identificadas durante el EventStorming.

Es importante señalar que los *Bounded Contexts candidatos no fueron definidos únicamente a partir de los nombres de los paquetes del backend*. Primero se identificaron las agrupaciones funcionales que emergieron del comportamiento del dominio y posteriormente se contrastaron con la estructura existente del sistema.

Como resultado se reconocieron *siete Candidate Bounded Contexts*:

1. *Identity & Access*
2. *Workshop Management*
3. *Fleet & Appointments*
4. *Vehicle Intelligence & Diagnostics*
5. *Service Operations*
6. *Inventory Management*
7. *Billing & Payments*

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter2/strategic-level-DDD/event-storming/candidate-context-discovery.jpg", width: 95%),
    caption: [Candidate Context Discovery -- Reconocimiento de los Candidate Bounded Contexts de ShiftIq.]
  )
]
#v(0.5em)

A continuación, se describe la responsabilidad de cada contexto identificado.

#v(0.3em)
===== 1. Identity & Access

Este contexto concentra las responsabilidades relacionadas con la identidad y el acceso de los usuarios. Incluye procesos de registro, autenticación, recuperación de contraseña y actualización de credenciales.

Su correspondencia con el backend se evidencia en el módulo `iam`, donde se encuentra el agregado `User`, comandos como `SignUpCommand`, `SignInCommand`, `ResetPasswordCommand` y comandos para actualizar las credenciales. También existen servicios relacionados con correo, hashing y tokens.

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter2/strategic-level-DDD/event-storming/candidate-context-identity-access.png", width: 90%),
    caption: [Candidate Bounded Context -- Identity & Access.]
  )
]
#v(0.5em)

===== 2. Workshop Management

Este contexto gestiona la información organizacional del taller, incluyendo talleres, sucursales, propietarios, clientes y empleados.

La correspondencia con el backend se encuentra en el módulo `core`, donde existen eventos como `WorkshopCreatedEvent`, `BranchCreatedEvent`, `CustomerCreatedEvent`, `EmployeeCreatedEvent` y `OwnerCreatedEvent`, además de sus respectivas consultas.

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter2/strategic-level-DDD/event-storming/candidate-context-workshop-management.png", width: 90%),
    caption: [Candidate Bounded Context -- Workshop Management.]
  )
]
#v(0.5em)

===== 3. Fleet & Appointments

Este contexto concentra la gestión de citas y registros asociados a clientes y empleados, funcionando como punto de coordinación entre la planificación del servicio y las operaciones del taller.

El backend contiene `Appointment` y comandos relacionados con su creación, actualización y eliminación, además de `AppointmentCreatedEvent`. También dispone de recursos y servicios de consulta asociados.

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter2/strategic-level-DDD/event-storming/candidate-context-fleet-appointments.png", width: 90%),
    caption: [Candidate Bounded Context -- Fleet & Appointments.]
  )
]
#v(0.5em)

===== 4. Vehicle Intelligence & Diagnostics

Este contexto concentra las capacidades relacionadas con el vehículo, dispositivos OBD2, telemetría y diagnóstico. Su propósito dentro del dominio es transformar los datos técnicos del vehículo en información útil para el seguimiento de su condición.

Esta agrupación se relaciona con el flujo identificado previamente de vehículo vinculado, telemetría recibida, detección de DTC y evaluación de severidad.

Además, el lenguaje ubicuo del proyecto incorpora explícitamente términos como *Vehicle, OBD2 Dongle, Telemetry, DTC, Preventive Alert y Severity Level*.

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter2/strategic-level-DDD/event-storming/candidate-context-vehicle-intelligence-diagnostics.png", width: 90%),
    caption: [Candidate Bounded Context -- Vehicle Intelligence & Diagnostics.]
  )
]
#v(0.5em)

===== 5. Service Operations

Este contexto gestiona la ejecución de los servicios mediante órdenes de trabajo, tareas y asignación de mecánicos.

La estructura del backend contiene comandos para crear órdenes de trabajo, agregar tareas, asignar mecánicos, iniciar y completar tareas, así como eventos como `TaskStartedEvent`, `TaskCompletedEvent`, `TaskReopenedEvent` y `WorkOrderCompletedEvent`.

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter2/strategic-level-DDD/event-storming/candidate-context-service-operations.png", width: 90%),
    caption: [Candidate Bounded Context -- Service Operations.]
  )
]
#v(0.5em)

===== 6. Inventory Management

Este contexto administra los productos y existencias necesarias para la ejecución de los servicios. Incluye productos, lotes, reservas, liberaciones, movimientos de stock y evaluación de niveles mínimos.

La estructura contiene el agregado `Product`, la entidad `ProductBatch`, comandos de productos y eventos como `ProductCreatedEvent`, `StockReservedEvent`, `StockReleasedEvent`, `StockMovementAppliedEvent` y eventos relacionados con bajo stock.

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter2/strategic-level-DDD/event-storming/candidate-context-inventory-management.png", width: 90%),
    caption: [Candidate Bounded Context -- Inventory Management.]
  )
]
#v(0.5em)

===== 7. Billing & Payments

Este contexto concentra las responsabilidades relacionadas con cotizaciones, pagos y comprobantes asociados al servicio.

La estructura del backend contiene elementos de cotización y facturación, incluyendo `Quote`, `Voucher`, `Payment` y comandos relacionados con la creación y aprobación de cotizaciones, checkout y procesamiento de pagos.

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter2/strategic-level-DDD/event-storming/candidate-context-billing-payments.png", width: 90%),
    caption: [Candidate Bounded Context -- Billing & Payments.]
  )
]
#v(0.5em)

===== Resultado del Candidate Context Discovery

Como resultado, se obtuvieron *siete agrupaciones de responsabilidad*, que posteriormente fueron utilizadas para construir los flujos de interacción y los Bounded Context Canvases.

Por tanto, esta actividad establece *los límites candidatos del dominio*, pero no constituye todavía la definición definitiva de las relaciones entre ellos. Estas relaciones se desarrollan en el siguiente apartado mediante el *Domain Message Flows Modeling*.

#v(0.5em)
==== 2.5.1.2. Domain Message Flows Modeling

Una vez reconocidos los siete Candidate Bounded Contexts, se realizó el *Domain Message Flows Modeling* con el propósito de representar cómo estos contextos colaboran para ejecutar los principales procesos del dominio.

Los flujos se construyeron utilizando los elementos identificados durante el EventStorming, principalmente *Commands, Events, Actors, Aggregates, Read Models y External Systems*.

Se definieron seis flujos principales.

#v(0.3em)
===== Flow 1 -- Vehicle Intelligence & Diagnostics

Representa el proceso de registro y monitoreo del vehículo, incluyendo la vinculación del dispositivo OBD2, recepción de telemetría y generación de información de diagnóstico.

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter2/strategic-level-DDD/event-storming/Flow-1-Vehicle-Intelligence-&-Diagnostics.png", width: 95%),
    caption: [Domain Message Flow -- Vehicle Intelligence & Diagnostics.]
  )
]
#v(0.5em)

Este flujo representa una de las capacidades centrales de ShiftIq, ya que conecta la información obtenida del vehículo con el proceso de diagnóstico y seguimiento de su condición.

#v(0.3em)
===== Flow 2 -- Appointment & Service

Representa la transición desde la planificación de una atención hasta la recepción del vehículo para iniciar el servicio.

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter2/strategic-level-DDD/event-storming/Flow-2-Appointment-&-Service.png", width: 95%),
    caption: [Domain Message Flow -- Appointment & Service.]
  )
]
#v(0.5em)

Este flujo muestra principalmente la interacción entre *Fleet & Appointments* y *Service Operations*, evidenciando que la cita constituye un punto de conexión entre la planificación y la ejecución del servicio.

#v(0.3em)
===== Flow 3 -- Work Order & Inventory

Representa la ejecución de una orden de trabajo y la utilización de productos necesarios para realizar las tareas del servicio.

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter2/strategic-level-DDD/event-storming/Flow-3-Work-Order-&-Inventory.png", width: 95%),
    caption: [Domain Message Flow -- Work Order & Inventory.]
  )
]
#v(0.5em)

El flujo evidencia la colaboración entre *Service Operations* e *Inventory Management*, particularmente cuando una tarea requiere reservar o utilizar productos.

#v(0.3em)
===== Flow 4 -- Quotation & Payment

Representa el proceso que comienza con la elaboración de una cotización y continúa con su aprobación y procesamiento del pago.

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter2/strategic-level-DDD/event-storming/Flow-4-Quotation-&-Payment.png", width: 95%),
    caption: [Domain Message Flow -- Quotation & Payment.]
  )
]
#v(0.5em)

Este flujo permite representar la colaboración entre el proceso operativo del servicio y *Billing & Payments*, incluyendo la intervención de los mecanismos externos de pago cuando corresponde.

#v(0.3em)
===== Flow 5 -- Workshop Management

Representa las operaciones relacionadas con la configuración y administración de la información del taller, sus sucursales, clientes y empleados.

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter2/strategic-level-DDD/event-storming/Flow-5-Workshop-Management.png", width: 95%),
    caption: [Domain Message Flow -- Workshop Management.]
  )
]
#v(0.5em)

El flujo representa las principales operaciones administrativas que permiten mantener disponible la información necesaria para los demás procesos del sistema.

#v(0.3em)
===== Flow 6 -- Identity & Access

Representa el ciclo de acceso de los usuarios a la plataforma, desde el registro hasta la autenticación y gestión de sus credenciales.

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter2/strategic-level-DDD/event-storming/Flow-6-Identity-&-Access.png", width: 95%),
    caption: [Domain Message Flow -- Identity & Access.]
  )
]
#v(0.5em)

Este flujo delimita las responsabilidades de *Identity & Access* frente a los demás contextos que requieren información sobre el usuario autenticado.

#v(0.3em)
===== Resultado del Domain Message Flows Modeling

Los seis flujos permiten observar que los Candidate Bounded Contexts *colaboran mediante mensajes*, en lugar de funcionar como componentes completamente aislados.

De esta forma, los flujos muestran las principales interacciones del dominio y permiten comprobar que un mismo proceso de negocio puede atravesar más de un contexto. Por ejemplo, la ejecución de un servicio puede involucrar *Fleet & Appointments, Service Operations, Inventory Management y Billing & Payments*.

Los Domain Message Flows constituyen así el vínculo entre el descubrimiento de los contextos y su formalización mediante los Canvas.

#v(0.5em)
==== 2.5.1.3. Bounded Context Canvases

A partir de los siete Candidate Bounded Contexts identificados y de los seis Domain Message Flows modelados, se elaboraron los *Bounded Context Canvases*.

El Canvas permite describir cada contexto desde una perspectiva estratégica, especificando su propósito, clasificación estratégica, roles de dominio, comunicaciones de entrada y salida, lenguaje ubicuo, decisiones de negocio, supuestos, métricas de verificación y preguntas abiertas.

Los siete Canvas desarrollados son los siguientes:

#v(0.3em)
===== Canvas 1 -- Identity & Access

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter2/strategic-level-DDD/event-storming/bounded-context-canvas-identity-access.jpg", width: 95%),
    caption: [Bounded Context Canvas -- Identity & Access.]
  )
]
#v(0.5em)

El Canvas formaliza las responsabilidades del contexto relacionadas con usuarios, autenticación, recuperación de credenciales y acceso a la plataforma.

#v(0.3em)
===== Canvas 2 -- Workshop Management

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter2/strategic-level-DDD/event-storming/bounded-context-canvas-workshop-management.jpg", width: 95%),
    caption: [Bounded Context Canvas -- Workshop Management.]
  )
]
#v(0.5em)

El Canvas delimita las responsabilidades relacionadas con Workshop, Branch, Owner, Customer y Employee.

#v(0.3em)
===== Canvas 3 -- Fleet & Appointments

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter2/strategic-level-DDD/event-storming/bounded-context-canvas-fleet-appointments.jpg", width: 95%),
    caption: [Bounded Context Canvas -- Fleet & Appointments.]
  )
]
#v(0.5em)

El Canvas formaliza la responsabilidad de gestionar citas y los registros necesarios para coordinar la atención del vehículo.

#v(0.3em)
===== Canvas 4 -- Vehicle Intelligence & Diagnostics

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter2/strategic-level-DDD/event-storming/bounded-context-canvas-vehicle-intelligence-diagnostics.jpg", width: 95%),
    caption: [Bounded Context Canvas -- Vehicle Intelligence & Diagnostics.]
  )
]
#v(0.5em)

El Canvas formaliza las responsabilidades relacionadas con Vehicle, OBD2 Device, Telemetry, DTC y diagnóstico, elementos que forman parte del lenguaje ubicuo del proyecto.

#v(0.3em)
===== Canvas 5 -- Service Operations

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter2/strategic-level-DDD/event-storming/bounded-context-canvas-service-operations.jpg", width: 95%),
    caption: [Bounded Context Canvas -- Service Operations.]
  )
]
#v(0.5em)

El Canvas formaliza las responsabilidades relacionadas con Service, Work Order, Task y Mechanic, incluyendo las reglas asociadas con la ejecución del servicio.

#v(0.3em)
===== Canvas 6 -- Inventory Management

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter2/strategic-level-DDD/event-storming/bounded-context-canvas-inventory-management.jpg", width: 95%),
    caption: [Bounded Context Canvas -- Inventory Management.]
  )
]
#v(0.5em)

El Canvas formaliza las responsabilidades relacionadas con Product, Product Batch, Stock, Reservation y Low Stock.

#v(0.3em)
===== Canvas 7 -- Billing & Payments

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter2/strategic-level-DDD/event-storming/bounded-context-canvas-billing-payments.jpg", width: 95%),
    caption: [Bounded Context Canvas -- Billing & Payments.]
  )
]
#v(0.5em)

El Canvas formaliza las responsabilidades relacionadas con Quote, Payment, Checkout y Voucher, incluyendo las interacciones necesarias con servicios externos de pago y facturación.

#v(0.5em)
=== 2.5.2. Context Mapping

Una vez identificados los siete *Candidate Bounded Contexts* mediante EventStorming y formalizadas sus responsabilidades mediante los *Bounded Context Canvases*, se realizó el *Context Mapping* con el propósito de analizar las relaciones existentes entre dichos contextos.

El Context Mapping permite pasar de la identificación individual de los contextos a una visión de conjunto, determinando *quién consume información de quién, qué contexto proporciona determinados servicios o eventos y qué sistemas externos participan en cada interacción*.

Para ShiftIq, el análisis considera los siguientes siete contextos:

1. *Identity & Access*
2. *Workshop Management*
3. *Fleet & Appointments*
4. *Vehicle Intelligence & Diagnostics*
5. *Service Operations*
6. *Inventory Management*
7. *Billing & Payments*

La separación de estos contextos tiene correspondencia con la organización del backend, donde existen módulos independientes para `iam`, `core`, `fleet`, `iot`, `operations`, `inventory` y `billing`.

#v(0.5em)
==== Identificación de relaciones entre Bounded Contexts

El análisis de Context Mapping se realizó tomando como referencia los *Domain Message Flows* desarrollados anteriormente. Estos flujos permitieron identificar qué contextos requieren información o servicios proporcionados por otros contextos.

Las principales relaciones identificadas son:

#v(0.5em)
#table(
  columns: (30%, 35%, 35%),
  align: left,
  stroke: 0.4pt + rgb("#cbd5e1"),
  inset: (x: 8pt, y: 6pt),
  fill: (x, y) => if y == 0 { rgb("#1e3a8a") } else if calc.even(y) { rgb("#f8fafc") } else { white },
  table.header(
    [#text(fill: white, weight: "bold")[Contexto consumidor]],
    [#text(fill: white, weight: "bold")[Contexto proveedor]],
    [#text(fill: white, weight: "bold")[Información / servicio relacionado]],
  ),
  [Fleet & Appointments], [Workshop Management], [Workshop, Branch, Customer, Employee],
  [Fleet & Appointments], [Vehicle Intelligence & Diagnostics], [Vehicle],
  [Service Operations], [Fleet & Appointments], [Appointment],
  [Service Operations], [Workshop Management], [Branch, Employee],
  [Service Operations], [Inventory Management], [Product, Stock, Reservation],
  [Service Operations], [Billing & Payments], [Billing / Payment],
  [Billing & Payments], [Service Operations], [Service / Work Order information],
  [Identity & Access], [Workshop Management], [User identity / profile association],
  [Workshop Management], [Identity & Access], [User identity],
)
#v(0.5em)

Estas relaciones se encuentran respaldadas por la estructura del backend. Por ejemplo, `fleet` dispone de servicios externos hacia `core` y hacia el contexto de vehículos, mientras que `operations` posee servicios externos para Appointment, Billing, Branch, Employee y Product.

#v(0.5em)
==== Context Map de ShiftIq

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter2/strategic-level-DDD/event-storming/Context-Mapping.jpg", width: 70%),
    caption: [Context Map -- Relaciones entre los Bounded Contexts de ShiftIq.]
  )
]
#v(0.5em)

El mapa representa las principales relaciones entre los siete contextos identificados. Las conexiones muestran que los contextos mantienen responsabilidades independientes, pero requieren colaborar para completar determinados procesos de negocio.

La interacción más relevante se presenta alrededor del proceso de servicio automotriz:

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter2/strategic-level-DDD/event-storming/context-mapping-flow.svg", width: 85%),
    caption: [Flujo de interacción entre Bounded Contexts en el proceso de servicio automotriz.]
  )
]
#v(0.5em)

=== 2.5.3. Software Architecture

==== 2.5.3.1. Software Architecture Context Level Diagrams

Según el Modelo C4 de Simon Brown, el *Diagrama de Contexto del Sistema* ofrece la vista de mayor nivel de abstracción, representando el sistema como una caja negra. En ShiftIQ, este nivel muestra la plataforma como sistema central y sus interacciones con los usuarios principales, el dispositivo IoT del vehículo y los servicios externos utilizados para mensajería, pagos y facturación electrónica.

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter2/strategic-level-DDD/software-architecture/c4-system-context.svg", width: 95%),
    caption: [Diagrama de Contexto del Sistema -- ShiftIQ Platform.]
  )
]
#v(0.5em)

===== Elementos y Relaciones

- *Mechanic / Admin:* Usuario administrativo y técnico que gestiona talleres, sucursales, vehículos y genera reportes operativos.
- *Final Client:* Cliente dueño del vehículo que monitorea el estado del mantenimiento en tiempo real y gestiona sus citas.
- *Dispositivo OBD-II IoT:* Componente de hardware que transmite parámetros del vehículo y códigos de diagnóstico DTC.
- *ShiftIQ Platform:* Sistema central que integra la gestión de talleres, vehículos, telemetría, órdenes de trabajo y facturación.
- *Messaging Service:* Servicio externo utilizado para el envío de notificaciones y comprobantes por correo electrónico.
- *Stripe Payment Gateway:* Pasarela externa utilizada para el procesamiento de pagos digitales.
- *Factos SUNAT API:* Servicio externo utilizado para la emisión y validación de comprobantes electrónicos.
- *Relaciones principales:* Los usuarios interactúan con ShiftIQ mediante interfaces web y móviles, el dispositivo OBD-II transmite información telemática hacia la plataforma y ShiftIQ se comunica con los servicios externos para mensajería, pagos y facturación.

#v(0.5em)
==== 2.5.3.2. Software Architecture Container Level Diagrams

El *Diagrama de Contenedores* abre la caja negra del sistema para mostrar sus principales unidades ejecutables y responsabilidades tecnológicas. En ShiftIQ se representan la Landing Page, la aplicación web SPA, la aplicación móvil, la API RESTful y la base de datos PostgreSQL, junto con sus principales mecanismos de comunicación y las integraciones con servicios externos.

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter2/strategic-level-DDD/software-architecture/c4-container-diagram.svg", width: 95%),
    caption: [Diagrama de Contenedores -- ShiftIQ Platform.]
  )
]
#v(0.5em)

===== Elementos y Relaciones

- *Landing Page:* Sitio web de presentación del producto que proporciona información comercial y redirige hacia la aplicación principal.
- *Web Application (SPA):* Interfaz web desarrollada en Angular para la gestión del taller, flota y seguimiento de los vehículos.
- *Mobile App:* Aplicación nativa Android desarrollada en Kotlin para mecánicos y clientes.
- *API RESTful:* Backend desarrollado con Java 21 y Spring Boot 3 que contiene la lógica de negocio y los siete Bounded Contexts.
- *Database:* Base de datos PostgreSQL utilizada para la persistencia de la información del sistema.
- *Messaging Service:* Servicio externo utilizado para el envío de notificaciones y facturas por correo electrónico.
- *Relaciones principales:* Las aplicaciones web y móvil consumen los servicios de la API RESTful mediante HTTPS. El dispositivo OBD-II transmite telemetría y códigos DTC al backend. La API persiste información en PostgreSQL y se comunica con los servicios externos de mensajería, pagos y facturación.

#v(0.5em)
==== 2.5.3.3. Software Architecture Deployment Diagrams

El *Diagrama de Despliegue* representa la distribución física y tecnológica de ShiftIQ en su infraestructura. Esta vista muestra cómo los componentes definidos en los niveles anteriores se despliegan sobre dispositivos de usuario, servidores web, servidores de aplicación, contenedores Docker y servicios externos en la nube.

#v(0.5em)
#align(center)[
  #figure(
    image("assets/chapter2/strategic-level-DDD/software-architecture/c4-deployment-diagram.svg", width: 95%),
    caption: [Diagrama de Despliegue -- ShiftIQ Platform Infrastructure.]
  )
]
#v(0.5em)

===== Elementos y Relaciones

- *Web Browser:* Dispositivo utilizado para acceder a la Landing Page y a la Web Application.
- *Smartphone Android:* Dispositivo donde se ejecuta la aplicación móvil desarrollada en Kotlin.
- *Módulo IoT OBD-II:* Hardware instalado en el vehículo que transmite información telemática.
- *Servidor Web / CDN Hosting:* Infraestructura encargada de distribuir los archivos estáticos de la Landing Page y la aplicación web.
- *Cloud Application Host:* Servidor que aloja el entorno de ejecución de la aplicación backend.
- *Docker Engine:* Entorno de contenedores donde se ejecutan el backend y la base de datos.
- *API RESTful Backend:* Aplicación Spring Boot que ejecuta los siete Bounded Contexts.
- *Database:* Contenedor PostgreSQL encargado de la persistencia de los datos.
- *Servicios externos:* Servicios cloud utilizados para mensajería, procesamiento de pagos y facturación electrónica.
- *Relaciones principales:* Los navegadores acceden al servidor web mediante HTTPS, mientras que la aplicación web y móvil consumen la API RESTful. El dispositivo OBD-II transmite información al backend. La API se conecta con PostgreSQL mediante JDBC y con los servicios externos mediante HTTPS y SMTP.
```