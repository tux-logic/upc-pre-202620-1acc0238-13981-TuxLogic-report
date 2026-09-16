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
      image("assets/shared/interface-layer-diagram.svg", width: 100%)
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
      image("assets/shared/application-layer-diagram.svg", width: 95%)
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
      image("assets/shared/infrastracture-layer-diagram.svg", width: 95%)
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
      image("assets/shared/component-diagram-share.svg", width: 80%)
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
      image("assets/shared/domain-shared-kernel-class-diagram.svg", width: 80%)
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
    columns: (auto, auto, 1fr),
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
      image("assets/iam/domain-layer-diagram.svg", width: 95%)
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
      image("assets/iam/application-layer-diagram.svg", width: 95%)
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
      image("assets/iam/interface-layer-diagram.svg", width: 95%)
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
      image("assets/iam/infrastructure-layer-diagram.svg", width: 95%)
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
      image("assets/iam/c4-component-diagram.svg", width: 80%)
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
      image("assets/iam/class-diagram.svg", width: 80%)
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
      image("assets/iam/database-er-diagram.svg", width: 80%)
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
    columns: (auto, auto, 1fr),
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
    columns: (auto, auto, 1fr),
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
    columns: (auto, auto, 1fr),
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
      image("assets/operations/domain-layer-diagram.svg", width: 80%)
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
      image("assets/operations/application-layer-diagram.svg", width: 95%)
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
      image("assets/operations/interface-layer-diagram.svg", width: 95%)
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
      image("assets/operations/infrastructure-layer-diagram.svg", width: 95%)
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
    columns: (auto, auto, 1fr),
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
      image("assets/operations/c4-component-diagram.svg", width: 80%)
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
      image("assets/operations/class-diagram.svg", width: 80%)
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
      image("assets/operations/database-er-diagram.svg", width: 80%)
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
    columns: (auto, auto, 1fr),
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
    columns: (auto, auto, 1fr),
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
      image("assets/inventory/inventory-domain-layer.svg", width: 80%)
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
      image("assets/inventory/inventory-app-layer.svg", width: 95%)
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
      image("assets/inventory/inventory-interface-layer.svg", width: 95%)
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
      image("assets/inventory/inventory-infra-layer.svg", width: 30%)
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
    columns: (auto, auto, 1fr),
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
    columns: (auto, auto, 1fr),
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
      image("assets/inventory/inventory-c4-component.svg", width: 80%)
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
      image("assets/inventory/inventory-code-domain.svg", width: 80%)
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
      image("assets/inventory/inventory-erd.svg", width: 80%)
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
      image("assets/iot/iot-domain-layer.svg", width: 80%)
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
      image("assets/iot/iot-app-layer.svg", width: 95%)
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
      image("assets/iot/iot-interface-layer.svg", width: 95%)
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
      image("assets/iot/iot-infra-layer.svg", width: 80%)
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
    columns: (auto, auto, 1fr),
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
    columns: (auto, auto, 1fr),
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
    columns: (auto, auto, 1fr),
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
    columns: (auto, auto, 1fr),
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
    columns: (auto, auto, 1fr),
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
    columns: (auto, auto, 1fr),
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
      image("assets/iot/iot-c4-component.svg", width: 80%)
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
      image("assets/iot/iot-code-domain.svg", width: 80%)
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
      image("assets/iot/iot-erd.svg", width: 60%)
    ),
    caption: [Diagrama de Base de Datos Relacional ER -- IoT]
  )
]

```

```