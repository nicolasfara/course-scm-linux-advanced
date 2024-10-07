#import "@preview/touying:0.5.2": *
#import themes.metropolis: *
#import "@preview/fontawesome:0.1.0": *
#import "@preview/ctheorems:1.1.2": *
#import "@preview/numbly:0.1.0": numbly

// Pdfpc configuration
// typst query --root . ./example.typ --field value --one "<pdfpc-file>" > ./example.pdfpc
#let pdfpc-config = pdfpc.config(
    duration-minutes: 30,
    start-time: datetime(hour: 14, minute: 10, second: 0),
    end-time: datetime(hour: 14, minute: 40, second: 0),
    last-minutes: 5,
    note-font-size: 12,
    disable-markdown: false,
    default-transition: (
      type: "push",
      duration-seconds: 2,
      angle: ltr,
      alignment: "vertical",
      direction: "inward",
    ),
  )

// Theorems configuration by ctheorems
#show: thmrules.with(qed-symbol: $square$)
#let theorem = thmbox("theorem", "Theorem", fill: rgb("#eeffee"))
#let corollary = thmplain(
  "corollary",
  "Corollary",
  base: "theorem",
  titlefmt: strong
)
#let definition = thmbox("definition", "Definition", inset: (x: 1.2em, top: 1em))
#let example = thmplain("example", "Example").with(numbering: none)
#let proof = thmproof("proof", "Proof")

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  config-common(
    // handout: true,
    preamble: pdfpc-config, 
  ),
  config-info(
    title: [Title],
    subtitle: [Subtitle],
    author: [Authors],
    date: datetime.today(),
    institution: [Institution],
    // logo: emoji.school,
  ),
)

#set text(font: "Fira Sans", weight: "light", size: 20pt)
#show math.equation: set text(font: "Fira Math")
#set raw(tab-size: 4)
#show raw: set text(size: 0.75em)
#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: (x: 1em, y: 1em),
  radius: 0.7em,
  width: 100%,
)

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

#title-slide()

// ============================ Packages and Package Managers ============================
// =======================================================================================
= Package Manager su distro Linux

== Che cos'è un Package Manager?
  Un *package manager* è uno strumento (_software_) che permette di gestire l'installazione, la rimozione e l'aggiornamento di #underline[pacchetti software] su un sistema operativo.

  I package manager possono essere:
    - *grafici* --- consentono l'installazione di pacchetti tramite _interfaccia grafica_
    - *testuali* --- consentono l'installazione di pacchetti tramite _linea di comando_

  #v(1em)

  #align(center)[In questo corso ci concentreremo su package manager a *linea di comando*.]

  #only("1-")[
    #figure(image("images/why-meme.png"))
  ]


== Perché la linea di comando?
  Se a primo impatto può sembrare più complesso, l'utilizzo della _riga di comando_ per la gestione dei pacchetti ha diversi vantaggi:

  - *Velocità*: l'installazione di pacchetti è più veloce
  - *Controllo*: maggiore controllo sulle operazioni
  - *Automatizzazione*: possibilità di automatizzare le operazioni

  Inoltre, la riga di comando è #alert[più leggera] e #alert[più flessibile] rispetto ad una GUI.


== Pacchetti software
  Un #alert[pacchetto software] è tipicamente una *applicazione* (GUI o CLI) o una *libreria* che può essere installata su un sistema operativo.

  È un archivio che può contenere:

    - #alert[binari]
    - #alert[file di configurazione]
    - #alert[documentazione]
    - #alert[informazioni su dipendenze]
    - ...
    
  #figure(image("images/linux-packages.png", width: 61%))

== Prima dei package manager
  Un tempo il software veniva installato dai suoi #alert[sorgenti], ovvero il codice sorgente del programma.

  Tipicamente un file definiva le #alert[istruzioni di compilazione] e le #alert[dipendenze] necessarie per la compilazione.

  Spettava all'utente *compilare* il software e gestire le eventuali *dipendenze*.

  #v(1em)

  #align(center)[Questo processo era #alert[lungo], #alert[complesso] e #alert[tedioso].]
  #align(center)[Altro annoso problema era #alert[l'aggiornamento del software].]

== Gestione dei pacchetti con package manager
  Per superare queste limitazioni, ogni distribuzione ha implementato un proprio #alert[formato di pacchetto] e un #alert[package manager] per la gestione dei pacchetti.

  L'idea è quella di *semplificare* l'installazione e la gestione del software distribuendolo (principalmente) in forma binaria,
  assieme a #alert[metadati] che descrivono il pacchetto e le sue dipendenze.

  #figure(image("images/source-code-comilation-vs-packaging.png", height: 55%))

== Come funziona un package manager?"
  #figure(image("images/linux-package-manager-explanation.png"))

== Repository"
  (Quasi) tutte le distribuzioni Linux mantengono uno o più #alert[repository] ufficiali contenenti i pacchetti software.

  I repository sono #alert[server] che contengono i pacchetti software e le informazioni necessarie per la loro installazione.

  Esempio di repository: \
  #link("http://archive.ubuntu.com/ubuntu/")[`http://archive.ubuntu.com/ubuntu/`]

  #figure(image("images/repository.png"))

== Repository e metadati"
  I *repository* contengono, oltre ai pacchetti software, anche i #alert[metadati] necessari per la gestione degli stessi.

  I #alert[metadati] sono informazioni che descrivono il pacchetto come:
    - nome
    - versione
    - dipendenze
    - descrizione

== Package manager e interazioni con repository
  Il *package manager* inizialmente interagisce con i metadati, scaricando le informazioni necessarie per la gestione dei pacchetti e le salva in una #alert[cache locale].

  Quando si richiede un aggiornamento, il *package manager* aggiorna la cache locale e confronta le informazioni con quelle presenti nel repository.

  Quando si richiede l'installazione di un pacchetto, il *package manager* interroga la cache locale e quindi scarica il pacchetto dal repository.
  Se il pacchetto ha delle dipendenze, queste vengono scaricate e installate automaticamente.

== Esempio installazione pacchetto

  ```bash
  $ sudo pacman -S freecad

  resolving dependencies...
  looking for conflicting packages...

  Packages (35) asciidoctor-2.0.23-2  blosc-1.21.6-1 ... freecad-1.0rc1-1

  Total Download Size:    239,66 MiB
  Total Installed Size:  1128,19 MiB

  :: Proceed with installation? [Y/n]
  ```

// =================================== Linux Embedded ====================================
// =======================================================================================

= Linux Embedded (Yocto Project)

== Architettura sistema Linux (semplificata)

#figure(image("images/linux-architecture.png"))

== Linux Embedded

- *BSP* (Board Support Package): pacchetto software che contiene i driver e il codice necessario per far funzionare il sistema operativo su una specifica piattaforma hardware.
- *System Integration*: assemblaggio dei componenti in user space (applicazioni, librerie, ecc.) necessari per il sistema e loro configurazione
- *Sviluppo applicazioni*: sviluppo di applicazioni e librerie custom per il sistema embedded.

== System integration: diverse possibilità

#show table.cell: set text(size: 0.8em)

#table(
  columns: (auto, auto, auto),
  fill: (luma(250), green.transparentize(90%), red.transparentize(90%)),
  inset: 0.5em,
  table.header(
    [], align(center)[#text(green, weight: "bold")[Pro]], align(center)[#text(red, weight: "bold")[Contro]]
  ),
  text(weight: "bold")[Compilazione manuale], [
    - Controllo totale
    - Flessibilità
    - Formativo
  ],
  [
    - Problemi di dipendenze (dependecy hell)
    - Conoscenza approfondita del sistema
    - Compatibilità tra versioni
  ],
  [
    #text(weight: "bold")[Distribuzione binaria] \
    (debian, fedora, ecc.)
  ],
  [
    - Facile da creare
  ],
  [
    - Non disponibile per tutte le architetture
    - Molte dipendenze
    - Difficile da ottimizzare
  ],
  text(weight: "bold")[Build system],
  [
    - Estremamente flessibile
    - Pacchetti specifici per embedded
    - Compilato dai sorgenti
    - Cross-compilazione
  ],
  [
    - Tempi di compilazione
  ]
)

== Linux Embedded: Principi
#figure(image("images/linux-embedded-principles.png"))

- Compilare da sorgenti --> elevata *flessibilità*
- Cross-compilazione --> compilazione su un *sistema diverso* da quello target
- "Ricette" per costruire componenti --> *facilità* di realizzazione

== Build system per Linux Embedded

- Ampio panorama: _Yocto/OpenEmbedded, Buildroot, PTXdist, OpenWRT_, ecc.
- Ad oggi, *due* soluzioni sono tra le più popolari:
  - *Yocto/OpenEmbedded* \ Creazione di distribuzioni Linux complete. #text(weight: "bold")[Molto potente] ma #underline[complesso].
  - *Buildroot* \ Creazione di filesystem minimi, no pacchetti binari. Più #underline[semplice] da usare ma #text(weight: "bold")[meno flessibile].

= Yocto Project: Overeview
