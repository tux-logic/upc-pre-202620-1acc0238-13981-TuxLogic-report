```{=typst}
== 2.6. Tactical-Level Domain-Driven Design

=== 2.6.1. Bounded Context: Shared Kernel

El *Shared Kernel* (`shared`) provee la infraestructura transversal, las abstracciones de dominio compartidas, los Value Objects reutilizables, la gestión de eventos de dominio cross-context, el patrón funcional de manejo de errores (`Result<T, E>`), la seguridad multi-tenant por sucursal (`MultiTenancySecurityService`), el mapeo relacional base auditado (`AuditableAbstractPersistenceEntity`) y el manejo centralizado de excepciones REST en la plataforma *ShiftIQ*.

#v(0.5em)

==== 2.6.1.1. Domain Layer

La Capa de Dominio del Shared Kernel encapsula los tipos de valor reutilizables entre múltiples Bounded Contexts, la abstracción base para raíces de agregado (`AbstractDomainAggregateRoot`), y los eventos de dominio de integración que comunican el flujo entre módulos sin acoplamiento directo de infraestructura.

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/shared/domain-layer-diagram.svg", width: 95%)
    ),
    caption: [Diagrama de la Capa de Dominio -- Shared Kernel]
  )
]
#v(0.5em)

===== 1.1. Base Aggregates & Abstract Entities

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`AbstractDomainAggregateRoot<T extends AbstractDomainAggregateRoot<T>>`] \
  #text(size: 9.5pt, fill: rgb("#475569"))[*Tipo:* Clase Abstracta (`extends AbstractAggregateRoot<T>`)] \
  *Propósito:* Provee soporte inmutable para registro y despacho de Eventos de Dominio sin acoplar el modelo a JPA ni a frameworks de persistencia. \
  *Métodos:*
  - `#registerDomainEvent(Object event)`: Registra un evento de dominio para ser publicado tras persistir el agregado.
  - `+domainEvents()`: Retorna la colección no modificable de eventos registrados.
  - `+clearDomainEvents()`: Limpia la lista de eventos tras su publicación exitosa por los adaptadores de repositorio.
]

#v(0.5em)

===== 1.2. Shared Value Objects & Records

#grid(
  columns: (1fr, 1fr),
  gutter: 10pt,
  block(
    fill: rgb("#f8fafc"),
    stroke: 0.5pt + rgb("#cbd5e1"),
    radius: 4pt,
    inset: 8pt,
    width: 100%
  )[
    #text(weight: "bold", fill: rgb("#b91c1c"))[Record: `Money(BigDecimal amount)`] \
    *Propósito:* Value Object inmutable para montos monetarios. \
    *Invariantes & Validaciones:*
    - No nulo (`operations.error.money.required`).
    - No negativo (`operations.error.money.cannotBeNegative`).
    - Redondeo a 2 decimales (`HALF_UP`). \
    *Operaciones:* `plus`, `minus`, `multiply`, `isGreaterThan`, `isLessThan`. \
    *Constantes:* `ZERO` (`BigDecimal.ZERO`).
  ],
  block(
    fill: rgb("#f8fafc"),
    stroke: 0.5pt + rgb("#cbd5e1"),
    radius: 4pt,
    inset: 8pt,
    width: 100%
  )[
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `BranchId(UUID value)`] \
    *Propósito:* Identificador fuertemente tipado para sucursales. \
    *Validación:* No permite valores nulos (`shared.error.branchId.required`).

    #v(4pt)
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `CustomerId(UUID value)`] \
    *Propósito:* Identificador fuertemente tipado para clientes. \
    *Validación:* No permite valores nulos (`shared.error.customerId.required`).
  ]
)

#v(6pt)

#grid(
  columns: (1fr, 1fr),
  gutter: 10pt,
  block(
    fill: rgb("#f8fafc"),
    stroke: 0.5pt + rgb("#cbd5e1"),
    radius: 4pt,
    inset: 8pt,
    width: 100%
  )[
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `VehicleId(UUID value)`] \
    *Propósito:* Identificador fuertemente tipado para vehículos. \
    *Validación:* No permite valores nulos (`shared.error.vehicleId.required`).

    #v(4pt)
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `Mileage(Integer value)`] \
    *Propósito:* Kilometraje de vehículos. \
    *Validación:* No nulo y no negativo.
  ],
  block(
    fill: rgb("#f8fafc"),
    stroke: 0.5pt + rgb("#cbd5e1"),
    radius: 4pt,
    inset: 8pt,
    width: 100%
  )[
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `Address(String value)`] \
    *Propósito:* Dirección física formateada. \
    *Validación:* No vacía/nula (`operations.error.address.notBlank`) y máx. 100 caracteres.
  ]
)

#v(0.5em)

===== 1.3. Cross-Context Domain Events

- *`ProductReservedEvent(Object source, BranchId branchId, UUID productId, Integer quantity)`*: Notifica la reserva temporal de repuestos emitida desde `Operations` hacia `Inventory`.
- *`ProductReservationCanceledEvent(Object source, BranchId branchId, UUID productId, Integer quantity)`*: Notifica la liberación de reservas de stock al modificar o cancelar tareas de órdenes de trabajo.
- *`PaymentProcessedEvent(UUID workOrderId)`*: Notifica el procesamiento exitoso de pago de una orden de trabajo desde `Billing`.

#v(0.5em)

==== 2.6.1.2. Interface Layer

Manejo global de excepciones (`@RestControllerAdvice`), ensambladores universales de respuestas HTTP e internacionalización (`MessageSource`).

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/shared/interface-layer-diagram.svg", width: 95%)
    ),
    caption: [Diagrama de la Capa de Interfaz -- Shared Kernel]
  )
]
#v(0.5em)

===== 2.1. Infrastructure REST Utilities & Cross-Cutting Exception Handlers

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`GlobalExceptionHandler` (`@RestControllerAdvice`)] \
  Centraliza las excepciones no capturadas a nivel REST. Traduce `@Valid` binding errors (`MethodArgumentNotValidException`), `IllegalArgumentException`, `AccessDeniedException` y `RuntimeException` a respuestas `ErrorResource` internacionalizadas mediante `messages.properties`.

  #v(6pt)
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`ErrorResponseAssembler` & `ResponseEntityAssembler`] \
  Mapea códigos de error (`VALIDATION_ERROR`, `NOT_FOUND`, `CONFLICT`, `ACCESS_DENIED`) a los códigos de estado HTTP correspondientes (`400`, `404`, `409`, `403`, `500`).
]

#v(0.5em)

==== 2.6.1.3. Application Layer

La Capa de Aplicación del Shared Kernel provee la estructura funcional `Result<T, E>` para manejo de errores sin excepciones de control de flujo, y el modelo canónico de errores de aplicación `ApplicationError`.

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/shared/application-layer-diagram.svg", width: 95%)
    ),
    caption: [Diagrama de la Capa de Aplicación -- Shared Kernel]
  )
]
#v(0.5em)

===== 3.1. Functional Result Pattern & Error Specification

#grid(
  columns: (1fr, 1fr),
  gutter: 10pt,
  block(
    fill: rgb("#f8fafc"),
    stroke: 0.5pt + rgb("#cbd5e1"),
    radius: 4pt,
    inset: 8pt,
    width: 100%
  )[
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Sealed Interface: `Result<T, E>`] \
    *Permite:* `Result.Success<T, E>`, `Result.Failure<T, E>`. \
    *Métodos Principales:*
    - `static success(T value)` / `static failure(E error)`
    - `fold(onSuccess, onFailure)`
    - `isSuccess()`, `isFailure()`, `success()`, `failure()`.
  ],
  block(
    fill: rgb("#f8fafc"),
    stroke: 0.5pt + rgb("#cbd5e1"),
    radius: 4pt,
    inset: 8pt,
    width: 100%
  )[
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `ApplicationError(code, message, details)`] \
    *Métodos Estáticos de Fábrica:*
    - `validationError(field, reason)`
    - `notFound(resourceType, identifier)`
    - `businessRuleViolation(rule, reason)`
    - `conflict(resource, reason)`
    - `unexpected(context, reason)`
  ]
)

#v(0.5em)

==== 2.6.1.4. Infrastructure Layer

Clase base relacional auditada JPA (`AuditableAbstractPersistenceEntity`), conversores de atributos (`AttributeConverter`), seguridad multi-tenant por sucursal y configuraciones transversales.

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/shared/infrastracture-layer-diagram.svg", width: 95%)
    ),
    caption: [Diagrama de la Capa de Infraestructura -- Shared Kernel]
  )
]
#v(0.5em)

===== 4.1. JPA MappedSuperclass & Persistence Base

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`@MappedSuperclass`: `AuditableAbstractPersistenceEntity`] \
  *Anotaciones:* `@EntityListeners(AuditingEntityListener.class)` \
  *Atributos Heredados:*
  - `@Id @GeneratedValue(strategy = GenerationType.UUID) UUID id`
  - `@CreatedDate Instant createdAt`
  - `@LastModifiedDate Instant updatedAt`
  - `@Version Long version`
]

#v(0.5em)

===== 4.2. JPA Custom Attribute Converters

- *`MoneyAttributeConverter`*: Mapea `Money` ↔ `DECIMAL(12,2)`.
- *`MileageAttributeConverter`*: Mapea `Mileage` ↔ `INTEGER`.
- *`AddressAttributeConverter`*: Mapea `Address` ↔ `VARCHAR(100)`.

#v(0.5em)

===== 4.3. Multi-Tenancy Security & Auditing

- *`MultiTenancySecurityService`*: Bean `@Service("multiTenancySecurityService")` expuesto para expresiones SpEL (`@PreAuthorize`) que valida si el usuario autenticado posee permisos sobre el `branchId`, `userId` o `workshopId` de la petición.
- *`UserSecurityService`*: Bean `@Service("userSecurityService")` para verificación de identidad propia en SpEL (prevención de IDOR).
- *`SnakeCaseWithPluralizedTablePhysicalNamingStrategy`*: Convierte los nombres de entidades de CamelCase a `snake_case` pluralizado para PostgreSQL (ej. `WorkOrder` ➔ `work_orders`).

#v(0.5em)

==== 2.6.1.5. Bounded Context Software Architecture Component Level Diagrams

Descomposición del Container REST API resaltando los componentes del *Shared Kernel* que prestan servicio transversal a todos los Bounded Contexts.

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/shared/component-diagram-share.svg", width: 95%)
    ),
    caption: [Component Diagram (C4 Level 3) -- Shared Kernel]
  )
]
#v(0.5em)

==== 2.6.1.6. Bounded Context Software Architecture Code Level Diagrams

===== 2.6.1.6.1. Bounded Context Domain Layer Class Diagrams

Representación detallada de clases del módulo Shared Kernel en formato UML, abarcando las clases abstractas, Value Objects, Records, Eventos de Dominio, interfaces selladas y utilitarios transversales.

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/shared/domain-shared-kernel-class-diagram.svg", width: 95%)
    ),
    caption: [Diagrama de Clases del Dominio UML -- Shared Kernel]
  )
]
#v(0.5em)

===== 2.6.1.6.2. Bounded Context Database Design Diagram

Estructura de la tabla relacional base heredada por las entidades persistentes mediante la estrategia `@MappedSuperclass` de JPA en PostgreSQL:

#v(0.5em)
#align(center)[
  #table(
    columns: (110pt, 100pt, 1fr),
    align: (center, center, left),
    table.header([Columna], [Tipo de Dato], [Constraints / Descripción]),
    [*`id`*], [`UUID`], [`PRIMARY KEY, DEFAULT gen_random_uuid()`],
    [*`created_at`*], [`TIMESTAMP`], [`NOT NULL, DEFAULT CURRENT_TIMESTAMP`],
    [*`updated_at`*], [`TIMESTAMP`], [`NOT NULL, DEFAULT CURRENT_TIMESTAMP`],
    [*`version`*], [`BIGINT`], [`NOT NULL, DEFAULT 0` (Control de concurrencia optimista)],
  )
]
```
