# Informe del Trabajo Final -- TuxLogic (ShiftIq)

**Curso:** 1ACC0238 – Aplicaciones para Dispositivos Móviles (NRC 13981)  
**Universidad:** Universidad Peruana de Ciencias Aplicadas (UPC)  
**Equipo:** TuxLogic  
**Proyecto:** ShiftIq  

---

## 📁 Estructura del Repositorio (Módulos)

El repositorio está organizado en dos módulos independientes según el formato de trabajo:

```text
upc-pre-202620-1acc0238-13981-TuxLogic-report/
├── assets/                                  # Recursos gráficos y diagramas compartidos
├── markdown/                                # Módulo 1: Redacción puramente en Markdown (GFM)
│   ├── 01-cover.md
│   ├── 02-report-version-log.md
│   ├── 03-collaboration-insights.md
│   ├── 04-student-outcome.md
│   ├── 05-table-of-contents.md
│   ├── 06-smart-goals.md
│   ├── 07-startup-profile.md
│   ├── 08-solution-profile.md
│   ├── 09-target-segments.md
│   ├── 10-competitors.md
│   ├── 11-interviews.md
│   ├── 12-needfinding.md
│   ├── 13-requirements-specification.md
│   ├── 14-strategic-domain-driven-design.md
│   └── 15-tactical-domain-driven-design.md
├── typst/                                   # Módulo 2: Fuente nativa Typst (Maquetación PDF)
│   ├── main.typ                             # Ensamblador principal del documento PDF
│   ├── header.typ                           # Configuración de estilos, encabezados y fuentes UPC
│   ├── template.typ                         # Plantilla Typst para exportación
│   └── sections/                            # Secciones individuales en sintaxis Typst (.typ)
│       ├── 01-cover.typ
│       ├── 02-version-log.typ
│       ├── 03-collaboration-insights.typ
│       ├── 04-student-outcome.typ
│       ├── 05-table-of-contents.typ
│       ├── 06-smart-goals.typ
│       ├── 07-startup-profile.typ
│       ├── 08-solution-profile.typ
│       ├── 09-target-segments.typ
│       ├── 10-competitors.typ
│       ├── 11-interviews.typ
│       ├── 12-needfinding.typ
│       ├── 13-requirements-specification.typ
│       ├── 14-strategic-domain-driven-design.typ
│       └── 15-tactical-domain-driven-design.typ
├── informe_final.pdf                        # Documento PDF compilado final
└── README.md                                # Documentación del repositorio
```

---

## 🚀 Compilación del Informe en PDF (Módulo Typst)

Para generar el PDF `informe_final.pdf` desde el módulo Typst, ejecuta el siguiente comando desde la raíz del proyecto:

```bash
typst compile --root . typst/main.typ informe_final.pdf
```

Para activar la recompilación automática en tiempo real mientras editas:

```bash
typst watch --root . typst/main.typ informe_final.pdf
```

---

## ✍️ Módulo Markdown (GFM)

La carpeta `markdown/` contiene la versión en Markdown estándar (GitHub Flavored Markdown) del informe. Esta carpeta no contiene bloque alguno de código Typst (`{=typst}`), siendo totalmente portátil para lectura en GitHub, Obsidian o cualquier visor Markdown.
