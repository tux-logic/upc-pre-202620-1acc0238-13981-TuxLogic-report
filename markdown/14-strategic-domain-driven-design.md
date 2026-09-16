## 2.5. Strategic-Level Domain-Driven Design

### 2.5.1. EventStorming

Para el diseño estratégico de ShiftIq se empleó **EventStorming** como técnica para explorar y estructurar el dominio del sistema a partir de los acontecimientos relevantes del negocio. Esta actividad permitió pasar de una visión general del dominio hacia una identificación progresiva de eventos, causas, procesos y límites de responsabilidad.

El proceso se desarrolló tomando como punto de partida el **Big Picture EventStorming** realizado anteriormente en la etapa de Needfinding. En dicho análisis ya se habían identificado acontecimientos relacionados con la vinculación del vehículo, recepción de telemetría, detección de códigos DTC, evaluación de severidad, reserva de citas, gestión del taller y actualización del historial de servicio.

Para profundizar este análisis en el nivel estratégico de DDD, el EventStorming se organizó en tres actividades: **Collect Domain Events**, **Refine Domain** y **Track Causes (Process Modelling)**. Los resultados de estas actividades fueron utilizados posteriormente para identificar los **Candidate Bounded Contexts**, establecer sus interacciones mediante **Domain Message Flows** y formalizar cada contexto mediante **Bounded Context Canvases**.

#### Collect Domain Events

En la primera actividad se recopilaron los principales **Domain Events** asociados con las actividades del dominio automotriz de ShiftIq. El objetivo fue obtener una visión amplia de los hechos relevantes que ocurren durante los diferentes procesos del sistema, sin establecer inicialmente límites entre contextos.

![Collect Domain Events — EventStorming parte 1](../assets/chapter2/strategic-level-DDD/event-storming/event_storming_s1.jpg)

**Figura 16.** Collect Domain Events — Identificación de eventos de dominio de ShiftIq.

La actividad permitió reunir acontecimientos relacionados con identidad, gestión del taller, vehículos, telemetría, diagnóstico, citas, órdenes de trabajo, inventario, cotizaciones y pagos. Esta recopilación constituye la materia prima para el posterior refinamiento del dominio.

#### Refine Domain

A continuación, los eventos recopilados fueron revisados y refinados para distinguir los acontecimientos relevantes del negocio de acciones, datos o elementos que no representan hechos de dominio. También se consolidaron eventos relacionados y se estableció una nomenclatura orientada al lenguaje del dominio.

![Refine Domain — EventStorming parte 2](../assets/chapter2/strategic-level-DDD/event-storming/event_storming_s2.jpg)

**Figura 17.** Refine Domain — Refinamiento y organización de los eventos del dominio.

El refinamiento permitió obtener un conjunto de eventos más consistente y representativo de los procesos principales de ShiftIq. Esta etapa es importante porque proporciona una base común para posteriormente identificar agrupaciones de responsabilidades.

#### Track Causes (Process Modelling)

Finalmente, se realizó el seguimiento de las causas y consecuencias de los eventos mediante **Process Modelling**. En esta actividad se relacionaron los elementos del EventStorming, principalmente **Actor, Command, Event, Business Process/Policy, Aggregate, External System y Hotspot**.

![Track Causes (Process Modelling) — EventStorming parte 3](../assets/chapter2/strategic-level-DDD/event-storming/event_storming_s3.jpg)

**Figura 18.** Track Causes (Process Modelling) — Relación causal de comandos, eventos y procesos.

El modelado permitió comprender cómo una acción ejecutada por un actor genera un comando que modifica el estado de un agregado y produce un evento. Asimismo, permitió identificar interacciones con sistemas externos y puntos de incertidumbre o riesgo (*hotspots*).

Entre los principales problemas identificados previamente se encuentran la conectividad inestable, el consumo de datos de telemetría, los retrasos o inasistencias a las citas, la incertidumbre respecto a los presupuestos y la necesidad de simplificar la gestión del taller.

El resultado de estas tres actividades constituyó la base para la siguiente etapa: **Candidate Context Discovery**.

#### 2.5.1.1. Candidate Context Discovery



#### 2.5.1.2. Domain Message Flows Modeling



#### 2.5.1.3. Bounded Context Canvases



### 2.5.2. Context Mapping



### 2.5.3. Software Architecture

#### 2.5.3.1. Software Architecture Context Level Diagrams



#### 2.5.3.2. Software Architecture Container Level Diagrams



#### 2.5.3.3. Software Architecture Deployment Diagrams
