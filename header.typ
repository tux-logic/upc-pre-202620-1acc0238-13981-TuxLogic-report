// Configuración de página e idioma
#set page(
  paper: "a4",
  margin: (x: 2.5cm, top: 2.8cm, bottom: 2.5cm),
  header: context {
    if counter(page).get().first() > 1 {
      text(size: 8.5pt, fill: rgb("#64748b"))[
        *Universidad Peruana de Ciencias Aplicadas* | Aplicaciones para Dispositivos Móviles
        #h(1fr)
        *TuxLogic* -- ShiftIq
      ]
      v(-4pt)
      line(length: 100%, stroke: 0.4pt + rgb("#cbd5e1"))
    }
  },
  footer: context {
    if counter(page).get().first() > 1 {
      align(center, text(size: 9pt, fill: rgb("#64748b"))[
        Página #counter(page).display("1")
      ])
    }
  }
)

#set text(
  font: ("Liberation Sans", "DejaVu Sans", "Arial", "Roboto"),
  size: 11pt,
  lang: "es",
  region: "PE",
  fill: rgb("#1e293b")
)

#set par(
  justify: true,
  leading: 0.7em,
  spacing: 1.2em
)

// Numeración y diseño de encabezados (Headings)
#set heading(numbering: "1.1.1.")

#show heading.where(level: 1): it => {
  v(1.2em)
  text(fill: rgb("#b91c1c"), weight: "bold", size: 16pt)[
    #if it.numbering != none [
      #counter(heading).display()#h(0.5em)
    ]
    #it.body
  ]
  v(0.6em)
}

#show heading.where(level: 2): it => {
  v(1em)
  text(fill: rgb("#1e3a8a"), weight: "bold", size: 13pt)[
    #if it.numbering != none [
      #counter(heading).display()#h(0.5em)
    ]
    #it.body
  ]
  v(0.5em)
}

#show heading.where(level: 3): it => {
  v(0.8em)
  text(fill: rgb("#334155"), weight: "bold", size: 11pt)[
    #if it.numbering != none [
      #counter(heading).display()#h(0.5em)
    ]
    #it.body
  ]
  v(0.4em)
}

// Estilo de Tablas
#set table(
  stroke: 0.4pt + rgb("#cbd5e1"),
  fill: (x, y) => if y == 0 { rgb("#1e3a8a") } else if calc.even(y) { rgb("#f8fafc") } else { rgb("#ffffff") },
  inset: (x: 10pt, y: 7pt)
)

#show table.cell.where(y: 0): set text(fill: white, weight: "bold")

// Estilo de Figuras e Imágenes
#show figure.where(kind: image): it => [
  #align(center)[
    #block(
      stroke: 0.5pt + rgb("#e2e8f0"),
      inset: 4pt,
      radius: 4pt,
      it.body
    )
    #if it.has("caption") [
      #v(4pt)
      #text(size: 9pt, style: "italic", fill: rgb("#64748b"))[#it.caption]
    ]
  ]
]

// Estilo de Listas
#set list(indent: 1em, marker: ([•], [–], [◦]))
#set enum(indent: 1em)
