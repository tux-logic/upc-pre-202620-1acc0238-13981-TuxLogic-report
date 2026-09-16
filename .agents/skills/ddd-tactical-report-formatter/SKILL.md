---
name: ddd-tactical-report-formatter
description: >-
  Use this skill whenever integrating, documenting, or formatting a Tactical DDD Bounded Context
  into the project report files (both Markdown and Typst formats) and compiling the final PDF.
---

# Tactical DDD Bounded Context Report Formatter Skill

This skill defines the complete, standardized workflow and visual design guidelines for integrating a Tactical Domain-Driven Design (DDD) Bounded Context specification into the report codebase.

--------------------------------------------------------------------------------

## 1. Dual File Target Requirements

Every Bounded Context specification (e.g. `docs/<context>-bounded-contexts-dictionary.md`) must be integrated into **BOTH** report target files:

1. **Markdown Version:** [`markdown/15-tactical-domain-driven-design.md`](file:///home/aldo/Proyectos/University/Mobile-Applications/report/upc-pre-202620-1acc0238-13981-TuxLogic-report/markdown/15-tactical-domain-driven-design.md)
   - Standard GitHub Flavored Markdown syntax.
   - Embed diagrams with standard image tags: `![Caption](../assets/<context>/<diagram-name>.svg)`.
2. **Typst Version:** [`typst/15-tactical-level-domain-driven-design.md`](file:///home/aldo/Proyectos/University/Mobile-Applications/report/upc-pre-202620-1acc0238-13981-TuxLogic-report/typst/15-tactical-level-domain-driven-design.md)
   - Unified inside the top-level ````{=typst}` raw block.
   - Utilizes Typst native styling, blocks, grids, tables, and figures.

--------------------------------------------------------------------------------

## 2. Content Preservation & Strict No-Emoji Rule

- **Zero Content Omission:** Maintain 100% exhaustive content preservation from the dictionary source. Do NOT summarize, drop, or truncate attributes, methods, invariants, events, DTOs, or database schemas.
- **No Emojis:** Remove all emoji characters (`📌`, `🟧`, `🟦`, `🟩`, `🔹`, `⭐`, etc.) from both Markdown and Typst files. Use clean monospace code blocks and bold typography instead.

--------------------------------------------------------------------------------

## 3. Native Vector SVG Diagram Compilation

Extract all Mermaid blocks from the Bounded Context dictionary and compile them into native SVG vector files under `assets/<context>/`:

1. Save Mermaid diagram source to temporary `.mmd` files.
2. Ensure Mermaid CLI config (`scratch/mermaid-config.json`) has `"htmlLabels": false` to force native SVG `<text>` elements:
   ```json
   { "htmlLabels": false }
   ```
3. Compile using `@mermaid-js/mermaid-cli`:
   ```bash
   npx -y @mermaid-js/mermaid-cli -i scratch/<diagram>.mmd -o assets/<context>/<diagram>.svg -c scratch/mermaid-config.json -b transparent
   ```
4. Embed in Typst inside a styled white container block:
   ```typst
   #align(center)[
     #figure(
       block(
         fill: rgb("#ffffff"),
         stroke: 0.5pt + rgb("#cbd5e1"),
         inset: 8pt,
         radius: 4pt,
         image("assets/<context>/<diagram>.svg", width: 95%)
       ),
       caption: [Caption del Diagrama -- <Context>]
     )
   ]
   ```
5. **Diagram Image Scaling Rule for Large Diagrams:**
   - If a diagram is visually very large, tall, or wide (such as large ERDs, complex C4 component diagrams, or extensive domain model diagrams), **scale down the image width** (e.g., set `width: 75%`, `width: 80%` or `width: 85%` instead of `95%` or `100%`) so it fits harmoniously on the page without overflowing or taking up disproportionate space.

--------------------------------------------------------------------------------

## 4. Typst UI & Visual Design System

### A. Card Blocks (`#block`)
Wrap Aggregate Roots, Entities, Repositories, Services, and Controllers inside clean card blocks:

```typst
#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[`ClassName` (Role)] \
  #text(size: 9.5pt, fill: rgb("#475569"))[*Tipo:* Category (`extends BaseClass`)] \
  *Propósito:* Detailed description of purpose. \
  #v(4pt)
  *Atributos:*
  - `attributeName`: `Type` -- Description.
  #v(4pt)
  *Métodos y Comportamientos:*
  - `methodName()`: Description.
]
```

### B. 2-Column Grids (`#grid`)
Use 2-column grids for side-by-side elements like Value Objects or Enumerations:

```typst
#grid(
  columns: (1fr, 1fr),
  gutter: 10pt,
  block(
    fill: rgb("#f8fafc"),
    stroke: 0.5pt + rgb("#cbd5e1"),
    radius: 4pt,
    inset: 8pt,
    width: 100%
  )[
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `ValueObject1`] \
    *Propósito:* Purpose statement.
  ],
  block(
    fill: rgb("#f8fafc"),
    stroke: 0.5pt + rgb("#cbd5e1"),
    radius: 4pt,
    inset: 8pt,
    width: 100%
  )[
    #text(weight: "bold", fill: rgb("#1e3a8a"))[Record: `ValueObject2`] \
    *Propósito:* Purpose statement.
  ]
)
```

### C. Minimalist CQRS Commands & Queries Block
Group application DTOs into a single clean block with two internal sections:

```typst
#block(
  fill: rgb("#f8fafc"),
  stroke: 0.5pt + rgb("#cbd5e1"),
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Comandos de Escritura (CQRS Commands):] \
  - `CommandName(Params)`: Description.

  #v(8pt)
  #text(weight: "bold", fill: rgb("#1e3a8a"))[Consultas y DTOs de Resultado (CQRS Queries):] \
  - `QueryName(Params)`: Description.
]
```

--------------------------------------------------------------------------------

## 5. Database Table Formatting & Overflow Prevention

- **Database Version:** Always specify **PostgreSQL 18**.
- **Rounded Table Corners:** Global template (`typst/template.typ`) includes:
  ```typst
  #show table: it => block(
    radius: 5pt,
    stroke: 0.4pt + rgb("#cbd5e1"),
    clip: true,
    it
  )
  ```
- **Table Titles Above Tables:** Place table titles in bold text above the table (`#text(weight: "bold", size: 9.5pt, fill: rgb("#334155"))[Tabla: table_name]`). Do NOT put long table names inside column headers.
- **Fixed Proportional Column Widths:**
  ```typst
  #align(center)[
    #table(
      columns: (85pt, 95pt, 1fr),
      align: (left, center, left),
      table.header([Columna], [Tipo de Dato], [Constraints / Descripción]),
      [*`id`*], [`UUID`], [`PRIMARY KEY, DEFAULT gen_random_uuid()`],
      ...
    )
  ]
  ```

--------------------------------------------------------------------------------

## 6. Anti-Orphan Heading & Pagebreak Rules

- **Global Heading Sticky Rule:** Ensure `typst/template.typ` includes:
  ```typst
  #show heading: set block(sticky: true)
  ```
- **Sticky Subheaders:** Wrap custom text section headers in sticky blocks to prevent orphaned titles at the bottom of pages:
  ```typst
  #block(sticky: true)[
    #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[1.1. Aggregates & Entities]
  ]
  ```

--------------------------------------------------------------------------------

## 8. Hierarchical Subheader Numbering Rule

Never restart subheaders from `1.1.` inside a sub-layer. Every subheader must follow the strict hierarchical path of the document tree:

- **Top Section:** `2.6. Tactical-Level Domain-Driven Design`
- **Bounded Context:** `2.6.1. Bounded Context: Shared Kernel` / `2.6.2. Bounded Context: Identity & Access Management (IAM)`
- **Layer Header:** `2.6.1.1. Domain Layer` / `2.6.2.1. Domain Layer`
- **Sub-layer Headers:**
  - `2.6.1.1.1. Base Aggregates & Abstract Entities`
  - `2.6.1.1.2. Shared Value Objects & Records`
  - `2.6.1.1.3. Cross-Context Domain Events`
  - `2.6.2.1.1. Aggregates & Entities`
  - `2.6.2.1.2. Value Objects & Records`
  - `2.6.2.1.3. Enumerations`
  - `2.6.2.1.4. Domain Repositories (Interfaces)`
  - `2.6.2.1.5. Domain Events`

--------------------------------------------------------------------------------

## 9. Report Compilation & Verification Command

After updating the Bounded Context in both files, run the full Pandoc/Typst compilation command:

```bash
pandoc --template=typst/template.typ typst/1-cover.md typst/2-report-version-log.md typst/3-project-report-collaboration-insights.md typst/4-student-outcome.md typst/5-content.md typst/6-smart-goals.md typst/7-startup-profile.md typst/8-solution-profile.md typst/9-target-segments.md typst/10-competitors.md typst/11-interviews.md typst/12-needfinding.md typst/13-requirements-specification.md typst/14-strategic-level-domain-driven-design.md typst/15-tactical-level-domain-driven-design.md -o informe_final.pdf --pdf-engine=typst
```

Verify that the process exits with **code 0** and produces a clean, un-truncated `informe_final.pdf`.
