#!/bin/bash
echo "======================================================="
echo "Compilando informe_final.pdf con Pandoc y Typst..."
echo "======================================================="

pandoc --template=typst/template.typ \
  typst/01-cover.md \
  typst/02-report-version-log.md \
  typst/03-project-report-collaboration-insights.md \
  typst/04-student-outcome.md \
  typst/05-smart-goals.md \
  typst/06-content.md \
  typst/07-startup-profile.md \
  typst/08-solution-profile.md \
  typst/09-target-segments.md \
  typst/10-competitors.md \
  typst/11-interviews.md \
  typst/12-needfinding.md \
  typst/13-requirements-specification.md \
  typst/14-strategic-level-domain-driven-design.md \
  typst/15-tactical-level-domain-driven-design.md \
  typst/16-solution-ui-ux-design.md \
  typst/17-product-implementation-and-validation.md \
  typst/18-conclusions-and-recommendations.md \
  typst/19-references.md \
  typst/20-appendices.md \
  -o informe_final.pdf --pdf-engine=typst

if [ $? -eq 0 ]; then
    echo "[EXITO] informe_final.pdf generado correctamente."
else
    echo "[ERROR] Hubo un problema al generar informe_final.pdf."
fi
