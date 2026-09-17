
``` {=typst}
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
      image("assets/chapter-2/tactical-ddd/shared/domain-layer-diagram.svg", width: 95%)
    ),
    caption: [Diagrama de la Capa de Dominio -- Shared Kernel]
  )
]
#v(0.5em)


#v(0.5em)
#text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.1.1.1. Base Aggregates & Abstract Entities]
#v(0.3em)


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


#v(0.5em)
#text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.1.1.2. Shared Value Objects & Records]
#v(0.3em)


#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#b91c1c"))[Record: `Money(BigDecimal amount)`] \
  *Propósito:* Value Object inmutable para montos monetarios. \
  *Invariantes & Validaciones:*
  - No puede ser nulo (`operations.error.money.required`).
  - No puede ser negativo (`operations.error.money.cannotBeNegative`).
  - Redondeo automático a 2 decimales (`HALF_UP`). \
  *Operaciones:* `plus(Money)`, `minus(Money)`, `multiply(int)`, `multiply(BigDecimal)`, `isGreaterThan(Money)`, `isLessThan(Money)`. \
  *Constantes:* `ZERO` (`BigDecimal.ZERO`).
]

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
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `BranchId(UUID value)`] \
    *Propósito:* Identificador fuertemente tipado para sucursales. \
    *Validación:* No nulo (`shared.error.branchId.required`).

    #v(6pt)
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `CustomerId(UUID value)`] \
    *Propósito:* Identificador fuertemente tipado para clientes. \
    *Validación:* No nulo (`shared.error.customerId.required`).
  ],
  block(
    fill: rgb("#f8fafc"),
    stroke: 0.5pt + rgb("#cbd5e1"),
    radius: 4pt,
    inset: 8pt,
    width: 100%
  )[
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `VehicleId(UUID value)`] \
    *Propósito:* Identificador fuertemente tipado para vehículos. \
    *Validación:* No nulo (`shared.error.vehicleId.required`).

    #v(6pt)
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `Mileage(Integer value)`] \
    *Propósito:* Kilometraje de vehículos. \
    *Validación:* No nulo y no negativo.
  ]
)

#v(6pt)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 8pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `Address(String value)`] \
  *Propósito:* Dirección física formateada. \
  *Validación:* No vacía ni nula (`operations.error.address.notBlank`) y longitud máxima de 100 caracteres.
]

#v(0.5em)


#v(0.5em)
#text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.1.1.3. Cross-Context Domain Events]
#v(0.3em)


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
      image("assets/chapter-2/tactical-ddd/shared/interface-layer-diagram.svg", width: 100%)
    ),
    caption: [Diagrama de la Capa de Interfaz -- Shared Kernel]
  )
]
#v(0.5em)


#v(0.5em)
#text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.1.2.1. Infrastructure REST Utilities & Cross-Cutting Exception Handlers]
#v(0.3em)


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
      image("assets/chapter-2/tactical-ddd/shared/application-layer-diagram.svg", width: 95%)
    ),
    caption: [Diagrama de la Capa de Aplicación -- Shared Kernel]
  )
]
#v(0.5em)


#v(0.5em)
#text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.1.3.1. Functional Result Pattern & Error Specification]
#v(0.3em)


#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Sealed Interface: `Result<T, E>`] \
  *Permite:* `Result.Success<T, E>`, `Result.Failure<T, E>`. \
  *Métodos Principales:*
  - `static success(T value)` / `static failure(E error)`: Métodos de fábrica.
  - `fold(onSuccess, onFailure)`: Evaluación funcional pattern-matching.
  - `isSuccess()`, `isFailure()`, `success()`, `failure()`.
]

#v(6pt)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
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
      image("assets/chapter-2/tactical-ddd/shared/infrastracture-layer-diagram.svg", width: 95%)
    ),
    caption: [Diagrama de la Capa de Infraestructura -- Shared Kernel]
  )
]
#v(0.5em)


#v(0.5em)
#text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.1.4.1. JPA MappedSuperclass & Persistence Base]
#v(0.3em)


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


#v(0.5em)
#text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.1.4.2. JPA Custom Attribute Converters]
#v(0.3em)


- *`MoneyAttributeConverter`*: Mapea `Money` ↔ `DECIMAL(12,2)`.
- *`MileageAttributeConverter`*: Mapea `Mileage` ↔ `INTEGER`.
- *`AddressAttributeConverter`*: Mapea `Address` ↔ `VARCHAR(100)`.

#v(0.5em)


#v(0.5em)
#text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.1.4.3. Multi-Tenancy Security & Auditing]
#v(0.3em)


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
      image("assets/chapter-2/tactical-ddd/shared/component-diagram-share.svg", width: 80%)
    ),
    caption: [Component Diagram (C4 Level 3) -- Shared Kernel]
  )
]
#v(0.5em)

==== 2.6.1.6. Bounded Context Software Architecture Code Level Diagrams


#v(0.5em)
#text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.1.6.1. Bounded Context Domain Layer Class Diagrams]
#v(0.3em)


Representación detallada de clases del módulo Shared Kernel en formato UML, abarcando las clases abstractas, Value Objects, Records, Eventos de Dominio, interfaces selladas y utilitarios transversales.

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/shared/domain-shared-kernel-class-diagram.svg", width: 80%)
    ),
    caption: [Diagrama de Clases del Dominio UML -- Shared Kernel]
  )
]
#v(0.5em)


#v(0.5em)
#text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.1.6.2. Bounded Context Database Design Diagram]
#v(0.3em)


Estructura de la tabla relacional base heredada por las entidades persistentes mediante la estrategia `@MappedSuperclass` de JPA en PostgreSQL:

#v(0.5em)
#align(center)[
  #table(
    columns: (95pt, 110pt, 1fr),
    align: (center, center, left),
    table.header([Columna], [Tipo de Dato], [Constraints / Descripción]),
    [*`id`*], [`UUID`], [`PRIMARY KEY, DEFAULT gen_random_uuid()`],
    [*`created_at`*], [`TIMESTAMP`], [`NOT NULL, DEFAULT CURRENT_TIMESTAMP`],
    [*`updated_at`*], [`TIMESTAMP`], [`NOT NULL, DEFAULT CURRENT_TIMESTAMP`],
    [*`version`*], [`BIGINT`], [`NOT NULL, DEFAULT 0` (Control de concurrencia optimista)],
  )
]

#v(1em)



#v(1em)

#v(1em)
Este documento presenta la especificación exhaustiva, formal y técnica de los *Bounded Contexts* implementados en el ecosistema *ShiftIQ Platform*. Cada contexto se estructura rigurosamente bajo los lineamientos del *Domain-Driven Design (DDD) Táctico* y los principios de la *Arquitectura Limpia / Hexagonal*, alineado al 100% con la base de código real. Incluye diagramas de arquitectura en *C4 Model (Nivel 3: Componentes)*, diagramas a nivel de código (*UML Class Diagrams* y *Database ER Diagrams*), y el *Diccionario de Clases por Capas* con atributos tipados, signaturas completas de métodos, visibilidad, reglas de negocio, invariantes y relaciones estructurales entre componentes a través de las cuatro capas fundamentales: *Domain Layer*, *Application Layer*, *Interface Layer* e *Infrastructure Layer*.

#v(1em)
Este documento presenta la especificación exhaustiva, formal y técnica de los *Bounded Contexts* implementados en el ecosistema *ShiftIQ Platform*. Cada contexto se estructura rigurosamente bajo los lineamientos del *Domain-Driven Design (DDD) Táctico* y los principios de la *Arquitectura Limpia / Hexagonal*, alineado al 100% con la base de código real. Incluye diagramas de arquitectura en *C4 Model (Nivel 3: Componentes)*, diagramas a nivel de código (*UML Class Diagrams* y *Database ER Diagrams*), y el *Diccionario de Clases por Capas* con atributos tipados, signaturas completas de métodos, visibilidad, reglas de negocio, invariantes y relaciones estructurales entre componentes a través de las cuatro capas fundamentales: *Domain Layer*, *Application Layer*, *Interface Layer* e *Infrastructure Layer*.

#v(1em)

#v(1em)

#v(1em)

#v(1em)

#v(1em)
=== 2.6.2. Bounded Context: Identity & Access Management (IAM)

El Bounded Context de *Identity & Access Management (IAM)* constituye la piedra angular de seguridad, identidad y control de acceso de la plataforma *ShiftIQ*. Su responsabilidad primordial radica en centralizar el ciclo de vida de las identidades de usuario, garantizando:
- La confidencialidad y almacenamiento seguro de credenciales mediante hashing criptográfico BCrypt.
- La provisión de mecanismos de autenticación local (vía email y contraseña) y federada (mediante Google Identity Services / OAuth 2.0).
- La emisión, firma criptográfica y verificación de tokens de autorización sin estado (*JSON Web Tokens - JWT*).
- La asignación y verificación de roles de seguridad (Role-Based Access Control - RBAC) con soporte de autorización por propiedad de recurso mediante `UserSecurityService`.
- La orquestación del restablecimiento seguro de contraseñas olvidadas mediante tokens efímeros hasheados con SHA-256 (TTL por defecto de 60 minutos) y notificados vía correo electrónico (SMTP).

#v(0.5em)

==== 2.6.2.1. Domain Layer (Capa de Dominio)

La Capa de Dominio encierra la lógica de negocio pura, las invariantes operativas y las reglas del sistema de identidad, manteniéndose completamente agnóstica de frameworks web, motores de bases de datos o librerías de persistencia. En esta capa se definen Agregados, Entidades, Value Objects, Servicios de Dominio, Fábricas e Interfaces de Repositorio.

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/iam/domain-layer-diagram.svg", width: 95%)
    ),
    caption: [Diagrama de la Capa de Dominio -- IAM]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.2.1.1. Aggregates & Entities]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`User` (Aggregate Root)]   #text(size: 9.5pt, fill: rgb("#475569"))[*Tipo:* Aggregate Root (`extends AbstractDomainAggregateRoot<User>`)]   *Propósito:* Raíz de consistencia del agregado de usuario en IAM. Encapsula las credenciales, el estado vital de la cuenta, el rol de autorización RBAC, las asociaciones a sucursales de taller y las transiciones de estado, garantizando la publicación atómica de eventos de dominio ante cambios relevantes.   #v(4pt)
  *Atributos del Agregado:*
  - `id`: `UserId` (No Nulo) -- Identificador único tipado del usuario encapsulado en un Value Object.
  - `email`: `EmailAddress` (No Nulo) -- Dirección de correo electrónico normalizada y validada.
  - `password`: `Password` (No Nulo para auth local) -- Hash de la contraseña encriptada con BCrypt.
  - `googleId`: `GoogleId` (Opcional) -- Sujeto único emitido por Google OAuth (`sub`).
  - `status`: `UserStatus` (No Nulo) -- Estado de la cuenta (`ACTIVE` o `INACTIVE`).
  - `role`: `Roles` (No Nulo) -- Rol de autorización (`ROLE_USER`, `ROLE_ADMIN`, `ROLE_EMPLOYEE`, `ROLE_OWNER`).
  - `branchIds`: `Set<UUID>` (No Nulo) -- Colección de identificadores de sedes (`BranchId`) asociadas al usuario.
  - `createdAt`, `updatedAt`, `deletedAt`: `Instant` -- Auditoría temporal UTC.
  - `version`: `Long` -- Control de concurrencia optimista.
  #v(4pt)
  *Métodos y Comportamientos de Dominio:*
  - `assignRole(Roles role)`: Actualiza el rol de autorización RBAC.
  - `assignBranch(UUID branchId)` / `removeBranch(UUID branchId)`: Asocia o desvincula sedes operativas.
  - `deactivate()`: Desactiva la cuenta (`status = INACTIVE`) y registra `UserDeactivatedEvent`.
  - `changePassword(Password newPassword)`: Actualiza la clave y registra `UserPasswordChangedEvent`.
  - `changeEmail(EmailAddress newEmail)`: Cambia el correo y registra `UserEmailChangedEvent`.
  - `linkGoogleAccount(GoogleId googleId)`: Vincula la identidad federada de Google.
]

#v(0.5em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`PasswordRecoveryToken` (Entity)]   #text(size: 9.5pt, fill: rgb("#475569"))[*Tipo:* Entidad de Dominio]   *Propósito:* Representa un token efímero de recuperación de contraseña asociado a una cuenta de usuario.   #v(4pt)
  *Atributos:*
  - `id`: `UUID` -- Identificador único de la entidad.
  - `tokenHash`: `String` -- Digest SHA-256 del token enviado al usuario.
  - `createdAt`: `Instant` -- Fecha y hora de generación.
  - `expiresAt`: `Instant` -- Expiración calculada (TTL de 60 minutos por defecto).
  - `isUsed`: `boolean` -- Bandera de consumo (inicialmente `false`).
  - `userId`: `UUID` -- Identificador del usuario propietario.
  #v(4pt)
  *Reglas de Negocio e Invariantes:*
  - `isValid()`: Retorna `true` si `!isUsed` y `Instant.now().isBefore(expiresAt)`.
  - `markAsUsed()`: Marca la bandera `isUsed = true`.
]

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.2.1.2. Value Objects & Records]
]
#v(0.3em)

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
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `UserId(UUID value)`]     *Propósito:* Identificador fuertemente tipado del usuario.     *Validación:* Invariante no nula (`iam.error.userId.required`).

    #v(6pt)
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `EmailAddress(String value)`]     *Propósito:* Correo electrónico normalizado.     *Validación:* Regex RFC 5322 (`iam.error.email.invalidFormat`).
  ],
  block(
    fill: rgb("#f8fafc"),
    stroke: 0.5pt + rgb("#cbd5e1"),
    radius: 4pt,
    inset: 8pt,
    width: 100%
  )[
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `Password(String value)`]     *Propósito:* Credencial o hash criptográfico.     *Validación:* No nula ni vacía (`iam.error.password.required`).

    #v(6pt)
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `GoogleId(String value)`]     *Propósito:* Sujeto federado de Google OAuth (`sub`).     *Validación:* Identificador de sujeto no nulo.
  ]
)

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.2.1.3. Enumerations]
]
#v(0.3em)

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
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Enum: `UserStatus`]     *Propósito:* Estado vital de la cuenta.     - `ACTIVE`: Habilitada para autenticación.
    - `INACTIVE`: Dada de baja lógica.
  ],
  block(
    fill: rgb("#f8fafc"),
    stroke: 0.5pt + rgb("#cbd5e1"),
    radius: 4pt,
    inset: 8pt,
    width: 100%
  )[
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Enum: `Roles`]     *Propósito:* Roles RBAC de seguridad.     - `ROLE_USER`: Usuario cliente básico.
    - `ROLE_ADMIN`: Administrador de plataforma.
    - `ROLE_EMPLOYEE`: Empleado/Técnico.
    - `ROLE_OWNER`: Propietario de taller.
  ]
)

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.2.1.4. Domain Repositories (Interfaces)]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Interface: `UserRepository`]   *Métodos:* `save(User user)`, `findById(UUID id)`, `findByEmail(String email)`, `existsByEmail(String email)`.

  #v(6pt)
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Interface: `PasswordRecoveryTokenRepository`]   *Métodos:* `save(PasswordRecoveryToken token)`, `findByTokenHash(String tokenHash)`.
]

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.2.1.5. Domain Events]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  - `UserSignedUpEvent(Object source, UUID userId, String email)`: Publicado al crearse una nueva cuenta.
  - `UserPasswordChangedEvent(Object source, UUID userId)`: Publicado al modificar la contraseña.
  - `UserEmailChangedEvent(Object source, UUID userId, String oldEmail, String newEmail)`: Publicado tras actualizar el correo.
  - `UserDeactivatedEvent(Object source, UUID userId)`: Publicado al ejecutar la baja lógica de la cuenta.
]

#v(0.5em)

==== 2.6.2.2. Application Layer (Capa de Aplicación)

La Capa de Aplicación orquesta los casos de uso del Bounded Context. Recibe comandos y consultas, coordina los agregados del dominio, ejecuta validaciones de unicidad y delega en servicios de infraestructura.

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/iam/application-layer-diagram.svg", width: 95%)
    ),
    caption: [Diagrama de la Capa de Aplicación -- IAM]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.2.2.1. Commands & Queries (DTOs de Aplicación)]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Comandos de Escritura (CQRS Commands):]   - `SignUpCommand(EmailAddress email, Password password)`: Alta de nuevo usuario.
  - `SignInCommand(EmailAddress email, Password password)`: Autenticación local con credenciales.
  - `GoogleSignInCommand(String idToken)`: Autenticación federada con Google Identity Services.
  - `GeneratePasswordRecoveryTokenCommand(EmailAddress email)`: Solicitud de token de recuperación.
  - `ResetPasswordCommand(String token, Password newPassword)`: Restablecimiento de contraseña.
  - `UpdateUserEmailCommand(UserId userId, EmailAddress newEmail)`: Actualización de correo electrónico.
  - `UpdateUserPasswordCommand(UserId userId, Password currentPassword, Password newPassword)`: Cambio de contraseña.

  #v(8pt)
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Consultas y DTOs de Resultado (CQRS Queries):]   - `GetUserByIdQuery(UserId userId)`: Consulta inmutable de perfil por ID.
  - `GetUserByEmailQuery(EmailAddress email)`: Consulta inmutable por correo electrónico.
  - `AuthenticatedUser(User user, String token)`: DTO de respuesta con agregados de usuario y JWT emitido.
]

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.2.2.2. Application Services]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`UserCommandServiceImpl` (`@Service`, `@Transactional`)]   Orquesta el alta de usuarios (validando unicidad de correo), autenticación local (verificando hash BCrypt) y autenticación federada (validando token Google con `GoogleIdTokenVerifier`). Emite JWTs vía `TokenService`.

  #v(6pt)
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`PasswordRecoveryCommandServiceImpl` (`@Service`, `@Transactional`)]   Gestiona la emisión de tokens efímeros de recuperación (TTL 60 min), calcula su hash SHA-256 para almacenamiento y despacha el correo vía `EmailService`.

  #v(6pt)
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`UserQueryServiceImpl` (`@Service`, `@Transactional(readOnly = true)`)]   Atiende consultas de lectura de perfiles de usuario por ID o correo.
]

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.2.2.3. Outbound Port Interfaces]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  - `HashingService`: `encode(CharSequence raw)` / `matches(CharSequence raw, String encoded)`.
  - `TokenService`: `generateToken(String username)` / `validateToken(String token)` / `getUsernameFromToken(String token)`.
  - `EmailService`: `sendPasswordRecoveryEmail(String to, String token)`.
]

#v(0.5em)

==== 2.6.2.3. Interface Layer (Capa de Interfaces)

La Capa de Interfaces expone los controladores REST HTTP bajo la convención de URLs del sistema. Transforma peticiones JSON entrantes en comandos/queries y mapea los resultados a Resources DTOs.

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/iam/interface-layer-diagram.svg", width: 95%)
    ),
    caption: [Diagrama de la Capa de Interfaces -- IAM]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.2.3.1. REST Controllers & DTO Resources]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`AuthenticationController` (`/api/v1/authentication`)]   - `POST /sessions`: Autenticación local con email y clave.
  - `POST /sessions/google`: Autenticación federada con token OAuth de Google.
  - `POST /password-recoveries`: Solicitud de envío de correo de recuperación.
  - `POST /password-resets`: Restablecimiento de contraseña con token plano.

  #v(6pt)
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`UsersController` (`/api/v1/users`)]   - `POST`: Alta de nuevo usuario (`SignUpResource`).
  - `GET /{userId}`: Consulta de usuario por ID.
  - `GET ?email={email}`: Consulta por correo electrónico.
  - `PUT /{userId}/email`: Actualización de correo electrónico.
  - `PUT /{userId}/password`: Cambio de contraseña verificando clave actual.
]

#v(0.5em)

==== 2.6.2.4. Infrastructure Layer (Capa de Infraestructura)

La Capa de Infraestructura implementa la persistencia física en PostgreSQL 18 con Spring Data JPA, el filtrado de seguridad con Spring Security, el hashing BCrypt e integración externa con SMTP y Google Identity.

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/iam/infrastructure-layer-diagram.svg", width: 95%)
    ),
    caption: [Diagrama de la Capa de Infraestructura -- IAM]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.2.4.1. Persistence & Security Adapters]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`UserPersistenceEntity` & `UserRepositoryImpl`]   Entidad JPA mapeada a la tabla `users` (extiende de `AuditableAbstractPersistenceEntity`). Adaptador `UserRepositoryImpl` que delega en `UserPersistenceRepository` y despacha eventos de dominio con `ApplicationEventPublisher`.

  #v(6pt)
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`BearerAuthorizationRequestFilter` & `UserSecurityService`]   Filtro `OncePerRequestFilter` de Spring Security que extrae y valida tokens Bearer JWT en cada petición HTTP. `UserSecurityService` evalúa expresiones SpEL (`@PreAuthorize`) para verificar propiedad sobre recursos.
]

#v(0.5em)

==== 2.6.2.5. C4 Model Component Diagram (Container: Spring Boot REST API -- IAM)

Descomposición estructural del container REST API para el Bounded Context de IAM:

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/iam/c4-component-diagram.svg", width: 80%)
    ),
    caption: [Diagrama de Componentes C4 Nivel 3 -- IAM]
  )
]
#v(0.5em)

==== 2.6.2.6. Bounded Context Software Architecture Code Level Diagrams

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.2.6.1. Domain Layer Class Diagram]
]

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/iam/class-diagram.svg", width: 80%)
    ),
    caption: [Diagrama de Clases del Dominio UML -- IAM]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.2.6.2. Database Design Diagram (PostgreSQL 18)]
]

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/iam/database-er-diagram.svg", width: 80%)
    ),
    caption: [Diagrama de Base de Datos Relacional ER -- IAM]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Especificación de Tablas Relacionales (PostgreSQL 18):]
]
#v(0.4em)

#block(sticky: true)[
  #text(weight: "bold", size: 9.5pt, fill: rgb("#334155"))[Tabla: `users`]
]
#v(0.2em)
#align(center)[
  #table(
    columns: (95pt, 110pt, 1fr),
    align: (left, center, left),
    table.header([Columna], [Tipo de Dato], [Constraints / Descripción]),
    [*`id`*], [`UUID`], [`PRIMARY KEY, DEFAULT gen_random_uuid()`],
    [*`email`*], [`VARCHAR(100)`], [`NOT NULL, UNIQUE INDEX`],
    [*`password_hash`*], [`VARCHAR(255)`], [`NOT NULL (BCrypt hash)`],
    [*`google_id`*], [`VARCHAR(255)`], [`NULLABLE, UNIQUE INDEX`],
    [*`status`*], [`VARCHAR(20)`], [`NOT NULL (ACTIVE / INACTIVE)`],
    [*`role`*], [`VARCHAR(30)`], [`NOT NULL (ROLE_USER/ADMIN/EMPLOYEE/OWNER)`],
    [*`created_at`*], [`TIMESTAMP`], [`NOT NULL, DEFAULT CURRENT_TIMESTAMP`],
    [*`updated_at`*], [`TIMESTAMP`], [`NOT NULL, DEFAULT CURRENT_TIMESTAMP`],
    [*`deleted_at`*], [`TIMESTAMP`], [`NULLABLE (Soft-delete timestamp)`],
    [*`version`*], [`BIGINT`], [`NOT NULL, DEFAULT 0 (Concurrencia optimista)`],
  )
]

#v(0.6em)

#block(sticky: true)[
  #text(weight: "bold", size: 9.5pt, fill: rgb("#334155"))[Tabla: `user_branches`]
]
#v(0.2em)
#align(center)[
  #table(
    columns: (95pt, 110pt, 1fr),
    align: (left, center, left),
    table.header([Columna], [Tipo de Dato], [Constraints / Descripción]),
    [*`user_id`*], [`UUID`], [`PRIMARY KEY, FOREIGN KEY -> users(id)`],
    [*`branch_id`*], [`UUID`], [`PRIMARY KEY (Sede física autorizada)`],
  )
]

#v(0.6em)

#block(sticky: true)[
  #text(weight: "bold", size: 9.5pt, fill: rgb("#334155"))[Tabla: `password_recovery_tokens`]
]
#v(0.2em)
#align(center)[
  #table(
    columns: (95pt, 110pt, 1fr),
    align: (left, center, left),
    table.header([Columna], [Tipo de Dato], [Constraints / Descripción]),
    [*`id`*], [`UUID`], [`PRIMARY KEY, NOT NULL`],
    [*`token_hash`*], [`VARCHAR(255)`], [`NOT NULL (SHA-256 digest)`],
    [*`user_id`*], [`UUID`], [`FOREIGN KEY -> users(id)`],
    [*`created_at`*], [`TIMESTAMP`], [`NOT NULL, DEFAULT CURRENT_TIMESTAMP`],
    [*`expires_at`*], [`TIMESTAMP`], [`NOT NULL (TTL 60 minutos)`],
    [*`is_used`*], [`BOOLEAN`], [`NOT NULL, DEFAULT FALSE`],
  )
]

#v(1em)
=== 2.6.3. Bounded Context: Operations (Work Orders & Services)

El Bounded Context de *Operations* constituye el motor operativo principal de la plataforma *ShiftIQ*. Gestiona el flujo de trabajo completo del taller automotriz: desde la definición del catálogo de servicios ofreciendo precios y mantenimiento (`Service`), la emisión y control del ciclo de vida de Órdenes de Trabajo (`WorkOrder`), la orquestación de tareas asignadas a mecánicos (`WorkOrderTask`), hasta el consumo y reserva de repuestos/productos de inventario (`WorkOrderTaskProduct`).

#v(0.5em)

==== 2.6.3.1. Domain Layer (Capa de Dominio)

La Capa de Dominio encapsula el modelo de negocio inmutable, asegurando transiciones estrictas de estado para las órdenes de trabajo y tareas mediante métodos *Factory*, reglas de negocio encapsuladas en el Agregado `WorkOrder`, el cálculo dinámico de costos y la emisión de eventos de dominio.

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/operations/domain-layer-diagram.svg", width: 80%)
    ),
    caption: [Diagrama de la Capa de Dominio -- Operations]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.3.1.1. Aggregates & Entities]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`WorkOrder` (Aggregate Root)]   #text(size: 9.5pt, fill: rgb("#475569"))[*Tipo:* Aggregate Root (`extends AbstractDomainAggregateRoot<WorkOrder>`)]   *Propósito:* Raíz de consistencia del flujo operativo de taller. Encapsula las tareas planificadas, diagnóstico, millaje de ingreso, relaciones con vehículo, cliente y sede, calculando dinámicamente el monto total y despachando eventos de dominio ante cambios de estado.   #v(4pt)
  *Atributos del Agregado:*
  - `id`: `WorkOrderId` -- Identificador único del agregado.
  - `appointmentId`: `AppointmentId` -- Cita de origen asociada.
  - `branchId`: `BranchId` -- Sede física donde se ejecuta el trabajo.
  - `vehicleId`: `VehicleId` -- Vehículo en mantenimiento.
  - `customerId`: `CustomerId` -- Cliente propietario.
  - `internalNumber`: `Integer` -- Correlativo operativo visible.
  - `status`: `WorkOrderStatus` -- Estado (`DRAFT`, `IN_PROGRESS`, `COMPLETED`, `PAID`, `CANCELED`).
  - `diagnosticSummary`: `DiagnosticSummary` -- Resumen de diagnóstico técnico.
  - `mileageIn`: `Mileage` -- Kilometraje de ingreso.
  - `totalAmount`: `Money` -- Monto acumulado de tareas y repuestos.
  - `tasks`: `List<WorkOrderTask>` -- Lista interna de tareas operativas.
  #v(4pt)
  *Métodos y Comportamientos de Dominio:*
  - `addTask(ServiceId, MechanicId, TaskDescription, Money)`: Adiciona una tarea e incrementa el costo total.
  - `addProductToTask(WorkOrderTaskId, ProductId, Quantity, Money)`: Registra el uso de un repuesto y despacha `WorkOrderTaskProductAddedEvent`.
  - `startWork()` / `completeWorkOrder()` / `markAsPaid()`: Controlan el ciclo de vida y emiten eventos atómicos.
]

#v(0.5em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`Service` (Aggregate Root)]   #text(size: 9.5pt, fill: rgb("#475569"))[*Tipo:* Aggregate Root de Catálogo]   *Propósito:* Define los servicios ofrecidos por el taller (ej. Cambio de Aceite, Alineación) con precio base y estado de vigencia.   #v(4pt)
  *Atributos:* `id` (`ServiceId`), `name` (`ServiceName`), `description`, `price` (`Money`), `isActive` (`boolean`).
]

#v(0.5em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`WorkOrderTask` & `WorkOrderTaskProduct` (Entities)]   - `WorkOrderTask`: Entidad interna que representa un servicio ejecutado por un mecánico con estado (`PENDING`, `IN_PROGRESS`, `COMPLETED`).
  - `WorkOrderTaskProduct`: Entidad de repuesto asociado a una tarea con cantidad y subtotal.
]

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.3.1.2. Value Objects & Records]
]
#v(0.3em)

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
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `WorkOrderId(UUID value)`]     *Propósito:* Identificador de orden de trabajo.

    #v(6pt)
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `ServiceId(UUID value)`]     *Propósito:* Identificador del servicio de catálogo.
  ],
  block(
    fill: rgb("#f8fafc"),
    stroke: 0.5pt + rgb("#cbd5e1"),
    radius: 4pt,
    inset: 8pt,
    width: 100%
  )[
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `TaskDescription(String value)`]     *Propósito:* Detalle operativo de la tarea.

    #v(6pt)
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `Quantity(Integer value)`]     *Propósito:* Unidades de repuestos consumidos.
  ]
)

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.3.1.3. Enumerations]
]
#v(0.3em)

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
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Enum: `WorkOrderStatus`]     - `DRAFT`: Borrador en preparación.
    - `IN_PROGRESS`: En ejecución en taller.
    - `COMPLETED`: Trabajo finalizado.
    - `PAID`: Facturado y cancelado.
  ],
  block(
    fill: rgb("#f8fafc"),
    stroke: 0.5pt + rgb("#cbd5e1"),
    radius: 4pt,
    inset: 8pt,
    width: 100%
  )[
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Enum: `WorkOrderTaskStatus`]     - `PENDING`: Tarea pendiente de asignación.
    - `IN_PROGRESS`: Mecánico ejecutando la labor.
    - `COMPLETED`: Tarea concluida.
  ]
)

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.3.1.4. Domain Repositories (Interfaces)]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  - `WorkOrderRepository`: `save(WorkOrder order)`, `findById(WorkOrderId id)`, `findAllByBranchId(BranchId branchId)`.
  - `ServiceRepository`: `save(Service service)`, `findById(ServiceId id)`, `findAllActive()`.
]

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.3.1.5. Domain Events]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  - `WorkOrderCreatedEvent`: Notifica la creación de una orden de trabajo.
  - `WorkOrderStartedEvent` / `WorkOrderCompletedEvent`: Notifican inicio y cierre de trabajos.
  - `WorkOrderTaskProductAddedEvent`: Emite la reserva de repuestos consumidos hacia `Inventory`.
  - `ServiceCreatedEvent` / `ServiceUpdatedEvent`: Notifican modificaciones en el catálogo de servicios.
]

#v(0.5em)

==== 2.6.3.2. Application Layer (Capa de Aplicación)

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/operations/application-layer-diagram.svg", width: 95%)
    ),
    caption: [Diagrama de la Capa de Aplicación -- Operations]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.3.2.1. Commands & Queries (DTOs de Aplicación)]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Comandos de Escritura (CQRS Commands):]   - `CreateWorkOrderCommand`: Emisión de orden con cita y vehículo.
  - `AddTaskToWorkOrderCommand`: Asignación de tarea a mecánico.
  - `AddProductToTaskCommand`: Adición de repuesto consumido.
  - `StartWorkOrderCommand` / `CompleteWorkOrderCommand`: Mutaciones de estado de orden.
  - `CreateServiceCommand` / `UpdateServiceCommand`: Gestión de catálogo de servicios.

  #v(8pt)
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Consultas y DTOs de Resultado (CQRS Queries):]   - `GetWorkOrderByIdQuery`: Consulta por ID de orden.
  - `GetWorkOrdersByBranchIdQuery`: Consulta de órdenes por sede.
  - `GetServiceByIdQuery` / `GetAllActiveServicesQuery`: Consultas de servicios.
]

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.3.2.2. Application Services]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`WorkOrderCommandServiceImpl` & `ServiceCommandServiceImpl`]   Servicios transaccionales (`@Service`, `@Transactional`) que coordinan las mutaciones del agregado `WorkOrder` y `Service`, persisten en repositorio y publican eventos de dominio.
]

#v(0.5em)

==== 2.6.3.3. Interface Layer (Capa de Interfaces)

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/operations/interface-layer-diagram.svg", width: 95%)
    ),
    caption: [Diagrama de la Capa de Interfaces -- Operations]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.3.3.1. REST Controllers & DTO Resources]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  - `WorkOrdersController` (`/api/v1/work-orders`): Endpoints REST para creación, flujo de estado, tareas y repuestos.
  - `ServicesController` (`/api/v1/services`): Endpoints para administración del catálogo de servicios.
]

#v(0.5em)

==== 2.6.3.4. Infrastructure Layer (Capa de Infraestructura)

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/operations/infrastructure-layer-diagram.svg", width: 60%)
    ),
    caption: [Diagrama de la Capa de Infraestructura -- Operations]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.3.4.1. Persistence & Security Adapters]
]
#v(0.3em)

#align(center)[
  #table(
    columns: (95pt, 140pt, 1fr),
    align: (left, left, left),
    table.header([Tabla Relacional], [Clase JPA Entity], [Atributos & Campos Mapeados]),
    [*`work_orders`*], [`WorkOrderPersistenceEntity`], [`id` (UUID, PK), `appointment_id` (UUID), `branch_id` (UUID), `vehicle_id` (UUID), `customer_id` (UUID), `internal_number` (INTEGER), `status` (VARCHAR), `diagnostic_summary` (TEXT), `mileage_in` (DECIMAL), `total_amount` (DECIMAL), `created_at`, `updated_at`, `version`],
    [*`work_order_tasks`*], [`WorkOrderTaskPersistenceEntity`], [`id` (UUID, PK), `work_order_id` (UUID, FK), `service_id` (UUID), `branch_id` (UUID), `assigned_mechanic_id` (UUID), `status` (VARCHAR), `description` (TEXT), `price` (DECIMAL), `started_at`, `completed_at`],
    [*`work_order_task_products`*], [`WorkOrderTaskProductPersistenceEntity`], [`id` (UUID, PK), `work_order_task_id` (UUID, FK), `product_id` (UUID), `branch_id` (UUID), `quantity` (INTEGER), `unit_price` (DECIMAL), `total_amount` (DECIMAL)],
    [*`services`*], [`ServicePersistenceEntity`], [`id` (UUID, PK), `branch_id` (UUID), `name` (VARCHAR), `price` (DECIMAL), `created_at`, `updated_at`, `version`]
  )
]

#v(0.5em)

==== 2.6.3.5. C4 Model Component Diagram (Container: Spring Boot REST API -- Operations)

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/operations/c4-component-diagram.svg", width: 80%)
    ),
    caption: [Diagrama de Componentes C4 Nivel 3 -- Operations]
  )
]
#v(0.5em)

==== 2.6.3.6. Bounded Context Software Architecture Code Level Diagrams

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.3.6.1. Domain Layer Class Diagram]
]

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/operations/class-diagram.svg", width: 80%)
    ),
    caption: [Diagrama de Clases del Dominio UML -- Operations]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.3.6.2. Database Design Diagram (PostgreSQL 18)]
]

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/operations/database-er-diagram.svg", width: 80%)
    ),
    caption: [Diagrama de Base de Datos Relacional ER -- Operations]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Especificación de Tablas Relacionales (PostgreSQL 18):]
]
#v(0.4em)

#block(sticky: true)[
  #text(weight: "bold", size: 9.5pt, fill: rgb("#334155"))[Tabla: `work_orders`]
]
#v(0.2em)
#align(center)[
  #table(
    columns: (95pt, 110pt, 1fr),
    align: (left, center, left),
    table.header([Columna], [Tipo de Dato], [Constraints / Descripción]),
    [*`id`*], [`UUID`], [`PRIMARY KEY, DEFAULT gen_random_uuid()`],
    [*`branch_id`*], [`UUID`], [`NOT NULL, FOREIGN KEY -> branches(id)`],
    [*`vehicle_id`*], [`UUID`], [`NOT NULL, FOREIGN KEY -> vehicles(id)`],
    [*`customer_id`*], [`UUID`], [`NOT NULL, FOREIGN KEY -> customers(id)`],
    [*`status`*], [`VARCHAR(20)`], [`NOT NULL (DRAFT/IN_PROGRESS/COMPLETED/PAID)`],
    [*`total_amount`*], [`DECIMAL(12,2)`], [`NOT NULL, DEFAULT 0.00`],
    [*`created_at`*], [`TIMESTAMP`], [`NOT NULL, DEFAULT CURRENT_TIMESTAMP`],
    [*`updated_at`*], [`TIMESTAMP`], [`NOT NULL, DEFAULT CURRENT_TIMESTAMP`],
    [*`version`*], [`BIGINT`], [`NOT NULL, DEFAULT 0`],
  )
]

#v(0.6em)

#block(sticky: true)[
  #text(weight: "bold", size: 9.5pt, fill: rgb("#334155"))[Tabla: `services`]
]
#v(0.2em)
#align(center)[
  #table(
    columns: (95pt, 110pt, 1fr),
    align: (left, center, left),
    table.header([Columna], [Tipo de Dato], [Constraints / Descripción]),
    [*`id`*], [`UUID`], [`PRIMARY KEY, NOT NULL`],
    [*`name`*], [`VARCHAR(100)`], [`NOT NULL, UNIQUE`],
    [*`price`*], [`DECIMAL(12,2)`], [`NOT NULL, DEFAULT 0.00`],
    [*`is_active`*], [`BOOLEAN`], [`NOT NULL, DEFAULT TRUE`],
  )
]

#v(0.8em)

=== 2.6.4. Bounded Context: Inventory (Stock & Products Management)

El *Bounded Context `Inventory`* administra el catálogo de repuestos, autopartes y consumibles del taller automotriz (`Product`), la gestión física de existencias mediante lotes de adquisición (`ProductBatch`), la evaluación automática de niveles de stock mínimo (`MinimumStockAlertEvaluationJob`), y la sincronización asíncrona de inventario respondiendo a las reservas y despachos producidos por las Órdenes de Trabajo del Bounded Context `Operations`.

#v(0.5em)

==== 2.6.4.1. Domain Layer (Capa de Dominio)

La Capa de Dominio define las reglas inmutables del inventario, gestionando el stock disponible, la deducción FIFO encapsulada en el agregado `Product`, los métodos de creación y reconstitución (patrón *Factory*), la activación de alertas de bajo stock y las validaciones de negocio sin dependencias tecnológicas externas.

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/inventory/inventory-domain-layer.svg", width: 80%)
    ),
    caption: [Diagrama de la Capa de Dominio -- Inventory]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.4.1.1. Value Objects, Enums & Exceptions]
]
#v(0.3em)

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
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `BranchId`] \
    *Propósito:* Identificador único fuertemente tipado de la sucursal de taller asociada al inventario. \
    *Validaciones:* No nulo.
  ],
  block(
    fill: rgb("#f8fafc"),
    stroke: 0.5pt + rgb("#cbd5e1"),
    radius: 4pt,
    inset: 8pt,
    width: 100%
  )[
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `Money`] \
    *Propósito:* Representa montos monetarios para precios de venta y costos de adquisición de lotes. \
    *Validaciones:* `amount` no nulo y `>= 0`. \
    *Métodos:* `getAmount()`.
  ],
  block(
    fill: rgb("#f8fafc"),
    stroke: 0.5pt + rgb("#cbd5e1"),
    radius: 4pt,
    inset: 8pt,
    width: 100%
  )[
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `ProductName`] \
    *Propósito:* Nombre comercial de la autoparte o repuesto. \
    *Validaciones:* No nulo ni en blanco (`inventory.error.productName.required`).
  ],
  block(
    fill: rgb("#f8fafc"),
    stroke: 0.5pt + rgb("#cbd5e1"),
    radius: 4pt,
    inset: 8pt,
    width: 100%
  )[
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `Sku`] \
    *Propósito:* Stock Keeping Unit (código único de producto por sucursal). \
    *Validaciones:* No nulo ni en blanco (`inventory.error.sku.required`).
  ],
  block(
    fill: rgb("#f8fafc"),
    stroke: 0.5pt + rgb("#cbd5e1"),
    radius: 4pt,
    inset: 8pt,
    width: 100%
  )[
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `ProductCategory`] \
    *Propósito:* Categoría o familia del producto (ej. "Frenos", "Filtros", "Lubricantes"). \
    *Validaciones:* No nulo ni en blanco (`inventory.error.productCategory.required`).
  ],
  block(
    fill: rgb("#f8fafc"),
    stroke: 0.5pt + rgb("#cbd5e1"),
    radius: 4pt,
    inset: 8pt,
    width: 100%
  )[
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `InventoryQuantity`] \
    *Propósito:* Cantidad entera no negativa en inventario. \
    *Validaciones:* No nulo y `>= 0`. \
    *Métodos:* `add()`, `subtract()`.
  ]
)

#v(0.4em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `StockMovementQuantity(Integer value)`] \
  *Propósito:* Movimiento o ajuste de inventario (positivo para ingresos, negativo para egresos). \
  *Validaciones:* No nulo y distinto de cero. *Métodos:* `isPositive()`, `absoluteValue()`.

  #v(6pt)
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Enum: `ProductCommandFailure`] \
  *Valores:* `PRODUCT_NOT_FOUND`, `INVALID_PRODUCT_DATA`, `DUPLICATE_SKU`, `PRODUCT_IN_USE`, `INSUFFICIENT_STOCK`.

  #v(6pt)
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Excepción: `InsufficientStockException`] \
  *Propósito:* Excepción de dominio lanzada cuando se intenta reservar o descontar más stock del disponible (`inventory.error.product.insufficientStock`).
]

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.4.1.2. Aggregates & Entities]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Aggregate Root: `Product`] \
  #text(size: 9.5pt, fill: rgb("#475569"))[*Hereda de:* `AbstractAggregateRoot<Product>`] \
  *Propósito:* Raíz del agregado que representa un producto del inventario en una sucursal (`BranchId`). Clave primaria `UUID id`. \
  #v(4pt)
  *Reglas de Negocio:*
  - Mantiene la lista de lotes físicos recibidos (`batches`).
  - `reserveStock(InventoryQuantity amount)`: Recorre los lotes activos (`ProductBatch`) en estricto orden FIFO (`receptionDate` ascendente) descontando existencias. Lanza `InsufficientStockException` si `currentStock < amount`.
  - `releaseStock(InventoryQuantity amount)`: Reingresa existencias a los lotes en caso de cancelación de reserva.
  - `refreshLowStockAlert()`: Compara `currentStock <= minimumStock`. Si el estado cambia, emite `LowStockAlertTriggeredEvent` o `LowStockAlertClearedEvent`.

  #v(8pt)
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Entity: `ProductBatch`] \
  #text(size: 9.5pt, fill: rgb("#475569"))[*Propósito:* Entidad de dominio que representa un lote físico recibido con costo de adquisición y fecha de recepción. Clave primaria `UUID batchId`.] \
  *Atributos:* `batchId` (UUID), `initialQuantity` (InventoryQuantity), `availableQuantity` (InventoryQuantity), `acquisitionCost` (Money), `receptionDate` (Instant), `version` (Long). \
  *Comportamiento:* `deductQuantity` y `addQuantity` actualizan `availableQuantity`.
]

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.4.1.3. Creation & Reconstitution Methods (Factory Pattern)]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  - *Constructor Público `Product(...)`:* `public Product(UUID id, BranchId branchId, ProductCategory category, ProductName name, Sku sku, Money currentSellingPrice, String description, Integer minimumStock)`. Asigna `UUID.randomUUID()` si `id` es nulo, inicializa `currentStock = 0`, `lowStockAlert = false` y publica `ProductCreatedEvent`.
  - *`Product.reconstitute(...)`:* `public static Product reconstitute(UUID id, BranchId branchId, ProductCategory category, ProductName name, Sku sku, InventoryQuantity currentStock, Money currentSellingPrice, String description, Integer minimumStock, boolean lowStockAlert, Long version, List<ProductBatch> batches)`. Reconstruye el agregado desde infraestructura sin publicar eventos.
  - *`ProductBatch.forStockAdjustment(...)`:* `public static ProductBatch forStockAdjustment(int signedQuantity, Money acquisitionCost, int resultingStock)`. Reconstituye un `ProductBatch` para ajustes manuales de almacén asignando `initialQuantity = 0` y `availableQuantity = resultingStock`.
]

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.4.1.4. Domain Events]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  - `ProductCreatedEvent`: Notifica la creación de un nuevo producto en una sucursal.
  - `ProductUpdatedEvent`: Notifica la actualización de los datos del producto.
  - `StockMovementAppliedEvent`: Notifica la aplicación de un movimiento de stock manual o lote.
  - `StockReservedEvent`: Notifica la reserva exitosa de stock solicitada desde Operations.
  - `StockReleasedEvent`: Notifica la liberación de stock previamente reservado.
  - `LowStockAlertTriggeredEvent`: Notifica cuando el stock cae por debajo del mínimo configurado.
  - `LowStockAlertClearedEvent`: Notifica cuando el stock se recupera por encima del mínimo.
]

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.4.1.5. Domain Repositories (Interfaces)]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`ProductRepository` (Domain Repository Interface)] \
  *Métodos de Contrato:*
  - `Product save(Product product)`
  - `Optional<Product> findById(UUID id)`
  - `List<Product> findAllByBranchId(BranchId branchId)`
  - `List<Product> findAllByBranchIdWithFilters(BranchId branchId, String name, String category, Boolean lowStockOnly)`
  - `List<Product> findAll()`
  - `boolean existsByBranchIdAndSku(BranchId branchId, String sku)`
  - `boolean existsByBranchIdAndSkuAndIdNot(BranchId branchId, String sku, UUID productId)`
  - `boolean existsById(UUID id)`
  - `void deleteById(UUID id)`
]

#v(0.5em)

==== 2.6.4.2. Application Layer (Capa de Aplicación)

La Capa de Aplicación expone la ejecución de casos de uso utilizando `Result<T, ProductCommandFailure>` para manejo funcional de fallos y ejecuta tareas programadas para la evaluación continua de alertas.

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/inventory/inventory-app-layer.svg", width: 95%)
    ),
    caption: [Diagrama de la Capa de Aplicación -- Inventory]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.4.2.1. Commands & Queries (DTOs de Aplicación)]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Comandos de Escritura (CQRS Commands):] \
  - `CreateProductCommand(BranchId branchId, ProductCategory category, ProductName name, Sku sku, String description, Money salePrice, InventoryQuantity minimumStock)`
  - `UpdateProductCommand(UUID productId, ProductName name, ProductCategory category, Sku sku, String description, Money salePrice, InventoryQuantity minimumStock)`
  - `DeleteProductCommand(UUID productId)`
  - `AddBatchToProductCommand(UUID productId, StockMovementQuantity quantity, Money acquisitionCost)`

  #v(8pt)
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Consultas y DTOs de Resultado (CQRS Queries):] \
  - `GetProductByIdQuery(UUID productId)`
  - `GetProductsByBranchIdQuery(BranchId branchId, String name, String category, Boolean lowStockOnly)`
]

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.4.2.2. Capabilities & Scheduled Tasks]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`MinimumStockAlertEvaluationJob` (Scheduled Task / Job)] \
  *Tipo:* Proceso de fondo programado (`@Scheduled(cron = "0 0 * * * *")`). \
  *Responsabilidad:* Inspecciona el estado de existencias de todos los productos por sucursal en la base de datos, invocando directamente `product.refreshLowStockAlert()` en cada agregado para actualizar el indicador `lowStockAlert` y publicar eventos `LowStockAlertTriggeredEvent` cuando el stock disponible cae por debajo de la reserva mínima configurada.
]

#v(0.5em)

==== 2.6.4.3. Interface Layer (Capa de Interfaz / REST & Events)

Exposición RESTful e integración asíncrona mediante listeners de eventos producidos por otros Bounded Contexts.

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/inventory/inventory-interface-layer.svg", width: 95%)
    ),
    caption: [Diagrama de la Capa de Interfaz -- Inventory]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.4.3.1. Endpoints & REST Controllers]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`ProductsController` (`/api/v1/inventory/products`)] \
  - `POST /api/v1/inventory/products`: Registra un nuevo producto en el inventario de una sucursal.
  - `GET /api/v1/inventory/products?branchId={branchId}`: Consulta productos por sucursal con filtros opcionales (`name`, `category`, `lowStockOnly`).
  - `GET /api/v1/inventory/products/branch/{branchId}`: Catálogo de productos por ruta de sucursal.
  - `GET /api/v1/inventory/products/{productId}`: Consulta detalles completos de un producto incluyendo sus lotes.
  - `PUT /api/v1/inventory/products/{productId}`: Actualiza información básica del producto.
  - `DELETE /api/v1/inventory/products/{productId}`: Eliminación lógica (soft-delete vía `deleted_at`) del producto y sus lotes.
  - `POST /api/v1/inventory/products/{productId}/batches`: Registra la entrada de un nuevo lote de stock o un ajuste manual de almacén.

  #v(8pt)
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Event Listener: `InventoryStockListener`] \
  - Escucha `ProductReservedEvent` proveniente de `Operations` e invoca `product.reserveStock(amount)`.
  - Escucha `ProductReservationCanceledEvent` proveniente de `Operations` e invoca `product.releaseStock(amount)`.
]

#v(0.5em)

==== 2.6.4.4. Infrastructure Layer (Capa de Infraestructura)

Mapeo ORM relacional a PostgreSQL 18 con Spring Data JPA y configuración de Jobs programados con `@EnableScheduling`.

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/inventory/inventory-infra-layer.svg", width: 30%)
    ),
    caption: [Diagrama de la Capa de Infraestructura -- Inventory]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.4.4.1. Mapeo de Entidades Relacionales (JPA)]
]
#v(0.3em)

#block(sticky: true)[
  #text(weight: "bold", size: 9.5pt, fill: rgb("#334155"))[Tabla: `products` (`ProductJpaEntity`)]
]
#v(0.2em)
#align(center)[
  #table(
    columns: (95pt, 110pt, 1fr),
    align: (left, center, left),
    table.header([Columna], [Tipo de Dato], [Constraints / Descripción]),
    [*`id`*], [`UUID`], [`PRIMARY KEY, NOT NULL`],
    [*`branch_id`*], [`UUID`], [`NOT NULL, FOREIGN KEY -> branches(id)`],
    [*`category`*], [`VARCHAR(100)`], [`NOT NULL`],
    [*`name`*], [`VARCHAR(150)`], [`NOT NULL`],
    [*`sku`*], [`VARCHAR(100)`], [`NOT NULL, UNIQUE`],
    [*`description`*], [`TEXT`], [`NULLABLE`],
    [*`current_selling_price`*], [`NUMERIC(12,2)`], [`NOT NULL, CHECK (current_selling_price >= 0)`],
    [*`current_stock`*], [`INTEGER`], [`NOT NULL, CHECK (current_stock >= 0)`],
    [*`minimum_stock`*], [`INTEGER`], [`NOT NULL, CHECK (minimum_stock >= 0)`],
    [*`low_stock_alert`*], [`BOOLEAN`], [`NOT NULL DEFAULT false`],
    [*`created_by`*], [`UUID`], [`NOT NULL`],
    [*`updated_by`*], [`UUID`], [`NOT NULL`],
    [*`created_at`*], [`TIMESTAMP`], [`NOT NULL`],
    [*`updated_at`*], [`TIMESTAMP`], [`NOT NULL`],
    [*`deleted_at`*], [`TIMESTAMP`], [`NULLABLE (Soft Delete)`],
    [*`version`*], [`BIGINT`], [`NOT NULL`],
  )
]

#v(0.6em)

#block(sticky: true)[
  #text(weight: "bold", size: 9.5pt, fill: rgb("#334155"))[Tabla: `product_batches` (`ProductBatchJpaEntity`)]
]
#v(0.2em)
#align(center)[
  #table(
    columns: (95pt, 110pt, 1fr),
    align: (left, center, left),
    table.header([Columna], [Tipo de Dato], [Constraints / Descripción]),
    [*`id`*], [`UUID`], [`PRIMARY KEY, NOT NULL`],
    [*`product_id`*], [`UUID`], [`NOT NULL, FOREIGN KEY -> products(id)`],
    [*`branch_id`*], [`UUID`], [`NOT NULL, FOREIGN KEY -> branches(id)`],
    [*`initial_quantity`*], [`INTEGER`], [`NOT NULL, CHECK (initial_quantity > 0)`],
    [*`available_quantity`*], [`INTEGER`], [`NOT NULL, CHECK (available_quantity >= 0)`],
    [*`acquisition_cost`*], [`NUMERIC(12,2)`], [`NOT NULL, CHECK (acquisition_cost >= 0)`],
    [*`created_by`*], [`UUID`], [`NOT NULL`],
    [*`updated_by`*], [`UUID`], [`NOT NULL`],
    [*`created_at`*], [`TIMESTAMP`], [`NOT NULL`],
    [*`updated_at`*], [`TIMESTAMP`], [`NOT NULL`],
    [*`deleted_at`*], [`TIMESTAMP`], [`NULLABLE (Soft Delete)`],
    [*`version`*], [`BIGINT`], [`NOT NULL`],
  )
]

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.4.4.2. Repository Adapters & Infrastructure Components]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`ProductRepositoryAdapter` (Infrastructure Repository Adapter)] \
  *Implementa:* Contrato de dominio `ProductRepository`. \
  *Inyecta:* `ProductJpaRepository` (Spring Data JPA). \
  *Responsabilidad:* Provee persistencia relacional con aislamiento total del modelo de dominio. Realiza el mapeo bidireccional entre los agregados de dominio (`Product`, `ProductBatch`) y las entidades de persistencia JPA (`ProductJpaEntity`, `ProductBatchJpaEntity`). \
  *Métodos Clave:* `save()`, `findById()`, `findAllByBranchId()`, `findAllByBranchIdWithFilters()`, `existsByBranchIdAndSku()`, `deleteById()`.
]

#v(0.5em)

==== 2.6.4.5. Software Architecture Component Level Diagrams (C4 Model - Level 3)

El siguiente diagrama C4 descompone el Container API en sus componentes principales para el Bounded Context *Inventory*.

#v(0.5em)
#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.4.5.1. C4 Model Component Diagram (Container: Spring Boot REST API -- Inventory)]
]
#v(0.3em)

#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/inventory/inventory-c4-component.svg", width: 80%)
    ),
    caption: [Diagrama de Componentes C4 Nivel 3 -- Inventory]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.4.5.2. Descomposición y Responsabilidad de Componentes]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  - *`ProductsController` (Interface Layer):* Expone los endpoints RESTful para la creación, consulta filtrada, actualización y eliminación de productos y registro de lotes. *(Spring Web MVC, REST over HTTPS, Jackson JSON)*.
  - *`InventoryStockListener` (Interface Layer):* Escucha asíncronamente eventos de dominio emitidos por `Operations` (`ProductReservedEvent`, `ProductReservationCanceledEvent`) e invoca reglas de reserva. *(Spring Application Events)*.
  - *`MinimumStockAlertEvaluationJob` (Application Layer):* Capability programada en segundo plano que evalúa los umbrales de stock mínimo invocando `product.refreshLowStockAlert()`. *(Spring Scheduled Tasks)*.
  - *`ProductCommandService` (Application Layer):* Orquesta los comandos de creación, edición, borrado de productos y adición de lotes de inventario. *(Spring Service, Functional `Result<T, E>`)*.
  - *`ProductQueryService` (Application Layer):* Ejecuta consultas filtradas por sucursal, categoría y estado de alerta de bajo stock. *(Spring Service, Read-only Transactions)*.
  - *`ProductRepositoryAdapter` (Infrastructure Layer):* Adaptador de infraestructura que mapea agregados y entidades de dominio hacia/desde entidades relacionales JPA. *(Spring Component, JPA Hibernate Mapping)*.
  - *`ProductJpaRepository` (Infrastructure Layer):* Repositorio Spring Data JPA que interactúa directamente con PostgreSQL 18. *(Spring Data JPA, Hibernate ORM, SQL Native Queries)*.
]

#v(0.5em)

==== 2.6.4.6. Bounded Context Software Architecture Code Level Diagrams

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.4.6.1. Domain Layer Class Diagram]
]
#v(0.3em)

#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/inventory/inventory-code-domain.svg", width: 80%)
    ),
    caption: [Diagrama de Clases del Dominio UML -- Inventory]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.4.6.2. Database Design Diagram (PostgreSQL 18)]
]
#v(0.3em)

#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/inventory/inventory-erd.svg", width: 80%)
    ),
    caption: [Diagrama de Base de Datos Relacional ER -- Inventory]
  )
]

#v(0.8em)

=== 2.6.5. Bounded Context: IoT (Telemetry, Vehicles & OBD-II Devices)

El *Bounded Context `IoT`* administra la identidad telemática de los vehículos (`Vehicle`), la vinculación con sus conductores/propietarios (`VehicleRegistration`), el inventario y estado operativo de escáneres telemáticos OBD2 (`Obd2Device`), el emparejamiento activo entre escáneres y vehículos (`Obd2DeviceRegistration`), la ingesta remota de ráfagas telemáticas (`TelemetrySnapshot`), y la gestión inmutable de alertas por códigos de error computarizados (`DtcAlert` / Diagnostic Trouble Codes).

#v(0.5em)

==== 2.6.5.1. Domain Layer (Capa de Dominio)

La Capa de Dominio rige las reglas de lectura e ingesta telemática, constructores de dominio para la instanciación garantizada de Agregados (`Vehicle`, `Obd2Device`, `TelemetrySnapshot`), el servicio de contexto `ActiveRegistrationContextService`, la vinculación inmutable de dispositivos OBD2 con vehículos, las alertas automáticas según la gravedad de los códigos DTC (LOW, MEDIUM, HIGH, CRITICAL) y la validación de vin/placa vehicular.

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/iot/iot-domain-layer.svg", width: 80%)
    ),
    caption: [Diagrama de la Capa de Dominio -- IoT]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.5.1.1. Value Objects, Enums & Exceptions]
]
#v(0.3em)

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
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `Obd2DeviceStatus`] \
    *Propósito:* Estado de disponibilidad física de un escáner OBD2 en la sucursal. \
    *Valores:* `AVAILABLE`, `LINKED`, `NOT_AVAILABLE`.
  ],
  block(
    fill: rgb("#f8fafc"),
    stroke: 0.5pt + rgb("#cbd5e1"),
    radius: 4pt,
    inset: 8pt,
    width: 100%
  )[
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `Obd2RegistrationStatus`] \
    *Propósito:* Estado del acoplamiento entre un escáner OBD2 y un vehículo. \
    *Valores:* `ACTIVE`, `INACTIVE`.
  ],
  block(
    fill: rgb("#f8fafc"),
    stroke: 0.5pt + rgb("#cbd5e1"),
    radius: 4pt,
    inset: 8pt,
    width: 100%
  )[
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `VehicleRegistrationStatus`] \
    *Propósito:* Estado de la vinculación entre un usuario conductor y un vehículo. \
    *Valores:* `ACTIVE`, `PREVIOUS`.
  ],
  block(
    fill: rgb("#f8fafc"),
    stroke: 0.5pt + rgb("#cbd5e1"),
    radius: 4pt,
    inset: 8pt,
    width: 100%
  )[
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `DtcAlertSeverity`] \
    *Propósito:* Severidad del código de error de diagnóstico telemático. \
    *Valores:* `LOW`, `MEDIUM`, `HIGH`, `CRITICAL`.
  ]
)

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.5.1.2. Aggregates & Entities]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  - *Aggregate Root `Vehicle`:* Representa un automóvil del parque vehicular. Valida placa, marca, modelo, VIN y año (1900 a año actual + 1). Emite `VehicleDetailsUpdatedEvent`.
  - *Aggregate Root `VehicleRegistration`:* Enlace entre un conductor (`userId`) y vehículo (`vehicleId`). Método `deactivateRegistration()` emite `VehicleRegistrationDeactivatedEvent`.
  - *Aggregate Root `Obd2Device`:* Dispositivo físico de diagnóstico registrado en sucursal. Métodos `ping()`, `markAsLinked()`, `markAsAvailable()`. Emite `Obd2DeviceStatusChangedEvent`.
  - *Aggregate Root `Obd2DeviceRegistration`:* Emparejamiento activo escáner-vehículo. Método `deactivate()` emite `Obd2DeviceRegistrationDeactivatedEvent`.
  - *Aggregate Root `TelemetrySnapshot`:* Captura puntual e inmutable de parámetros de motor (RPM, temperatura, velocidad km/h, odómetro, combustible %).
  - *Aggregate Root `DtcAlert`:* Alerta de falla computarizada generada por el escáner (código DTC, descripción y severidad). Emite `DtcAlertTriggeredEvent`.
]

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.5.1.3. Domain Events]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  - `VehicleDetailsUpdatedEvent`: Notifica actualización de datos de un vehículo.
  - `VehicleRegistrationDeactivatedEvent`: Notifica desvinculación de un conductor con un vehículo.
  - `Obd2DeviceStatusChangedEvent`: Notifica cambios de estado de un escáner OBD2 (AVAILABLE / LINKED).
  - `Obd2DeviceRegistrationDeactivatedEvent`: Notifica la desvinculación de un escáner OBD2 de un vehículo.
  - `DtcAlertTriggeredEvent`: Notifica la detección de una falla telemática DTC en tiempo real.
]

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.5.1.4. Domain Repositories (Interfaces)]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  - *`VehicleRepository`:* `save()`, `findById()`, `findByVin()`, `findByPlateNumber()`, `delete()`, `findAllByIds()`.
  - *`VehicleRegistrationRepository`:* `save()`, `findActiveByVehicleId()`, `findAllActiveByUserId()`, `findAllActiveByUserIds()`.
  - *`Obd2DeviceRepository`:* `save()`, `findById()`, `findByMacAddress()`, `existsByMacAddress()`, `delete()`, `findAllByBranchId()`, `findAllByBranchIdAndStatus()`.
  - *`Obd2DeviceRegistrationRepository`:* `save()`, `findById()`, `findActiveByObd2DeviceId()`, `findActiveByVehicleId()`, `findAllByBranchIdAndStatus()`, `findVehicleIdsWithActiveRegistration()`.
  - *`TelemetrySnapshotRepository`:* `save()`, `saveAll()`, `findById()`, `findLatestByRegistrationId()`, `findAllByRegistrationId()`, `findAllByRegistrationIdAndCreatedAtGreaterThanEqual()`.
  - *`DtcAlertRepository`:* `save()`, `saveAll()`, `findAllByRegistrationId()`, `findAllByRegistrationIdAndCreatedAtGreaterThanEqual()`.
]

#v(0.5em)

==== 2.6.5.2. Application Layer (Capa de Aplicación)

La Capa de Aplicación expone la ingesta de telemetría, emparejamiento de escáneres y consulta de alertas de motor.

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/iot/iot-app-layer.svg", width: 95%)
    ),
    caption: [Diagrama de la Capa de Aplicación -- IoT]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.5.2.1. Commands & Queries (DTOs de Aplicación)]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Comandos de Escritura (CQRS Commands):] \
  - `RegisterVehicleCommand`, `UpdateVehicleCommand`, `DeleteVehicleCommand`
  - `CreateObd2DeviceCommand`, `UpdateObd2DeviceCommand`, `DeleteObd2DeviceCommand`
  - `LinkObd2DeviceToVehicleCommand`, `DeactivateObd2DeviceRegistrationCommand`
  - `IngestTelemetryBatchCommand`

  #v(8pt)
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Consultas y DTOs de Resultado (CQRS Queries):] \
  - `GetVehicleByIdQuery`, `GetActiveVehiclesByCustomerIdQuery`, `GetVehiclesAvailableForLinkingQuery`
  - `GetObd2DeviceByIdQuery`, `GetObd2DevicesByBranchIdQuery`, `GetAvailableObd2DevicesQuery`
  - `GetObd2DeviceRegistrationsByBranchIdAndStatusQuery`
  - `GetLatestTelemetrySnapshotQuery`, `GetTelemetrySnapshotHistoryQuery`, `GetTelemetrySnapshotsByRegistrationIdQuery`, `GetVehicleTelemetrySnapshotHistoryQuery`
  - `GetDtcAlertsByRegistrationIdQuery`, `GetVehicleDtcAlertHistoryQuery`
]

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.5.2.2. Command Failure ADTs (Sealed Interfaces)]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  - `VehicleCommandFailure`: `NotFound`, `InvalidState`, `Duplicate`
  - `Obd2DeviceCommandFailure`: `NotFound`, `InvalidState`, `Duplicate`
  - `Obd2DeviceRegistrationCommandFailure`: `NotFound`, `InvalidState`
  - `TelemetryCommandFailure`: `NotFound`, `InvalidState`
]

#v(0.5em)

==== 2.6.5.3. Interface Layer (Capa de Interfaz / REST)

Exposición RESTful para ingesta telemática, alertas de motor y catálogo de vehículos.

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/iot/iot-interface-layer.svg", width: 95%)
    ),
    caption: [Diagrama de la Capa de Interfaz -- IoT]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.5.3.1. Endpoints & REST Controllers]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  - *`VehiclesController` (`/api/v1/vehicles`):* `GET /` (filtro catálogo), `GET /{id}`, `POST /` (registro), `PUT /{id}`, `DELETE /{id}`, `GET /{vehicleId}/telemetry-snapshots`, `GET /{vehicleId}/dtc-alerts`.
  - *`CustomerVehiclesController` (`/api/v1/customers/{customerId}/vehicles`):* `GET /` (vehículos activos del cliente).
  - *`Obd2DevicesController` (`/api/v1/obd2-devices`):* `POST /`, `GET /{id}`, `DELETE /{id}`, `PUT /{id}`, `GET /` (filtro sucursal), `GET /{id}/telemetry-snapshots/latest`, `GET /{id}/telemetry-snapshots`.
  - *`Obd2DeviceRegistrationsController` (`/api/v1/obd2-device-registrations`):* `POST /` (vincular), `PATCH /{id}` (desactivar), `GET /` (listar sucursal/estado), `GET /{id}/telemetry-snapshots`, `GET /{id}/dtc-alerts`.
  - *`TelemetryBatchesController` (`/api/v1/telemetry-batches`):* `POST /` (ingesta masiva de hardware OBD2).
]

#v(0.5em)

==== 2.6.5.4. Infrastructure Layer (Capa de Infraestructura)

Mapeo relacional JPA a PostgreSQL 18 con adaptadores de repositorio, ensambladores de persistencia y listeners de eventos de dominio.

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/iot/iot-infra-layer.svg", width: 80%)
    ),
    caption: [Diagrama de la Capa de Infraestructura -- IoT]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.5.4.1. Mapeo de Entidades Relacionales (JPA)]
]
#v(0.3em)

#block(sticky: true)[
  #text(weight: "bold", size: 9.5pt, fill: rgb("#334155"))[Tabla: `vehicles` (`VehiclePersistenceEntity`)]
]
#v(0.2em)
#align(center)[
  #table(
    columns: (95pt, 110pt, 1fr),
    align: (left, center, left),
    table.header([Columna], [Tipo de Dato], [Constraints / Descripción]),
    [*`id`*], [`UUID`], [`PRIMARY KEY, NOT NULL`],
    [*`plate_number`*], [`VARCHAR(20)`], [`NOT NULL`],
    [*`brand`*], [`VARCHAR(50)`], [`NOT NULL`],
    [*`model`*], [`VARCHAR(50)`], [`NOT NULL`],
    [*`year`*], [`INTEGER`], [`NOT NULL`],
    [*`vin`*], [`VARCHAR(50)`], [`NOT NULL`],
    [*`created_at`*], [`TIMESTAMP`], [`NOT NULL`],
    [*`updated_at`*], [`TIMESTAMP`], [`NOT NULL`],
    [*`deleted_at`*], [`TIMESTAMP`], [`NULLABLE (Soft Delete)`],
    [*`version`*], [`BIGINT`], [`NOT NULL`],
  )
]

#v(0.6em)

#block(sticky: true)[
  #text(weight: "bold", size: 9.5pt, fill: rgb("#334155"))[Tabla: `vehicle_registrations` (`VehicleRegistrationPersistenceEntity`)]
]
#v(0.2em)
#align(center)[
  #table(
    columns: (95pt, 110pt, 1fr),
    align: (left, center, left),
    table.header([Columna], [Tipo de Dato], [Constraints / Descripción]),
    [*`id`*], [`UUID`], [`PRIMARY KEY, NOT NULL`],
    [*`user_id`*], [`UUID`], [`NOT NULL`],
    [*`vehicle_id`*], [`UUID`], [`NOT NULL, FOREIGN KEY -> vehicles(id)`],
    [*`status`*], [`VARCHAR(20)`], [`NOT NULL (ACTIVE / PREVIOUS)`],
    [*`deleted_at`*], [`TIMESTAMP`], [`NULLABLE (Soft Delete)`],
  )
]

#v(0.6em)

#block(sticky: true)[
  #text(weight: "bold", size: 9.5pt, fill: rgb("#334155"))[Tabla: `obd2_devices` (`Obd2DevicePersistenceEntity`)]
]
#v(0.2em)
#align(center)[
  #table(
    columns: (95pt, 110pt, 1fr),
    align: (left, center, left),
    table.header([Columna], [Tipo de Dato], [Constraints / Descripción]),
    [*`id`*], [`UUID`], [`PRIMARY KEY, NOT NULL`],
    [*`branch_id`*], [`UUID`], [`NOT NULL, FOREIGN KEY -> branches(id)`],
    [*`mac_address`*], [`VARCHAR(50)`], [`NOT NULL, UNIQUE`],
    [*`last_ping`*], [`TIMESTAMP`], [`NULLABLE`],
    [*`status`*], [`VARCHAR(20)`], [`NOT NULL (AVAILABLE / LINKED)`],
  )
]

#v(0.6em)

#block(sticky: true)[
  #text(weight: "bold", size: 9.5pt, fill: rgb("#334155"))[Tabla: `obd2_device_registrations` (`Obd2DeviceRegistrationPersistenceEntity`)]
]
#v(0.2em)
#align(center)[
  #table(
    columns: (95pt, 110pt, 1fr),
    align: (left, center, left),
    table.header([Columna], [Tipo de Dato], [Constraints / Descripción]),
    [*`id`*], [`UUID`], [`PRIMARY KEY, NOT NULL`],
    [*`obd2_device_id`*], [`UUID`], [`NOT NULL, FOREIGN KEY -> obd2_devices(id)`],
    [*`branch_id`*], [`UUID`], [`NOT NULL, FOREIGN KEY -> branches(id)`],
    [*`vehicle_id`*], [`UUID`], [`NOT NULL, FOREIGN KEY -> vehicles(id)`],
    [*`status`*], [`VARCHAR(20)`], [`NOT NULL (ACTIVE / INACTIVE)`],
    [*`deleted_at`*], [`TIMESTAMP`], [`NULLABLE (Soft Delete)`],
  )
]

#v(0.6em)

#block(sticky: true)[
  #text(weight: "bold", size: 9.5pt, fill: rgb("#334155"))[Tabla: `telemetry_snapshots` (`TelemetrySnapshotPersistenceEntity`)]
]
#v(0.2em)
#align(center)[
  #table(
    columns: (95pt, 110pt, 1fr),
    align: (left, center, left),
    table.header([Columna], [Tipo de Dato], [Constraints / Descripción]),
    [*`id`*], [`UUID`], [`PRIMARY KEY, NOT NULL`],
    [*`obd2_device_registration_id`*], [`UUID`], [`NOT NULL, FOREIGN KEY -> obd2_device_registrations(id)`],
    [*`branch_id`*], [`UUID`], [`NOT NULL`],
    [*`rpm`*], [`INTEGER`], [`NOT NULL`],
    [*`temperature`*], [`INTEGER`], [`NOT NULL`],
    [*`speed_kmh`*], [`DOUBLE PRECISION`], [`NOT NULL`],
    [*`odometer_km`*], [`INTEGER`], [`NOT NULL`],
    [*`fuel_level_percent`*], [`DOUBLE PRECISION`], [`NOT NULL`],
    [*`created_at`*], [`TIMESTAMP`], [`NOT NULL`],
  )
]

#v(0.6em)

#block(sticky: true)[
  #text(weight: "bold", size: 9.5pt, fill: rgb("#334155"))[Tabla: `dtc_alerts` (`DtcAlertPersistenceEntity`)]
]
#v(0.2em)
#align(center)[
  #table(
    columns: (95pt, 110pt, 1fr),
    align: (left, center, left),
    table.header([Columna], [Tipo de Dato], [Constraints / Descripción]),
    [*`id`*], [`UUID`], [`PRIMARY KEY, NOT NULL`],
    [*`telemetry_snapshot_id`*], [`UUID`], [`NOT NULL, FOREIGN KEY -> telemetry_snapshots(id)`],
    [*`branch_id`*], [`UUID`], [`NOT NULL`],
    [*`dtc_code`*], [`VARCHAR(20)`], [`NOT NULL`],
    [*`description`*], [`TEXT`], [`NULLABLE`],
    [*`severity`*], [`VARCHAR(20)`], [`NOT NULL (LOW/MEDIUM/HIGH/CRITICAL)`],
    [*`created_at`*], [`TIMESTAMP`], [`NOT NULL`],
  )
]

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.5.4.2. Adapters & Infrastructure Components]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  - *Persistence Adapters:* `VehicleRepositoryImpl`, `VehicleRegistrationRepositoryImpl`, `Obd2DeviceRepositoryImpl`, `Obd2DeviceRegistrationRepositoryImpl`, `TelemetrySnapshotRepositoryImpl`, `DtcAlertRepositoryImpl`.
  - *Assemblers de Persistencia:* `VehiclePersistenceAssembler`, `VehicleRegistrationPersistenceAssembler`, `Obd2DevicePersistenceAssembler`, `Obd2DeviceRegistrationPersistenceAssembler`, `TelemetrySnapshotPersistenceAssembler`, `DtcAlertPersistenceAssembler`.
  - *Outbound Services / Ports:* `CustomerDirectoryPortImpl` (ACL para validación de clientes en Core), `ActiveRegistrationContextServiceImpl` (resolución de contexto activo escáner-vehículo).
  - *Event Listeners:* `DtcAlertEventListener` (escucha `DtcAlertTriggeredEvent` para integración con Órdenes de Trabajo).
]

#v(0.5em)

==== 2.6.5.5. Software Architecture Component Level Diagrams (C4 Model - Level 3)

Descomposición del Container API en sus componentes principales para el Bounded Context *IoT*.

#v(0.5em)
#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.5.5.1. C4 Model Component Diagram (Container: Spring Boot REST API -- IoT)]
]
#v(0.3em)

#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/iot/iot-c4-component.svg", width: 80%)
    ),
    caption: [Diagrama de Componentes C4 Nivel 3 -- IoT]
  )
]
#v(0.5em)

==== 2.6.5.6. Bounded Context Software Architecture Code Level Diagrams

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.5.6.1. Domain Layer Class Diagram]
]
#v(0.3em)

#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/iot/iot-code-domain.svg", width: 80%)
    ),
    caption: [Diagrama de Clases del Dominio UML -- IoT]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.5.6.2. Database Design Diagram (PostgreSQL 18)]
]
#v(0.3em)

#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/iot/iot-erd.svg", width: 60%)
    ),
    caption: [Diagrama de Base de Datos Relacional ER -- IoT]
  )
]



=== 2.6.6. Bounded Context: Core (Profiles, Workshops & Branches)

El Bounded Context *Core* constituye el núcleo relacional y organizacional de la plataforma *ShiftIQ*. Gestiona la identidad de los perfiles operacionales de los usuarios (`Customer`, `Employee`, `Owner`), las organizaciones y talleres mecánicos (`Workshop`), sus sedes o sucursales físicas (`Branch`), así como el modelo de monetización y suscripciones de la plataforma (`SubscriptionPlan`, `BranchSubscription`).

#v(0.5em)

==== 2.6.6.1. Domain Layer (Capa de Dominio)

La Capa de Dominio define el modelo de negocio inmutable, encapsulando reglas de validación, agregados principales, objetos de valor (Value Objects), métodos de creación (fábricas / constructores), eventos de dominio e interfaces de repositorios agnósticas a la tecnología de persistencia.

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/core/core-domain-layer.svg", width: 80%)
    ),
    caption: [Diagrama de la Capa de Dominio -- Core]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.6.1.1. Value Objects, Enums & Exceptions]
]
#v(0.3em)

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
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `Document`] \
    #text(size: 9.5pt, fill: rgb("#475569"))[`(DocumentType documentType, String documentNumber)`] \
    *Propósito:* Encapsula la identidad legal del sujeto. \
    *Validaciones:* `documentType` no nulo \ (`core.error.documentType.notNull`); \ `documentNumber` no nulo ni en blanco \ (`core.error.documentNumber.notBlank`).
  ],
  block(
    fill: rgb("#f8fafc"),
    stroke: 0.5pt + rgb("#cbd5e1"),
    radius: 4pt,
    inset: 8pt,
    width: 100%
  )[
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `PersonName`] \
    #text(size: 9.5pt, fill: rgb("#475569"))[`(String firstName, String lastName)`] \
    *Propósito:* Nombre y apellidos de personas naturales. \
    *Validaciones:* `firstName` y `lastName` no nulos ni vacíos. Método `getFullName()`.
  ]
)

#v(0.4em)

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
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `Phone`] \
    #text(size: 9.5pt, fill: rgb("#475569"))[`(String value)`] \
    *Propósito:* Número telefónico de contacto. \
    *Validaciones:* No nulo ni en blanco (`core.error.phone.required`).
  ],
  block(
    fill: rgb("#f8fafc"),
    stroke: 0.5pt + rgb("#cbd5e1"),
    radius: 4pt,
    inset: 8pt,
    width: 100%
  )[
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `TaxId`] \
    #text(size: 9.5pt, fill: rgb("#475569"))[`(String value)`] \
    *Propósito:* Identificador tributario (RUC de 11 dígitos). \
    *Validaciones:* Exactamente 11 dígitos numéricos (`core.error.taxId.invalid`).
  ]
)

#v(0.4em)

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
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `CreditCard`] \
    #text(size: 9.5pt, fill: rgb("#475569"))[`(cardNumber, cardHolderName, expirationDate, cvv)`] \
    *Propósito:* Datos de tarjeta para cobro simulado de suscripciones. \
    *Validaciones:* 16 dígitos, formato `MM/YY`, `cvv` de 3 dígitos.
  ],
  block(
    fill: rgb("#f8fafc"),
    stroke: 0.5pt + rgb("#cbd5e1"),
    radius: 4pt,
    inset: 8pt,
    width: 100%
  )[
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `MileageIntervalConfig`] \
    #text(size: 9.5pt, fill: rgb("#475569"))[`(int value)`] \
    *Propósito:* Intervalo de kilometraje para mantenimientos sugeridos del taller. \
    *Validaciones:* Entero estrictamente positivo \ (`core.error.mileageIntervalConfig.mustBePositive`).
  ]
)

#v(0.4em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 8pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Strongly Typed IDs & Enumerations] \
  - *Typed IDs:* `UserId`, `CustomerId`, `EmployeeId`, `OwnerId`, `WorkshopId`, `BranchId`, `BranchSubscriptionId`, `SubscriptionPlanId` (encapsulan `UUID`).
  - *Enum `DocumentType`:* `DNI`, `RUC`, `CE`, `PASSPORT`.
  - *Enum `SubscriptionStatus`:* `ACTIVE`, `CANCELED`, `EXPIRED`.
  - *Enum `BillingCycle`:* `MONTHLY`, `ANNUAL`.
]

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.6.1.2. Aggregates & Entities]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`Customer` (Aggregate Root)] \
  #text(size: 9.5pt, fill: rgb("#475569"))[*Tipo:* Raíz de Agregado (`extends AbstractDomainAggregateRoot<Customer>`)] \
  *Propósito:* Agregado para clientes del sistema (persona natural `isCorporate = false` o persona jurídica `isCorporate = true`). \
  #v(4pt)
  *Atributos:* `id` (`CustomerId`), `userId` (`UserId`), `isCorporate` (`boolean`), `name` (`PersonName`), `businessName` (`String`), `document` (`Document`), `phone` (`Phone`). \
  #v(4pt)
  *Reglas de Negocio & Métodos:* Si es corporativo, `businessName` es obligatorio. En actualizaciones, el tipo de documento corporativo es inmutable. Emite `CustomerCreatedEvent` y `CustomerUpdatedEvent`.
]

#v(0.4em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`Employee` (Aggregate Root)] \
  #text(size: 9.5pt, fill: rgb("#475569"))[*Tipo:* Raíz de Agregado (`extends AbstractDomainAggregateRoot<Employee>`)] \
  *Propósito:* Agregado para perfiles de empleados y personal técnico del taller vinculados a un `UserId`. \
  #v(4pt)
  *Atributos:* `id` (`EmployeeId`), `userId` (`UserId`), `name` (`PersonName`), `document` (`Document`), `phone` (`Phone`). \
  #v(4pt)
  *Métodos:* `update(PersonName, Document, Phone)`. Emite `EmployeeCreatedEvent` y `EmployeeUpdatedEvent`.
]

#v(0.4em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`Owner` (Aggregate Root)] \
  #text(size: 9.5pt, fill: rgb("#475569"))[*Tipo:* Raíz de Agregado (`extends AbstractDomainAggregateRoot<Owner>`)] \
  *Propósito:* Agregado para propietarios y dueños de talleres automotrices. \
  #v(4pt)
  *Atributos:* `id` (`OwnerId`), `userId` (`UserId`), `name` (`PersonName`), `document` (`Document`), `phone` (`Phone`). \
  #v(4pt)
  *Métodos:* `update(PersonName, Document, Phone)`. Emite `OwnerCreatedEvent` y `OwnerUpdatedEvent`.
]

#v(0.4em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`Workshop` (Aggregate Root)] \
  #text(size: 9.5pt, fill: rgb("#475569"))[*Tipo:* Raíz de Agregado (`extends AbstractDomainAggregateRoot<Workshop>`)] \
  *Propósito:* Representa la empresa o taller mecánico comercial propiedad de un `Owner`. \
  #v(4pt)
  *Atributos:* `id` (`WorkshopId`), `ownerId` (`OwnerId`), `businessName` (`String`), `brandName` (`String`), `taxId` (`TaxId`), `mileageIntervalConfig` (`MileageIntervalConfig`). \
  #v(4pt)
  *Reglas de Negocio:* `businessName` y `brandName` requeridos. Emite `WorkshopCreatedEvent` y `WorkshopUpdatedEvent`.
]

#v(0.4em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`Branch` & `BranchSubscription` (Aggregates)] \
  - *`Branch`:* Representa cada sucursal física (`BranchId`, `WorkshopId`, `code`, `name`, `address`, `phone`). Code único requerido. Emite `BranchCreatedEvent` y `BranchUpdatedEvent`.
  - *`BranchSubscription`:* Suscripción contratada (`BranchSubscriptionId`, `BranchId`, `SubscriptionPlanId`, `status`, `billingCycle`, `startDate`, `endDate`). Calcula `endDate` automáticamente (+1 mes / +12 meses). `cancel(Instant)` cambia estado a `CANCELED`.
  - *`SubscriptionPlan`:* Plan de comercialización SaaS (`SubscriptionPlanId`, `name`, `monthlyPrice`, `maxObd2Devices`, `maxMonthlySnapshotsPerVehicle`, `maxCustomers`, `maxStaffAccounts`, `isActive`).
]

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.6.1.3. Domain Repositories (Interfaces)]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Interfaces de Repositorio del Dominio Core:] \
  - `CustomerRepository`: `save(Customer)`, `findById(CustomerId)`, `findByUserId(UserId)`, `existsByUserId(UserId)`, `findByDocumentNumber(String)`, `findProfileRolesByUserId(UserId)`, `delete(Customer)`.
  - `EmployeeRepository`: `save(Employee)`, `findById(EmployeeId)`, `findByUserId(UserId)`, `existsByUserId(UserId)`, `findByDocumentNumber(String)`, `delete(Employee)`.
  - `OwnerRepository`: `save(Owner)`, `findById(OwnerId)`, `findByUserId(UserId)`, `existsById(OwnerId)`, `existsByUserId(UserId)`, `findByDocumentNumber(String)`, `delete(Owner)`.
  - `WorkshopRepository`: `save(Workshop)`, `findById(WorkshopId)`, `findAllByOwnerId(OwnerId)`, `existsById(WorkshopId)`.
  - `BranchRepository`: `save(Branch)`, `findById(BranchId)`, `findAllByWorkshopId(WorkshopId)`, `existsById(BranchId)`, `existsByCode(String)`.
  - `BranchSubscriptionRepository`: `save(BranchSubscription)`, `findById(BranchSubscriptionId)`, `findAllByBranchId(BranchId)`, `findActiveByBranchId(BranchId)`.
  - `SubscriptionPlanRepository`: `save(SubscriptionPlan)`, `findById(SubscriptionPlanId)`, `findByName(String)`, `findAll()`.
]

#v(0.5em)

==== 2.6.6.2. Application Layer (Capa de Aplicación)

La Capa de Aplicación orquesta los casos de uso, transformando los Commands y Queries provenientes de la capa de interfaz en operaciones del modelo de dominio.

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/core/core-app-layer.svg", width: 95%)
    ),
    caption: [Diagrama de la Capa de Aplicación -- Core]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.6.2.1. Commands & Queries (DTOs)]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Comandos de Escritura (CQRS Commands):] \
  - `CreateCustomerCommand(...)`, `UpdateCustomerCommand(...)`, `DeleteCustomerCommand(...)`
  - `CreateEmployeeCommand(...)`, `UpdateEmployeeCommand(...)`, `DeleteEmployeeCommand(...)`
  - `CreateOwnerCommand(...)`, `UpdateOwnerCommand(...)`, `DeleteOwnerCommand(...)`
  - `CreateWorkshopCommand(...)`, `UpdateWorkshopCommand(...)`
  - `CreateBranchCommand(...)`, `UpdateBranchCommand(...)`
  - `AssignSubscriptionCommand(BranchId, SubscriptionPlanId, BillingCycle, CreditCard)`
  - `CancelSubscriptionCommand(BranchId)`

  #v(8pt)
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Consultas y DTOs de Resultado (CQRS Queries & Responses):] \
  - `GetCustomerByIdQuery`, `GetCustomerByUserIdQuery`
  - `GetEmployeeByIdQuery`, `GetEmployeeByUserIdQuery`, `GetEmployeeByDocumentNumberQuery`
  - `GetOwnerByIdQuery`, `GetOwnerByUserIdQuery`
  - `GetWorkshopByIdQuery`, `GetAllWorkshopsByOwnerIdQuery`
  - `GetBranchByIdQuery`, `GetAllBranchesByWorkshopIdQuery`
  - `GetProfileRolesByUserIdQuery`, `GetProfileByDocumentNumberQuery`
  - `ProfileSummary(profileId, userId, firstName, lastName, documentType, documentNumber, profileType)`
]

#v(0.5em)

==== 2.6.6.3. Interface Layer (Capa de Interfaz / REST)

Expone los servicios de la plataforma a través de una API RESTful documentada con Swagger/OpenAPI y protegida mediante Spring Security.

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/core/core-interface-layer.svg", width: 95%)
    ),
    caption: [Diagrama de la Capa de Interfaz -- Core]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.6.3.1. Endpoints & REST Controllers]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`ProfilesController` (`/api/v1/profiles`)] \
  - `GET /api/v1/profiles/roles?userId={userId}`: Retorna lista de roles asignados al usuario (ej. `["CUSTOMER", "OWNER"]`).
  - `GET /api/v1/profiles?documentNumber={documentNumber}`: Búsqueda rápida de perfil por DNI/RUC.

  #v(6pt)
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`CustomersController` (`/api/v1/customers`)] \
  - `POST /api/v1/customers`: Registra perfil de cliente (natural o corporativo).
  - `GET /api/v1/customers?userId={userId}` / `GET /api/v1/customers/{customerId}`: Consultas de clientes.
  - `PUT /api/v1/customers/{customerId}` / `DELETE /api/v1/customers/{customerId}`: Actualización y borrado lógico.

  #v(6pt)
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`EmployeesController` & `OwnersController`] \
  - CRUD completo para perfiles de empleados (`/api/v1/employees`) y dueños de taller (`/api/v1/owners`).

  #v(6pt)
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`WorkshopsController` & `BranchesController`] \
  - `POST /api/v1/workshops` & `GET /api/v1/workshops?ownerId={ownerId}`: Gestión de talleres.
  - `POST /api/v1/branches`, `GET /api/v1/branches?workshopId={workshopId}`, `POST /api/v1/branches/{branchId}/subscriptions`, `DELETE /api/v1/branches/{branchId}/subscription`: Gestión de sucursales y suscripciones.
]

#v(0.5em)

==== 2.6.6.4. Infrastructure Layer (Capa de Infraestructura)

Implementa la persistencia física en PostgreSQL 18 utilizando Spring Data JPA, mapeando entidades de dominio inmutables a entidades de tabla relacional.

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/core/core-infra-layer.svg", width: 80%)
    ),
    caption: [Diagrama de la Capa de Infraestructura -- Core]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.6.4.1. Mapeo de Entidades Relacionales (JPA)]
]
#v(0.3em)

#block(sticky: true)[
  #text(weight: "bold", size: 9.5pt, fill: rgb("#334155"))[Tabla: `customers` (`CustomerPersistenceEntity`)]
]
#v(0.2em)
#align(center)[
  #table(
    columns: (95pt, 110pt, 1fr),
    align: (left, center, left),
    table.header([Columna], [Tipo de Dato], [Constraints / Descripción]),
    [*`id`*], [`UUID`], [`PRIMARY KEY, NOT NULL`],
    [*`user_id`*], [`UUID`], [`NOT NULL, UNIQUE`],
    [*`is_corporate`*], [`BOOLEAN`], [`NOT NULL`],
    [*`first_name`*], [`VARCHAR`], [`NOT NULL`],
    [*`last_name`*], [`VARCHAR`], [`NOT NULL`],
    [*`business_name`*], [`VARCHAR`], [`NULLABLE`],
    [*`document_type`*], [`VARCHAR`], [`NOT NULL`],
    [*`document_number`*], [`VARCHAR`], [`NOT NULL`],
    [*`phone`*], [`VARCHAR`], [`NOT NULL`],
    [*`created_at`*], [`TIMESTAMP`], [`NOT NULL`],
    [*`updated_at`*], [`TIMESTAMP`], [`NOT NULL`],
    [*`deleted_at`*], [`TIMESTAMP`], [`NULLABLE (Soft Delete)`],
    [*`version`*], [`BIGINT`], [`NOT NULL`]
  )
]

#v(0.4em)

#block(sticky: true)[
  #text(weight: "bold", size: 9.5pt, fill: rgb("#334155"))[Tabla: `employees` (`EmployeePersistenceEntity`)]
]
#v(0.2em)
#align(center)[
  #table(
    columns: (95pt, 110pt, 1fr),
    align: (left, center, left),
    table.header([Columna], [Tipo de Dato], [Constraints / Descripción]),
    [*`id`*], [`UUID`], [`PRIMARY KEY, NOT NULL`],
    [*`user_id`*], [`UUID`], [`NOT NULL, UNIQUE`],
    [*`first_name`*], [`VARCHAR`], [`NOT NULL`],
    [*`last_name`*], [`VARCHAR`], [`NOT NULL`],
    [*`document_type`*], [`VARCHAR`], [`NOT NULL`],
    [*`document_number`*], [`VARCHAR`], [`NOT NULL`],
    [*`phone`*], [`VARCHAR`], [`NOT NULL`],
    [*`created_at`*], [`TIMESTAMP`], [`NOT NULL`],
    [*`updated_at`*], [`TIMESTAMP`], [`NOT NULL`],
    [*`deleted_at`*], [`TIMESTAMP`], [`NULLABLE (Soft Delete)`],
    [*`version`*], [`BIGINT`], [`NOT NULL`]
  )
]

#v(0.4em)

#block(sticky: true)[
  #text(weight: "bold", size: 9.5pt, fill: rgb("#334155"))[Tabla: `owners` (`OwnerPersistenceEntity`)]
]
#v(0.2em)
#align(center)[
  #table(
    columns: (95pt, 110pt, 1fr),
    align: (left, center, left),
    table.header([Columna], [Tipo de Dato], [Constraints / Descripción]),
    [*`id`*], [`UUID`], [`PRIMARY KEY, NOT NULL`],
    [*`user_id`*], [`UUID`], [`NOT NULL, UNIQUE`],
    [*`first_name`*], [`VARCHAR`], [`NOT NULL`],
    [*`last_name`*], [`VARCHAR`], [`NOT NULL`],
    [*`document_type`*], [`VARCHAR`], [`NOT NULL`],
    [*`document_number`*], [`VARCHAR`], [`NOT NULL`],
    [*`phone`*], [`VARCHAR`], [`NOT NULL`],
    [*`created_at`*], [`TIMESTAMP`], [`NOT NULL`],
    [*`updated_at`*], [`TIMESTAMP`], [`NOT NULL`],
    [*`deleted_at`*], [`TIMESTAMP`], [`NULLABLE (Soft Delete)`],
    [*`version`*], [`BIGINT`], [`NOT NULL`]
  )
]

#v(0.4em)

#block(sticky: true)[
  #text(weight: "bold", size: 9.5pt, fill: rgb("#334155"))[Tabla: `workshops` (`WorkshopPersistenceEntity`)]
]
#v(0.2em)
#align(center)[
  #table(
    columns: (95pt, 110pt, 1fr),
    align: (left, center, left),
    table.header([Columna], [Tipo de Dato], [Constraints / Descripción]),
    [*`id`*], [`UUID`], [`PRIMARY KEY, NOT NULL`],
    [*`owner_id`*], [`UUID`], [`NOT NULL, FOREIGN KEY (owners.id)`],
    [*`business_name`*], [`VARCHAR`], [`NOT NULL`],
    [*`brand_name`*], [`VARCHAR`], [`NOT NULL`],
    [*`tax_id`*], [`VARCHAR`], [`NOT NULL`],
    [*`mileage_interval_config`*], [`INTEGER`], [`NOT NULL`],
    [*`created_at`*], [`TIMESTAMP`], [`NOT NULL`],
    [*`updated_at`*], [`TIMESTAMP`], [`NOT NULL`],
    [*`deleted_at`*], [`TIMESTAMP`], [`NULLABLE (Soft Delete)`],
    [*`version`*], [`BIGINT`], [`NOT NULL`]
  )
]

#v(0.4em)

#block(sticky: true)[
  #text(weight: "bold", size: 9.5pt, fill: rgb("#334155"))[Tabla: `branches` (`BranchPersistenceEntity`)]
]
#v(0.2em)
#align(center)[
  #table(
    columns: (95pt, 110pt, 1fr),
    align: (left, center, left),
    table.header([Columna], [Tipo de Dato], [Constraints / Descripción]),
    [*`id`*], [`UUID`], [`PRIMARY KEY, NOT NULL`],
    [*`workshop_id`*], [`UUID`], [`NOT NULL, FOREIGN KEY (workshops.id)`],
    [*`code`*], [`VARCHAR`], [`NOT NULL, UNIQUE`],
    [*`name`*], [`VARCHAR`], [`NOT NULL`],
    [*`address`*], [`VARCHAR`], [`NOT NULL`],
    [*`phone`*], [`VARCHAR`], [`NOT NULL`],
    [*`created_by`*], [`UUID`], [`NOT NULL`],
    [*`updated_by`*], [`UUID`], [`NOT NULL`],
    [*`created_at`*], [`TIMESTAMP`], [`NOT NULL`],
    [*`updated_at`*], [`TIMESTAMP`], [`NOT NULL`],
    [*`deleted_at`*], [`TIMESTAMP`], [`NULLABLE (Soft Delete)`],
    [*`version`*], [`BIGINT`], [`NOT NULL`]
  )
]

#v(0.4em)

#block(sticky: true)[
  #text(weight: "bold", size: 9.5pt, fill: rgb("#334155"))[Tabla: `branch_subscriptions` (`BranchSubscriptionPersistenceEntity`)]
]
#v(0.2em)
#align(center)[
  #table(
    columns: (95pt, 110pt, 1fr),
    align: (left, center, left),
    table.header([Columna], [Tipo de Dato], [Constraints / Descripción]),
    [*`id`*], [`UUID`], [`PRIMARY KEY, NOT NULL`],
    [*`branch_id`*], [`UUID`], [`NOT NULL, FOREIGN KEY (branches.id)`],
    [*`plan_id`*], [`UUID`], [`NOT NULL, FOREIGN KEY (subscription_plans.id)`],
    [*`status`*], [`VARCHAR`], [`NOT NULL (Enum)`],
    [*`billing_cycle`*], [`VARCHAR`], [`NOT NULL (Enum)`],
    [*`start_date`*], [`TIMESTAMP`], [`NOT NULL`],
    [*`end_date`*], [`TIMESTAMP`], [`NOT NULL`],
    [*`canceled_at`*], [`TIMESTAMP`], [`NULLABLE`],
    [*`deleted_at`*], [`TIMESTAMP`], [`NULLABLE (Soft Delete)`],
    [*`version`*], [`BIGINT`], [`NOT NULL`]
  )
]

#v(0.4em)

#block(sticky: true)[
  #text(weight: "bold", size: 9.5pt, fill: rgb("#334155"))[Tabla: `subscription_plans` (`SubscriptionPlanPersistenceEntity`)]
]
#v(0.2em)
#align(center)[
  #table(
    columns: (95pt, 110pt, 1fr),
    align: (left, center, left),
    table.header([Columna], [Tipo de Dato], [Constraints / Descripción]),
    [*`id`*], [`UUID`], [`PRIMARY KEY, NOT NULL`],
    [*`name`*], [`VARCHAR`], [`NOT NULL, UNIQUE`],
    [*`monthly_price`*], [`DOUBLE PRECISION`], [`NOT NULL`],
    [*`max_obd2_devices`*], [`INTEGER`], [`NOT NULL`],
    [*`max_monthly_snapshots_per_vehicle`*], [`INTEGER`], [`NOT NULL`],
    [*`max_customers`*], [`INTEGER`], [`NOT NULL`],
    [*`max_staff_accounts`*], [`INTEGER`], [`NOT NULL`],
    [*`is_active`*], [`BOOLEAN`], [`NOT NULL`],
    [*`deleted_at`*], [`TIMESTAMP`], [`NULLABLE (Soft Delete)`],
    [*`version`*], [`BIGINT`], [`NOT NULL`]
  )
]

#v(0.5em)

==== 2.6.6.5. Software Architecture Component Level Diagrams (C4 Model - Level 3)

Descomposición del Container API en sus componentes principales para el Bounded Context *Core*.

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.6.5.1. C4 Model Component Diagram]
]
#v(0.3em)

#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/core/core-c4-component.svg", width: 80%)
    ),
    caption: [Diagrama de Componentes C4 Nivel 3 -- Core]
  )
]
#v(0.5em)

==== 2.6.6.6. Code Level Diagrams

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.6.6.1. Domain Layer Class Diagram]
]
#v(0.3em)

#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/core/core-code-domain.svg", width: 80%)
    ),
    caption: [Diagrama de Clases del Dominio UML -- Core]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.6.6.2. Database Design Diagram (PostgreSQL 18)]
]
#v(0.3em)

#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/core/core-erd.svg", width: 60%)
    ),
    caption: [Diagrama de Base de Datos Relacional ER -- Core]
  )
]



=== 2.6.7. Bounded Context: Fleet (Appointments & Registrations)

El Bounded Context *Fleet* administra las citas programadas de atención mecánica (`Appointment`) en las distintas sucursales del taller, así como el registro y vinculación multi-tenant de clientes (`CustomerRegistration`) y empleados técnicos (`EmployeeRegistration`) con las sucursales del sistema. Interactúa mediante un Anti-Corruption Layer (ACL) con el Bounded Context *Core* para validar la existencia de clientes, empleados y sucursales.

#v(0.5em)

==== 2.6.7.1. Domain Layer (Capa de Dominio)

La Capa de Dominio define las reglas de agendamiento de citas mecánicas, duraciones estimadas predeterminadas (1 hora), métodos *Factory* para instanciación de agregados, validaciones de solapamiento de horarios en la capa de aplicación y la adscripción de clientes y empleados a las sedes activas del taller.

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/fleet/fleet-domain-layer.svg", width: 80%)
    ),
    caption: [Diagrama de la Capa de Dominio -- Fleet]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.7.1.1. Value Objects, Enums & Exceptions]
]
#v(0.3em)

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
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Enum: `AppointmentStatus`] \
    #text(size: 9.5pt, fill: rgb("#475569"))[*Valores:* `PENDING`, `COMPLETED`, `CANCELED`] \
    *Propósito:* Representa el estado del ciclo de vida de una cita programada.
  ],
  block(
    fill: rgb("#f8fafc"),
    stroke: 0.5pt + rgb("#cbd5e1"),
    radius: 4pt,
    inset: 8pt,
    width: 100%
  )[
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `AppointmentSummary`] \
    #text(size: 9.5pt, fill: rgb("#475569"))[`(String value)`] \
    *Propósito:* Notas explicativas o resumen del motivo técnico de la cita. Max `2000` chars.
  ]
)

#v(0.4em)

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
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `CustomerRegistrationStatus`] \
    #text(size: 9.5pt, fill: rgb("#475569"))[`(String value)`] \
    *Constantes:* `ACTIVE` ("ACTIVE"), `INACTIVE` ("INACTIVE"). No nulo ni en blanco.
  ],
  block(
    fill: rgb("#f8fafc"),
    stroke: 0.5pt + rgb("#cbd5e1"),
    radius: 4pt,
    inset: 8pt,
    width: 100%
  )[
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `EmployeeRegistrationStatus`] \
    #text(size: 9.5pt, fill: rgb("#475569"))[`(String value)`] \
    *Constantes:* `ACTIVE` ("ACTIVE"), `INACTIVE` ("INACTIVE"). No nulo ni en blanco.
  ]
)

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.7.1.2. Aggregates & Entities]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`Appointment` (Aggregate Root)] \
  #text(size: 9.5pt, fill: rgb("#475569"))[*Tipo:* Raíz de Agregado (`extends AbstractDomainAggregateRoot<Appointment>`)] \
  *Propósito:* Cita de servicio agendada para un cliente y vehículo en una sucursal específica. \
  #v(4pt)
  *Atributos:* `id` (`UUID`), `branchId` (`BranchId`), `customerId` (`CustomerId`), `vehicleId` (`VehicleId`), `scheduledStart` (`LocalDateTime`), `scheduledEnd` (`LocalDateTime`), `status` (`AppointmentStatus`), `notes` (`AppointmentSummary`). \
  #v(4pt)
  *Reglas de Negocio:* Al crearse calcula automáticamente `scheduledEnd = scheduledStart + 1 hora`. Inicia en estado `PENDING`. Emite `AppointmentCreatedEvent`.
]

#v(0.4em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`CustomerRegistration` (Aggregate Root)] \
  #text(size: 9.5pt, fill: rgb("#475569"))[*Tipo:* Raíz de Agregado (`extends AbstractDomainAggregateRoot<CustomerRegistration>`)] \
  *Propósito:* Registro de asociación de un cliente (`CustomerId`) con una sucursal (`BranchId`). \
  #v(4pt)
  *Atributos:* `id` (`CustomerId`), `customerId` (`UUID`), `branchId` (`BranchId`), `status` (`CustomerRegistrationStatus`). \
  #v(4pt)
  *Reglas de Negocio:* Inicia en estado `ACTIVE`. Método `deactivate()` cambia a `INACTIVE` y setea `deletedAt`. Emite `CustomerRegistrationCreatedEvent`.
]

#v(0.4em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`EmployeeRegistration` (Aggregate Root)] \
  #text(size: 9.5pt, fill: rgb("#475569"))[*Tipo:* Raíz de Agregado (`extends AbstractDomainAggregateRoot<EmployeeRegistration>`)] \
  *Propósito:* Registro de adscripción de un empleado (`EmployeeId`) a una sucursal con especialidad técnica y salario. \
  #v(4pt)
  *Atributos:* `id` (`EmployeeId`), `employeeId` (`UUID`), `branchId` (`BranchId`), `speciality` (`String`), `specialityName` (`String`), `salary` (`BigDecimal`), `status` (`EmployeeRegistrationStatus`). \
  #v(4pt)
  *Reglas de Negocio:* Permite actualizar especialidad y salario. `deactivate()` deshabilita la adscripción. Emite `EmployeeRegistrationCreatedEvent`.
]

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.7.1.4. Domain Repositories (Interfaces)]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Interfaces de Repositorio del Dominio Fleet:] \
  - `AppointmentRepository`: `save(Appointment)`, `findById(UUID)`, `existsById(UUID)`, `deleteById(UUID)`, `existsByScheduledStartLessThanAndScheduledEndGreaterThan(...)`, `findByBranchId(...)`, `findByCustomerId(...)`, `findByVehicleId(...)`, `findByBranchIdAndStatus(...)`.
  - `CustomerRegistrationRepository`: `save(...)`, `findById(...)`, `findByCustomerId(...)`, `findByCustomerIdAndBranchId(...)`, `findByBranchIdAndStatus(...)`, `existsByCustomerIdAndBranchId(...)`.
  - `EmployeeRegistrationRepository`: `save(...)`, `findById(...)`, `findByEmployeeId(...)`, `findByBranchId(...)`, `findByBranchIdAndStatus(...)`, `existsByEmployeeIdAndBranchId(...)`.
]

#v(0.5em)

==== 2.6.7.2. Application Layer (Capa de Aplicación)

La Capa de Aplicación expone la ejecución de casos de uso mediante servicios de comando y consulta.

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/fleet/fleet-app-layer.svg", width: 95%)
    ),
    caption: [Diagrama de la Capa de Aplicación -- Fleet]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.7.2.1. Commands & Queries (DTOs de Aplicación)]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Comandos de Escritura (CQRS Commands):] \
  - `CreateAppointmentCommand(BranchId, CustomerId, VehicleId, LocalDateTime, AppointmentSummary)`
  - `UpdateAppointmentCommand(UUID, BranchId, CustomerId, VehicleId, LocalDateTime, AppointmentStatus, AppointmentSummary)`
  - `DeleteAppointmentCommand(UUID appointmentId)`
  - `CreateCustomerRegistrationCommand(CustomerId, BranchId)`
  - `UpdateCustomerRegistrationCommand(UUID registrationId, CustomerRegistrationStatus)`
  - `DeleteCustomerRegistrationCommand(UUID registrationId)`
  - `CreateEmployeeRegistrationCommand(EmployeeId, BranchId, String, String, BigDecimal)`
  - `UpdateEmployeeRegistrationCommand(EmployeeId, String, String, BigDecimal)`
  - `DeleteEmployeeRegistrationCommand(EmployeeId registrationId)`

  #v(8pt)
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Consultas y DTOs de Resultado (CQRS Queries & ACL Outbound):] \
  - `AppointmentQueryService` (búsquedas por ID, sucursal, cliente, vehículo y estado).
  - `GetCustomerRegistrationByCustomerIdQuery(UUID customerId)`
  - `GetEmployeeRegistrationByIdQuery`, `GetEmployeeRegistrationByEmployeeIdQuery`
  - `GetEmployeeRegistrationsByBranchIdQuery`, `GetEmployeeRegistrationsByBranchIdAndStatusQuery`
  - *Outbound Services (ACL):* `ExternalCoreService` (valida Clientes/Empleados/Sucursales en Core), `ExternalVehicleService` (valida Vehículos).
]

#v(0.5em)

==== 2.6.7.3. Interface Layer (Capa de Interfaz / REST)

Exposición RESTful para agendamiento de citas y registros de clientes/empleados por sucursal.

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/fleet/fleet-interface-layer.svg", width: 95%)
    ),
    caption: [Diagrama de la Capa de Interfaz -- Fleet]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.7.3.1. Endpoints & REST Controllers]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`AppointmentsController` (`/api/v1/appointments`)] \
  - `POST /api/v1/appointments`: Agenda una nueva cita mecánica.
  - `GET /api/v1/appointments`: Obtiene citas filtradas opcionalmente por `branchId`, `status`, `customerId` o `vehicleId`.
  - `GET /api/v1/appointments/{appointmentId}`: Obtiene el detalle de una cita específica.
  - `PUT /api/v1/appointments/{appointmentId}` / `DELETE /api/v1/appointments/{appointmentId}`: Edición y soft-delete.

  #v(6pt)
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`CustomerRegistrationsController` (`/api/v1/customer-registrations`)] \
  - `POST /api/v1/customer-registrations`: Vincula a un cliente con una sucursal.
  - `GET /api/v1/customer-registrations?customerId={customerId}` / `?branchId={branchId}&status={status}`: Consultas.
  - `PUT /api/v1/customer-registrations/{id}` / `DELETE /api/v1/customer-registrations/{id}`: Edición y desactivación.

  #v(6pt)
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`EmployeeRegistrationsController` (`/api/v1/employee-registrations`)] \
  - `POST /api/v1/employee-registrations`: Adscribe a un empleado técnico a una sucursal.
  - `GET /api/v1/employee-registrations?branchId={branchId}&status={status}` / `{id}`: Consultas de adscripción.
  - `PUT /api/v1/employee-registrations/{id}` / `DELETE /api/v1/employee-registrations/{id}`: Actualización y desactivación.
]

#v(0.5em)

==== 2.6.7.4. Infrastructure Layer (Capa de Infraestructura)

Mapeo relacional JPA a PostgreSQL 18 con soporte de eliminación lógica (`@SQLDelete` seteando `deleted_at`).

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/fleet/fleet-infra-layer.svg", width: 80%)
    ),
    caption: [Diagrama de la Capa de Infraestructura -- Fleet]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.7.4.1. Mapeo de Entidades Relacionales (JPA)]
]
#v(0.3em)

#block(sticky: true)[
  #text(weight: "bold", size: 9.5pt, fill: rgb("#334155"))[Tabla: `appointments` (`AppointmentPersistenceEntity`)]
]
#v(0.2em)
#align(center)[
  #table(
    columns: (95pt, 110pt, 1fr),
    align: (left, center, left),
    table.header([Columna], [Tipo de Dato], [Constraints / Descripción]),
    [*`id`*], [`UUID`], [`PRIMARY KEY, NOT NULL`],
    [*`branch_id`*], [`UUID`], [`NOT NULL`],
    [*`customer_id`*], [`UUID`], [`NOT NULL`],
    [*`vehicle_id`*], [`UUID`], [`NOT NULL`],
    [*`status`*], [`VARCHAR(20)`], [`NOT NULL (PENDING, COMPLETED, CANCELED)`],
    [*`scheduled_start`*], [`TIMESTAMP`], [`NOT NULL`],
    [*`scheduled_end`*], [`TIMESTAMP`], [`NOT NULL, CHECK (scheduled_end > scheduled_start)`],
    [*`notes`*], [`TEXT`], [`NULLABLE (AppointmentSummaryAttributeConverter)`],
    [*`created_by`*], [`UUID`], [`NOT NULL`],
    [*`updated_by`*], [`UUID`], [`NOT NULL`],
    [*`created_at`*], [`TIMESTAMP`], [`NOT NULL`],
    [*`updated_at`*], [`TIMESTAMP`], [`NOT NULL`],
    [*`deleted_at`*], [`TIMESTAMP`], [`NULLABLE (Soft Delete)`],
    [*`version`*], [`BIGINT`], [`NOT NULL`]
  )
]

#v(0.4em)

#block(sticky: true)[
  #text(weight: "bold", size: 9.5pt, fill: rgb("#334155"))[Tabla: `customer_registrations` (`CustomerRegistrationPersistenceEntity`)]
]
#v(0.2em)
#align(center)[
  #table(
    columns: (95pt, 110pt, 1fr),
    align: (left, center, left),
    table.header([Columna], [Tipo de Dato], [Constraints / Descripción]),
    [*`id`*], [`UUID`], [`PRIMARY KEY, NOT NULL`],
    [*`customer_id`*], [`UUID`], [`NOT NULL`],
    [*`branch_id`*], [`UUID`], [`NOT NULL`],
    [*`status`*], [`VARCHAR(20)`], [`NOT NULL (ACTIVE, INACTIVE)`],
    [*`created_at`*], [`TIMESTAMP`], [`NOT NULL`],
    [*`updated_at`*], [`TIMESTAMP`], [`NOT NULL`],
    [*`deleted_at`*], [`TIMESTAMP`], [`NULLABLE (Soft Delete)`],
    [*`version`*], [`BIGINT`], [`NOT NULL`]
  )
]

#v(0.4em)

#block(sticky: true)[
  #text(weight: "bold", size: 9.5pt, fill: rgb("#334155"))[Tabla: `employee_registrations` (`EmployeeRegistrationPersistenceEntity`)]
]
#v(0.2em)
#align(center)[
  #table(
    columns: (95pt, 110pt, 1fr),
    align: (left, center, left),
    table.header([Columna], [Tipo de Dato], [Constraints / Descripción]),
    [*`id`*], [`UUID`], [`PRIMARY KEY, NOT NULL`],
    [*`employee_id`*], [`UUID`], [`NOT NULL`],
    [*`branch_id`*], [`UUID`], [`NOT NULL`],
    [*`speciality`*], [`VARCHAR(50)`], [`NOT NULL`],
    [*`speciality_name`*], [`VARCHAR(50)`], [`NULLABLE`],
    [*`salary`*], [`NUMERIC(10,2)`], [`NOT NULL, CHECK (salary >= 0)`],
    [*`status`*], [`VARCHAR(20)`], [`NOT NULL (ACTIVE, INACTIVE)`],
    [*`created_at`*], [`TIMESTAMP`], [`NOT NULL`],
    [*`updated_at`*], [`TIMESTAMP`], [`NOT NULL`],
    [*`deleted_at`*], [`TIMESTAMP`], [`NULLABLE (Soft Delete)`],
    [*`version`*], [`BIGINT`], [`NOT NULL`]
  )
]

#v(0.5em)

==== 2.6.7.5. Software Architecture Component Level Diagrams (C4 Model - Level 3)

Descomposición del Container API en sus componentes principales para el Bounded Context *Fleet*.

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.7.5.1. C4 Model Component Diagram]
]
#v(0.3em)

#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/fleet/fleet-c4-component.svg", width: 80%)
    ),
    caption: [Diagrama de Componentes C4 Nivel 3 -- Fleet]
  )
]
#v(0.5em)

==== 2.6.7.6. Code Level Diagrams

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.7.6.1. Domain Layer Class Diagram]
]
#v(0.3em)

#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/fleet/fleet-code-domain.svg", width: 80%)
    ),
    caption: [Diagrama de Clases del Dominio UML -- Fleet]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.7.6.2. Database Design Diagram (PostgreSQL 18)]
]
#v(0.3em)

#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/fleet/fleet-erd.svg", width: 60%)
    ),
    caption: [Diagrama de Base de Datos Relacional ER -- Fleet]
  )
]



=== 2.6.8. Bounded Context: Billing (Quotes, Vouchers & Payments)

El Bounded Context *Billing* gestiona el ciclo de vida financiero posterior a la prestación de servicios en el taller automotriz. Comprende la cotización preliminar de órdenes de trabajo (`Quote`), la emisión de comprobantes de pago electrónicos autorizados por SUNAT (`Voucher`: Facturas/Boletas) mediante la integración con la API externa *Factos*, el registro y amortización de pagos multicanal (`Payment`), la integración de cobros con tarjeta mediante *Stripe*, y los flujos de facturación inmediata (*Checkout*).

#v(0.5em)

==== 2.6.8.1. Domain Layer (Capa de Dominio)

La Capa de Dominio encapsula el cálculo estricto de subtotales, impuestos (IGV 18%), descuentos porcentuales, montos totales mediante métodos *Factory*, reglas financieras encapsuladas en los Agregados `Quote` y `Voucher`, transiciones de estado inmutables, la validación del saldo deudor de comprobantes y la emisión de eventos de dominio financieros.

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/billing/billing-domain-layer.svg", width: 80%)
    ),
    caption: [Diagrama de la Capa de Dominio -- Billing]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.8.1.1. Value Objects, Enums & Exceptions]
]
#v(0.3em)

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
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Enum: `QuoteStatus`] \
    #text(size: 9.5pt, fill: rgb("#475569"))[*Valores:* `DRAFT`, `APPROVED`, `CANCELED`] \
    *Propósito:* Ciclo de vida de la cotización preliminar. `APPROVED` es requisito obligatorio para emitir `Voucher`.
  ],
  block(
    fill: rgb("#f8fafc"),
    stroke: 0.5pt + rgb("#cbd5e1"),
    radius: 4pt,
    inset: 8pt,
    width: 100%
  )[
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Enum: `VoucherType`] \
    #text(size: 9.5pt, fill: rgb("#475569"))[*Valores:* `RECEIPT`, `INVOICE`] \
    *Propósito:* Tipo de comprobante fiscal SUNAT (`RECEIPT`: Boleta B001 para DNI; `INVOICE`: Factura F001 para RUC).
  ]
)

#v(0.4em)

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
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Enum: `VoucherStatus`] \
    #text(size: 9.5pt, fill: rgb("#475569"))[*Valores:* `PENDING`, `PARTIALLY_PAID`, `PAID`, `CANCELED`] \
    *Propósito:* Estado de saldo deudor. Al saldar 100%, emite `VoucherPaidEvent`.
  ],
  block(
    fill: rgb("#f8fafc"),
    stroke: 0.5pt + rgb("#cbd5e1"),
    radius: 4pt,
    inset: 8pt,
    width: 100%
  )[
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Enum: `PaymentMethod`] \
    #text(size: 9.5pt, fill: rgb("#475569"))[*Valores:* `CASH`, `CREDIT_CARD`, `DEBIT_CARD`, `BANK_TRANSFER`] \
    *Propósito:* Canal transaccional del abono registrado.
  ]
)

#v(0.4em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 8pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Excepciones y Fallos del Dominio Financiero:] \
  - *`QuoteCommandFailure`:* `WORK_ORDER_NOT_FOUND`, `INVALID_QUOTE_DATA`, `QUOTE_ALREADY_EXISTS_FOR_WORK_ORDER`, `QUOTE_NOT_FOUND`, `INVALID_QUOTE_STATE`.
  - *`VoucherCommandFailure`:* `QUOTE_NOT_FOUND`, `QUOTE_NOT_APPROVED`, `INVALID_VOUCHER_DATA`, `ISSUER_NOT_FOUND`, `FACTOS_ISSUANCE_FAILED`, `VOUCHER_NOT_FOUND`, `VOUCHER_ALREADY_PAID`, `VOUCHER_CANCELED`, `PAYMENT_EXCEEDS_TOTAL_DEBT`, `PAYMENT_NOT_FOUND`.
]

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.8.1.2. Aggregates & Entities]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`Quote` (Aggregate Root)] \
  #text(size: 9.5pt, fill: rgb("#475569"))[*Tipo:* Raíz de Agregado (`extends AbstractDomainAggregateRoot<Quote>`)] \
  *Propósito:* Representa la cotización de servicios y repuestos de una Orden de Trabajo. \
  #v(4pt)
  *Atributos:* `id` (`UUID`), `workOrderId` (`UUID`), `branchId` (`BranchId`), `subtotalAmount` (`Money`), `discountPercentage` (`Double`), `totalAmount` (`Money`), `status` (`QuoteStatus`). \
  #v(4pt)
  *Reglas de Negocio:* Aplica descuento porcentual sobre el subtotal (`0%` a `100%`) para calcular `totalAmount = subtotal * (1 - discount/100)`. La aprobación `approve()` requiere estar previamente en `DRAFT`.
]

#v(0.4em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`Voucher` (Aggregate Root) & `Payment` (Entity)] \
  - *`Voucher`:* Agregado principal de facturación (`quoteId`, `type`, `customerDocumentType`, `customerDocumentNumber`, `customerName`, `totalAmount`, `status`, `externalInvoiceId`, `pdfUrl`, `payments`).
  - *`Payment`:* Entidad de abono (`id`, `amount`, `method`, `branchId`, `paidAt`).
  - *Reglas de Negocio:* `addPayment(...)` valida que el monto no exceda la deuda restante. Transiciona automáticamente a `PARTIALLY_PAID` o `PAID`. Al cubrir el 100% emite `VoucherPaidEvent`. `removePayment(UUID)` elimina abonos y recalcula dinámicamente el estado.
]

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.8.1.4. Domain Repositories (Interfaces)]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Interfaces de Repositorio del Dominio Billing:] \
  - `QuoteRepository`: `save(Quote)`, `findById(UUID)`, `findAllByBranchId(BranchId)`, `existsByWorkOrderId(UUID)`.
  - `VoucherRepository`: `save(Voucher)`, `findById(UUID)`, `findByBranchId(BranchId)`.
]

#v(0.5em)

==== 2.6.8.2. Application Layer (Capa de Aplicación)

La Capa de Aplicación expone la ejecución de casos de uso mediante servicios de comando (`QuoteCommandService`, `VoucherCommandService`, `StripePaymentCommandService`) y servicios de consulta (`QuoteQueryService`, `VoucherQueryService`).

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/billing/billing-app-layer.svg", width: 95%)
    ),
    caption: [Diagrama de la Capa de Aplicación -- Billing]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.8.2.1. Commands, Queries & Outbound Gateways (DTOs & Ports)]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Comandos de Escritura (CQRS Commands):] \
  - `CreateQuoteCommand(workOrderId, branchId, discountPercentage)`, `UpdateQuoteDiscountCommand(...)`, `ApproveQuoteCommand(...)`, `CancelQuoteCommand(...)`
  - `GenerateVoucherCommand(quoteId, type, customerDocumentType, customerDocumentNumber, customerName)`
  - `AddPaymentCommand(voucherId, amount, method)`, `RemovePaymentCommand(voucherId, paymentId)`
  - `ProcessCheckoutCommand(...)`, `ProcessStripeCheckoutCommand(...)`

  #v(8pt)
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Consultas & Outbound Gateways (CQRS Queries & Ports):] \
  - `GetQuoteByIdQuery`, `GetQuotesByBranchIdQuery`, `GetVoucherByIdQuery`, `GetVouchersByBranchIdQuery`
  - *`FactosGateway`:* `issueVoucher(issuerRuc, documentType, customerDocumentType, customerDocumentNumber, customerName, items)`
  - *`StripeGateway` / `PaymentGateway`:* `createStripePaymentIntent(amount, currency, description)`, `getStripePaymentIntent(paymentIntentId)`
]

#v(0.5em)

==== 2.6.8.3. Interface Layer (Capa de Interfaz / REST & Events)

Exposición RESTful e integración de listeners para eventos internos de facturación.

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/billing/billing-interface-layer.svg", width: 95%)
    ),
    caption: [Diagrama de la Capa de Interfaz -- Billing]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.8.3.1. Endpoints & REST Controllers]
]
#v(0.3em)

#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`QuotesController` (`/api/v1/quotes`)] \
  - `POST /api/v1/quotes`: Registra cotización basada en Orden de Trabajo.
  - `GET /api/v1/quotes?branchId={branchId}` / `GET /api/v1/quotes/{id}`: Consultas.
  - `PUT /api/v1/quotes/{id}`: Actualiza descuento en `DRAFT`.
  - `POST /api/v1/quotes/{id}/approvals`: Aprueba cotización.
  - `POST /api/v1/quotes/{id}/cancellations`: Anula cotización.

  #v(6pt)
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`VouchersController` & `CheckoutsController`] \
  - `POST /api/v1/vouchers`: Emisión de Boleta/Factura vía Factos API SUNAT.
  - `GET /api/v1/vouchers?branchId={branchId}` / `{voucherId}`: Consultas de comprobantes y sus abonos.
  - `POST /api/v1/vouchers/{voucherId}/payments`: Registro de abonos parciales/totales.
  - `POST /api/v1/checkouts` & `POST /api/v1/checkouts/stripe`: Flujos de cobro inmediato y checkout con Stripe.

  #v(6pt)
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`StripePaymentsController` & Event Listener] \
  - `POST /api/v1/payments/stripe/payment-intents`: Genera `PaymentIntent` para tarjetas en app web/móvil.
  - `VoucherPaidListener`: Escucha `VoucherPaidEvent` para auditoría y finalización de la Orden de Trabajo.
]

#v(0.5em)

==== 2.6.8.4. Infrastructure Layer (Capa de Infraestructura)

Mapeo relacional JPA a tablas PostgreSQL 18 e integración de clientes HTTP REST (`FactosGatewayImpl` y `StripeGatewayImpl`).

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/billing/billing-infra-layer.svg", width: 80%)
    ),
    caption: [Diagrama de la Capa de Infraestructura -- Billing]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.8.4.1. Mapeo de Entidades Relacionales (JPA)]
]
#v(0.3em)

#block(sticky: true)[
  #text(weight: "bold", size: 9.5pt, fill: rgb("#334155"))[Tabla: `quotes` (`QuotePersistenceEntity`)]
]
#v(0.2em)
#align(center)[
  #table(
    columns: (95pt, 110pt, 1fr),
    align: (left, center, left),
    table.header([Columna], [Tipo de Dato], [Constraints / Descripción]),
    [*`id`*], [`UUID`], [`PRIMARY KEY, NOT NULL`],
    [*`work_order_id`*], [`UUID`], [`NOT NULL, UNIQUE`],
    [*`branch_id`*], [`UUID`], [`NOT NULL`],
    [*`subtotal_amount`*], [`DECIMAL`], [`NOT NULL, CHECK (subtotal_amount >= 0)`],
    [*`discount_percentage`*], [`DOUBLE PRECISION`], [`NOT NULL, CHECK (0 <= discount <= 100)`],
    [*`total_amount`*], [`DECIMAL`], [`NOT NULL, CHECK (total_amount >= 0)`],
    [*`status`*], [`VARCHAR(20)`], [`NOT NULL (DRAFT, APPROVED, CANCELED)`],
    [*`created_by`*], [`UUID`], [`NOT NULL`],
    [*`updated_by`*], [`UUID`], [`NOT NULL`],
    [*`created_at`*], [`TIMESTAMP`], [`NOT NULL`],
    [*`updated_at`*], [`TIMESTAMP`], [`NOT NULL`],
    [*`deleted_at`*], [`TIMESTAMP`], [`NULLABLE (Soft Delete)`],
    [*`version`*], [`BIGINT`], [`NOT NULL`]
  )
]

#v(0.4em)

#block(sticky: true)[
  #text(weight: "bold", size: 9.5pt, fill: rgb("#334155"))[Tabla: `vouchers` (`VoucherPersistenceEntity`)]
]
#v(0.2em)
#align(center)[
  #table(
    columns: (95pt, 110pt, 1fr),
    align: (left, center, left),
    table.header([Columna], [Tipo de Dato], [Constraints / Descripción]),
    [*`id`*], [`UUID`], [`PRIMARY KEY, NOT NULL`],
    [*`quote_id`*], [`UUID`], [`NOT NULL`],
    [*`type`*], [`VARCHAR(20)`], [`NOT NULL (RECEIPT, INVOICE)`],
    [*`customer_document_type`*], [`VARCHAR(20)`], [`NOT NULL`],
    [*`customer_document_number`*], [`VARCHAR(20)`], [`NOT NULL`],
    [*`customer_name`*], [`VARCHAR(150)`], [`NOT NULL`],
    [*`total_amount`*], [`DECIMAL(10,2)`], [`NOT NULL, CHECK (total_amount >= 0)`],
    [*`status`*], [`VARCHAR(20)`], [`NOT NULL (PENDING, PARTIALLY_PAID, PAID, CANCELED)`],
    [*`external_invoice_id`*], [`UUID`], [`NOT NULL`],
    [*`pdf_url`*], [`VARCHAR(500)`], [`NULLABLE`],
    [*`created_at`*], [`TIMESTAMP`], [`NOT NULL`],
    [*`updated_at`*], [`TIMESTAMP`], [`NOT NULL`],
    [*`deleted_at`*], [`TIMESTAMP`], [`NULLABLE (Soft Delete)`],
    [*`version`*], [`BIGINT`], [`NOT NULL`]
  )
]

#v(0.4em)

#block(sticky: true)[
  #text(weight: "bold", size: 9.5pt, fill: rgb("#334155"))[Tabla: `payments` (`PaymentPersistenceEntity`)]
]
#v(0.2em)
#align(center)[
  #table(
    columns: (95pt, 110pt, 1fr),
    align: (left, center, left),
    table.header([Columna], [Tipo de Dato], [Constraints / Descripción]),
    [*`id`*], [`UUID`], [`PRIMARY KEY, NOT NULL`],
    [*`voucher_id`*], [`UUID`], [`NOT NULL, FOREIGN KEY (vouchers.id)`],
    [*`amount`*], [`DECIMAL`], [`NOT NULL, CHECK (amount > 0)`],
    [*`currency`*], [`VARCHAR(3)`], [`NOT NULL DEFAULT 'PEN'`],
    [*`method`*], [`VARCHAR(20)`], [`NOT NULL (CASH, CREDIT_CARD, DEBIT_CARD, BANK_TRANSFER)`],
    [*`branch_id`*], [`UUID`], [`NOT NULL`],
    [*`paid_at`*], [`TIMESTAMP`], [`NOT NULL`]
  )
]

#v(0.5em)

==== 2.6.8.5. Software Architecture Component Level Diagrams (C4 Model - Level 3)

Descomposición del Container API en sus componentes principales para el Bounded Context *Billing*.

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.8.5.1. C4 Model Component Diagram]
]
#v(0.3em)

#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/billing/billing-c4-component.svg", width: 80%)
    ),
    caption: [Diagrama de Componentes C4 Nivel 3 -- Billing]
  )
]
#v(0.5em)

==== 2.6.8.6. Code Level Diagrams

#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.8.6.1. Domain Layer Class Diagram]
]
#v(0.3em)

#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/billing/billing-code-domain.svg", width: 80%)
    ),
    caption: [Diagrama de Clases del Dominio UML -- Billing]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.6.8.6.2. Database Design Diagram (PostgreSQL 18)]
]
#v(0.3em)

#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/chapter-2/tactical-ddd/billing/billing-erd.svg", width: 60%)
    ),
    caption: [Diagrama de Base de Datos Relacional ER -- Billing]
  )
]

```