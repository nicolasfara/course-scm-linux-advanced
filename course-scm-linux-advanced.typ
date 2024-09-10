#import "@preview/polylux:0.3.1": *
#import "@preview/fontawesome:0.1.0": *

#import themes.metropolis: *

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: [Nicolas Farabegoli --- Advanced Linux \@ SCM Campus #datetime.today().year()]
)

#set text(lang: "it")
#set text(font: "Fira Sans", weight: 350, size: 20pt)
#show math.equation: set text(font: "New Computer Modern Math")
#set strong(delta: 200)
#set par(justify: true)

#set quote(block: true)
#show quote: set align(left)
#show quote: set pad(x: 2em, y: -0.8em)

#set raw(tab-size: 4)
#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: 1em,
  radius: 0.7em,
  width: 100%,
)

#show bibliography: set text(size: 0.8em)
#show footnote.entry: it => {
  block(inset: (x: 2em, y: 0.1em))[#text(size: 0.75em)[#it.note.body]]
}

#let fcite(clabel) = {
  footnote(cite(form: "full", label(clabel)))
}

#let author = block(inset: 0.0em)[
  #table(inset: (0em, 0.7em), stroke: none, columns: (auto, 4fr),  align: (left, left),
    [#alert[*Nicolas Farabegoli*]], []
  )
  #place(right + top, dy: 4.5em)[
    #figure(image("images/disi.svg", width:40%))
  ]
]

#title-slide(
  title: [Advanced Linux],
  subtitle: [Demoni e timer --- Package manager --- Ambienti grafici],
  author: author,
  date: [Compiled *#datetime.today().display()*], //.display("[day] [month repr:long] [year]"),
)

#new-section-slide([Init System --- OpenRC vs Systemd])

#slide(title: [Che cos'è un *Init System*?])[
  In *Linux* e sistemi *Unix-like* l'#underline[init system] è il #alert[primo] processo e che si occupa di avviare *tutti* gli altri processi del sistema.

  Questo processo viene *eseguito dal kernel* a tempo di avvio con `PID 1` (quello con `ID 0` è il kernel stesso) ed è eseguito in #alert[background] fino allo spegnimento del sistema.

  Un processo può avviare altri processi (child), ma se il processo padre *muore*,
  #alert[init] si occupa di "adottare" i processi orfani.

  #figure(image("images/Linux-init-Systems.png")) // CAMBIARE IMMAGINE
]

#slide(title: [Init systems disponibili])[
  Nel corso degli anni sono stati proposti diversi *init system* adottati dalle principali distribuzioni *Linux*.

  I principali sono:
  - *`System V`* (`SysV`) --- _a mature and popular init scheme on Unix-like operating systems_
  - #alert[*`OpenRC`*] --- _a dependency-based init scheme for Unix-like operating systems_
  - #alert[*`Systemd`*] --- _relatively new init scheme on the Linux platform_
  - *`Upstart`* --- _an event-based init system developed by Canonical_ (_*fuori produzione*_ #fa-warning())

  In questo corso ci concentreremo su *OpenRC* e *Systemd*.
]

// #slide[
//   #bibliography("bibliography.bib")
// ]
