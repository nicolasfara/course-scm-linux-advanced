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
// #show raw.where(block: true): block.with(
//   fill: luma(240),
//   inset: 1em,
//   radius: 0.7em,
//   width: 100%,
// )

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

#let section(title) = new-section-slide(title)
#let centering(content) = align(center, content)

#let carbon-snippet(
  code,
  theme: "monokai",
  font: "JetBrains Mono",
  background-color: luma(230),
  header-color: rgb("#1e1f1c"),
  radius: 0.3em
) = {
  let themes = (
    "monokai": (
      keyword: rgb("#f92672"),
      function: rgb("#66d9ef"),
      string: rgb("#e6db74"),
      comment: rgb("#75715e"),
      type: rgb("#a6e22e"),
    ),
    // Add more themes here
  )

  let current-theme = themes.at(theme, default: themes.monokai)

  //set text(font: font, size: 9pt, fill: text-color)
  let code-lines = code.text.split("\n")
  let line-count = code-lines.len()
  
  box(
    width: 100%,
    fill: background-color,
    radius: radius,
    stroke: (paint: background-color, thickness: 0.07em),
    [
      #box(
        width: 100%,
        height: 1.3em,
        inset: 0.5em,
        fill: header-color,
        radius: (top-left: radius, top-right: radius),
        [
          #stack(dir: ltr, spacing: 0.4em)[
            #circle(radius: 0.3em, fill: rgb("#ff5f56"))
          ][
            #circle(radius: 0.3em, fill: rgb("#ffbd2e"))
          ][
            #circle(radius: 0.3em, fill: rgb("#27c93f"))
          ]
        ]
      )
      #v(-10pt)
      #pad(
        bottom: 0.8em,
        grid(
          columns: (1em, auto),
          column-gutter: 0.8em,
          row-gutter: 0.4em,
          ..code-lines.enumerate().map(((i, line)) => {
            (
              align(right + horizon, text(fill: header-color, size: 0.8em, str(i + 1))),
              [#raw(line, lang: code.lang)],
            )
          }).flatten()
        )
      )
    ]
  )
}

#let carbon-shell(
  code,
  theme: "monokai",
  font: "JetBrains Mono",
  background-color: luma(230),
  header-color: rgb("#1e1f1c"),
  radius: 0.3em
) = {
  let themes = (
    "monokai": (
      keyword: rgb("#f92672"),
      function: rgb("#66d9ef"),
      string: rgb("#e6db74"),
      comment: rgb("#75715e"),
      type: rgb("#a6e22e"),
    ),
    // Add more themes here
  )

  let current-theme = themes.at(theme, default: themes.monokai)

  //set text(font: font, size: 9pt, fill: text-color)
  let code-lines = code.text.split("\n")
  let line-count = code-lines.len()
  
  box(
    width: 100%,
    fill: background-color,
    radius: radius,
    stroke: (paint: background-color, thickness: 0.07em),
    [
      #box(
        width: 100%,
        height: 1.3em,
        inset: 0.5em,
        fill: header-color,
        radius: (top-left: radius, top-right: radius),
        [
          #stack(dir: ltr, spacing: 0.4em)[
            #circle(radius: 0.3em, fill: rgb("#ff5f56"))
          ][
            #circle(radius: 0.3em, fill: rgb("#ffbd2e"))
          ][
            #circle(radius: 0.3em, fill: rgb("#27c93f"))
          ]
        ]
      )
      #v(-10pt)
      #pad(
        bottom: 0.8em,
        grid(
          columns: (1em, auto),
          column-gutter: 0.8em,
          row-gutter: 0.4em,
          ..code-lines.enumerate().map(((i, line)) => {
            let row-symbol = if i == 0 { ">" } else { "" }
            (
              align(right + horizon, text(fill: header-color, size: 0.8em, row-symbol)),
              [#raw(line, lang: "bash")],
            )
          }).flatten()
        )
      )
    ]
  )
}

#title-slide(
  title: [Advanced Linux],
  subtitle: [Demoni e timer --- Package manager --- Ambienti grafici],
  author: author,
  date: [Compiled *#datetime.today().display()*], //.display("[day] [month repr:long] [year]"),
)

// ============================ Packages and Package Managers ============================
// =======================================================================================
#section([*Package Manager* su distro Linux])

#slide(title: [Che cos'è un *Package Manager*?])[
  #only(1)[
    Un #alert[package manager] è uno strumento (_software_) che permette di gestire l'installazione, la rimozione e l'aggiornamento di #underline[pacchetti software] su un sistema operativo.

    I package manager possono essere:
      - #alert[grafici] --- consentono l'installazione di pacchetti tramite _interfaccia grafica_
      - #alert[testuali] --- consentono l'installazione di pacchetti tramite _riga di comando_
  ]

  #only(2)[
    Un #alert[package manager] è uno strumento (_software_) che permette di gestire l'installazione, la rimozione e l'aggiornamento di #underline[pacchetti software] su un sistema operativo.

    I package manager possono essere:
      - #alert[grafici] --- consentono l'installazione di pacchetti tramite _interfaccia grafica_
      - #alert[testuali] --- consentono l'installazione di pacchetti tramite _linea di comando_

    #v(1em)

    #centering[In questo corso ci concentreremo su package manager a *linea di comando*.]
  ]

  #only(3)[
    #figure(image("images/why-meme.png"))
  ]
]

#slide(title: [Perché la linea di comando?])[
  Se a primo impatto può sembrare più complesso, l'utilizzo della #alert[riga di comando] per la gestione dei pacchetti ha diversi vantaggi:

  - #alert[Velocità]: l'installazione di pacchetti è più veloce
  - #alert[Controllo]: maggiore controllo sulle operazioni
  - #alert[Automatizzazione]: possibilità di automatizzare le operazioni

  Inoltre, la riga di comando è #alert[più leggera] e #alert[più flessibile] rispetto ad una GUI.
]

#slide(title: [Pacchetti software])[
  Un #alert[pacchetto software] è tipicamente una *applicazione* (GUI o CLI) o una *libreria* che può essere installata su un sistema operativo.
  
  #side-by-side(columns: (2fr, auto))[
    È un archivio che può contenere:

      - #alert[binari]
      - #alert[file di configurazione]
      - #alert[documentazione]
      - #alert[informazioni su dipendenze]
      - ...
  ][
    #figure(image("images/linux-packages.png", width: 61%))
  ]
]

#slide(title: [Prima dei package manager])[
  Un tempo il software veniva installato dai suoi #alert[sorgenti], ovvero il codice sorgente del programma.

  Tipicamente un file definiva le #alert[istruzioni di compilazione] e le #alert[dipendenze] necessarie per la compilazione.

  Spettava all'utente *compilare* il software e gestire le eventuali *dipendenze*.

  #v(1em)

  #align(center)[Questo processo era #alert[lungo], #alert[complesso] e #alert[tedioso].]
  #align(center)[Altro annoso problema era #alert[l'aggiornamento del software].]
]

#slide(title: [Gestione dei pacchetti con package manager])[
  Per superare queste limitazioni, ogni distribuzione ha implementato un proprio #alert[formato di pacchetto] e un #alert[package manager] per la gestione dei pacchetti.

  #side-by-side(columns: (2fr, auto), gutter: 2em)[
    L'idea è quella di *semplificare* l'installazione e la gestione del software distribuendolo (principalmente) in forma binaria,
    assieme a #alert[metadati] che descrivono il pacchetto e le sue dipendenze.
  ][
    #figure(image("images/source-code-comilation-vs-packaging.png", height: 55%))
  ]
]

#slide(title: "Come funziona un package manager?")[
  #figure(image("images/linux-package-manager-explanation.png"))
]

#slide(title: "Repository")[

  #side-by-side(columns: (2fr, 1fr), gutter: 1em)[
  (Quasi) tutte le distribuzioni Linux mantengono uno o più #alert[repository] ufficiali contenenti i pacchetti software.

  I repository sono #alert[server] che contengono i pacchetti software e le informazioni necessarie per la loro installazione.

  Esempio di repository: \
  #link("http://archive.ubuntu.com/ubuntu/")[`http://archive.ubuntu.com/ubuntu/`]
  ][
    #figure(image("images/repository.png"))
  ]
]

#slide(title: "Repository e metadati")[
  I *repository* contengono, oltre ai pacchetti software, anche i #alert[metadati] necessari per la gestione degli stessi.

  I #alert[metadati] sono informazioni che descrivono il pacchetto come:
    - nome
    - versione
    - dipendenze
    - descrizione
]

#slide(title: "Package manager e interazioni con repository")[
  Il *package manager* inizialmente interagisce con i metadati, scaricando le informazioni necessarie per la gestione dei pacchetti e le salva in una #alert[cache locale].

  Quando si richiede un aggiornamento, il *package manager* aggiorna la cache locale e confronta le informazioni con quelle presenti nel repository.

  Quando si richiede l'installazione di un pacchetto, il *package manager* interroga la cache locale e quindi scarica il pacchetto dal repository.
  Se il pacchetto ha delle dipendenze, queste vengono scaricate e installate automaticamente.
]

#slide(title: "Esempio installazione pacchetto")[
  #carbon-shell(
    ```
    sudo pacman -Syu freecad

    resolving dependencies...
    looking for conflicting packages...

    Packages (35) asciidoctor-2.0.23-2  blosc-1.21.6-1 ... freecad-1.0rc1-1

    Total Download Size:    239,66 MiB
    Total Installed Size:  1128,19 MiB

    :: Proceed with installation? [Y/n]
    ```
  )
]

// #slide(title: "Deleteme")[
//   #carbon-snippet(
//     ```scala
//     trait Monad[F[_]]:
//       def pure[A](a: A): F[A]
//       def flatMap[A, B](fa: F[A])(f: A => F[B]): F[B]

//     object Monad:
//       def apply[F[_]](using F: Monad[F]): Monad[F] = F

//     given Monad[List] with
//       def pure[A](a: A): List[A] = List(a)
//       def flatMap[A, B](fa: List[A])(f: A => List[B]): List[B] =
//         fa.flatMap(f)
//     ```
//   )
// ]

// #slide(title: [Package Manager su Linux])[
//   #carbon-shell(
//     ```
//     yay -Syu

//     :: Synchronizing package databases...
//      core is up to date
//      extra is up to date
//      multilib is up to date
//     :: Starting full system upgrade...
//      there is nothing to do
//     :: Searching AUR for updates...
//     :: Searching databases for updates...

//     ```
//   )
// ]

// =======================================================================================
// =======================================================================================

// #new-section-slide([Init System --- OpenRC vs Systemd])

// #slide(title: [Che cos'è un *Init System*?])[
//   In *Linux* e sistemi *Unix-like* l'#underline[init system] è il #alert[primo] processo e che si occupa di avviare *tutti* gli altri processi del sistema.

//   Questo processo viene *eseguito dal kernel* a tempo di avvio con `PID 1` (quello con `ID 0` è il kernel stesso) ed è eseguito in #alert[background] fino allo spegnimento del sistema.

//   Un processo può avviare altri processi (child), ma se il processo padre *muore*,
//   #alert[init] si occupa di "adottare" i processi orfani.

//   #figure(image("images/Linux-init-Systems.png")) // CAMBIARE IMMAGINE
// ]

// #slide(title: [Init systems disponibili])[
//   Nel corso degli anni sono stati proposti diversi *init system* adottati dalle principali distribuzioni *Linux*.

//   I principali sono:
//   - *`System V`* (`SysV`) --- _a mature and popular init scheme on Unix-like operating systems_
//   - #alert[*`OpenRC`*] --- _a dependency-based init scheme for Unix-like operating systems_
//   - #alert[*`Systemd`*] --- _relatively new init scheme on the Linux platform_
//   - *`Upstart`* --- _an event-based init system developed by Canonical_ (_*fuori produzione*_ #fa-warning())

//   In questo corso ci concentreremo su *OpenRC* e *Systemd*.
// ]

// #slide[
//   #bibliography("bibliography.bib")
// ]
