# 🚀 Guía Paso a Paso para la Configuración de Jira Software — Sprint 2 (ShiftIQ / TuxLogic)

Esta guía contiene la configuración paso a paso exacta para configurar **Jira Software** para el **Sprint 2**, reflejando la arquitectura de **dos aplicaciones móviles clientes** en dos repositorios independientes:
1. **Segmento 1 (Talleres Mecánicos B2B):** `shiftiq_mobile_app_flutter` (Desarrollado en **Flutter / Dart**)
2. **Segmento 2 (Conductores Particulares B2C):** `shiftiq-mobile-app` (Desarrollado en **Kotlin / Android Jetpack Compose**)
3. **Plataforma Backend:** `shiftiq-platform` (Spring Boot 3.5.5 / PostgreSQL 18)

---

## 🟢 PASO 1: Acceso al Tablero y Creación de Épicas (Epics)

1. **Ingresar a Jira:**  
   Accede al tablero de Scrum de TuxLogic en Jira:  
   👉 **`https://tux-logic.atlassian.net/jira/software/projects/TL/boards/2`**

2. **Crear o Habilitar las Épicas del Sprint 2:**  
   En la vista de **Backlog**, activa el panel lateral de **Epics** y crea o selecciona las siguientes Épicas temáticas:
   - `EP-07`: **Workshop Mobile App (Flutter B2B - Talleres)**
   - `EP-08`: **Driver Mobile App (Kotlin Compose B2C - Conductores)**
   - `EP-09`: **IAM Mobile Security & JWT Authentication**
   - `EP-10`: **Vehicle Telematics & OBD-II Bluetooth Integration**
   - `EP-11`: **Service Operations & Mechanic Task Workflow**
   - `EP-12`: **Mobile CI/CD Deployment & Testing Suites**

---

## 🟢 PASO 2: Crear las Historias de Usuario (User Stories) e Historias Técnicas

En la sección del Backlog, crea las siguientes **8 Historias de Usuario** priorizadas para el Sprint 2. Asigna sus Story Points (**Total: 42 SP**) y vincúlalas a su Épica y Plataforma correspondiente:

| ID Historia | Título Exacto en Jira | Plataforma / Repositorio | Épica | Story Points | Responsable Principal |
| :--- | :--- | :--- | :---: | :---: | :--- |
| **`US001`** | Registro de taller y dueño (Flutter B2B) | `shiftiq_mobile_app_flutter` | `EP-07` | **5 SP** | Dhilsen Mallqui (`Dhilsen18`) |
| **`US002`** | Inicio de sesión y autenticación JWT | `shiftiq_mobile_app_flutter` & `shiftiq-mobile-app` | `EP-09` | **3 SP** | Alan Mamani (`alanjm-pe`) |
| **`US005`** | Gestión de empleados y roles del taller | `shiftiq_mobile_app_flutter` | `EP-07` | **5 SP** | Jareth Vidal (`Jareth-18`) |
| **`US006`** | Gestión de sucursales del taller | `shiftiq_mobile_app_flutter` | `EP-07` | **3 SP** | Dhilsen Mallqui (`Dhilsen18`) |
| **`US012`** | Creación de Orden de Trabajo | `shiftiq_mobile_app_flutter` | `EP-11` | **5 SP** | Jareth Vidal (`Jareth-18`) |
| **`US014`** | Panel de ejecución de tareas mecánicas | `shiftiq_mobile_app_flutter` | `EP-11` | **5 SP** | Dhilsen Mallqui (`Dhilsen18`) |
| **`US017`** | Registro vehicular en Mi Garaje (Kotlin B2C) | `shiftiq-mobile-app` | `EP-08` | **3 SP** | Alan Mamani (`alanjm-pe`) |
| **`US018`** | Vinculación telemática con escáner OBD-II | `shiftiq-mobile-app` | `EP-10` | **5 SP** | Alan Mamani (`alanjm-pe`) |
| **`TS-04`** | Suites de Pruebas Unitarias Móviles y Backend | Ambos repositorios móviles | `EP-12` | **4 SP** | Diego Ramos (`DiegoRamosH`) |
| **`TS-05`** | Pipeline GitHub Actions & Release de APKs | Ambos repositorios móviles | `EP-12` | **4 SP** | Diego Ramos (`DiegoRamosH`) |

> 📌 **Verificación de Estimación:** La suma de Story Points debe sumar exactamente **42 Story Points**.

---

## 🟢 PASO 3: Crear y Configurar el Sprint 2

1. **Crear el Sprint:**  
   Haz clic en **"Create Sprint"** en la parte superior del Backlog. Se creará el contenedor `Sprint 2`.

2. **Editar Parámetros del Sprint 2:**  
   Haz clic en los tres puntos (`...`) del Sprint y selecciona **Edit Sprint**:
   - **Sprint Name:** `Sprint 2`
   - **Duration:** `3 weeks` (o `Custom`)
   - **Start Date:** `05/10/2026, 03:30 PM`
   - **End Date:** `28/10/2026, 03:30 PM`
   - **Sprint Goal:** Copia y pega exactamente este texto formal:
     ```text
     Our focus is on developing and deploying the first functional release of the dual mobile client applications for ShiftIQ: the Workshop Mobile App built with Flutter for Segment 1 (Workshop administration, branch management, mechanic staff roles, and work order tracking) and the Driver Mobile App built with native Kotlin (Android Jetpack Compose) for Segment 2 (Vehicle garage, Bluetooth OBD-II device pairing, DTC telemetry alerts, and service appointment booking). We believe it delivers tailored, touch-optimized, and testable mobile client experiences for both sides of the market, seamlessly synchronizing vehicle telematics and workshop operational workflows through the deployed Spring Boot RESTful API. This will be confirmed when both mobile applications connect in real time to the cloud backend endpoints, execute their respective end-to-end user journeys without mock simulation, pass their automated unit/widget test suites, and generate signed release APKs on GitHub Releases.
     ```

3. **Mover las Historias al Sprint 2:**  
   Arrastra las historias desde el Backlog hacia la caja del **`Sprint 2`**. Confirma que el contador de Story Points marque **`42`**.

---

## 🟢 PASO 4: Crear las Sub-tareas Técnicas (Child Issues / Subtasks)

Entra a cada Historia de Usuario dentro del Sprint 2 y crea las sub-tareas técnicas correspondientes (**`WI-21` a `WI-36`**):

### A. Repositorio Flutter (Segmento 1 - Talleres B2B: `shiftiq_mobile_app_flutter`)
- **En `US001` (Registro Taller):**
  - `WI-21`: *Vistas de Registro y Onboarding en Flutter* (`6h` | Asignado: `Jareth Vidal / Dhilsen Mallqui`)
  - `WI-22`: *Integración SignUp API con Dio/Retrofit* (`5h` | Asignado: `Dhilsen Mallqui / Aldo Machacca`)
- **En `US005` (Staff y Roles):**
  - `WI-25`: *Módulo de Colaboradores y Mecánicos en Flutter* (`5h` | Asignado: `Jareth Vidal`)
  - `WI-26`: *Filtrado de Privilegios y Roles RBAC* (`4h` | Asignado: `Aldo Machacca`)
- **En `US006` (Sucursales):**
  - `WI-27`: *CRUD de Sucursales y Sedes en Flutter* (`4h` | Asignado: `Dhilsen Mallqui`)
  - `WI-28`: *Sincronización con `/api/v1/workshops/{id}/branches`* (`4h` | Asignado: `Aldo Machacca`)
- **En `US012` (Órdenes de Trabajo):**
  - `WI-29`: *Formulario Móvil de Orden de Trabajo en Flutter* (`5h` | Asignado: `Jareth Vidal / Dhilsen Mallqui`)
  - `WI-30`: *Apertura de OT en Backend (`/api/v1/work-orders`)* (`4h` | Asignado: `Aldo Machacca`)
- **En `US014` (Tareas Técnicas del Mecánico):**
  - `WI-31`: *Espacio de Trabajo del Mecánico (Iniciar/Pausar/Completar)* (`6h` | Asignado: `Dhilsen Mallqui`)
  - `WI-32`: *Actualización PATCH de Tareas en Tiempo Real* (`4h` | Asignado: `Aldo Machacca`)

### B. Repositorio Kotlin Nativo (Segmento 2 - Conductores B2C: `shiftiq-mobile-app`)
- **En `US002` (Login y JWT):**
  - `WI-23`: *Pantallas de Login en Kotlin (Compose) y Flutter* (`4h` | Asignado: `Alan Mamani / Dhilsen Mallqui`)
  - `WI-24`: *Almacenamiento seguro EncryptedSharedPreferences e Interceptor Bearer* (`5h` | Asignado: `Alan Mamani / Aldo Machacca`)
- **En `US017` (Mi Garaje):**
  - `WI-33`: *Vistas de Mi Garaje en Jetpack Compose (Placa, Marca, VIN)* (`4h` | Asignado: `Alan Mamani`)
  - `WI-34`: *Consumo de API de Vehículos con Retrofit & Hilt* (`4h` | Asignado: `Alan Mamani / Diego Ramos`)
- **En `US018` (Vinculación OBD-II IoT):**
  - `WI-35`: *Emparejamiento Bluetooth con Escáner OBD-II (MAC)* (`5h` | Asignado: `Alan Mamani`)
  - `WI-36`: *Consumo de `/api/v1/vehicles/{id}/obd2/bind` y Alertas DTC* (`4h` | Asignado: `Alan Mamani / Aldo Machacca`)

### C. DevOps, QA & Releases (`TS-04` y `TS-05`)
- **En `TS-04` (Testing):**
  - `WI-37`: *Batería de Pruebas Unitarias en Flutter (`flutter test`)* (`4h` | Asignado: `Dhilsen Mallqui`)
  - `WI-38`: *Pruebas Unitarias JUnit/Robolectric en Kotlin* (`4h` | Asignado: `Diego Ramos`)
- **En `TS-05` (Deployment):**
  - `WI-39`: *GitHub Actions CI/CD para compilar APK de Flutter* (`4h` | Asignado: `Diego Ramos`)
  - `WI-40`: *GitHub Actions CI/CD para compilar y firmar APK de Kotlin* (`4h` | Asignado: `Diego Ramos`)

---

## 🟢 PASO 5: Iniciar el Sprint y Mover a "Done"

1. **Iniciar el Sprint:**  
   Haz clic en el botón azul **"Start Sprint"** arriba a la derecha.  
   Confirma la fecha de inicio (`05/10/2026`), fecha de fin (`28/10/2026`) y el objetivo (*Sprint Goal*).
2. **Tomar Captura 1:**  
   👉 Antes de mover las tareas, captura la pantalla del **Backlog** mostrando las historias del Sprint 2 y los **42 Story Points** estimadas. Guárdala como:  
   `assets/chapter-4/sprint-2/sprint2_backlog.png`
3. **Mover las Tareas a Done:**  
   Ve a la pestaña **Active Sprints** (Tablero). Arrastra cada una de las historias y sub-tareas a través de `In Progress` hasta la columna **`Done`** (100% completado).
4. **Tomar Captura 2:**  
   👉 Captura el tablero activo con todas las tarjetas en la columna **Done**. Guárdala como:  
   `assets/chapter-4/sprint-2/sprint2_board.png`

---

## 📸 Resumen de Evidencias y Capturas a Guardar para el Sprint 2

Coloca todas las capturas en la carpeta:  
📁 `assets/chapter-4/sprint-2/`

### 1. Gestión en Jira
- `sprint2_backlog.png`: Vista del backlog del Sprint 2 planificado con 42 SP.
- `sprint2_board.png`: Tablero activo de Jira con todas las historias en **Done**.

### 2. Evidencias del Repositorio Flutter (Taller B2B: `shiftiq_mobile_app_flutter`)
- `mobile_work_orders_execution.png`: Pantallas de la app en Flutter (Dashboard del taller, listado de órdenes de trabajo y espacio de tareas del mecánico).

### 3. Evidencias del Repositorio Kotlin (Conductor B2C: `shiftiq-mobile-app`)
- `mobile_auth_and_dashboard.png`: Pantallas de la app en Kotlin (Login, vista de "Mi Garaje" con vehículos registrados y alertas DTC de diagnóstico).
- `mobile_vehicle_iot_pairing.png`: Pantalla de vinculación Bluetooth con el sensor telemático OBD-II.

### 4. Evidencias de Backend y Pruebas
- `mobile_tests_evidence.png`: Captura de las suites de pruebas pasando en verde (`flutter test` y pruebas JUnit en Android Studio).
- `backend_swagger_mobile_endpoints.png`: Captura de Swagger UI ejecutando con éxito los endpoints de `/api/v1/vehicles` y `/api/v1/work-orders`.

### 5. Despliegue y Colaboración en GitHub (ambos repositorios)
- `mobile_deployment_github_actions.png`: Pipeline de GitHub Actions ejecutado en verde generando los paquetes APK.
- `mobile_github_release_apk.png`: Sección Releases de GitHub mostrando los archivos descargables `shiftiq-workshop-release-v1.0.0.apk` y `shiftiq-driver-release-v1.0.0.apk`.
- `mobile_contributors_graph.png`: Gráfico de contribuidores en GitHub Insights mostrando la participación de los 5 integrantes.
- `mobile_pulse_activity.png`: Resumen de actividad semanal en GitHub Pulse.
- `mobile_closed_pull_requests.png`: Historial de Pull Requests cerrados y fusionados hacia `develop`.

