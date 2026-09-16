---
name: mermaid-c4-diagram-formatter
description: >-
  Use this skill whenever creating, editing, or formatting Mermaid C4 component diagrams and ERDs
  to compile clean, native SVG vector graphics with bold titles (`font-weight="bold"`) for Typst reports.
---

# Mermaid C4 Diagram & Native Vector SVG Formatter Skill

This skill defines the mandatory guidelines and standards for authoring, styling, and compiling Mermaid C4 component diagrams and ERD diagrams in native SVG vector format for Typst project reports.

--------------------------------------------------------------------------------

## 1. Technical Context: htmlLabels: false & Native SVG Mode

In Typst PDF reports, SVG image rendering requires native SVG vector elements (`<text>`, `<tspan>`, `<rect>`, `<path>`). Typst cannot render HTML `<foreignObject>` tags.

For this reason, `@mermaid-js/mermaid-cli` must be configured with `"htmlLabels": false` in `scratch/mermaid-config.json`.

--------------------------------------------------------------------------------

## 2. Standardized Node Layout

Every C4 component, container, external system, and database node label must strictly adhere to the following 3-part clean layout:

```mermaid
NodeId["Component Title<br>[Technology / Framework]<br>Detailed functional description of the component."]
```

### Layout Elements:
1. **Component Title (First Line):** Clean plain text title (e.g. `ShiftIQ WebApp / Mobile Client` or `QuotesController`). Do not wrap in `<b>` or `**` tags.
2. **Technology / Role Sub-label (Second Line):** Enclose technology, role, or stereotype in square brackets `[Technology]` on a new line after `<br>`.
3. **Functional Description (Subsequent Lines):** Provide concise functional details separated by `<br>`.

--------------------------------------------------------------------------------

## 3. Automated SVG Title Bolding Post-Processor

Because `@mermaid-js/mermaid-cli` in native SVG mode (`htmlLabels: false`) outputs `font-weight="normal"` for all text tspans, run the post-processing script [`scratch/make_svg_titles_bold.py`](file:///home/aldo/Proyectos/University/Mobile-Applications/report/upc-pre-202620-1acc0238-13981-TuxLogic-report/scratch/make_svg_titles_bold.py) after compiling any Mermaid diagram to SVG.

The script automatically sets `font-weight="bold"` on the title lines (all tspans preceding the `[` technology sub-label).

### Execution Steps:
1. **Compile Diagram to SVG:**
   ```bash
   npx -y @mermaid-js/mermaid-cli -i scratch/<diagram>.mmd -o assets/<context>/<diagram>.svg -c scratch/mermaid-config.json -b transparent
   ```
2. **Apply Bold Title Post-Processing:**
   ```bash
   python3 scratch/make_svg_titles_bold.py assets/<context>/<diagram>.svg
   ```
3. **Verify SVG Output:** Check that node titles render in **bold** while technology tags and descriptions remain in regular font weight.

--------------------------------------------------------------------------------

## 4. Multi-File Synchronization Standard

Whenever a C4 diagram is updated or fixed, the changes **MUST** be synchronized across all relevant files:

1. **Dictionary Source:** [`docs/<context>-bounded-context-dictionary.md`](file:///home/aldo/Proyectos/University/Mobile-Applications/report/upc-pre-202620-1acc0238-13981-TuxLogic-report/docs/)
2. **Markdown Report:** [`markdown/15-tactical-domain-driven-design.md`](file:///home/aldo/Proyectos/University/Mobile-Applications/report/upc-pre-202620-1acc0238-13981-TuxLogic-report/markdown/15-tactical-domain-driven-design.md)
3. **Typst Report:** [`typst/15-tactical-level-domain-driven-design.md`](file:///home/aldo/Proyectos/University/Mobile-Applications/report/upc-pre-202620-1acc0238-13981-TuxLogic-report/typst/15-tactical-level-domain-driven-design.md)
4. **SVG Asset:** `assets/<context>/<diagram-name>.svg`
5. **PDF Verification:** Recompile `informe_final.pdf` to ensure all vector diagrams render cleanly without errors.
