# Conclusiones y Recomendaciones

## Conclusiones

1. **Transformación del Modelo de Mantenimiento Automotriz (Propuesta de Valor):**  
   ShiftIq aborda la ineficiencia del mantenimiento reactivo en Lima Metropolitana mediante un ecosistema digital integral que combina telemetría OBD2 en tiempo real con notificaciones preventivas expresadas en lenguaje accesible. Esta integración permite a los conductores tomar decisiones informadas antes de sufrir averías graves y a los talleres mecánicos independientes aplanar la volatilidad de su demanda.

2. **Rigurosidad Arquitectural bajo Domain-Driven Design (DDD):**  
   La aplicación de metodologías DDD estratégicas y tácticas —a través de *EventStorming*, *Bounded Context Canvases*, *Context Mapping* y el modelado C4 (Contexto, Contenedores y Despliegue)— permitió estructurar una plataforma distribuida desacoplada en 7 *Bounded Contexts* principales (`IAM`, `Core`, `Fleet`, `IoT`, `Operations`, `Inventory`, `Billing`). Esto asegura mantenibilidad, escalabilidad e independencia funcional de los servicios.

3. **Validación Cualitativa de Necesidades de Usuario (Needfinding & UX Research):**  
   El proceso de investigación cualitativa con actores reales (dueños/administradores de talleres e ingenieros de servicio, así como conductores particulares) respaldó la formulación de los *User Personas*, *User Journey Maps* y *Empathy Maps*. Los hallazgos confirmaron que la falta de confianza y la asimetría informativa son las barreras principales para la adopción de mantenimiento preventivo.

4. **Trazabilidad de Requerimientos y Metodología Ágil:**  
   El catálogo de 60 Historias de Usuario bajo el estándar INVEST, priorizadas mediante estimación de *Story Points* y mapeadas mediante diagramas de *Impact Mapping*, garantiza una alineación transparente entre las necesidades del negocio y la entrega de valor en cada Sprint de desarrollo.

---

## Recomendaciones

1. **Evolución Hacia una Arquitectura de Microservicios Distribuidos (Backend & Cloud):**  
   Se recomienda continuar el desarrollo del backend modular evolucionando la base Spring Boot 3 / Java 21 hacia una arquitectura de microservicios contenerizada con Docker y Kubernetes, aprovechando la separación clara de los 7 Bounded Contexts definidos.

2. **Estrategia Offline-First y Eficiencia Telemática (IoT & Móvil):**  
   Para mitigar la inestabilidad de la conectividad móvil en zonas periféricas de Lima, se recomienda implementar colas de mensajes locales (`SQLite` / `Room` en la app móvil y buffering en el dongle OBD2) que garanticen la sincronización diferida de telemetría sin pérdida de paquetes de datos.

3. **Estrategia de Adopción Gradual y Capacitación para Talleres Mecánicos:**  
   Dado que el segmento de administradores de talleres presenta cierta resistencia a plataformas complejas, se recomienda priorizar interfaces simplificadas con paneles visuales intuitivos, asistentes guiados (*onboarding*) y soporte omnicanal (WhatsApp/llamada) integrado en la plataforma.

4. **Integración de Modelos de Inteligencia Artificial Predictiva (Machine Learning):**  
   En etapas posteriores del proyecto, se sugiere entrenar modelos de aprendizaje automático basados en el historial acumulado de códigos DTC y telemetría para elevar la precisión en la predicción de vida útil de componentes mecánicos.
