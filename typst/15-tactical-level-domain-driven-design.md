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
#text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[1.1. Base Aggregates & Abstract Entities]
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
#text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[1.2. Shared Value Objects & Records]
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
#text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[1.3. Cross-Context Domain Events]
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
      image("assets/shared/interface-layer-diagram.svg", width: 95%)
    ),
    caption: [Diagrama de la Capa de Interfaz -- Shared Kernel]
  )
]
#v(0.5em)


#v(0.5em)
#text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.1. Infrastructure REST Utilities & Cross-Cutting Exception Handlers]
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
#text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[3.1. Functional Result Pattern & Error Specification]
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
#text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[4.1. JPA MappedSuperclass & Persistence Base]
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
#text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[4.2. JPA Custom Attribute Converters]
#v(0.3em)


- *`MoneyAttributeConverter`*: Mapea `Money` ↔ `DECIMAL(12,2)`.
- *`MileageAttributeConverter`*: Mapea `Mileage` ↔ `INTEGER`.
- *`AddressAttributeConverter`*: Mapea `Address` ↔ `VARCHAR(100)`.

#v(0.5em)


#v(0.5em)
#text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[4.3. Multi-Tenancy Security & Auditing]
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
      image("assets/shared/component-diagram-share.svg", width: 95%)
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
      image("assets/shared/domain-shared-kernel-class-diagram.svg", width: 95%)
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
    columns: (110pt, 100pt, 1fr),
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
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[1.1. Aggregates & Entities]
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
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[1.2. Value Objects & Records]
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
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[1.3. Enumerations]
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
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[1.4. Domain Repositories (Interfaces)]
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
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[1.5. Domain Events]
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
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.1. Commands & Queries (DTOs de Aplicación)]
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
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.2. Application Services]
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
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[2.3. Outbound Port Interfaces]
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
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[3.1. REST Controllers & DTO Resources]
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
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[4.1. Persistence & Security Adapters]
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
      image("assets/iam/c4-component-diagram.svg", width: 95%)
    ),
    caption: [Diagrama de Componentes C4 Nivel 3 -- IAM]
  )
]
#v(0.5em)

==== 2.6.2.6. Bounded Context Software Architecture Code Level Diagrams

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[6.1. Domain Layer Class Diagram]
]

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/iam/class-diagram.svg", width: 95%)
    ),
    caption: [Diagrama de Clases del Dominio UML -- IAM]
  )
]
#v(0.5em)

#block(sticky: true)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[6.2. Database Design Diagram (PostgreSQL 18)]
]

#v(0.5em)
#align(center)[
  #figure(
    block(
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 8pt,
      radius: 4pt,
      image("assets/iam/database-er-diagram.svg", width: 95%)
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
    columns: (85pt, 95pt, 1fr),
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
    columns: (85pt, 95pt, 1fr),
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
    columns: (85pt, 95pt, 1fr),
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
```