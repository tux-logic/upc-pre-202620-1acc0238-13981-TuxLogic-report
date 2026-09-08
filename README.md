# Informe del Trabajo Final -- TuxLogic (ShiftIq)

**Curso:** 1ACC0238 – Aplicaciones para Dispositivos Móviles (NRC 13981)  
**Universidad:** Universidad Peruana de Ciencias Aplicadas (UPC)  
**Equipo:** TuxLogic  
**Proyecto:** ShiftIq  

---

## 📁 Estructura del Repositorio (Módulos)

```text
upc-pre-202620-1acc0238-13981-TuxLogic-report/
├── assets/                                  # Recursos gráficos compartidos
├── markdown/                                # Módulo 1: Markdown limpio (GFM) sin sintaxis Typst
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
├── typst/                                   # Módulo 2: Código original para motor Typst (vía Pandoc)
│   ├── template.typ                         # Plantilla Typst con marcador $body$
│   ├── header.typ                           # Configuración de estilos y encabezados UPC
│   ├── 1-cover.md                           # Archivos originales con bloques {=typst}
│   ├── 2-report-version-log.md
│   ├── 3-project-report-collaboration-insights.md
│   ├── 4-student-outcome.md
│   ├── 5-content.md
│   ├── 6-smart-goals.md
│   ├── 7-startup-profile.md
│   ├── 8-solution-profile.md
│   ├── 9-target-segments.md
│   ├── 10-competitors.md
│   ├── 11-interviews.md
│   ├── 12-needfinding.md
│   ├── 13-requirements-specification.md
│   ├── 14-strategic-level-domain-driven-design.md
│   └── 15-tactical-level-domain-driven-design.md
├── informe_final.pdf                        # PDF compilado final
└── README.md
```

---

## 🚀 Compilación del PDF (Pandoc + Motor Typst)

Para compilar el informe `informe_final.pdf` a partir del módulo `typst/`, ejecuta:

```bash
pandoc typst/1-cover.md typst/2-report-version-log.md typst/4-student-outcome.md typst/5-content.md typst/6-smart-goals.md typst/7-startup-profile.md typst/8-solution-profile.md typst/9-target-segments.md typst/10-competitors.md typst/11-interviews.md typst/12-needfinding.md typst/13-requirements-specification.md typst/14-strategic-level-domain-driven-design.md typst/15-tactical-level-domain-driven-design.md --pdf-engine=typst --template=typst/template.typ -o informe_final.pdf
```
