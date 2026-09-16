## 2.4. Requirements Specification

### 2.4.1. User Stories

```{=typst}
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
  [US019], [Mecánico], [Alta], [EP004],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Consulta de telemetría del vehículo],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como mecánico, quiero consultar los snapshots de telemetría de un vehículo, para analizar su comportamiento operativo en tiempo casi real.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que el vehículo tiene telemetría registrada, when se consulta GET /api/v1/vehicles/{vehicleId}/telemetry-snapshots, then el sistema retorna el historial de snapshots. \
    Given que el vehículo no existe, when se consulta, then el sistema retorna un error 404.
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
#v(0.5em)
#table(
  columns: (auto, 1fr, auto, auto),
  align: left,
  stroke: 0.4pt + rgb("#cbd5e1"),
  fill: story-header,
  inset: (x: 6pt, y: 5pt),
  table.header([*Story ID*], [*User*], [*Priority*], [*Epic*]),
  [US021], [Administrador], [Alta], [EP004],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Alta de dispositivo OBD2],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como administrador, quiero registrar un dispositivo OBD2 en el inventario de la sucursal, para disponer de dongles listos para vincular a vehículos.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que el serial del dispositivo es único, when se crea mediante POST /api/v1/obd2-devices, then el sistema lo registra disponible. \
    Given que el serial ya existe, when se intenta crear, then el sistema rechaza la operación por duplicidad.
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
  [US022], [Mecánico], [Media], [EP004],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Actualización de datos del vehículo],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como mecánico, quiero actualizar los datos técnicos de un vehículo registrado, para mantener su ficha operativa al día.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que el vehículo existe, when se actualiza mediante PUT /api/v1/vehicles/{id}, then el sistema persiste los cambios. \
    Given que el vehículo no existe, when se intenta actualizar, then el sistema retorna un error 404.
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
  [US023], [Mecánico], [Alta], [EP004],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Consulta de alertas DTC],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como mecánico, quiero consultar las alertas DTC de un vehículo, para priorizar diagnósticos según la severidad detectada.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que el vehículo tiene códigos DTC reportados, when se consulta GET /api/v1/vehicles/{vehicleId}/dtc-alerts, then el sistema retorna las alertas con su severidad y contador. \
    Given que no hay alertas, when se consulta, then el sistema retorna una lista vacía.
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
  [US024], [Administrador], [Media], [EP004],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Listado de vehículos por cliente],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como administrador, quiero listar los vehículos asociados a un cliente, para identificar la flota vinculada a su cuenta.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que el cliente tiene vehículos registrados, when se consulta GET /api/v1/customers/{customerId}/vehicles, then el sistema retorna su listado. \
    Given que el cliente no existe, when se consulta, then el sistema retorna un error 404.
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
  [US025], [Mecánico], [Media], [EP004],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Actualización de estado de registro OBD2],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como mecánico, quiero actualizar el estado de un registro de dispositivo OBD2, para activar o desactivar la captura de telemetría asociada.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que el registro existe, when se actualiza mediante PATCH /api/v1/obd2-device-registrations/{id}, then el sistema refleja el nuevo estado. \
    Given que el registro no existe, when se intenta actualizar, then el sistema retorna un error 404.
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
  [US026], [Administrador], [Alta], [EP005],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Creación de cita de servicio],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como administrador, quiero crear una cita (Appointment) para un cliente y vehículo, para planificar la atención en el taller.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que el cliente, el vehículo y la franja horaria son válidos, when se crea mediante POST /api/v1/appointments, then el sistema agenda la cita. \
    Given que la franja horaria está ocupada, when se intenta crear, then el sistema rechaza la operación por conflicto.
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
  [US027], [Administrador], [Media], [EP005],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Actualización de cita de servicio],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como administrador, quiero actualizar una cita existente, para reprogramar o corregir datos de la atención.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que la cita existe y no está cancelada, when se actualiza mediante PUT /api/v1/appointments/{appointmentId}, then el sistema guarda los cambios. \
    Given que la cita no existe, when se intenta actualizar, then el sistema retorna un error 404.
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
  [US028], [Administrador], [Media], [EP005],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Cancelación de cita de servicio],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como administrador, quiero cancelar una cita, para liberar la agenda cuando el cliente no asistirá.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que la cita existe y está activa, when se elimina mediante DELETE /api/v1/appointments/{appointmentId}, then el sistema la cancela y libera el horario. \
    Given que la cita ya fue atendida, when se intenta cancelar, then el sistema rechaza la operación.
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
  [US029], [Administrador], [Media], [EP005],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Consulta de citas de la sucursal],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como administrador, quiero consultar las citas programadas, para organizar la carga operativa del taller.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que existen citas en el rango consultado, when se solicita GET /api/v1/appointments, then el sistema retorna el listado correspondiente. \
    Given que no hay citas, when se consulta, then el sistema retorna una lista vacía.
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
  [US030], [Administrador], [Alta], [EP005],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Registro de cliente en flota],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como administrador, quiero crear un CustomerRegistration, para vincular un cliente al flujo de citas y atención de la flota.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que los datos del cliente son válidos, when se crea mediante POST /api/v1/customer-registrations, then el sistema genera el registro. \
    Given que el documento ya está registrado en la sucursal, when se intenta crear, then el sistema rechaza por duplicidad.
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
  [US031], [Administrador], [Media], [EP005],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Registro de empleado en flota],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como administrador, quiero crear un EmployeeRegistration, para asociar personal operativo a la planificación de la flota.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que el empleado existe en el taller, when se crea el registro mediante POST /api/v1/employee-registrations, then queda disponible para asignación. \
    Given que el empleado ya tiene un registro activo, when se intenta crear otro, then el sistema rechaza la operación.
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
  [US032], [Administrador], [Alta], [EP001],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Gestión de clientes del taller],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como administrador, quiero crear, actualizar y consultar clientes, para mantener la base de clientes del Workshop.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que se envían datos válidos, when se crea mediante POST /api/v1/customers, then el sistema registra al cliente. \
    Given que se actualiza un cliente inexistente, when se procesa PUT /api/v1/customers/{customerId}, then el sistema retorna un error 404.
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
  [US033], [Dueño de taller], [Media], [EP001],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Actualización de datos del taller],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como dueño de taller, quiero actualizar la información de mi Workshop, para mantener los datos comerciales y de contacto correctos.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que el taller existe y el usuario es el Owner, when se actualiza mediante PUT /api/v1/workshops/{workshopId}, then el sistema persiste los cambios. \
    Given que el usuario no es el propietario, when intenta actualizar, then el sistema deniega el acceso.
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
  [US034], [Administrador], [Baja], [EP001],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Consulta de perfiles y roles],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como administrador, quiero consultar los roles disponibles y perfiles por documento, para validar identidades antes de asignar accesos.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que el usuario está autenticado, when consulta GET /api/v1/profiles/roles, then el sistema retorna el catálogo de roles. \
    Given que se busca un documento existente, when se consulta GET /api/v1/profiles?documentNumber=..., then el sistema retorna el perfil asociado.
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
  [US035], [Usuario registrado], [Media], [EP001],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Actualización de correo electrónico],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como usuario registrado, quiero actualizar mi correo electrónico, para mantener mi identidad de acceso vigente.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que el nuevo correo no está en uso, when se actualiza mediante PUT /api/v1/users/{userId}/email, then el sistema cambia el correo. \
    Given que el correo ya pertenece a otro usuario, when se intenta actualizar, then el sistema rechaza por duplicidad.
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
  [US036], [Usuario registrado], [Media], [EP001],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Cambio de contraseña autenticado],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como usuario registrado, quiero cambiar mi contraseña estando autenticado, para reforzar la seguridad de mi cuenta.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que la contraseña actual es correcta, when se actualiza mediante PUT /api/v1/users/{userId}/password, then el sistema guarda la nueva contraseña. \
    Given que la contraseña actual es incorrecta, when se intenta cambiar, then el sistema rechaza la operación.
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
  [US037], [Administrador], [Alta], [EP007],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Creación de cotización],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como administrador, quiero crear una cotización (Quote) a partir de una Orden de Trabajo, para presupuestar el servicio al cliente.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que la orden de trabajo existe y no tiene cotización, when se crea mediante POST /api/v1/quotes, then el sistema genera una Quote en estado DRAFT. \
    Given que ya existe una cotización para la orden, when se intenta crear otra, then el sistema retorna conflicto 409.
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
  [US038], [Administrador], [Alta], [EP007],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Aprobación de cotización],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como administrador, quiero aprobar una cotización en borrador, para habilitar la emisión del comprobante de pago.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que la cotización está en DRAFT, when se aprueba mediante POST /api/v1/quotes/{id}/approvals, then el sistema la pasa a APPROVED. \
    Given que la cotización no está en DRAFT, when se intenta aprobar, then el sistema rechaza la transición.
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
  [US039], [Administrador], [Media], [EP007],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Cancelación de cotización],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como administrador, quiero cancelar una cotización, para descartar presupuestos que ya no aplican.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que la cotización está activa, when se cancela mediante POST /api/v1/quotes/{id}/cancellations, then el sistema la marca como CANCELED. \
    Given que la cotización ya fue facturada, when se intenta cancelar, then el sistema bloquea la operación.
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
  [US040], [Cajero], [Media], [EP007],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Actualización de descuento en cotización],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como cajero, quiero actualizar el descuento de una cotización en borrador, para ajustar el presupuesto antes de aprobarlo.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que la cotización está en DRAFT y el descuento es válido, when se actualiza mediante PUT /api/v1/quotes/{id}, then el sistema recalcula los montos. \
    Given que la cotización no está en DRAFT, when se intenta actualizar, then el sistema retorna conflicto 409.
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
  [US041], [Cajero], [Alta], [EP007],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Generación de comprobante de pago],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como cajero, quiero generar un comprobante (Voucher) a partir de una cotización aprobada, para emitir boleta o factura al cliente.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que la cotización está APPROVED, when se genera mediante POST /api/v1/vouchers, then el sistema crea el comprobante en PENDING_PAYMENT. \
    Given que la cotización no está aprobada, when se intenta generar, then el sistema retorna conflicto 409.
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
  [US042], [Cajero], [Alta], [EP007],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Checkout con pago inmediato],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como cajero, quiero procesar un checkout que emita el comprobante y registre el pago total, para cerrar la venta en un solo paso.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que la cotización está aprobada y el método de pago es válido, when se procesa POST /api/v1/checkouts, then el sistema genera el voucher en estado PAID. \
    Given que el método de pago no es soportado, when se procesa, then el sistema rechaza la operación.
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
  [US043], [Cajero], [Alta], [EP007],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Registro de pago parcial en comprobante],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como cajero, quiero registrar pagos parciales sobre un comprobante pendiente, para permitir cobros fraccionados hasta saldar la deuda.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que el voucher está en PENDING_PAYMENT y el monto no supera la deuda, when se registra POST /api/v1/vouchers/{voucherId}/payments, then el sistema aplica el pago. \
    Given que la suma de pagos alcanza el total, when se registra el último pago, then el voucher pasa a PAID.
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
  [US044], [Cajero], [Media], [EP007],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Pago con Stripe],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como cajero, quiero iniciar un Payment Intent de Stripe y completar el checkout digital, para cobrar con tarjeta de forma segura.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que el monto es válido, when se crea un Payment Intent mediante POST /api/v1/payments/stripe/payment-intents, then el sistema retorna el clientSecret. \
    Given que el pago de Stripe se confirma, when se procesa POST /api/v1/checkouts/stripe, then el sistema registra el comprobante como pagado.
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
  [US045], [Cajero], [Baja], [EP007],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Consulta de comprobantes por sucursal],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como cajero, quiero consultar los comprobantes de una sucursal, para revisar el historial de cobros emitidos.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que la sucursal tiene vouchers, when se consulta GET /api/v1/vouchers?branchId=..., then el sistema retorna el listado. \
    Given que se consulta un voucher por id inexistente, when se solicita GET /api/v1/vouchers/{voucherId}, then el sistema retorna 404.
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
  [US046], [Administrador], [Alta], [EP003],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Completar orden de trabajo],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como administrador, quiero marcar una Orden de Trabajo como completada, para cerrar operativamente el servicio cuando todas las tareas finalizaron.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que todas las tareas están completadas, when se ejecuta POST /api/v1/work-orders/{id}/complete, then el sistema marca la orden como COMPLETED. \
    Given que existen tareas pendientes, when se intenta completar, then el sistema rechaza la operación.
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
  [US047], [Administrador], [Media], [EP003],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Actualización de detalles de la orden],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como administrador, quiero actualizar el diagnóstico y el kilometraje de una Orden de Trabajo, para documentar el estado del vehículo atendido.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que la orden existe, when se actualiza mediante PUT /api/v1/work-orders/{id}, then el sistema guarda el resumen diagnóstico y el kilometraje. \
    Given que la orden no existe, when se intenta actualizar, then el sistema retorna un error 404.
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
  [US048], [Administrador], [Alta], [EP003],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Agregar tarea a la orden de trabajo],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como administrador, quiero agregar tareas (WorkOrderTask) a una orden, para descomponer el servicio en trabajos asignables.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que la orden está abierta y el servicio existe, when se agrega mediante POST /api/v1/work-orders/{id}/tasks, then el sistema crea la tarea pendiente. \
    Given que la orden ya está completada, when se intenta agregar una tarea, then el sistema rechaza la operación.
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
  [US049], [Administrador], [Media], [EP003],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Eliminar tarea de la orden de trabajo],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como administrador, quiero eliminar una tarea de una orden, para corregir el alcance del servicio antes de su ejecución.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que la tarea está pendiente y sin consumo de stock, when se elimina mediante DELETE /api/v1/work-orders/{id}/tasks/{taskId}, then el sistema la retira. \
    Given que la tarea ya fue iniciada, when se intenta eliminar, then el sistema bloquea la baja.
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
  [US050], [Administrador], [Media], [EP003],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Consulta de órdenes de trabajo],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como administrador, quiero listar y consultar Órdenes de Trabajo, para dar seguimiento al estado operativo del taller.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que existen órdenes en la sucursal, when se consulta GET /api/v1/work-orders, then el sistema retorna el listado. \
    Given que se consulta una orden por id válido, when se solicita GET /api/v1/work-orders/{id}, then el sistema retorna el detalle con sus tareas.
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
  [TS003], [Developer], [Alta], [EP006],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Endpoints de talleres, dueños y sucursales],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como developer, quiero implementar los endpoints de /api/v1/workshops, /api/v1/owners y /api/v1/branches, para exponer la gestión organizacional del taller.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que se envían datos válidos, when se ejecuta POST /api/v1/workshops o POST /api/v1/branches, then el sistema retorna 201 Created. \
    Given que se asigna o cancela una suscripción, when se invoca POST /api/v1/branches/{branchId}/subscriptions o DELETE /api/v1/branches/{branchId}/subscription, then el sistema actualiza el estado de la Branch.
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
  [TS004], [Developer], [Alta], [EP006],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Endpoints de inventario de productos],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como developer, quiero implementar los endpoints de /api/v1/inventory/products, para gestionar el catálogo, lotes y stock por sucursal.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que el SKU es único, when se crea un producto mediante POST /api/v1/inventory/products, then el sistema retorna 201 Created. \
    Given que se registra un lote válido, when se invoca POST /api/v1/inventory/products/{productId}/batches, then el stock del producto se actualiza y se retorna 201 Created. \
    Given que el producto está en uso, when se intenta DELETE /api/v1/inventory/products/{productId}, then el sistema retorna conflicto 409.
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
  [TS005], [Developer], [Alta], [EP006],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Endpoints de órdenes de trabajo y tareas],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como developer, quiero implementar los endpoints de /api/v1/work-orders y /api/v1/work-order-tasks, para soportar el ciclo operativo del servicio.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que se crea una orden válida, when se invoca POST /api/v1/work-orders, then el sistema retorna 201 Created. \
    Given que se inicia, completa o reabre una tarea, when se invocan los endpoints /start, /complete o /reopen, then el sistema actualiza el estado y retorna 200 OK. \
    Given que se asigna un mecánico, when se invoca POST /api/v1/work-order-tasks/{taskId}/assign-mechanic, then la tarea queda vinculada al empleado técnico.
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
  [TS006], [Developer], [Alta], [EP006],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Endpoints de cotizaciones, vouchers y checkout],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como developer, quiero implementar los endpoints de /api/v1/quotes, /api/v1/vouchers, /api/v1/checkouts y /api/v1/payments/stripe, para cubrir el flujo de facturación.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que se crea y aprueba una cotización válida, when se generan los recursos correspondientes, then el sistema retorna los estados esperados (201/200). \
    Given que se procesa un checkout válido, when se invoca POST /api/v1/checkouts, then el voucher queda en PAID. \
    Given que se crea un Payment Intent de Stripe, when se invoca POST /api/v1/payments/stripe/payment-intents, then el sistema retorna el clientSecret.
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
  [TS007], [Developer], [Alta], [EP006],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Endpoints de citas y registros de flota],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como developer, quiero implementar los endpoints de /api/v1/appointments, /api/v1/customer-registrations y /api/v1/employee-registrations, para soportar la planificación de la flota.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que se crea una cita válida, when se invoca POST /api/v1/appointments, then el sistema retorna 201 Created. \
    Given que se actualiza o elimina una cita existente, when se invocan PUT o DELETE, then el sistema refleja el cambio con 200 OK o 204. \
    Given que se listan los registros de cliente o empleado, when se invocan los GET correspondientes, then el sistema retorna las colecciones filtrables.
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
  [TS008], [Developer], [Alta], [EP006],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Endpoints de vehículos y dispositivos OBD2],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como developer, quiero implementar los endpoints de /api/v1/vehicles, /api/v1/obd2-devices y /api/v1/obd2-device-registrations, para habilitar el flujo IoT del diagnóstico.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que se registra un vehículo o dispositivo válido, when se invocan los POST correspondientes, then el sistema retorna 201 Created. \
    Given que se consulta telemetría o alertas DTC, when se invocan los GET de snapshots o dtc-alerts, then el sistema retorna 200 OK con la colección. \
    Given que se actualiza el estado de un registro OBD2, when se invoca PATCH /api/v1/obd2-device-registrations/{id}, then el sistema retorna 200 OK.
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
  [TS009], [Developer], [Media], [EP006],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Listado filtrado de productos por sucursal],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como developer, quiero exponer el listado de productos con filtros por nombre, categoría y lowStockOnly, para que el frontend consulte el inventario de forma eficiente.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que se consulta GET /api/v1/inventory/products?branchId=...&lowStockOnly=true, when existen productos bajo el mínimo, then el sistema retorna solo esos ítems. \
    Given que se aplica un filtro por name o category, when se procesa la consulta, then el resultado respeta el criterio indicado.
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
  [TS010], [Developer], [Alta], [EP006],
  table.cell(colspan: 4, fill: section-fill)[*Title*],
  table.cell(colspan: 4)[Integración de eventos de stock entre Operations e Inventory],
  table.cell(colspan: 4, fill: section-fill)[*Description*],
  table.cell(colspan: 4)[Como developer, quiero implementar los listeners de ProductReservedEvent y ProductReservationCanceledEvent, para sincronizar el stock cuando las tareas consumen o liberan repuestos.],
  table.cell(colspan: 4, fill: section-fill)[*Acceptance Criteria*],
  table.cell(colspan: 4)[
    Given que se reserva un producto en una tarea, when se publica ProductReservedEvent, then Inventory descuenta el stock reservado. \
    Given que se cancela una reserva, when se publica ProductReservationCanceledEvent, then Inventory libera el stock correspondiente. \
    Given que el stock cae al mínimo, when se evalúa el umbral, then el sistema emite LowStockAlertTriggeredEvent.
  ],
)

```

### 2.4.2. Impact Mapping

El Impact Mapping articula, para cada segmento objetivo de ShiftIq, el *Goal* de negocio, los *Actors* que pueden influir en su logro, los *Impacts* (cambios de comportamiento) y los *Deliverables* del Product Backlog.

#### Segmento Objetivo 1 — Talleres independientes (B2B)

**Figura.** *Impact Mapping — Segmento Objetivo 1 (Dueños / Administradores de talleres)*

![](assets/impact-mapping-segmento-1.jpg)

#### Segmento Objetivo 2 — Conductores (B2C)

**Figura.** *Impact Mapping — Segmento Objetivo 2 (Conductores de Lima)*

![](assets/impact-mapping-segmento-2.jpg)

### 2.4.3. Product Backlog

```{=typst}
#text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[Orden de User Stories y Technical Stories]

#v(0.4em)
#text(size: 9.5pt)[El Product Backlog prioriza las historias según valor de negocio y dependencias técnicas. Las Technical Stories se intercalan junto a las User Stories que habilitan. Los _Bounded Contexts_ corresponden a los identificados en el diseño estratégico de ShiftIq. _Vehicle Intelligence_ abrevia _Vehicle Intelligence & Diagnostics_.]

#v(0.6em)
#text(size: 8.5pt)[
#table(
  columns: (36pt, 48pt, 1fr, 52pt, 110pt),
  align: (center, left, left, center, left),
  inset: (x: 5pt, y: 4pt),
  table.header([*Orden*], [*ID*], [*User Story / Technical Story*], [*Story Points*], [*Bounded Context*]),
  [01], [US001], [Registro de taller y dueño], [5], [Workshop Management],
  [02], [TS002], [Endpoints de autenticación], [5], [Identity & Access],
  [03], [US002], [Inicio de sesión], [3], [Identity & Access],
  [04], [US003], [Inicio de sesión con Google], [3], [Identity & Access],
  [05], [US004], [Recuperación de contraseña], [5], [Identity & Access],
  [06], [US035], [Actualización de correo electrónico], [2], [Identity & Access],
  [07], [US036], [Cambio de contraseña autenticado], [2], [Identity & Access],
  [08], [US034], [Consulta de perfiles y roles], [2], [Identity & Access],
  [09], [TS003], [Endpoints de talleres, dueños y sucursales], [5], [Workshop Management],
  [10], [US005], [Gestión de empleados y roles], [5], [Workshop Management],
  [11], [US006], [Gestión de sucursales], [3], [Workshop Management],
  [12], [US007], [Asignación y cancelación de suscripción por sucursal], [5], [Workshop Management],
  [13], [US033], [Actualización de datos del taller], [2], [Workshop Management],
  [14], [US032], [Gestión de clientes del taller], [3], [Workshop Management],
  [15], [TS004], [Endpoints de inventario de productos], [5], [Inventory Management],
  [16], [US008], [Alta de producto en catálogo], [3], [Inventory Management],
  [17], [US009], [Actualización y baja de producto], [3], [Inventory Management],
  [18], [US010], [Ingreso de lote y ajuste de stock], [5], [Inventory Management],
  [19], [TS009], [Listado filtrado de productos por sucursal], [3], [Inventory Management],
  [20], [US011], [Gestión del catálogo de servicios], [3], [Service Operations],
  [21], [TS008], [Endpoints de vehículos y dispositivos OBD2], [5], [Vehicle Intelligence],
  [22], [US017], [Registro de vehículo], [3], [Vehicle Intelligence],
  [23], [US021], [Alta de dispositivo OBD2], [3], [Vehicle Intelligence],
  [24], [US018], [Vinculación de dispositivo OBD2 a vehículo], [5], [Vehicle Intelligence],
  [25], [US020], [Desvinculación de dispositivo OBD2], [3], [Vehicle Intelligence],
  [26], [US025], [Actualización de estado de registro OBD2], [3], [Vehicle Intelligence],
  [27], [TS001], [Endpoint de ingesta de telemetría OBD2], [8], [Vehicle Intelligence],
  [28], [US019], [Consulta de telemetría del vehículo], [5], [Vehicle Intelligence],
  [29], [US023], [Consulta de alertas DTC], [5], [Vehicle Intelligence],
  [30], [US022], [Actualización de datos del vehículo], [2], [Vehicle Intelligence],
  [31], [US024], [Listado de vehículos por cliente], [2], [Vehicle Intelligence],
  [32], [TS007], [Endpoints de citas y registros de flota], [5], [Fleet & Appointments],
  [33], [US026], [Creación de cita de servicio], [5], [Fleet & Appointments],
  [34], [US027], [Actualización de cita de servicio], [3], [Fleet & Appointments],
  [35], [US028], [Cancelación de cita de servicio], [2], [Fleet & Appointments],
  [36], [US029], [Consulta de citas de la sucursal], [2], [Fleet & Appointments],
  [37], [US030], [Registro de cliente en flota], [3], [Fleet & Appointments],
  [38], [US031], [Registro de empleado en flota], [3], [Fleet & Appointments],
  [39], [TS005], [Endpoints de órdenes de trabajo y tareas], [8], [Service Operations],
  [40], [US012], [Creación de Orden de Trabajo], [5], [Service Operations],
  [41], [US048], [Agregar tarea a la orden de trabajo], [3], [Service Operations],
  [42], [US013], [Asignación de mecánico a tarea], [3], [Service Operations],
  [43], [US014], [Inicio y finalización de tarea], [5], [Service Operations],
  [44], [US015], [Consumo de repuestos en una tarea], [5], [Service Operations],
  [45], [TS010], [Integración de eventos de stock entre Operations e Inventory], [8], [Inventory Management],
  [46], [US047], [Actualización de detalles de la orden], [3], [Service Operations],
  [47], [US049], [Eliminar tarea de la orden de trabajo], [2], [Service Operations],
  [48], [US046], [Completar orden de trabajo], [3], [Service Operations],
  [49], [US050], [Consulta de órdenes de trabajo], [2], [Service Operations],
  [50], [US016], [Marcar Orden de Trabajo como pagada], [3], [Service Operations],
  [51], [TS006], [Endpoints de cotizaciones, vouchers y checkout], [8], [Billing & Payments],
  [52], [US037], [Creación de cotización], [5], [Billing & Payments],
  [53], [US040], [Actualización de descuento en cotización], [2], [Billing & Payments],
  [54], [US038], [Aprobación de cotización], [3], [Billing & Payments],
  [55], [US039], [Cancelación de cotización], [2], [Billing & Payments],
  [56], [US041], [Generación de comprobante de pago], [5], [Billing & Payments],
  [57], [US043], [Registro de pago parcial en comprobante], [5], [Billing & Payments],
  [58], [US042], [Checkout con pago inmediato], [5], [Billing & Payments],
  [59], [US044], [Pago con Stripe], [8], [Billing & Payments],
  [60], [US045], [Consulta de comprobantes por sucursal], [2], [Billing & Payments],
)
]
```

