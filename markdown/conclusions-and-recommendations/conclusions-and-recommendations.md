# Conclusiones y Recomendaciones

## Conclusiones

1. **Cumplimiento y Validación de los Problem Statements (PS-1 y PS-2):**  
   A través del ciclo de ingeniería y diseño desarrollado en el Sprint 1, el equipo contrastó los *Problem Statements* definidos durante la fase de Lean UX frente a los requerimientos de la industria automotriz y conductores en Lima Metropolitana:
   - Respecto al **Problem Statement 1 (Administradores de Talleres Automotrices B2B)**, se confirmó que la carencia de plataformas tecnológicas integradas mantenía a los talleres independientes en un esquema puramente reactivo y con alta variabilidad de ingresos. La arquitectura de ShiftIQ —que articula la ingestión de telemetría vehicular, pre-diagnóstico de códigos de falla y agendamiento estructurado— demostró proporcionar a los administradores la base operativa para transformar emergencias imprevistas en citas preventivas planificadas, optimizando el uso de sus bahías mecánicas.
   - Respecto al **Problem Statement 2 (Conductores de Vehículos Particulares B2C)**, la investigación y el diseño de experiencia evidenciaron que la desconfianza hacia los talleres mecánicos tradicionales se debe fundamentalmente a la asimetría informativa y la falta de transparencia en las cotizaciones. La traducción de códigos DTC crudos (OBD2) a explicaciones comprensibles y semaforizadas en lenguaje natural (Baja, Media y Crítica), junto con cotizaciones referenciales previas, permite disipar el escepticismo del usuario, incentivando el mantenimiento oportuno antes de sufrir averías graves en ruta.

2. **Contraste de Assumptions frente a la Propuesta de Valor y Comportamiento de los Segmentos:**  
   La confrontación de las hipótesis y creencias iniciales (*Assumptions*) con los artefactos de diseño y prototipos interactivos arrojó aprendizajes técnicos sustanciales:
   - *Business & Outcome Assumptions:* Se ratificó la viabilidad del modelo de suscripción escalonada (SaaS B2B) para los talleres mecánicos, respaldado por la capacidad de derivación de conductores con necesidades de mantenimiento diagnosticadas.
   - *User & Benefit Assumptions:* Se confirmó que los conductores particulares no buscan interactuar diariamente con la aplicación ni saturarse de gráficos técnicos complejos, sino contar con un asistente confiable y silencioso que únicamente emita alertas oportunas ante anomalías mecánicas o proximidad de revisiones por kilometraje. En los talleres, se validó la exigencia de una consola operativa ágil que reduzca tiempos administrativos.
   - *Feature Assumptions:* Las funcionalidades priorizadas para el Sprint 1 —conversión de códigos de falla a lenguaje natural, agendamiento express y visualización de planes de suscripción en la Landing Page comercial— representan los componentes de mayor tracción y valor percibido para la solución.

3. **Verificación de Hypothesis Statements y Criterios de Éxito de Lean UX:**  
   Los prototipos y flujos funcionales permitieron evaluar la consistencia de las hipótesis formuladas en Lean UX:
   - *Hipótesis 1 (Gestión Proactiva del Taller):* La disponibilidad de una bandeja de alertas mecánicas entrantes permite al personal del taller anticipar la demanda de repuestos y mano de obra, orientando la prospección comercial hacia vehículos con fallas activas.
   - *Hipótesis 2 (Adopción y Confianza del Conductor):* La simplificación del diagnóstico técnico proporciona certidumbre al usuario, reduciendo el temor al sobreprecio y elevando la disposición a acudir al taller preventivamente.
   - *Hipótesis 3 (Flujo de Agendamiento Sin Fricción):* El flujo interactivo diseñado en Figma consolida la vinculación directa entre la notificación de falla y la reserva de cita técnica en menos de 60 segundos, minimizando los pasos de interacción.

4. **Solidez de la Implementación Técnica y Despliegue en Producción (Sprint 1 / TB1):**  
   El cierre del primer ciclo de desarrollo (Segundo Hito TB1) consolidó la entrega de software funcional, modular y desplegado en entornos cloud:
   - **Landing Page Comercial en Producción:** Maquetada con HTML5 semántico, CSS3 modular y JavaScript moderno, optimizada para SEO y accesibilidad, y desplegada exitosamente en Vercel Cloud ([https://shiftiq-landing-page.vercel.app/](https://shiftiq-landing-page.vercel.app/)) con calificaciones Lighthouse de 98 a 100.
   - **Backend REST API Platform en Render Cloud:** Implementado bajo la arquitectura hexagonal y patrones tácticos de *Domain-Driven Design* (DDD) en Spring Boot 3.5.5 y Java 21, desacoplado en Bounded Contexts independientes con persistencia en PostgreSQL, desplegado y operativo en la nube de Render Cloud ([https://shiftiq-platform.onrender.com/](https://shiftiq-platform.onrender.com/)), con documentación interactiva pública en Swagger UI ([https://shiftiq-platform.onrender.com/swagger-ui/index.html](https://shiftiq-platform.onrender.com/swagger-ui/index.html)).
   - **Aseguramiento de Calidad:** Suite de pruebas unitarias automatizadas ejecutada exitosamente con JUnit 5 y Mockito (`42 tests passed, 0 failures, 0 errors`), garantizando la robustez de los controladores, servicios de aplicación y reglas de negocio del dominio.
   - **Diseño UI/UX Móvil:** Prototipado completo de las pantallas core en Figma (Wireframes, Wireflows y Mockups de alta fidelidad) preparado para la siguiente etapa de desarrollo.

---

## Recomendaciones

1. **Roadmap de Productos Digitales — Sprint 2 (Tercer Hito: AV2 / Semana 12):**  
   - **Desarrollo de la Aplicación Móvil:** Iniciar la codificación de la aplicación móvil cliente en Flutter/Dart y Kotlin Multiplatform Mobile (KMM), consumiendo los endpoints REST ya desplegados en Render para autenticación (IAM), gestión de perfil y vehículos (Fleet) y programación de servicios (Operations).
   - **Integración de Pasarela de Pagos (Stripe):** Implementar la arquitectura de pagos investigada en la Spike Story, conectando el backend con el SDK cliente de Stripe para procesar cobros de suscripciones y pagos de órdenes de trabajo.
   - **Ejecución de Pruebas de Usabilidad y Evaluaciones Heurísticas:** Con la aplicación móvil en funcionamiento sobre dispositivos físicos y emuladores, llevar a cabo las sesiones formales de evaluación heurística de UX (según las 10 heurísticas de Nielsen y principios de diseño inclusivo) y registrar las entrevistas de validación correspondientes.

2. **Roadmap de Productos Digitales — Sprint 3 (Cuarto Hito: TB2 / Semana 15):**  
   - **Ingesta de Telemetría IoT en Tiempo Real:** Configurar brokers de mensajería liviana (MQTT / WebSockets) para la transmisión asíncrona de telemetría de motor y códigos DTC en vivo desde el dispositivo OBD2.
   - **Distribución de la Aplicación Móvil:** Publicar las versiones beta y release a través de Firebase App Distribution para pruebas de campo con usuarios reales.
   - **Producción Audiovisual Oficial:** Desarrollar los videos requeridos para el cierre del proyecto: Video de Validación de la Aplicación, Video *About the Product* y Video *About the Team*.

3. **Estrategia Offline-First y Resiliencia en Red Móvil:**  
   - Incorporar mecanismos de persistencia local en la aplicación móvil (SQLite / Room) para almacenar el historial de diagnósticos y citas en caché, garantizando funcionalidad continua ante intermitencias en la conexión de datos móviles.

4. **Monitoreo y Observabilidad en la Nube:**  
   - Configurar herramientas de observabilidad en el backend (`Spring Boot Actuator` y métricas de salud) para supervisar la latencia de respuesta, el uso de memoria en Render y la concurrencia de peticiones por taller.
