## 2.4. Requirements Specification

### 2.4.1. User Stories

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US001</td><td>Dueño de taller</td><td>Alta</td><td>EP001</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Registro de taller y dueño</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como dueño de taller, quiero registrar mi taller (Workshop) y mi cuenta de Owner, para crear mi espacio de trabajo en ShiftIq.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que se proporcionan datos válidos del taller y del dueño, when el sistema procesa el registro, then crea el Workshop y el Owner asociado.<br>
Given que el correo del dueño ya está registrado, when se procesa el alta, then el sistema rechaza la operación por duplicidad.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US002</td><td>Usuario registrado</td><td>Alta</td><td>EP001</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Inicio de sesión</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como usuario registrado, quiero iniciar sesión con mis credenciales, para acceder a mi espacio de trabajo.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que el usuario envía credenciales válidas a sign-in, when el sistema las valida, then retorna un token de acceso.<br>
Given que las credenciales son inválidas, when se procesa la solicitud, then el sistema deniega el acceso.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US003</td><td>Usuario</td><td>Media</td><td>EP001</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Inicio de sesión con Google</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como usuario, quiero iniciar sesión con mi cuenta de Google, para acceder sin crear una contraseña nueva.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que el token de Google es válido y corresponde a un correo registrado, when se procesa el sign-in, then el sistema concede acceso.<br>
Given que el token de Google no corresponde a ningún usuario existente, when se procesa, then el sistema aplica la política de registro configurada.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US004</td><td>Usuario</td><td>Media</td><td>EP001</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Recuperación de contraseña</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como usuario, quiero solicitar y completar la recuperación de mi contraseña, para restablecer mi acceso.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que el correo existe, when se genera el token de recuperación, then el sistema lo envía y permite el reseteo dentro de su vigencia.<br>
Given que el token está expirado, when se intenta usar, then el sistema rechaza el reseteo.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US005</td><td>Dueño de taller</td><td>Alta</td><td>EP001</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Gestión de empleados y roles</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como dueño de taller, quiero crear, actualizar y eliminar empleados, para administrar el acceso de mi personal por rol.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que se crea un empleado con un rol válido, when el sistema procesa el alta, then el empleado queda habilitado con los permisos de ese rol.<br>
Given que se elimina un empleado, when se confirma la baja, then el sistema revoca sus accesos.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US006</td><td>Dueño de taller</td><td>Media</td><td>EP001</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Gestión de sucursales</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como dueño de taller, quiero crear y actualizar sucursales (Branch), para administrar mis puntos de atención.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que se crea una sucursal con datos válidos, when el sistema la procesa, then queda asociada al Workshop.<br>
Given que se actualiza una sucursal inexistente, when se procesa la solicitud, then el sistema retorna un error 404.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US007</td><td>Dueño de taller</td><td>Alta</td><td>EP001</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Asignación y cancelación de suscripción por sucursal</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como dueño de taller, quiero asignar o cancelar el plan de suscripción de una sucursal, para habilitar o suspender sus capacidades operativas.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que se asigna un plan válido a una Branch, when el pago se confirma, then el sistema habilita los módulos del plan.<br>
Given que se cancela la suscripción activa, when se procesa, then el sistema mantiene los datos en modo solo lectura.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US008</td><td>Administrador</td><td>Alta</td><td>EP002</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Alta de producto en catálogo</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como administrador, quiero registrar un nuevo producto en el inventario, para mantener un catálogo digital de repuestos.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que el SKU proporcionado es único, when se crea el producto, then el sistema lo añade al catálogo.<br>
Given que el SKU ya existe, when se intenta crear, then el sistema rechaza la operación.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US009</td><td>Administrador</td><td>Media</td><td>EP002</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Actualización y baja de producto</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como administrador, quiero actualizar o eliminar un producto del catálogo, para mantener la información y disponibilidad al día.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que el producto no tiene órdenes de trabajo asociadas, when se elimina, then el sistema lo retira del catálogo.<br>
Given que el producto tiene tareas asociadas, when se intenta eliminar, then el sistema bloquea la baja por integridad referencial.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US010</td><td>Administrador</td><td>Alta</td><td>EP002</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Ingreso de lote y ajuste de stock</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como administrador, quiero registrar un nuevo lote (ProductBatch) de un producto, para actualizar el stock disponible con trazabilidad.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que se registra un lote con cantidad positiva, when se confirma, then el sistema incrementa el stock total del producto.<br>
Given que el ajuste dejaría el stock global en negativo, when se procesa, then el sistema lo rechaza.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US011</td><td>Administrador</td><td>Media</td><td>EP003</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Gestión del catálogo de servicios</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como administrador, quiero crear y actualizar los servicios (Service) que ofrece el taller, para poder asociarlos a las órdenes de trabajo.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que se crea un servicio con un precio válido, when se guarda, then queda disponible para usarse en nuevas órdenes.<br>
Given que se intenta eliminar un servicio en uso, when se procesa, then el sistema lo bloquea.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US012</td><td>Administrador</td><td>Alta</td><td>EP003</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Creación de Orden de Trabajo</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como administrador, quiero crear una Orden de Trabajo (WorkOrder) asociada a un cliente y vehículo, para documentar el servicio solicitado.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que el cliente y el vehículo existen, when se crea la orden, then el sistema la inicializa en estado pendiente.<br>
Given que el vehículo no está registrado, when se intenta crear, then el sistema rechaza la operación.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US013</td><td>Administrador</td><td>Alta</td><td>EP003</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Asignación de mecánico a tarea</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como administrador, quiero asignar un mecánico a una tarea (WorkOrderTask) de la orden, para delegar la reparación.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que el empleado tiene rol técnico, when se le asigna la tarea, then el sistema vincula al mecánico y le da acceso.<br>
Given que el empleado no tiene rol técnico, when se intenta asignar, then el sistema rechaza por falta de permisos.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US014</td><td>Mecánico</td><td>Alta</td><td>EP003</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Inicio y finalización de tarea</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como mecánico, quiero iniciar, completar o reabrir una tarea de la orden, para reflejar el avance real de la reparación.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que la tarea está pendiente, when el mecánico la inicia, then el sistema cambia su estado a en progreso.<br>
Given que la tarea no tiene un diagnóstico registrado, when se intenta completar, then el sistema impide el cierre.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US015</td><td>Mecánico</td><td>Media</td><td>EP003</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Consumo de repuestos en una tarea</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como mecánico, quiero agregar o quitar productos consumidos en una tarea, para que el inventario refleje el uso real de repuestos.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que el producto tiene stock suficiente, when se agrega a la tarea, then el sistema descuenta la cantidad reservada del inventario.<br>
Given que el stock disponible es insuficiente, when se intenta agregar, then el sistema rechaza la operación.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US016</td><td>Cajero</td><td>Alta</td><td>EP003</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Marcar Orden de Trabajo como pagada</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como cajero, quiero marcar una Orden de Trabajo como pagada tras completar el cobro, para cerrar el ciclo del servicio.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que la orden está completa y el pago fue registrado, when se marca como pagada, then el sistema actualiza su estado final.<br>
Given que la orden aún tiene tareas sin completar, when se intenta marcar como pagada, then el sistema lo impide.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US017</td><td>Mecánico</td><td>Alta</td><td>EP004</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Registro de vehículo</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como mecánico, quiero registrar un vehículo con su placa y datos técnicos, para poder asociarle telemetría y órdenes de trabajo.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que la placa no existe previamente, when se registra el vehículo, then el sistema crea su perfil.<br>
Given que la placa ya está registrada, when se intenta crear de nuevo, then el sistema rechaza la operación.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US018</td><td>Mecánico</td><td>Alta</td><td>EP004</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Vinculación de dispositivo OBD2 a vehículo</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como mecánico, quiero vincular un dispositivo OBD2 (Obd2Device) a un vehículo, para iniciar la captura de telemetría en tiempo real.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que el dispositivo no está vinculado a otro vehículo activo, when se procesa la vinculación, then el sistema empareja el flujo de datos.<br>
Given que el dispositivo ya está vinculado a otro vehículo, when se intenta vincular de nuevo, then el sistema rechaza la operación.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US019</td><td>Mecánico</td><td>Alta</td><td>EP004</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Consulta de telemetría del vehículo</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como mecánico, quiero consultar los snapshots de telemetría de un vehículo, para analizar su comportamiento operativo en tiempo casi real.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que el vehículo tiene telemetría registrada, when se consulta GET /api/v1/vehicles/{vehicleId}/telemetry-snapshots, then el sistema retorna el historial de snapshots.<br>
Given que el vehículo no existe, when se consulta, then el sistema retorna un error 404.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US020</td><td>Mecánico</td><td>Media</td><td>EP004</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Desvinculación de dispositivo OBD2</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como mecánico, quiero desvincular un dispositivo OBD2 de un vehículo, para poder reutilizarlo en otro vehículo.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que el registro de vinculación está activo, when se desactiva, then el sistema libera el dispositivo y detiene la ingesta.<br>
Given que el dispositivo no está vinculado a ningún vehículo, when se intenta desvincular, then el sistema omite la acción sin error.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>TS001</td><td>Developer</td><td>Alta</td><td>EP006</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Endpoint de ingesta de telemetría OBD2</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como developer, quiero implementar el endpoint POST /api/v1/telemetry-batches, para recibir y persistir los lotes de snapshots de telemetría emitidos por los dispositivos OBD2.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que se envía un payload válido mediante POST a /api/v1/telemetry-batches, when el sistema procesa la solicitud, then persiste el lote de snapshots y retorna un estado 201 Created.<br>
Given que el payload contiene un código DTC ya reportado en las últimas 24 horas, when el sistema lo procesa, then incrementa el contador de la alerta existente en lugar de crear una nueva.<br>
Given que se envía un payload sin autenticación válida, when la solicitud llega al endpoint, then el sistema retorna un estado 401 Unauthorized.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>TS002</td><td>Developer</td><td>Alta</td><td>EP006</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Endpoints de autenticación</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como developer, quiero implementar los endpoints de autenticación (/api/v1/authentication), para gestionar el inicio de sesión, el sign in con Google y la recuperación de contraseña.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que se envían credenciales válidas mediante POST a /api/v1/authentication/sessions, when el sistema las valida, then retorna un token de acceso con estado 200 OK.<br>
Given que se envía un token de Google válido mediante POST a /api/v1/authentication/sessions/google, when el sistema lo verifica, then retorna un token de acceso con estado 200 OK.<br>
Given que se envía un correo registrado mediante POST a /api/v1/authentication/password-recoveries, when el sistema procesa la solicitud, then genera el token de recuperación y retorna un estado 200 OK sin exponer si el correo existe.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US021</td><td>Administrador</td><td>Alta</td><td>EP004</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Alta de dispositivo OBD2</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como administrador, quiero registrar un dispositivo OBD2 en el inventario de la sucursal, para disponer de dongles listos para vincular a vehículos.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que el serial del dispositivo es único, when se crea mediante POST /api/v1/obd2-devices, then el sistema lo registra disponible.<br>
Given que el serial ya existe, when se intenta crear, then el sistema rechaza la operación por duplicidad.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US022</td><td>Mecánico</td><td>Media</td><td>EP004</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Actualización de datos del vehículo</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como mecánico, quiero actualizar los datos técnicos de un vehículo registrado, para mantener su ficha operativa al día.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que el vehículo existe, when se actualiza mediante PUT /api/v1/vehicles/{id}, then el sistema persiste los cambios.<br>
Given que el vehículo no existe, when se intenta actualizar, then el sistema retorna un error 404.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US023</td><td>Mecánico</td><td>Alta</td><td>EP004</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Consulta de alertas DTC</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como mecánico, quiero consultar las alertas DTC de un vehículo, para priorizar diagnósticos según la severidad detectada.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que el vehículo tiene códigos DTC reportados, when se consulta GET /api/v1/vehicles/{vehicleId}/dtc-alerts, then el sistema retorna las alertas con su severidad y contador.<br>
Given que no hay alertas, when se consulta, then el sistema retorna una lista vacía.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US024</td><td>Administrador</td><td>Media</td><td>EP004</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Listado de vehículos por cliente</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como administrador, quiero listar los vehículos asociados a un cliente, para identificar la flota vinculada a su cuenta.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que el cliente tiene vehículos registrados, when se consulta GET /api/v1/customers/{customerId}/vehicles, then el sistema retorna su listado.<br>
Given que el cliente no existe, when se consulta, then el sistema retorna un error 404.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US025</td><td>Mecánico</td><td>Media</td><td>EP004</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Actualización de estado de registro OBD2</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como mecánico, quiero actualizar el estado de un registro de dispositivo OBD2, para activar o desactivar la captura de telemetría asociada.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que el registro existe, when se actualiza mediante PATCH /api/v1/obd2-device-registrations/{id}, then el sistema refleja el nuevo estado.<br>
Given que el registro no existe, when se intenta actualizar, then el sistema retorna un error 404.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US026</td><td>Administrador</td><td>Alta</td><td>EP005</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Creación de cita de servicio</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como administrador, quiero crear una cita (Appointment) para un cliente y vehículo, para planificar la atención en el taller.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que el cliente, el vehículo y la franja horaria son válidos, when se crea mediante POST /api/v1/appointments, then el sistema agenda la cita.<br>
Given que la franja horaria está ocupada, when se intenta crear, then el sistema rechaza la operación por conflicto.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US027</td><td>Administrador</td><td>Media</td><td>EP005</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Actualización de cita de servicio</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como administrador, quiero actualizar una cita existente, para reprogramar o corregir datos de la atención.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que la cita existe y no está cancelada, when se actualiza mediante PUT /api/v1/appointments/{appointmentId}, then el sistema guarda los cambios.<br>
Given que la cita no existe, when se intenta actualizar, then el sistema retorna un error 404.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US028</td><td>Administrador</td><td>Media</td><td>EP005</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Cancelación de cita de servicio</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como administrador, quiero cancelar una cita, para liberar la agenda cuando el cliente no asistirá.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que la cita existe y está activa, when se elimina mediante DELETE /api/v1/appointments/{appointmentId}, then el sistema la cancela y libera el horario.<br>
Given que la cita ya fue atendida, when se intenta cancelar, then el sistema rechaza la operación.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US029</td><td>Administrador</td><td>Media</td><td>EP005</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Consulta de citas de la sucursal</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como administrador, quiero consultar las citas programadas, para organizar la carga operativa del taller.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que existen citas en el rango consultado, when se solicita GET /api/v1/appointments, then el sistema retorna el listado correspondiente.<br>
Given que no hay citas, when se consulta, then el sistema retorna una lista vacía.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US030</td><td>Administrador</td><td>Alta</td><td>EP005</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Registro de cliente en flota</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como administrador, quiero crear un CustomerRegistration, para vincular un cliente al flujo de citas y atención de la flota.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que los datos del cliente son válidos, when se crea mediante POST /api/v1/customer-registrations, then el sistema genera el registro.<br>
Given que el documento ya está registrado en la sucursal, when se intenta crear, then el sistema rechaza por duplicidad.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US031</td><td>Administrador</td><td>Media</td><td>EP005</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Registro de empleado en flota</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como administrador, quiero crear un EmployeeRegistration, para asociar personal operativo a la planificación de la flota.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que el empleado existe en el taller, when se crea el registro mediante POST /api/v1/employee-registrations, then queda disponible para asignación.<br>
Given que el empleado ya tiene un registro activo, when se intenta crear otro, then el sistema rechaza la operación.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US032</td><td>Administrador</td><td>Alta</td><td>EP001</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Gestión de clientes del taller</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como administrador, quiero crear, actualizar y consultar clientes, para mantener la base de clientes del Workshop.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que se envían datos válidos, when se crea mediante POST /api/v1/customers, then el sistema registra al cliente.<br>
Given que se actualiza un cliente inexistente, when se procesa PUT /api/v1/customers/{customerId}, then el sistema retorna un error 404.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US033</td><td>Dueño de taller</td><td>Media</td><td>EP001</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Actualización de datos del taller</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como dueño de taller, quiero actualizar la información de mi Workshop, para mantener los datos comerciales y de contacto correctos.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que el taller existe y el usuario es el Owner, when se actualiza mediante PUT /api/v1/workshops/{workshopId}, then el sistema persiste los cambios.<br>
Given que el usuario no es el propietario, when intenta actualizar, then el sistema deniega el acceso.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US034</td><td>Administrador</td><td>Baja</td><td>EP001</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Consulta de perfiles y roles</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como administrador, quiero consultar los roles disponibles y perfiles por documento, para validar identidades antes de asignar accesos.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que el usuario está autenticado, when consulta GET /api/v1/profiles/roles, then el sistema retorna el catálogo de roles.<br>
Given que se busca un documento existente, when se consulta GET /api/v1/profiles?documentNumber=..., then el sistema retorna el perfil asociado.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US035</td><td>Usuario registrado</td><td>Media</td><td>EP001</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Actualización de correo electrónico</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como usuario registrado, quiero actualizar mi correo electrónico, para mantener mi identidad de acceso vigente.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que el nuevo correo no está en uso, when se actualiza mediante PUT /api/v1/users/{userId}/email, then el sistema cambia el correo.<br>
Given que el correo ya pertenece a otro usuario, when se intenta actualizar, then el sistema rechaza por duplicidad.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US036</td><td>Usuario registrado</td><td>Media</td><td>EP001</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Cambio de contraseña autenticado</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como usuario registrado, quiero cambiar mi contraseña estando autenticado, para reforzar la seguridad de mi cuenta.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que la contraseña actual es correcta, when se actualiza mediante PUT /api/v1/users/{userId}/password, then el sistema guarda la nueva contraseña.<br>
Given que la contraseña actual es incorrecta, when se intenta cambiar, then el sistema rechaza la operación.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US037</td><td>Administrador</td><td>Alta</td><td>EP007</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Creación de cotización</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como administrador, quiero crear una cotización (Quote) a partir de una Orden de Trabajo, para presupuestar el servicio al cliente.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que la orden de trabajo existe y no tiene cotización, when se crea mediante POST /api/v1/quotes, then el sistema genera una Quote en estado DRAFT.<br>
Given que ya existe una cotización para la orden, when se intenta crear otra, then el sistema retorna conflicto 409.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US038</td><td>Administrador</td><td>Alta</td><td>EP007</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Aprobación de cotización</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como administrador, quiero aprobar una cotización en borrador, para habilitar la emisión del comprobante de pago.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que la cotización está en DRAFT, when se aprueba mediante POST /api/v1/quotes/{id}/approvals, then el sistema la pasa a APPROVED.<br>
Given que la cotización no está en DRAFT, when se intenta aprobar, then el sistema rechaza la transición.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US039</td><td>Administrador</td><td>Media</td><td>EP007</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Cancelación de cotización</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como administrador, quiero cancelar una cotización, para descartar presupuestos que ya no aplican.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que la cotización está activa, when se cancela mediante POST /api/v1/quotes/{id}/cancellations, then el sistema la marca como CANCELED.<br>
Given que la cotización ya fue facturada, when se intenta cancelar, then el sistema bloquea la operación.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US040</td><td>Cajero</td><td>Media</td><td>EP007</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Actualización de descuento en cotización</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como cajero, quiero actualizar el descuento de una cotización en borrador, para ajustar el presupuesto antes de aprobarlo.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que la cotización está en DRAFT y el descuento es válido, when se actualiza mediante PUT /api/v1/quotes/{id}, then el sistema recalcula los montos.<br>
Given que la cotización no está en DRAFT, when se intenta actualizar, then el sistema retorna conflicto 409.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US041</td><td>Cajero</td><td>Alta</td><td>EP007</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Generación de comprobante de pago</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como cajero, quiero generar un comprobante (Voucher) a partir de una cotización aprobada, para emitir boleta o factura al cliente.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que la cotización está APPROVED, when se genera mediante POST /api/v1/vouchers, then el sistema crea el comprobante en PENDING_PAYMENT.<br>
Given que la cotización no está aprobada, when se intenta generar, then el sistema retorna conflicto 409.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US042</td><td>Cajero</td><td>Alta</td><td>EP007</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Checkout con pago inmediato</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como cajero, quiero procesar un checkout que emita el comprobante y registre el pago total, para cerrar la venta en un solo paso.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que la cotización está aprobada y el método de pago es válido, when se procesa POST /api/v1/checkouts, then el sistema genera el voucher en estado PAID.<br>
Given que el método de pago no es soportado, when se procesa, then el sistema rechaza la operación.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US043</td><td>Cajero</td><td>Alta</td><td>EP007</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Registro de pago parcial en comprobante</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como cajero, quiero registrar pagos parciales sobre un comprobante pendiente, para permitir cobros fraccionados hasta saldar la deuda.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que el voucher está en PENDING_PAYMENT y el monto no supera la deuda, when se registra POST /api/v1/vouchers/{voucherId}/payments, then el sistema aplica el pago.<br>
Given que la suma de pagos alcanza el total, when se registra el último pago, then el voucher pasa a PAID.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US044</td><td>Cajero</td><td>Media</td><td>EP007</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Pago con Stripe</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como cajero, quiero iniciar un Payment Intent de Stripe y completar el checkout digital, para cobrar con tarjeta de forma segura.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que el monto es válido, when se crea un Payment Intent mediante POST /api/v1/payments/stripe/payment-intents, then el sistema retorna el clientSecret.<br>
Given que el pago de Stripe se confirma, when se procesa POST /api/v1/checkouts/stripe, then el sistema registra el comprobante como pagado.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US045</td><td>Cajero</td><td>Baja</td><td>EP007</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Consulta de comprobantes por sucursal</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como cajero, quiero consultar los comprobantes de una sucursal, para revisar el historial de cobros emitidos.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que la sucursal tiene vouchers, when se consulta GET /api/v1/vouchers?branchId=..., then el sistema retorna el listado.<br>
Given que se consulta un voucher por id inexistente, when se solicita GET /api/v1/vouchers/{voucherId}, then el sistema retorna 404.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US046</td><td>Administrador</td><td>Alta</td><td>EP003</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Completar orden de trabajo</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como administrador, quiero marcar una Orden de Trabajo como completada, para cerrar operativamente el servicio cuando todas las tareas finalizaron.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que todas las tareas están completadas, when se ejecuta POST /api/v1/work-orders/{id}/complete, then el sistema marca la orden como COMPLETED.<br>
Given que existen tareas pendientes, when se intenta completar, then el sistema rechaza la operación.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US047</td><td>Administrador</td><td>Media</td><td>EP003</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Actualización de detalles de la orden</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como administrador, quiero actualizar el diagnóstico y el kilometraje de una Orden de Trabajo, para documentar el estado del vehículo atendido.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que la orden existe, when se actualiza mediante PUT /api/v1/work-orders/{id}, then el sistema guarda el resumen diagnóstico y el kilometraje.<br>
Given que la orden no existe, when se intenta actualizar, then el sistema retorna un error 404.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US048</td><td>Administrador</td><td>Alta</td><td>EP003</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Agregar tarea a la orden de trabajo</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como administrador, quiero agregar tareas (WorkOrderTask) a una orden, para descomponer el servicio en trabajos asignables.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que la orden está abierta y el servicio existe, when se agrega mediante POST /api/v1/work-orders/{id}/tasks, then el sistema crea la tarea pendiente.<br>
Given que la orden ya está completada, when se intenta agregar una tarea, then el sistema rechaza la operación.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US049</td><td>Administrador</td><td>Media</td><td>EP003</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Eliminar tarea de la orden de trabajo</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como administrador, quiero eliminar una tarea de una orden, para corregir el alcance del servicio antes de su ejecución.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que la tarea está pendiente y sin consumo de stock, when se elimina mediante DELETE /api/v1/work-orders/{id}/tasks/{taskId}, then el sistema la retira.<br>
Given que la tarea ya fue iniciada, when se intenta eliminar, then el sistema bloquea la baja.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>US050</td><td>Administrador</td><td>Media</td><td>EP003</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Consulta de órdenes de trabajo</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como administrador, quiero listar y consultar Órdenes de Trabajo, para dar seguimiento al estado operativo del taller.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que existen órdenes en la sucursal, when se consulta GET /api/v1/work-orders, then el sistema retorna el listado.<br>
Given que se consulta una orden por id válido, when se solicita GET /api/v1/work-orders/{id}, then el sistema retorna el detalle con sus tareas.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>TS003</td><td>Developer</td><td>Alta</td><td>EP006</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Endpoints de talleres, dueños y sucursales</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como developer, quiero implementar los endpoints de /api/v1/workshops, /api/v1/owners y /api/v1/branches, para exponer la gestión organizacional del taller.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que se envían datos válidos, when se ejecuta POST /api/v1/workshops o POST /api/v1/branches, then el sistema retorna 201 Created.<br>
Given que se asigna o cancela una suscripción, when se invoca POST /api/v1/branches/{branchId}/subscriptions o DELETE /api/v1/branches/{branchId}/subscription, then el sistema actualiza el estado de la Branch.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>TS004</td><td>Developer</td><td>Alta</td><td>EP006</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Endpoints de inventario de productos</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como developer, quiero implementar los endpoints de /api/v1/inventory/products, para gestionar el catálogo, lotes y stock por sucursal.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que el SKU es único, when se crea un producto mediante POST /api/v1/inventory/products, then el sistema retorna 201 Created.<br>
Given que se registra un lote válido, when se invoca POST /api/v1/inventory/products/{productId}/batches, then el stock del producto se actualiza y se retorna 201 Created.<br>
Given que el producto está en uso, when se intenta DELETE /api/v1/inventory/products/{productId}, then el sistema retorna conflicto 409.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>TS005</td><td>Developer</td><td>Alta</td><td>EP006</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Endpoints de órdenes de trabajo y tareas</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como developer, quiero implementar los endpoints de /api/v1/work-orders y /api/v1/work-order-tasks, para soportar el ciclo operativo del servicio.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que se crea una orden válida, when se invoca POST /api/v1/work-orders, then el sistema retorna 201 Created.<br>
Given que se inicia, completa o reabre una tarea, when se invocan los endpoints /start, /complete o /reopen, then el sistema actualiza el estado y retorna 200 OK.<br>
Given que se asigna un mecánico, when se invoca POST /api/v1/work-order-tasks/{taskId}/assign-mechanic, then la tarea queda vinculada al empleado técnico.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>TS006</td><td>Developer</td><td>Alta</td><td>EP006</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Endpoints de cotizaciones, vouchers y checkout</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como developer, quiero implementar los endpoints de /api/v1/quotes, /api/v1/vouchers, /api/v1/checkouts y /api/v1/payments/stripe, para cubrir el flujo de facturación.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que se crea y aprueba una cotización válida, when se generan los recursos correspondientes, then el sistema retorna los estados esperados (201/200).<br>
Given que se procesa un checkout válido, when se invoca POST /api/v1/checkouts, then el voucher queda en PAID.<br>
Given que se crea un Payment Intent de Stripe, when se invoca POST /api/v1/payments/stripe/payment-intents, then el sistema retorna el clientSecret.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>TS007</td><td>Developer</td><td>Alta</td><td>EP006</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Endpoints de citas y registros de flota</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como developer, quiero implementar los endpoints de /api/v1/appointments, /api/v1/customer-registrations y /api/v1/employee-registrations, para soportar la planificación de la flota.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que se crea una cita válida, when se invoca POST /api/v1/appointments, then el sistema retorna 201 Created.<br>
Given que se actualiza o elimina una cita existente, when se invocan PUT o DELETE, then el sistema refleja el cambio con 200 OK o 204.<br>
Given que se listan los registros de cliente o empleado, when se invocan los GET correspondientes, then el sistema retorna las colecciones filtrables.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>TS008</td><td>Developer</td><td>Alta</td><td>EP006</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Endpoints de vehículos y dispositivos OBD2</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como developer, quiero implementar los endpoints de /api/v1/vehicles, /api/v1/obd2-devices y /api/v1/obd2-device-registrations, para habilitar el flujo IoT del diagnóstico.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que se registra un vehículo o dispositivo válido, when se invocan los POST correspondientes, then el sistema retorna 201 Created.<br>
Given que se consulta telemetría o alertas DTC, when se invocan los GET de snapshots o dtc-alerts, then el sistema retorna 200 OK con la colección.<br>
Given que se actualiza el estado de un registro OBD2, when se invoca PATCH /api/v1/obd2-device-registrations/{id}, then el sistema retorna 200 OK.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>TS009</td><td>Developer</td><td>Media</td><td>EP006</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Listado filtrado de productos por sucursal</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como developer, quiero exponer el listado de productos con filtros por nombre, categoría y lowStockOnly, para que el frontend consulte el inventario de forma eficiente.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que se consulta GET /api/v1/inventory/products?branchId=...&lowStockOnly=true, when existen productos bajo el mínimo, then el sistema retorna solo esos ítems.<br>
Given que se aplica un filtro por name o category, when se procesa la consulta, then el resultado respeta el criterio indicado.
</td></tr>
</table>

<table style="width:100%; border-collapse: collapse;">
<tr><td><b>Story ID</b></td><td><b>User</b></td><td><b>Priority</b></td><td><b>Epic</b></td></tr>
<tr><td>TS010</td><td>Developer</td><td>Alta</td><td>EP006</td></tr>
<tr><td colspan="4"><b>Title</b></td></tr>
<tr><td colspan="4">Integración de eventos de stock entre Operations e Inventory</td></tr>
<tr><td colspan="4"><b>Description</b></td></tr>
<tr><td colspan="4">Como developer, quiero implementar los listeners de ProductReservedEvent y ProductReservationCanceledEvent, para sincronizar el stock cuando las tareas consumen o liberan repuestos.</td></tr>
<tr><td colspan="4"><b>Acceptance Criteria</b></td></tr>
<tr><td colspan="4">
Given que se reserva un producto en una tarea, when se publica ProductReservedEvent, then Inventory descuenta el stock reservado.<br>
Given que se cancela una reserva, when se publica ProductReservationCanceledEvent, then Inventory libera el stock correspondiente.<br>
Given que el stock cae al mínimo, when se evalúa el umbral, then el sistema emite LowStockAlertTriggeredEvent.
</td></tr>
</table>


### 2.4.2. Impact Mapping



### 2.4.3. Product Backlog

**Orden de User Stories y Technical Stories**

El Product Backlog prioriza las historias según valor de negocio y dependencias técnicas. Las Technical Stories se intercalan junto a las User Stories que habilitan. Los *Bounded Contexts* corresponden a los identificados en el diseño estratégico de ShiftIq. *Vehicle Intelligence* abrevia *Vehicle Intelligence & Diagnostics*.

<table style="width:100%; border-collapse: collapse;">
<tr><th style="text-align:left;">Orden</th><th style="text-align:left;">ID</th><th style="text-align:left;">User Story / Technical Story</th><th style="text-align:left;">Story Points</th><th style="text-align:left;">Bounded Context</th></tr>
<tr><td>01</td><td>US001</td><td>Registro de taller y dueño</td><td>5</td><td>Workshop Management</td></tr>
<tr><td>02</td><td>TS002</td><td>Endpoints de autenticación</td><td>5</td><td>Identity & Access</td></tr>
<tr><td>03</td><td>US002</td><td>Inicio de sesión</td><td>3</td><td>Identity & Access</td></tr>
<tr><td>04</td><td>US003</td><td>Inicio de sesión con Google</td><td>3</td><td>Identity & Access</td></tr>
<tr><td>05</td><td>US004</td><td>Recuperación de contraseña</td><td>5</td><td>Identity & Access</td></tr>
<tr><td>06</td><td>US035</td><td>Actualización de correo electrónico</td><td>2</td><td>Identity & Access</td></tr>
<tr><td>07</td><td>US036</td><td>Cambio de contraseña autenticado</td><td>2</td><td>Identity & Access</td></tr>
<tr><td>08</td><td>US034</td><td>Consulta de perfiles y roles</td><td>2</td><td>Identity & Access</td></tr>
<tr><td>09</td><td>TS003</td><td>Endpoints de talleres, dueños y sucursales</td><td>5</td><td>Workshop Management</td></tr>
<tr><td>10</td><td>US005</td><td>Gestión de empleados y roles</td><td>5</td><td>Workshop Management</td></tr>
<tr><td>11</td><td>US006</td><td>Gestión de sucursales</td><td>3</td><td>Workshop Management</td></tr>
<tr><td>12</td><td>US007</td><td>Asignación y cancelación de suscripción por sucursal</td><td>5</td><td>Workshop Management</td></tr>
<tr><td>13</td><td>US033</td><td>Actualización de datos del taller</td><td>2</td><td>Workshop Management</td></tr>
<tr><td>14</td><td>US032</td><td>Gestión de clientes del taller</td><td>3</td><td>Workshop Management</td></tr>
<tr><td>15</td><td>TS004</td><td>Endpoints de inventario de productos</td><td>5</td><td>Inventory Management</td></tr>
<tr><td>16</td><td>US008</td><td>Alta de producto en catálogo</td><td>3</td><td>Inventory Management</td></tr>
<tr><td>17</td><td>US009</td><td>Actualización y baja de producto</td><td>3</td><td>Inventory Management</td></tr>
<tr><td>18</td><td>US010</td><td>Ingreso de lote y ajuste de stock</td><td>5</td><td>Inventory Management</td></tr>
<tr><td>19</td><td>TS009</td><td>Listado filtrado de productos por sucursal</td><td>3</td><td>Inventory Management</td></tr>
<tr><td>20</td><td>US011</td><td>Gestión del catálogo de servicios</td><td>3</td><td>Service Operations</td></tr>
<tr><td>21</td><td>TS008</td><td>Endpoints de vehículos y dispositivos OBD2</td><td>5</td><td>Vehicle Intelligence</td></tr>
<tr><td>22</td><td>US017</td><td>Registro de vehículo</td><td>3</td><td>Vehicle Intelligence</td></tr>
<tr><td>23</td><td>US021</td><td>Alta de dispositivo OBD2</td><td>3</td><td>Vehicle Intelligence</td></tr>
<tr><td>24</td><td>US018</td><td>Vinculación de dispositivo OBD2 a vehículo</td><td>5</td><td>Vehicle Intelligence</td></tr>
<tr><td>25</td><td>US020</td><td>Desvinculación de dispositivo OBD2</td><td>3</td><td>Vehicle Intelligence</td></tr>
<tr><td>26</td><td>US025</td><td>Actualización de estado de registro OBD2</td><td>3</td><td>Vehicle Intelligence</td></tr>
<tr><td>27</td><td>TS001</td><td>Endpoint de ingesta de telemetría OBD2</td><td>8</td><td>Vehicle Intelligence</td></tr>
<tr><td>28</td><td>US019</td><td>Consulta de telemetría del vehículo</td><td>5</td><td>Vehicle Intelligence</td></tr>
<tr><td>29</td><td>US023</td><td>Consulta de alertas DTC</td><td>5</td><td>Vehicle Intelligence</td></tr>
<tr><td>30</td><td>US022</td><td>Actualización de datos del vehículo</td><td>2</td><td>Vehicle Intelligence</td></tr>
<tr><td>31</td><td>US024</td><td>Listado de vehículos por cliente</td><td>2</td><td>Vehicle Intelligence</td></tr>
<tr><td>32</td><td>TS007</td><td>Endpoints de citas y registros de flota</td><td>5</td><td>Fleet & Appointments</td></tr>
<tr><td>33</td><td>US026</td><td>Creación de cita de servicio</td><td>5</td><td>Fleet & Appointments</td></tr>
<tr><td>34</td><td>US027</td><td>Actualización de cita de servicio</td><td>3</td><td>Fleet & Appointments</td></tr>
<tr><td>35</td><td>US028</td><td>Cancelación de cita de servicio</td><td>2</td><td>Fleet & Appointments</td></tr>
<tr><td>36</td><td>US029</td><td>Consulta de citas de la sucursal</td><td>2</td><td>Fleet & Appointments</td></tr>
<tr><td>37</td><td>US030</td><td>Registro de cliente en flota</td><td>3</td><td>Fleet & Appointments</td></tr>
<tr><td>38</td><td>US031</td><td>Registro de empleado en flota</td><td>3</td><td>Fleet & Appointments</td></tr>
<tr><td>39</td><td>TS005</td><td>Endpoints de órdenes de trabajo y tareas</td><td>8</td><td>Service Operations</td></tr>
<tr><td>40</td><td>US012</td><td>Creación de Orden de Trabajo</td><td>5</td><td>Service Operations</td></tr>
<tr><td>41</td><td>US048</td><td>Agregar tarea a la orden de trabajo</td><td>3</td><td>Service Operations</td></tr>
<tr><td>42</td><td>US013</td><td>Asignación de mecánico a tarea</td><td>3</td><td>Service Operations</td></tr>
<tr><td>43</td><td>US014</td><td>Inicio y finalización de tarea</td><td>5</td><td>Service Operations</td></tr>
<tr><td>44</td><td>US015</td><td>Consumo de repuestos en una tarea</td><td>5</td><td>Service Operations</td></tr>
<tr><td>45</td><td>TS010</td><td>Integración de eventos de stock entre Operations e Inventory</td><td>8</td><td>Inventory Management</td></tr>
<tr><td>46</td><td>US047</td><td>Actualización de detalles de la orden</td><td>3</td><td>Service Operations</td></tr>
<tr><td>47</td><td>US049</td><td>Eliminar tarea de la orden de trabajo</td><td>2</td><td>Service Operations</td></tr>
<tr><td>48</td><td>US046</td><td>Completar orden de trabajo</td><td>3</td><td>Service Operations</td></tr>
<tr><td>49</td><td>US050</td><td>Consulta de órdenes de trabajo</td><td>2</td><td>Service Operations</td></tr>
<tr><td>50</td><td>US016</td><td>Marcar Orden de Trabajo como pagada</td><td>3</td><td>Service Operations</td></tr>
<tr><td>51</td><td>TS006</td><td>Endpoints de cotizaciones, vouchers y checkout</td><td>8</td><td>Billing & Payments</td></tr>
<tr><td>52</td><td>US037</td><td>Creación de cotización</td><td>5</td><td>Billing & Payments</td></tr>
<tr><td>53</td><td>US040</td><td>Actualización de descuento en cotización</td><td>2</td><td>Billing & Payments</td></tr>
<tr><td>54</td><td>US038</td><td>Aprobación de cotización</td><td>3</td><td>Billing & Payments</td></tr>
<tr><td>55</td><td>US039</td><td>Cancelación de cotización</td><td>2</td><td>Billing & Payments</td></tr>
<tr><td>56</td><td>US041</td><td>Generación de comprobante de pago</td><td>5</td><td>Billing & Payments</td></tr>
<tr><td>57</td><td>US043</td><td>Registro de pago parcial en comprobante</td><td>5</td><td>Billing & Payments</td></tr>
<tr><td>58</td><td>US042</td><td>Checkout con pago inmediato</td><td>5</td><td>Billing & Payments</td></tr>
<tr><td>59</td><td>US044</td><td>Pago con Stripe</td><td>8</td><td>Billing & Payments</td></tr>
<tr><td>60</td><td>US045</td><td>Consulta de comprobantes por sucursal</td><td>2</td><td>Billing & Payments</td></tr>
</table>
