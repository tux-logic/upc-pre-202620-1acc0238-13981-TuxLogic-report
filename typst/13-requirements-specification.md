## 2.4. Requirements Specification

### 2.4.1. User Stories

``` {=typst}
#let story-header = (x, y) => if y == 0 { rgb("#1e3a8a") } else if calc.even(y) { rgb("#f8fafc") } else { rgb("#ffffff") }
#let section-fill = rgb("#e2e8f0")

#v(0.5em)
#table(
  columns: (auto, 1fr, auto, auto),
  align: left,
  stroke: 0.4pt + rgb("#cbd5e1"),
  fill: story-header,
  inset: (x: 6pt, y: 5pt),
  table.header([*Story ID*], [*User*], [*Priority*], [*Epic*]),
  [US001], [Dueño de taller], [Alta], [EP001],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Registro de taller y dueño],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como dueño de taller, quiero registrar mi taller (Workshop) y mi cuenta de Owner, para crear mi espacio de trabajo en ShiftIq.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que se proporcionan datos válidos del taller y del dueño, when el sistema procesa el registro, then crea el Workshop y el Owner asociado. \
    Given que el correo del dueño ya está registrado, when se procesa el alta, then el sistema rechaza la operación por duplicidad.
  ],
)

#v(0.5em)
#table(
  columns: (auto, 1fr, auto, auto),
  align: left,
  stroke: 0.4pt + rgb("#cbd5e1"),
  fill: story-header,
  inset: (x: 6pt, y: 5pt),
  table.header([*Story ID*], [*User*], [*Priority*], [*Epic*]),
  [US002], [Usuario registrado], [Alta], [EP001],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Inicio de sesión],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como usuario registrado, quiero iniciar sesión con mis credenciales, para acceder a mi espacio de trabajo.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que el usuario envía credenciales válidas a sign-in, when el sistema las valida, then retorna un token de acceso. \
    Given que las credenciales son inválidas, when se procesa la solicitud, then el sistema deniega el acceso.
  ],
)

#v(0.5em)
#table(
  columns: (auto, 1fr, auto, auto),
  align: left,
  stroke: 0.4pt + rgb("#cbd5e1"),
  fill: story-header,
  inset: (x: 6pt, y: 5pt),
  table.header([*Story ID*], [*User*], [*Priority*], [*Epic*]),
  [US003], [Usuario], [Media], [EP001],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Inicio de sesión con Google],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como usuario, quiero iniciar sesión con mi cuenta de Google, para acceder sin crear una contraseña nueva.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que el token de Google es válido y corresponde a un correo registrado, when se procesa el sign-in, then el sistema concede acceso. \
    Given que el token de Google no corresponde a ningún usuario existente, when se procesa, then el sistema aplica la política de registro configurada.
  ],
)

#v(0.5em)
#table(
  columns: (auto, 1fr, auto, auto),
  align: left,
  stroke: 0.4pt + rgb("#cbd5e1"),
  fill: story-header,
  inset: (x: 6pt, y: 5pt),
  table.header([*Story ID*], [*User*], [*Priority*], [*Epic*]),
  [US004], [Usuario], [Media], [EP001],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Recuperación de contraseña],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como usuario, quiero solicitar y completar la recuperación de mi contraseña, para restablecer mi acceso.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que el correo existe, when se genera el token de recuperación, then el sistema lo envía y permite el reseteo dentro de su vigencia. \
    Given que el token está expirado, when se intenta usar, then el sistema rechaza el reseteo.
  ],
)

#v(0.5em)
#table(
  columns: (auto, 1fr, auto, auto),
  align: left,
  stroke: 0.4pt + rgb("#cbd5e1"),
  fill: story-header,
  inset: (x: 6pt, y: 5pt),
  table.header([*Story ID*], [*User*], [*Priority*], [*Epic*]),
  [US005], [Dueño de taller], [Alta], [EP001],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Gestión de empleados y roles],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como dueño de taller, quiero crear, actualizar y eliminar empleados, para administrar el acceso de mi personal por rol.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que se crea un empleado con un rol válido, when el sistema procesa el alta, then el empleado queda habilitado con los permisos de ese rol. \
    Given que se elimina un empleado, when se confirma la baja, then el sistema revoca sus accesos.
  ],
)

#v(0.5em)
#table(
  columns: (auto, 1fr, auto, auto),
  align: left,
  stroke: 0.4pt + rgb("#cbd5e1"),
  fill: story-header,
  inset: (x: 6pt, y: 5pt),
  table.header([*Story ID*], [*User*], [*Priority*], [*Epic*]),
  [US006], [Dueño de taller], [Media], [EP001],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Gestión de sucursales],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como dueño de taller, quiero crear y actualizar sucursales (Branch), para administrar mis puntos de atención.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que se crea una sucursal con datos válidos, when el sistema la procesa, then queda asociada al Workshop. \
    Given que se actualiza una sucursal inexistente, when se procesa la solicitud, then el sistema retorna un error 404.
  ],
)

#v(0.5em)
#table(
  columns: (auto, 1fr, auto, auto),
  align: left,
  stroke: 0.4pt + rgb("#cbd5e1"),
  fill: story-header,
  inset: (x: 6pt, y: 5pt),
  table.header([*Story ID*], [*User*], [*Priority*], [*Epic*]),
  [US007], [Dueño de taller], [Alta], [EP001],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Asignación y cancelación de suscripción por sucursal],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como dueño de taller, quiero asignar o cancelar el plan de suscripción de una sucursal, para habilitar o suspender sus capacidades operativas.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que se asigna un plan válido a una Branch, when el pago se confirma, then el sistema habilita los módulos del plan. \
    Given que se cancela la suscripción activa, when se procesa, then el sistema mantiene los datos en modo solo lectura.
  ],
)

#v(0.5em)
#table(
  columns: (auto, 1fr, auto, auto),
  align: left,
  stroke: 0.4pt + rgb("#cbd5e1"),
  fill: story-header,
  inset: (x: 6pt, y: 5pt),
  table.header([*Story ID*], [*User*], [*Priority*], [*Epic*]),
  [US008], [Administrador], [Alta], [EP002],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Alta de producto en catálogo],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como administrador, quiero registrar un nuevo producto en el inventario, para mantener un catálogo digital de repuestos.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que el SKU proporcionado es único, when se crea el producto, then el sistema lo añade al catálogo. \
    Given que el SKU ya existe, when se intenta crear, then el sistema rechaza la operación.
  ],
)

#v(0.5em)
#table(
  columns: (auto, 1fr, auto, auto),
  align: left,
  stroke: 0.4pt + rgb("#cbd5e1"),
  fill: story-header,
  inset: (x: 6pt, y: 5pt),
  table.header([*Story ID*], [*User*], [*Priority*], [*Epic*]),
  [US009], [Administrador], [Media], [EP002],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Actualización y baja de producto],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como administrador, quiero actualizar o eliminar un producto del catálogo, para mantener la información y disponibilidad al día.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que el producto no tiene órdenes de trabajo asociadas, when se elimina, then el sistema lo retira del catálogo. \
    Given que el producto tiene tareas asociadas, when se intenta eliminar, then el sistema bloquea la baja por integridad referencial.
  ],
)

#v(0.5em)
#table(
  columns: (auto, 1fr, auto, auto),
  align: left,
  stroke: 0.4pt + rgb("#cbd5e1"),
  fill: story-header,
  inset: (x: 6pt, y: 5pt),
  table.header([*Story ID*], [*User*], [*Priority*], [*Epic*]),
  [US010], [Administrador], [Alta], [EP002],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Ingreso de lote y ajuste de stock],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como administrador, quiero registrar un nuevo lote (ProductBatch) de un producto, para actualizar el stock disponible con trazabilidad.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que se registra un lote con cantidad positiva, when se confirma, then el sistema incrementa el stock total del producto. \
    Given que el ajuste dejaría el stock global en negativo, when se procesa, then el sistema lo rechaza.
  ],
)

#v(0.5em)
#table(
  columns: (auto, 1fr, auto, auto),
  align: left,
  stroke: 0.4pt + rgb("#cbd5e1"),
  fill: story-header,
  inset: (x: 6pt, y: 5pt),
  table.header([*Story ID*], [*User*], [*Priority*], [*Epic*]),
  [US011], [Administrador], [Media], [EP003],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Gestión del catálogo de servicios],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como administrador, quiero crear y actualizar los servicios (Service) que ofrece el taller, para poder asociarlos a las órdenes de trabajo.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que se crea un servicio con un precio válido, when se guarda, then queda disponible para usarse en nuevas órdenes. \
    Given que se intenta eliminar un servicio en uso, when se procesa, then el sistema lo bloquea.
  ],
)

#v(0.5em)
#table(
  columns: (auto, 1fr, auto, auto),
  align: left,
  stroke: 0.4pt + rgb("#cbd5e1"),
  fill: story-header,
  inset: (x: 6pt, y: 5pt),
  table.header([*Story ID*], [*User*], [*Priority*], [*Epic*]),
  [US012], [Administrador], [Alta], [EP003],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Creación de Orden de Trabajo],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como administrador, quiero crear una Orden de Trabajo (WorkOrder) asociada a un cliente y vehículo, para documentar el servicio solicitado.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que el cliente y el vehículo existen, when se crea la orden, then el sistema la inicializa en estado pendiente. \
    Given que el vehículo no está registrado, when se intenta crear, then el sistema rechaza la operación.
  ],
)

#v(0.5em)
#table(
  columns: (auto, 1fr, auto, auto),
  align: left,
  stroke: 0.4pt + rgb("#cbd5e1"),
  fill: story-header,
  inset: (x: 6pt, y: 5pt),
  table.header([*Story ID*], [*User*], [*Priority*], [*Epic*]),
  [US013], [Administrador], [Alta], [EP003],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Asignación de mecánico a tarea],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como administrador, quiero asignar un mecánico a una tarea (WorkOrderTask) de la orden, para delegar la reparación.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que el empleado tiene rol técnico, when se le asigna la tarea, then el sistema vincula al mecánico y le da acceso. \
    Given que el empleado no tiene rol técnico, when se intenta asignar, then el sistema rechaza por falta de permisos.
  ],
)

#v(0.5em)
#table(
  columns: (auto, 1fr, auto, auto),
  align: left,
  stroke: 0.4pt + rgb("#cbd5e1"),
  fill: story-header,
  inset: (x: 6pt, y: 5pt),
  table.header([*Story ID*], [*User*], [*Priority*], [*Epic*]),
  [US014], [Mecánico], [Alta], [EP003],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Inicio y finalización de tarea],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como mecánico, quiero iniciar, completar o reabrir una tarea de la orden, para reflejar el avance real de la reparación.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que la tarea está pendiente, when el mecánico la inicia, then el sistema cambia su estado a en progreso. \
    Given que la tarea no tiene un diagnóstico registrado, when se intenta completar, then el sistema impide el cierre.
  ],
)

#v(0.5em)
#table(
  columns: (auto, 1fr, auto, auto),
  align: left,
  stroke: 0.4pt + rgb("#cbd5e1"),
  fill: story-header,
  inset: (x: 6pt, y: 5pt),
  table.header([*Story ID*], [*User*], [*Priority*], [*Epic*]),
  [US015], [Mecánico], [Media], [EP003],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Consumo de repuestos en una tarea],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como mecánico, quiero agregar o quitar productos consumidos en una tarea, para que el inventario refleje el uso real de repuestos.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que el producto tiene stock suficiente, when se agrega a la tarea, then el sistema descuenta la cantidad reservada del inventario. \
    Given que el stock disponible es insuficiente, when se intenta agregar, then el sistema rechaza la operación.
  ],
)

#v(0.5em)
#table(
  columns: (auto, 1fr, auto, auto),
  align: left,
  stroke: 0.4pt + rgb("#cbd5e1"),
  fill: story-header,
  inset: (x: 6pt, y: 5pt),
  table.header([*Story ID*], [*User*], [*Priority*], [*Epic*]),
  [US016], [Cajero], [Alta], [EP003],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Marcar Orden de Trabajo como pagada],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como cajero, quiero marcar una Orden de Trabajo como pagada tras completar el cobro, para cerrar el ciclo del servicio.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que la orden está completa y el pago fue registrado, when se marca como pagada, then el sistema actualiza su estado final. \
    Given que la orden aún tiene tareas sin completar, when se intenta marcar como pagada, then el sistema lo impide.
  ],
)

#v(0.5em)
#table(
  columns: (auto, 1fr, auto, auto),
  align: left,
  stroke: 0.4pt + rgb("#cbd5e1"),
  fill: story-header,
  inset: (x: 6pt, y: 5pt),
  table.header([*Story ID*], [*User*], [*Priority*], [*Epic*]),
  [US017], [Mecánico], [Alta], [EP004],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Registro de vehículo],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como mecánico, quiero registrar un vehículo con su placa y datos técnicos, para poder asociarle telemetría y órdenes de trabajo.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que la placa no existe previamente, when se registra el vehículo, then el sistema crea su perfil. \
    Given que la placa ya está registrada, when se intenta crear de nuevo, then el sistema rechaza la operación.
  ],
)

#v(0.5em)
#table(
  columns: (auto, 1fr, auto, auto),
  align: left,
  stroke: 0.4pt + rgb("#cbd5e1"),
  fill: story-header,
  inset: (x: 6pt, y: 5pt),
  table.header([*Story ID*], [*User*], [*Priority*], [*Epic*]),
  [US018], [Mecánico], [Alta], [EP004],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Vinculación de dispositivo OBD2 a vehículo],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como mecánico, quiero vincular un dispositivo OBD2 (Obd2Device) a un vehículo, para iniciar la captura de telemetría en tiempo real.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que el dispositivo no está vinculado a otro vehículo activo, when se procesa la vinculación, then el sistema empareja el flujo de datos. \
    Given que el dispositivo ya está vinculado a otro vehículo, when se intenta vincular de nuevo, then el sistema rechaza la operación.
  ],
)

#v(0.5em)
#table(
  columns: (auto, 1fr, auto, auto),
  align: left,
  stroke: 0.4pt + rgb("#cbd5e1"),
  fill: story-header,
  inset: (x: 6pt, y: 5pt),
  table.header([*Story ID*], [*User*], [*Priority*], [*Epic*]),
  [US020], [Mecánico], [Media], [EP004],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Desvinculación de dispositivo OBD2],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como mecánico, quiero desvincular un dispositivo OBD2 de un vehículo, para poder reutilizarlo en otro vehículo.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que el registro de vinculación está activo, when se desactiva, then el sistema libera el dispositivo y detiene la ingesta. \
    Given que el dispositivo no está vinculado a ningún vehículo, when se intenta desvincular, then el sistema omite la acción sin error.
  ],
)

#v(0.5em)
#table(
  columns: (auto, 1fr, auto, auto),
  align: left,
  stroke: 0.4pt + rgb("#cbd5e1"),
  fill: story-header,
  inset: (x: 6pt, y: 5pt),
  table.header([*Story ID*], [*User*], [*Priority*], [*Epic*]),
  [TS001], [Developer], [Alta], [EP006],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Endpoint de ingesta de telemetría OBD2],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como developer, quiero implementar el endpoint POST /api/v1/telemetry-batches, para recibir y persistir los lotes de snapshots de telemetría emitidos por los dispositivos OBD2.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que se envía un payload válido mediante POST a /api/v1/telemetry-batches, when el sistema procesa la solicitud, then persiste el lote de snapshots y retorna un estado 201 Created. \
    Given que el payload contiene un código DTC ya reportado en las últimas 24 horas, when el sistema lo procesa, then incrementa el contador de la alerta existente en lugar de crear una nueva. \
    Given que se envía un payload sin autenticación válida, when la solicitud llega al endpoint, then el sistema retorna un estado 401 Unauthorized.
  ],
)

#v(0.5em)
#table(
  columns: (auto, 1fr, auto, auto),
  align: left,
  stroke: 0.4pt + rgb("#cbd5e1"),
  fill: story-header,
  inset: (x: 6pt, y: 5pt),
  table.header([*Story ID*], [*User*], [*Priority*], [*Epic*]),
  [TS002], [Developer], [Alta], [EP006],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Endpoints de autenticación],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como developer, quiero implementar los endpoints de autenticación (/api/v1/authentication), para gestionar el inicio de sesión, el sign in con Google y la recuperación de contraseña.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que se envían credenciales válidas mediante POST a /api/v1/authentication/sessions, when el sistema las valida, then retorna un token de acceso con estado 200 OK. \
    Given que se envía un token de Google válido mediante POST a /api/v1/authentication/sessions/google, when el sistema lo verifica, then retorna un token de acceso con estado 200 OK. \
    Given que se envía un correo registrado mediante POST a /api/v1/authentication/password-recoveries, when el sistema procesa la solicitud, then genera el token de recuperación y retorna un estado 200 OK sin exponer si el correo existe.
  ],
)
#v(0.5em)
```

### 2.4.2. Impact Mapping



### 2.4.3. Product Backlog