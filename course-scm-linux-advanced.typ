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
#show raw.where(block: false): set text(size: 1.5em)
#show raw: set text(size: 0.75em)
#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: (x: 1em, y: 1em),
  radius: 0.7em,
  width: 100%,
)
#let b(content) = text(weight: "bold", content)

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

== Yocto: About

- *Yocto Project* è un progetto open source per la creazione di distribuzioni Linux embedded #b[custom].
- Ha origine nel 2010 dalla #b[Linux Foundation] e correntemente manutenuta.

#v(2em)

#figure(image("images/Yocto_Project_logo.svg"))

== Yocto: Principi

#figure(image("images/yocto-principles.png"))

- Yocto compila sempre pacchetti binari (*distribuzione*)
- Il filesystem finale è generato dalla distribuzione (*image*)

== Componenti Yocto: `bitbake`

Su Yocto, il _build engine_ è implementato dal programma `bitbake`

  - `bitbake` è *task scheduler*, simile a `make`
  - `bitbake` legge file testuali per capire *cosa* deve essere fatto e *dove*
  - Implementato in *Python* (richiesto `Python 3` per lo sviluppo)

== Componenti Yocto: `recipes`
#slide[
- Il principale tipo di file testuale gestito da `bitbake` sono le *recipes*
  - Una recipes descrive uno specifico *componente software*
- Ogni *Recipes* descrive come #b[recuperare] e #b[compilare] un componente software
  - programma
  - libreria
  - immagine
- Le recipes hanno una *sintassi specifica*
- `bitbake` può costruire ogni "ricetta", compilando le sue #b[dipendenze] in modo automatico
][
  #figure(image("images/recipes.png", width: 90%))
]

== Componenti Yocto: `tasks`
#slide[
- Il processo di build implementato da una "ricetta" è diviso in *tasks*
- Ogni task esegue uno specifico *step* nel processo di build
  - recupera il codice sorgente
  - configura il codice sorgente
  - compila il codice sorgente
  - installa il codice sorgente
- Più tasks possono *dipendere* da altri tasks (inclusi quelli di altre "ricette")
][
  #figure(image("images/task-dependencies.png"))
]

== Componenti Yocto: `layers e metadati`

- `bitbake` prende in input *metadati*
- I metadati includono #b[file di configurazione], #b[ricette], #b[file da includere], ecc.
- I metadati sono organizzati in *layers*
  - Un layer è un insieme di #b[recipes], #b[file di configurazione] e #b[classi con scopi comuni]
  - Più layers possono essere combinati per creare una *distribuzione*
- `openembedded-core` è il layer base di Yocto
  - Tutti gli altri layer sono costruiti sopra `openembedded-core`
  - Supporta `ARM`, `x86`, `MIPS`, `PowerPC`, `RISC-V` ecc.
  - Supporta `QEMU` per emulare macchine con queste architetture

== Componenti Yocto: `Poky`

- La parola *Poky* assume diversi significati
  - *Poky* è un repository `git` che è assemblato da altri repository: `bitbake`, `openembedded-core`, `yocto-docs` e `meta-yocto`
  - *Poky* è anche la distro di riferimento fornita dal _Progetto Yocto_
  - `meta-poky` è il layer fornito come rifefimento per la distro *Poky*

== Yocto Overview

#figure(image("images/yocto-overview.png"))

#meanwhile

- Il progetto Yocto *non è usato* come insieme finto di layer e strumenti
- Al contrario, fornisce *una base comune* di #b[tools] e #b[layers] sopra i quali è possibile specificarne di #b[custom] in base alle proprie esigenze

== Esempio Yocto Project basato su BSP

- Per costruire un'immagine per _BeagleBone Black_ ci serve:
  - *Poky* che fornisce le *ricette comuni* e i *tool*
  - Il layer `meta-ti-bsp` che fornisce una serie di ricette specifiche per #b[Texas Instruments] (azienda produttrice del processore di BeagleBone Black)
- Tutte le modifiche *DEVONO* essere fatte in un layer separato. Modificare Poky o un layer esistente è *SBAGLIATO*

Prepariamo questo tipo di ambiente!

== Configurazione host

Requisiti per il *build host*:
  - Almeno #b[90GB] di spazio libero su disco e #b[8GB] di RAM
  - Utilizzo di una distro supportata (#b[Ubuntu], Fedora, Debian, openSUSE, CentOS)
  - `Git` >=1.8.3.1 -- `tar` >=1.28 -- `Python` >=3.8.0 -- `gcc` >=8.0 -- `GNU make` >=4.0

Installazione pacchetti necessari su Ubuntu:

```bash
$ sudo apt install gawk wget git diffstat unzip texinfo gcc build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 python3-subunit zstd liblz4-tool file locales libacl1
```

Configurazione locale:

```bash
$ sudo locale-gen en_US.UTF-8
```

== Getting started: Poky reference system

Tutti i repository che fanno parte del progetto Yocto sono disponibili su: \
#link("https://git.yoctoproject.org", `https://git.yoctoproject.org`)

Per iniziare, cloniamo il repository `poky`:
```bash
$ git clone -b scarthgap git://git.yoctoproject.org/poky
```

Ogni 6 mesi viene rilasciata una nuova versione di Yocto e menutenuta per 7 mesi.
Versioni #b[LTS] sono supportate per 4 anni.

Ogni _release_ ha un *codename* come `kirkstone` o `honister` corrispondente a un *release number*.
Un riepilogo delle versioni è disponibile su: \
#link("https://wiki.yoctoproject.org/wiki/Releases", `https://wiki.yoctoproject.org/wiki/Releases`)

== Poky source tree

Una volta clonato il repository `poky`, la struttura della cartella sarà simile a:

```sh
$ tree -L 1
.
├── bitbake               # Script usati da bitbake (release stabile)
├── documentation         # Sorgenti per la documentazione. Usati per generare manuali in PDF
├── LICENSE               # Licenza sotto cui Poky è rilasciato (mix tra MIT e GPL-2.0-only)
├── LICENSE.GPL-2.0-only
├── LICENSE.MIT
├── meta                  # Continene gli OpenEmbedded-Core metadata
├── meta-poky             # Contiene la configurazione per la Poky reference distribution
├── meta-selftest
├── meta-skeleton         # Contiene i template delle ricette per BSP e kernel development
├── meta-yocto-bsp        # Configurazione per Yocto Project reference hardware board support package
├── oe-init-build-env     # Script per inizializzare l'ambiente di build
├── scripts               # Script di supporto per la build, lo sviluppo e il flashing dell'immagine
└── SECURITY.md
```

== Documentazione

La documentazione, compilata com *"mega manual"*, è disponibile su: \
#link("https://docs.yoctoproject.org/singleindex.html", `https://docs.yoctoproject.org/singleindex.html`)

Le variabili sono descritte in modo dettagliato su: \
#link("https://docs.yoctoproject.org/genindex.html", `https://docs.yoctoproject.org/ref-manual/genindex.html`)

== Setup dell'ambiente di build

- Tutti i file di `Poky` #b[non] vanno modificati quando si crea un'immagine personalizzata
- Specifiche *configurazioni* e *build repository* vanno memorizzati in una directory separata

Per inizializzare l'ambiente di build, eseguire lo script `oe-init-build-env`:

```bash
$ source poky/oe-init-build-env
```

- Lo script `oe-init-build-env` inizializza l'ambiente di build
  - Crea una directory `build` per la build
  - All'interno una directory `conf` per le configurazioni
  - Imposta le variabili d'ambiente per la build (`BUILDDIR` e `PATH` per `bitbake`)

Opzionalmente, è possibile specificare un percorso per la directory di build:

```bash
$ source poky/oe-init-build-env /path/to/build/directory
```

== Comandi disponibili

/ `bitbake`: è il principale strumento per la build di un'immagine Yocto
/ `bitbake-*`: vari script specifici relativi a `bitbake`

== Configurazione del build system

- La cartella `conf/` contiene due file di configurazioni specifici della build (obbligatori):
  - `bblayers.conf`: definisce i layer da includere nella build
  - `local.conf`: definisce le variabili di configurazione per la build. Variabili di configurazione possono essere sovrascritte qui

== Consigurazione della build

Il file `conf/local.conf` contiene le variabili di configurazione locale per la build:
  - `BB_NUMBER_THREADS`: definisce quanti *task* possono essere eseguiti in parallelo da `bitbake`. Di default è impostato a `$(nproc)`
  - `PARALLEL_MAKE`: definisce quanti processi possono essere utilizzati per la compilazione. Di default è impostato a `$(nproc)`
  - `MACHINE`: definisce la macchina target per la build, nel nostro caso `beaglebone`

Il file `conf/local.conf` conterrà quindi:

```
MACHINE ?= "beaglebone-yocto"
MACHINE ??= "qeumx86-64"
...
```

== Compilazione dell'immagine

Utilizzo di `bitbake`: `bitbake [options] [recipename/target ...]` \
Per compilare un target: `bitbake [target]` 

Per compilare l'immagine di riferimento `core-image-minimal`:

```bash
$ bitbake core-image-minimal
```

*Nota* per utenti Ubuntu 24.04, se ottenete l'errore:

```
ERROR: PermissionError: [Errno 1] Operation not permitted
During handling of the above exception, another exception occurred:
...
```

Eseguite il comando:

```bash
$ sudo apparmor_parser -R /etc/apparmor.d/unprivileged_userns
```