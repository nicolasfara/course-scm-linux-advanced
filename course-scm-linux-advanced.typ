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

#let b(content) = text(weight: "bold", content)
#set list(marker: text(1.5em, [•]))

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  config-common(
    // handout: true,
    preamble: pdfpc-config, 
  ),
  config-info(
    title: [Corso Linux Avanzato],
    // subtitle: [Subtitle],
    author: [#b[Nicolas Farabegoli]],
    date: [_Versione slide_: #datetime.today().display()],
    institution: [SCM Campus],
    logo: fa-linux(),
  ),
)

#set text(font: "Fira Sans", weight: "light", size: 18pt)
#show math.equation: set text(font: "Fira Math")
#set raw(tab-size: 4)
#show raw.where(block: false): set text(size: 1.5em, font: "Fira Mono", fill: rgb("#f92672"))
#show raw: set text(size: 0.8em)
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

== Corso Linux Avanzato

*Modulo 1* a cura del prof. #b[Giovanni Ciatto] \
#fa-icon("github", fa-set: "Brands") #link("https://gciatto.github.io/course-scm-linux-advanced/#/", `https://gciatto.github.io/course-scm-linux-advanced/`)

#v(2em)

*Modulo 2* a cura di #b[Nicolas Farabegoli] \
#fa-icon("github", fa-set: "Brands") #link("https://github.com/nicolasfara/course-scm-linux-advanced/releases", `https://github.com/nicolasfara/course-scm-linux-advanced/releases`)

== Agenda

=== Modulo 1: Package manager su Linux

- Introduzione al concetto di *package manager*
- *Advanced Package Tool* (APT)
- Gestione versioni con `update-alternatives`
- *Alpine Package Manager* (`apk`)

=== Modulo 2: Server grafici

- Introduzione a *X Window System*
- Introduzione a *Wayland*
- Integrazione tra *X Window System* e *Wayland*

=== Modulo 3: Yocto Project

- Introduzione a *Yocto Project*
- Creazione di una *immagine custom*

== Esercitazioni

È prevista una serie di #b[esercitazioni] per ciascun modulo.

Le esercitazioni sono disponibili a questo link: \
#fa-icon("github", fa-set: "Brands") #link("https://github.com/nicolasfara/course-scm-linux-advanced-exercises", `https://github.com/nicolasfara/course-scm-linux-advanced-exercises`)

Nel branch `soluzioni` sono disponibili le soluzioni degli esercizi.

=== Setup esercitazioni

Clonare il repository delle esercitazioni:
```
$ git clone https://github.com/nicolasfara/course-scm-linux-advanced-exercises.git
```

Per passare al branch `soluzioni`:

```
$ git checkout soluzioni
```

// ============================ Packages and Package Managers ============================
// =======================================================================================
= Distro Linux Package Managers

== Installazione software su Linux

Quali opzioni si hanno per installare software su *Linux*?

- *Compilazione da sorgenti*
  - Si richiede il download dei sorgenti
  - Compilazione e installazione _manuale_
  - Certe volte è semplice, mentre altre volte può essere un #b[incubo]
  - A volte è una scelta #underline[obbligata]: solo i #b[sorgenti] sono disponibili
- *Installazione di pacchetti precompilati*
  - Il software può essere #b[pre-compilato] e distribuito per essere pronto per l'installazione
  - I pacchetti dipendono dalle distribuzioni Linux:
    - _Debian-based_ (come Ubuntu): distribuiscono pacchetti con estensione `.deb`
    - _Red Hat-based_ (come Fedora): distribuiscono pacchetti con estensione `.rpm`

== Installazione da sorgenti

- Download del codice sorgente
  - attraverso #b[zip] oppure #b[rar]
  - oppure attraverso #b[git] o #b[svn]
- Il *README*, distribuito generalmente con il codice sorgente, contiene le istruzioni per la compilazione e l'installazione
  - A volte contiene anche istruzioni su come personalizzare il software
  - Definisce quelle che sono le #b[dipendenze] necessarie per la compilazione

#pagebreak()

Per installare il software, tipicamente si seguono questi passaggi:

1. Applicare le #b[configurazioni] necessarie
2. Individuare il `Makefile`
  - Applicare le configurazioni con `make config`
  - Compilare il software con `make`
  - Installare il software con `make install`

Per effettuare questi passaggi, si assume che la *toolchain* sia installata sul sistema.

I binari installati #b[potrebbero] non funzionare correttamente se richiedono _librerie_ o _dipendenze_ non presenti sul sistema.

== Prima dei package manager

  Spettava all'utente *compilare* il software e gestire le eventuali *dipendenze*.

  #v(1em)

  #align(center)[Questo processo era #b[lungo], #b[complesso] e #b[tedioso].]
  #align(center)[Altro annoso problema era #b[l'aggiornamento del software].]


// == Pacchetti software

// - Un #b[pacchetto software] è un archivio che contiene:
//   - #b[binari]
//   - #b[file di configurazione]
//   - #b[documentazione]
//   - #b[informazioni su dipendenze]
//   - ...

// == Che cos'è un Package Manager?
//   Un *package manager* è uno strumento (_software_) che permette di gestire l'installazione, la rimozione e l'aggiornamento di #underline[pacchetti software] su un sistema operativo.

//   I package manager possono essere:
//     - *grafici* --- consentono l'installazione di pacchetti tramite _interfaccia grafica_
//     - *testuali* --- consentono l'installazione di pacchetti tramite _linea di comando_

//   #v(1em)

//   #align(center)[In questo corso ci concentreremo su package manager a *linea di comando*.]

//   #only("1-")[
//     #figure(image("images/why-meme.png"))
//   ]


// == Perché la linea di comando?
//   Se a primo impatto può sembrare più complesso, l'utilizzo della _riga di comando_ per la gestione dei pacchetti ha diversi vantaggi:

//   - *Velocità*: l'installazione di pacchetti è più veloce
//   - *Controllo*: maggiore controllo sulle operazioni
//   - *Automatizzazione*: possibilità di automatizzare le operazioni

//   Inoltre, la riga di comando è #alert[più leggera] e #alert[più flessibile] rispetto ad una GUI.


== Pacchetti software
  Un *pacchetto software* è tipicamente una #b[applicazione] (GUI o CLI) o una #b[libreria] che può essere installata su un sistema operativo.

  #components.side-by-side[
  È un archivio che può contenere:
    - binari
    - file di configurazione specifici per l'applicazione
    - documentazione
    - informazioni su dipendenze (metadati)
    - script per l'installazione e la rimozione del software
    - ...
  ][
    #figure(image("images/linux-packages.png", width: 75%))
  ]

== Formato nome file pacchetto

  #align(center)[
  `<nome>_<versione>-<rev>_<arch>.deb`
  ]

  #v(1em)

  - `<nome>`: nome del pacchetto eventualmente separato da `-`
  - `<versione>`: versione del pacchetto, solitamente numerica nel formato `major.minor.patch` (#link("https://semver.org/"))
  - `<rev>`: revisione del pacchetto (assegnata dal distributore)
  - `<arch>`: architettura del pacchetto (es. `amd64`, `i386`, `arm64`, ecc.)

  #align(center)[Ad esempio: `firefox_91.0-1_amd64.deb`]

  #v(1em)

  Ogni *distribuzione* Linux ha un #underline[proprio] formato per la nomenclatura dei pacchetti.

== Installare un `.deb` -- esempio

  Per installare un pacchetto `.deb` si fa uso del comando `dpkg`:

  ```bash
  $ sudo dpkg -i <pacchetto-completo>.deb
  ```

  Ad esempio, se abbiamo un pacchetto `firefox_91.0-1_amd64.deb`:

  ```bash
  $ sudo dpkg -i firefox_91.0-1_amd64.deb
  ```

  Per rimuovere un pacchetto `.deb` occorre specificare #underline[solo] il nome del pacchetto:

  ```bash
  $ sudo dpkg -r <pacchetto>
  ```
  Ad esempio, per rimuovere Firefox:

  ```bash
  $ sudo dpkg -r firefox
  ```

  #pagebreak()

  Per mostrare tutti i pacchetti installati:
  
  ```bash
  $ dpkg --list
  ```

  Per mostrare i file all'interno di un pacchetto `.deb`:

  ```bash
  $ dpkg -L <pacchetto>
  ```

  Per determinare se un pacchetto è installato:

  ```bash
  $ dpkg --status <pacchetto>
  ```

  #pagebreak()

  Per scoprire quale pacchetto ha installato un certo file:

  ```bash
  $ dpkg --search <file>
  ```

  `dpkg` mantiene le informazioni sui pacchetti installati in `/var/lib/dpkg`:
    - `/var/lib/dpkg/status`: informazioni sui pacchetti installati
    - `/var/lib/dpkg/available`: informazioni sui pacchetti disponibili

== Bene ma non benissimo...

  Come abbiamo appena visto `dpkg` è un ottimo strumento per installare pacchetti `.deb`, ma ha un #b[grande limite]:

  - Non gestisce le *dipendenze* dei pacchetti
    - Molti pacchetti richiedono altri pacchetti per funzionare correttamente
    - Un pacchetto `A` può richiedere una certa versione di un pacchetto `B`
    - L'utente deve controllare manualmente le dipendenze e installarle
    - Questo processo è #underline[complicato] e #underline[propenso ad errori]
  - Abbiamo bisogno di un too di "alto livello" che gestisca le dipendenze in modo automatico
    - Deve essere in grado di recuperare le dipendenze richieste
    - Deve effettuare le installazioni richieste
    - Deve installare i pacchetti richiesti
    - Tutto il processo deve essere #underline[automatico] e trasparente

== Gestione dei pacchetti con package manager
  Ogni distribuzione ha implementato un proprio #underline[formato di pacchetto] e un #underline[package manager] per la gestione dei pacchetti.

  L'idea è quella di *semplificare* l'installazione e la gestione del software distribuendolo (principalmente) in forma binaria,
  assieme a #b[metadati] che descrivono il pacchetto e le sue dipendenze.

  #figure(image("images/source-code-comilation-vs-packaging.png", height: 55%))

== Come funziona un package manager?
  #figure(image("images/linux-package-manager-explanation.png"))

== Repository
  (Quasi) tutte le distribuzioni Linux mantengono uno o più #b[repository] ufficiali contenenti i pacchetti software.

  #components.side-by-side(columns: (2fr, 1fr))[
    I repository sono #b[server] che contengono i pacchetti software e le informazioni necessarie per la loro installazione.
    
    Esempio di repository: \
    #link("http://archive.ubuntu.com/ubuntu/")[`http://archive.ubuntu.com/ubuntu/`]
  ][
    #figure(image("images/repository.png", width: 60%))
  ]

== Repository e metadati
  I *repository* contengono, oltre ai pacchetti software, anche i #b[metadati] necessari per la gestione degli stessi.

  I #b[metadati] sono informazioni che descrivono il pacchetto come:
    - nome
    - versione
    - dipendenze
    - descrizione

== Package manager e interazioni con repository
  Il *package manager* inizialmente interagisce con i metadati, scaricando le informazioni necessarie per la gestione dei pacchetti e le salva in una #b[cache locale].

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

#focus-slide[
  *Advanced Package Tool* (APT)
]

== APT: Advanced Package Tool

- *APT* è un package manager per sistemi Debian-based (come Ubuntu)
- È un'interfaccia a riga di comando per il sistema di gestione dei pacchetti di Debian
- Si compone di più strumenti:
  - `apt-get` (o `apt`): strumento principale per la gestione dei pacchetti
  - `apt-cache`: strumento per la ricerca delle informazioni sui pacchetti
  - `apt-key`: strumento per la gestione delle chiavi di autenticazione
  - `apt-config`: strumento per la configurazione di APT

== Vantaggi di APT

- Nasconde (in senso positivo) molti dettagli #b[superflui] all'utente
  - L'utente non deve preoccuparsi di *scaricare* le dipendenze
  - L'utente non deve preoccuparsi del *nome dei file* del pacchetto o la *versione* di rilascio
  - Deve #b[solo] sapere il *nome del pacchetto* da installare
  - Non deve preoccuparsi di *gestire le dipendenze* manualmente
  - Tutto è eseguito in modo *trasparente* e *automatico*

== Installazione di un pacchetto con APT

- Per installare un certo programma o libreria, tutto quello che serve è sapere il *nome del pacchetto*.
- Se non si conosce il nome del pacchetto si possono adottare diverse strategie:
  - Utlizzo del comando `apt-cache search <nome>`
  - Utilizzo del comando `apt search <nome>`
  - Ricerca su internet
- Per installare un pacchetto si utilizza il comando `sudo apt install <nome>`
- L'installazione include:
  - Identificazione dell'ultima versione del pacchetto da installare
  - Identificazione di pre-requisiti e dipendenze
  - Verifica dello spazio su disco
  - Conferma dell'installazione
  - Eesecuzione dell'installazione

== Repository APT

- Come visto in precedenza, i package manager interagiscono con i #b[repository] per scaricare i pacchetti.
- I repository APT sono configurati in `/etc/apt/sources.list` e `/etc/apt/sources.list.d/`
- Questi file contengono le liste degli URL dei repository *ufficiali* e *non ufficiali* che APT deve interrogare per scaricare i pacchetti

== Esempio repository Ubuntu

- *Ubuntu* fornisce i propri repository ufficiali
- Gli URL dei server *mirrors* sono elencati nel file `/etc/apt/sources.list`
- I pacchetti software su ubuntu sono divisi in 4 categorie:
  - #b[Main]: contiene software open source supportato direttamente da ubuntu
  - #b[Universe]: contiene "tutto" il software open source non supportato direttamente da ubuntu
  - #b[Multiverse]: contiene software *non* open source (installabile sotto propria responsabilità)
  - #b[Restricted]: contiene software che non è open source ma è supportato da ubuntu (es. driver proprietari)

== /etc/apt/sources.list

- Gli strumenti di `apt` usano questo file per identificare la lista di repository da cui scaricare i pacchetti
- L'utente può #b[modificare] questo file per aggiungere (o rimuovere) repository
- Il file contiene una lista di #b[URL] che partono con:
  - `deb`: URL per i pacchetti binari
  - `deb-src`: URL per i pacchetti sorgenti
  - seguiti da:
    - *nome* della distribuzione e *suite* (`updates`, `backport`, ecc.)
    - *componente* (`main`, `universe`, ecc.)

Nota: per scoprire il nome della #b[distribuzione] si può usare il comando: \
```$ lsb_release -sc```

== Modificare `/etc/apt/sources.list`

- Per modificare il file `sources.list` si può usare un editor di testo (esempio `nano`):
  - `$ sudo nano /etc/apt/sources.list`
  - Si aggiunge o rimuove gli URL dei repository
  - Si salva il file e si esce dall'editor
- Tuttavia, è *fortemente* consigliato usare il comando `add-apt-repository` per aggiungere repository
  - `$ sudo add-apt-repository <repository>`
  - Questo comando aggiunge l'URL del repository al file `sources.list`
  - Esempio: `$ sudo add-apt-repository ppa:libreoffice/ppa`

L'aggiornamento del file `sources.list` non comporta l'aggiornamento automatico della cache di APT.
Per rendere effettive le modifiche, è necessario *aggiornare* il database dei pacchetti `apt`.

== Aggiornamento database pacchetti

- Per aggiornare il database dei pacchetti si usa il comando `apt update`
- Questo comando accede al file `/etc/apt/sources.list` e scarica le informazioni sui pacchetti disponibili nei repository
- Per ogni pacchetto:
  - Recupera #b[l'ultimo] numero di versione
  - Recupera le informazioni sui pacchetti e le #b[dipendenze]
  - Recupera la #b[dimensione] del pacchetto
- Costruisce il database interno con queste informazioni
- Quando è richiesta un'installazione, APT usa il *database* per scaricare i pacchetti
- Per questo motivo, è *importante* eseguire `apt update` prima di installare un pacchetto

== Aggiornamento dei pacchetti installati

- Il comando `apt upgrade` aggiorna i pacchetti installati
- Questo comando:
  - Controlla il database interno
  - Confronta le versioni dei pacchetti installati con le versioni disponibili nel database
  - Se ci sono versioni più *recenti*, scarica e installa le nuove versioni
  - Se una nuova versione ha un conflitto, *non procederà* con l'aggiornamento

Dal momento che questo comando utilizza il database interno, è *importante* eseguire `apt update` #b[prima] di eseguire `apt upgrade`.

== Aggiornamento dei pacchetti installati (`dist-upgrade`)

- Il comando `apt dist-upgrade` è simile a `apt upgrade` ma con una differenza:
  - se `apt dist-upgrade` rileva che l'aggiornamento di un pacchetto richiede la rimozione di un altro pacchetto, *lo farà*
  - ciò significa che alcuni pacchetti potrebbero essere *installati* o *rimossi* durante l'aggiornamento
- Per sapere quali azioni dovranno essere prese da `apt` prima di procedere, si può usare il comando `apt check`
  - Questo comando aggiorna la cache e verifica se ci sono potenziali dipendenze rotte

== Rimozione di un pacchetto

- Per rimuovere un pacchetto si usa il comando `apt remove <nome>`
  - questo comando *preserva* i file di configurazione (per eventuali reinstallazioni)
- Per rimuovere un pacchetto e i file di configurazione si usa il comando `apt purge <nome>`
- Per rimuovere un pacchetto e le #underline[dipendenze] non più necessarie si usa il comando `apt autoremove`

== Ottenere informazioni sui pacchetti

- Per ricercare un pacchetto tramite #b[keyword]: `apt search <keyword>`
- Per ottenere #b[informazioni] su un pacchetto: `apt show <nome_pacchetto>`
- Per ottenere la lista di *tutti* i pacchetti installati: `apt list --installed`
- Per ottenere la #b[policy] di un pacchetto: `apt policy <nome_pacchetto>`

== Archivio dei pacchetti `/var/cache/apt/archives`

- I pacchetti scaricati da APT sono salvati in `/var/cache/apt/archives`
- Quando si installa un pacchetto, `apt` scarica il pacchetto e lo salva in questa directory
- Certe volte i pacchetti scaricati possono essere di #b[grandi dimensioni], quindi per salvare spazio su disco si possono rimuovere i pacchetti da questa directory:
  - `$ sudo apt autoclean` rimuove i pacchetti obsoleti
  - `$ sudo apt clean` rimuove tutti i pacchetti scaricati (anche quelli attualmente installati)
    - Nota: questo comando rimuove i pacchetti scaricati, ma *non* i pacchetti installati


#focus-slide[*Esercitazione*: 01-apt]

== Gestione di più versioni di un pacchetto

Spesso può essere necessario installare *più versioni* di un pacchetto sullo stesso sistema:

- Potremo aver bisogno di una version più #b[vecchia] per motivi di #b[compatibilità]
- Se siamo sviluppatori potremo voler sviluppare e testare il nostro software con #b[più versioni] di una libreria
- Semplicemente vogliamo diverse versioni di un software

== Introduzione a `update-alternatives`

- `update-alternatives` è uno strumento che permette di gestire #b[più versioni] di un programma sullo stesso sistema
- Le #b[alternative] sono diversi programmi o file che forniscono la stessa funzionalità
- `update-alternatives` permette di #b[selezionare] quale "alternativa" usare come *predefinita* sul sistema

== Come funziona `update-alternatives`

- Il comando `update-alternatives` mantiene un database di alternative disponibili installate nel sistema
- Ogni alternativa ha un #b[nome simbolico] e un set di programmi o file associati
- `update-alternatives` permette di #b[selezionare] quale alternativa usare come predefinita
  - con il comando `update-alternatives --list` si ottiene la lista delle alternative disponibili
  - con il comando `update-alternatives --config` si seleziona l'alternativa da usare

== Casi d'uso di `update-alternatives`

- Gestione di versioni multiple dello stesso software (es. Python, GCC, editor, ecc.)
- Consente di cambiare in modo *agile* la versione da utilizzare senza dover manualmente intervenire sui file di sistema

== Vantaggi di `update-alternatives`

- #b[Semplifica] la gestione di più versioni dello stesso software
- Permette agli utenti di #b[scegliere facilmente] l'alternativa predefinita senza modifiche manuali
- Mantiene un database *centralizzato* delle alternative disponibili
- Consente di *aggiungere* o *rimuovere* alternative in modo *sicuro* senza influire sugli altri programmi

== Utilizzo di `update-alternatives`

Anzitutto, per verificare se il `update-alternatives` è installato sul sistema, si può usare il comando:
```bash
$ update-alternatives --version
update-alternatives version 1.22.6.

This is free software; see the GNU General Public License version 2 or
later for copying conditions. There is NO warranty.
```

== Esempio dell'editor

- Un esempio comune di utilizzo di `update-alternatives` è la gestione di #b[editor di testo]
- Possiamo controllare quale editor di default viene utilizzato e vedere quali alternative abbiamo

```bash
$ update-alternatives --list editor
```

#focus-slide[*Esercitazione*: 02-update-alternatives]

== Alpine Package Manager: `apk`

- *Alpine Linux* è una distribuzione Linux leggera e sicura
- `apk` è il package manager di Alpine Linux
- È un package manager #b[semplice] e #b[veloce] che permette di installare, aggiornare e rimuovere pacchetti
- Disponibile attraverso il pacchetto `apk-tools`

== Repository di Alpine Linux

Come visto in precedenza per APT, anche `apk` interagisce con i repository per scaricare i pacchetti.

- `apk` recupera le informazioni sui pacchetti  da diversi #b[mirrors], i quali contengono diversi repository.
- A volte i termini *mirror* e *repository* vengono usati in modo intercambiabile, ma in realtà sono due cose diverse:
  - #b[mirror]: è un server che contiene più repository
  - #b[repository]: è una raccolta di pacchetti software e metadati
  - #b[release]: è una collezione di snapshot di vari repository

== Repository di Alpine Linux

Attualmente Apline Linux mette a disposizione *tre* repository principali:

- `main`: contiene i pacchetti ufficiali di Alpine Linux e che ragionevolmente ha senso trovare di base nella distro
- `community`: contiene pacchetti proveninenti dal repository `testing` che sono stati testati e sono pronti per l'uso
- `testing`: contiene pacchetti potenzialmente rotti, instabili o sotto test (questo repository è disponibile solo sulla release `edge`)

== Release di Alpine Linux

Alpine Linux fornisce due tipi principali di release:

- #b[Stable]: è la release principale e contiene pacchetti stabili e testati.
  Rilasciata ogni 6 mesi e ogni release stabile ha i suoi repository `community` e `main`. Il repository `main` viene supportato per 2 anni.
- #b[Edge]: è la release "rolling" e include nuovi pacchetti compilati dal branch `master` dei propri repository di riferimento.
  Considerata meno stabile rispetto alla release `stable`, ma stabile abbastanza per l'uso quotidiano o se si necessita di software più recenti.

== Configurazione repository

- I repository di Alpine Linux sono configurati in `/etc/apk/repositories`
- Ogni riga di questo file contiene un *URL di un repository*
- Il formato della riga è il seguente: \
   `[@tag] [protocol][/path][/release]/<repository>`

```bash
# comments look like so. valid examples below
http://dl-cdn.alpinelinux.org/alpine/edge/main 
@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing 
/var/apk/my-packages
```

== Ricerca dei pacchetti

Per cercare un pacchetto su Apline Linux si può procedere in due modi:

- Tramite interfaccia web: #b[#link("https://pkgs.alpinelinux.org")]
- Tramite il comando `apk search <keyword>`

```bash
apk search libsqlite3.so 
apk search consul 
apk search -e vim 
apk search -e so:libsqlite3.so.* 
```

== Installazione di un pacchetto

Installare un pacchetto comporta interrogare il repository, scaricare il pacchetto e le sue dipendenze, e installare il pacchetto.

I file esistenti possono essere sovrascritti *ad eccezione* dei file di configurazione in `/etc`.
In questo caso, i file verranno rinominati con l'estensione `.apk-new` (preservando i precedenti).

Per installare un nuovo pacchetto si usa il comando `apk add <nome_pacchetto>`.

```bash
apk add busybox-extras 
apk add bash zsh 
```

== Aggiornamento dei pacchetti

Per aggiornare i pacchetti installati si usa il comando `apk upgrade`.

In verità questo comando è composto da due comandi:
- `apk update`: aggiorna il database dei pacchetti
- `apk upgrade`: aggiorna i pacchetti installati

```bash
apk upgrade
```


== Rimozione di un pacchetto

Per rimuovere un pacchetto si usa il comando `apk del <nome_pacchetto>`.

Il suo funzionamento è speculare a `apk add`.

Diversi package manager hanno funzionalità dedicate per il "cleanup" dei pacchetti installati.
Ad esempio `apt` ha il comando `autoremove` per cancellare la cache dei pacchetti.
Con `apk` questo viene fatto automaticamente alla rimozione del pacchetto.

```bash
apk del bash
```

#focus-slide[*Esercitazione*: 03-apk]

= Server Grafici: Xorg e Wayland

// https://theswissbay.ch/pdf/Gentoomen%20Library/Misc/O%27Reilly%20X%20Power%20Tools.pdf

== Il Sistema X Window

#quote("The X Window System is a portable, network-based display system")

Questa definizione porta con sé tre delle caratteristiche principali di X:
- *Portabile*: il sistema di finestre X è primarimente utilizzato su sistemi Unix-like, ma è stato portato su molte altre piattaforme
  come Windows, macOS, e persino su dispositivi embedded. Supporta diverse architetture hardware.
- *Network-based*: X è un sistema client-server, il che significa che un'applicazione che disegna una finestra è il client, mentre il server
  è responsabile di disegnare la finestra sullo schermo. Questo permette di eseguire applicazioni grafiche su un computer remoto.
- *Display system*: X non è una GUI, ma fonisce le #b[fondamenta] per costruirle. Consente di sviluppare GUI senza preoccuparli dell'hardware
  sottostante e concentrarsi sugli aspetti grafici.

== Storia del Sistema X Window

- *Origini*:
  - Creato al MIT nel 1984 come parte del Progetto Athena.
  - Basato sul W Window System di Stanford.
  - Attirò presto l'interesse dei vendor Unix per facilitare lo sviluppo di applicazioni grafiche cross-platform.

- *Adozione e Licenze*:
  - 1987: rilascio di X11 sotto licenza MIT.
  - Creazione del X Consortium, un gruppo neutrale per gestire lo sviluppo, uno dei primi esempi di collaborazione open source (prima dell'uso del termine "open source").

#pagebreak()

- *Sviluppo e Crescita*:
  - Il controllo di X passò di mano diverse volte fino al 1999, quando X.org fu istituito dal The Open Group.
  - Nel 1992, X386 (poi rinominato XFree86) divenne una popolare implementazione di X per PC, con innovazioni che avvenivano fuori dai canali ufficiali.

- *Transizione verso X.org Foundation*:
  - 2003: dispute di licenza e problemi interni portarono alcuni sviluppatori a passare da XFree86 a X.org.
  - 2004: Il server X.org venne adottato diffusamente nelle distribuzioni open source, rivitalizzando lo sviluppo attivo della comunità X.

- *Eredità*:
  - Il server X.org sostituì XFree86, diventando l'implementazione principale del sistema X e avanzando la tecnologia X Window all'interno di una comunità open source rinvigorita.

== X e altri nomi

Spesso troviamo il sistema X Window riferito con diversi nomi:
- _X_
- _X Window System_
- _X version 11_
- _X Window System, version 11_
- _X11_

Il numero di versione non è mai riferito nell'uso moderno,
dal momento che le versioni precedenti erano *sperimentali* e la version 11 è in uso da quasi un ventennio.

Vista la dominanza dell'implementazione _X.org_ ha portato diverse persone a riferirsi al sistema come #b[Xorg].

== Architettura di X

#slide[
  #only("1")[
    In _Unix_ è tradizione fornire soluzioni composte da #b[piccoli programmi],
    piuttosto che da un singolo programma #b[monolitico].

    Le GUI basate su X seguono questa filosofia: sono costruite in *layer* che possono essere combinati in base alle esigenze.
  ]
  #only("2")[
    Gli elementi #b[in cima] sono più vicini all'utente, mentre quelli #b[in basso] sono più vicini all'hardware.

    Dal basso verso l'alto:
    - *Network Transport*: abilita la comunicazione con gli altri layer. Basato su TCP/IP più uno schema di comunicazione veloce per clinet locali.
    - *X Window System*: software per gestire lo schermo (mouse, tastiera e video) ed eseguito sul computer connesso all'hardware del display. I layer sopra sono considerati #b[client].
  ]
  #only("3")[
    - *Display Manager*: consente all'utente di accedere al sistema in modo grafico.
    - *Session Manager*: traccia lo stato delle applicazioni tra varie sessioni di login. Avvia il window manager e il desktop environment. Riavvia le applicazioni in caso di crash.
    - *Window and Compositing Manager*: gestisce il piazzamento delle finestre sullo schermo e la decorazione delle finestre. Se abilitata l'estensione COMPOSITE il window manager agisce come compositing manager.
  ]
  #only("4")[
    - *Desktop Environment*: un insieme di applicazioni che forniscono un'interfaccia grafica coerente. Include menu per avviare programmi, trays o pannelli, ...
    - *Application Clients*: applicazioni che disegnano le finestre sullo schermo. Possono essere applicazioni grafiche, terminali, ecc.
    - *Toolkit*: programmi o librerie per semplificare lo sviluppo di client che comunicano con un server X. Non è un vero e proprio layer, ma semplifica lo sviluppo dei layer #b[client].
  ]
][
  #figure(image("images/xorg-architecture.png"))
]

== Interazione Client/Server X

#slide(composer: (1fr, auto))[
  #only("1")[
    Per comprendere l'architettura di *Wayland* è utile confrontarla con quella di #b[X].

    1. Il kernel prende eventi dai dispositivi di input e li passa al server #b[traducendo] i singoli protocolli in un formato standard (`evdev`).
    2. Il server #[X] determina quale finestra è coinvolta dall'evento e lo passa al client. Il server #b[X] non sa l'effettiva posizione delle finestre in quanto gestito dal #b[compositor].
    3. Il client gestisce l'evento e decide come reagire.
  ]
  #only("2")[
    4. Quando il server #b[X] riceve la richiesta di *rerendering* calcolando le nuove bounding region delle finestre e lo comunica al #b[compositor] (_damage event_).
    5. Il compositor riorganizza parte dello schermo dove la finestra è visibile. È anche responsabile di #b[renderizzare] l'intero schermo passando dal server #b[X] per il rendereing.
    6. Il server #b[X] riceve la richiesta di rerendering e #b[copia] il buffer del compositor per essere renderizzato.
  ]
  
][
  #align(center)[Architettura di #b[X]]
  #figure(image("images/x-architecture.png"))
]

== Dov'è il server X?

Nella terminologia di _rete_, il sistema #b[client] è quello che è eseguito sul proprio computer,
mentre il #b[server] è "qualcosa" da qualche altra parte.

Nella terminologia di *X*,
il proprio computer esegue il #b[server],
mentre i #b[client] (applicazioni grafiche) possono risedere "altrove".

Le risorse gestire dal server X includono:
- *Schede video*
- *Pointing devices*: mouse, touchpad, ...
- *Tastiere*

== Perché finestre appaiono e agiscono differentemente?

I *client* possono essere collocati nella stessa macchina del server, oppure in una macchina remota.

Uno degli obiettivi iniziali di *X* era quello di fornire un meccanismo per #underline[implementare] le GUI,
ma non impone alcuna #b[politica] su come queste devono operare.

Questo significa che:
- Il _look and feel_ è lasciato a toolkit grafici (GTK, Qt, ecc.) generando #b[diversità] di stili
- Il vantaggio è che si può #b[sperimentare] e #b[innovare]

#figure(image("images/xorg-different-look.png", width: 50%))

Notare che la *title bar*, i *bordi* e i *controlli della finestra* sono uguali in quanto gestiti dal #b[window manager].

== Display e Monitor

In termini *X*, un #b[display] rappresenta l'interfaccia utente per una persona, solitamente costituita da una *tastiera*, un *puntatore*, una *scheda video* e un *monitor*.

Tuttavia, per alcune applicazioni è necessario più *spazio video*; quindi, un #b[display] può includere più schede video e monitor con _capacità_ e _risoluzioni_ diverse.

Tutte le schede e i monitor di un display possono essere combinati per agire come un unico grande monitor, un approccio chiamato *Xinerama*.
Xinerama permette di estendere le *finestre* su più monitor e funziona particolarmente bene su schermi #b[LCD multipannello], #b[pareti video] o #b[videoproiettori].

== Specifica del Display

Dal momento che un server X può essere raggiunto da qualunque parte della rete,
occorre un modo per specificare *quale display* si vuole usare.

#align(center)[`host:display[.screen]`]

- `:0` rappresenta il display 0 in locale utilizzando uno #b[schema di connessione locale]
- `localhost:0` è equivalente a `:0` ma la connessione avviene tramite #b[TCP/IP]
- `172.250.12.7:4.3` rappresenta il display 4 schermo 3 su un host remoto

#pagebreak()

La specifica del display può essere definita in vari modi:
- tramite il flag `-display` di un'applicazione X come `xterm -display <spec>`
- tramite la variabile d'ambiente `DISPLAY` come `export DISPLAY=<displayspec>`

Se la variabile d'ambiente `DISPLAY` è impostata, le applicazioni X la useranno per connettersi al server X.

Notare che l'opzione `-display` ha la precedenza sulla variabile d'ambiente.

== Eseguire X in locale

Un server *X* può essere eseguito in diversi modi per coprire le diverse esigenze.

Il modo più semplice è eseguire il comando:
```bash
$ X
```

Di default, il server X si avvia sul display `:0` e si connette al display locale.

Nel caso in cui il display `:0` sia già in uso, verrà generato un #b[errore].

Per cambiare il display si può usare il comando:

```bash
$ X :1
```

È altresì possibile specificare un file di configurazione con il flag `-config`:

```bash
$ X -config /etc/X11/xorg.conf
```

#b[Nota]: eseguire il server in questo modo non esegue alcuna applicazione #underline[client].

== Utilizzo di un Display Manager per avviare X

Uno dei possibili #underline[layer] di una GUI basata su *X* è il #b[Display Manager].

Generalmente configurato per avviare uno i più #b[Server X locali] e fornire un'interfaccia grafica per #underline[l'accesso all'utente].

Una volta autenticato l'utente,
questo fa partire alcuni client come il *Window Manager* e il *Desktop Environment*.

Alcuni esempi di #b[Display Manager] sono:

- `gdm` (GNOME Display Manager)
- `kdm` (KDE Display Manager)
- `lightdm` (Light Display Manager)
- `xdm` (X Display Manager)
- `sddm` (Simple Desktop Display Manager)

== Avvio Display Manager via init system

In ormai quasi tutte le distribuzioni come _Fedora_, _Manjaro_ (Arch) e _Ubuntu_,
il display manager viene avviato tramite il #b[init system] (es. `systemd`):

```bash
$ systemctl cat sddm  

# /usr/lib/systemd/system/sddm.service
[Unit]
Description=Simple Desktop Display Manager
Documentation=man:sddm(1) man:sddm.conf(5)
Conflicts=getty@tty1.service
After=systemd-user-sessions.service getty@tty1.service plymouth-quit.service systemd-logind.service
PartOf=graphical.target
StartLimitIntervalSec=30
StartLimitBurst=2

[Service]
ExecStart=/usr/bin/sddm
Restart=always

[Install]
Alias=display-manager.service
```

== Avviare un server X solo quando necessario

In alcuni casi, può essere utile avviare un server X *solo quando necessario*.

Ad esempio se si tratta di una macchina dedicata per servizi di rete potrebbe essere comodo avviare una sessione grafica per #b[amministrare il sistema].

L'utility `xinit` permette di avviare un server X e i client specificati, ma il wrapper `startx` fornisce una interfaccia più semplice. Dopo il login in una sessione testuale:

```bash
$ startx
```

Consente di specificare quali #b[client] avviare e quali opzioni passare al server X,
separati da `--`:

```bash
$ startx /usr/bin/xterm -- :1 -config /etc/X11/xorg.conf
```

== File `.xinitrc`

Se non si specificano client da avviare con `startx`, il server X cercherà un file `.xinitrc` nella home directory dell'utente.

Questo file contiene una lista di *comandi da eseguire* per avviare i client.

Ad esempio, per avviare un terminale e un window manager:

```bash
$ cat ~/.xinitrc

# Start a terminal
/usr/bin/X11/xterm &

# Start a window manager
exec gnome-session
```

== Eseguire X dentro X

Potrebbe essere scomodo dover continuamnete cambiare #b[VT] quando si vuole testare un setup di X.

Per evitare questo problema, si può eseguire un *server X dentro un altro server X*.

Per fare ciò, si usa il comando `Xnest`:

```bash
$ Xnest :1
```

È necessario specificare il display su cui si vuole eseguire il server X per #underline[evitare conflitti].

#pagebreak()

Per avviare `Xnest` con un client specifico si può fare uso del comando `startx`:

```bash
$ startx /usr/bin/xterm -- /usr/bin/Xnest :1
```

Dal momento che `Xnest` non interagisce direttamente con l'hardware,
è possibile specificare una dimansione dello schermo arbitraria:

```bash
$ Xnest -geometry 800x600 :1
```

Una alternativa più moderna a `Xnest` è `Xephyr`:

```bash
$ Xephyr -br -ac -noreset -screen 800x600 :1
```

Per eseguire un'applicazione in `Xephyr`:

```bash
$ DISPLAY=:1 xterm
```

== Configurazione di X

Un server X gestisce *diversi dispositivi*: tastiere, mouse, monitor, schede video.

Una configurazione del server X specifica come questi dispositivi sono #b[configurati] e #b[gestiti].

Per semplici configurazioni con #b[mouse], #b[tastiera], #b[monitor] e #b[scheda video] non è necessario alcun file di configurazione: *X* si adatta #underline[automaticamente].

Se abbiamo configurazioni più complesse come #b[multi-monitor] o #b[risoluzioni] personalizzate, occorre definire una #b[confiugrazione esplicita].

Inoltre, molte distribuzioni forniscono *configurazioni predefinite* #underline[ragionevoli].

== Dove si trovano i file di configurazione?

Secondo la _man page_ di `Xorg` i file di configurazione possono essere trovati in *diversi* path:

#table(
  columns: (1fr, auto),
  inset: 0.5em,
  stroke: none,
  table.header(
    [#b[Path]], [#b[Scopo]]
  ),
  table.hline(stroke: 0.03em),
  `/etc/X11/xorg.conf`, [Server configuration file.],
  `/etc/X11/xorg.conf-4`, [Server configuration file.],
  `/etc/xorg.conf`, [Server configuration file.],
  `/usr/etc/xorg.conf`, [Server configuration file.],
  `/usr/lib/X11/xorg.conf`, [Server configuration file.],
  `/etc/X11/xorg.conf.d`, [Server configuration directory.],
  `/etc/X11/xorg.conf.d-4`, [Server configuration directory.],
  `/etc/xorg.conf.d`, [Server configuration directory.],
  `/usr/etc/xorg.conf.d`, [Server configuration directory.],
  `/usr/lib/X11/xorg.conf.d`, [Server configuration directory.],
  table.hline(stroke: 0.03em),
)

#pagebreak()

Dal momento che possono le configurazioni possono essere *passate in vari modi*,
vengono lette in un ordine specifico:

1. Viene data priorità al file passato con l'opzione `-config`
2. Viene cercata la variabile d'ambiente `XORGCONFIG` (con nome del file di configurazione)
3. Viene cercato nella cartella `/etc/X11/`
  1. Primariamente `xorg.conf-4`
  2. Secondariamente `xorg.conf`
4. Viene cercato in `/etc` ma solo il file `xorg.conf`

La #b[configurazione standard] si trova in `/etc/X11/xorg.conf`,
oppure più file all'interno della cartella `/etc/X11/xorg.conf.d/`.

== Il file di configurazione `xorg.conf`

Il file di configurazione è suddiviso in 5 #b[sezioni] principali:

/ `ServerLayout`: Definisce come lo schermo e i dispositivi di input sono organizzati per formare un display.
/ `Screen`: Combina una scheda video e un `Monitor` per formare uno schermo.
/ `Monitor`: Definisce le caratteristiche del monitor.
/ `Device`: Definisce le caratteristiche della scheda video.
/ `InputDevice`: Continene informazioni per un device di input. Solitamente ci sono due di queste sezioni, una per mouse e una per tastiera.

== Esempio di file di configurazione `xorg.conf`

```
Section "ServerLayout"
    Identifier     "Layout0"
    Screen         0 "Screen0"
    InputDevice    "Keyboard0" "CoreKeyboard"
    InputDevice    "Mouse0" "CorePointer"
EndSection

Section "InputDevice"
    Identifier     "Keyboard0"
    Driver         "libinput"
    Option         "XkbLayout" "it"  # Imposta la tastiera in italiano
EndSection

Section "InputDevice"
    Identifier     "Mouse0"
    Driver         "libinput"
EndSection

Section "Device"
    Identifier     "Device0"
    Driver         "nvidia"  # Cambia con "intel", "amd", "nouveau", ecc. in base alla tua scheda grafica
    Option         "NoLogo" "True"  # Rimuove il logo NVIDIA all'avvio
EndSection

Section "Monitor"
    Identifier     "Monitor0"
    VendorName     "Generic"
    ModelName      "Generic Monitor"
    HorizSync      30.0 - 80.0
    VertRefresh    50.0 - 75.0
EndSection

Section "Screen"
    Identifier     "Screen0"
    Device         "Device0"
    Monitor        "Monitor0"
    DefaultDepth   24
    SubSection "Display"
        Depth       24
        Modes      "1920x1080"  # Risoluzione preferita
    EndSubSection
EndSection
```

== Configurazione: `ServerLayout`

Sezione del file di configurazione *opzionale* ma quasi sempre presente nel file di configurazione.

Le sotto-sezioni di `ServerLayout` includono:

/ `Identifier`: Nome univoco per il layout.
/ `Screen`: Associa uno schermo con il display. Se si vogliono associare più screen, si possono aggiungere più righe `Screen`.
/ `InputDevice`: Associa un dispositivo di input con il layout.
/ `Option`: Opzioni per il layout.

== Configurazione: `Screen`

La sezione `Screen` combina un `Device` e un `Monitor` per formare uno schermo.

Le sotto-sezioni di `Screen` includono:

/ `Identifier`: Nome univoco per lo screen. Utilizzabile anche da CLI con l'opzione `-screen`.
/ `Device`: Cross-reference alla scheda video deefinita nella blocco `Device`.
/ `Monitor`: Cross-reference al monitor definito nella sezione `Monitor`.
/ `DefaultDepth`: Profondità di colore predefinita per lo screen in bits/pixel, 24 è la più comune.

== Configurazione: `Monitor`

La sezione `Monitor` definisce le caratteristiche del monitor e solitamente è molto semplice in quanto contiene solo una entry `Identifier`.

== Configurazione: `Device`

La sezione `Device` definisce le caratteristiche della scheda video.

Le sotto-sezioni di `Device` includono:

/ `Identifier`: Nome univoco per la scheda video.
/ `Driver`: Driver da utilizzare per la scheda video. Generalmente identificato automaticamente tramite PCI.

== Configurazione: `InputDevice`

La sezione `InputDevice` definisce le dispositivi di input come tastiere e mouse.

Le sotto-sezioni di `InputDevice` includono:

/ `Identifier`: Nome univoco per il dispositivo di input.
/ `Driver`: Driver da utilizzare per il dispositivo di input. \
    Ad esempio `libinput` o `synaptics` (touchpad).

== Server X Remoto

Un server X può essere eseguito su un *computer remoto* e visualizzato su un *computer locale*.

Per fare ciò, è necessario #b[abilitare il forwarding X] sul server remoto e #b[configurare il client locale] per connettersi al server remoto.

Prerequisiti:
- #b[Server remoto] con Xorg installato
- #b[Client locale] con *SSH* installato (`ssh` su Linux e macOS, `PuTTY` su Windows)
- #b[X11 forwarding] abilitato sul server remoto (configurazione di `sshd_config`)

== Abilitare X11 Forwarding

Per abilitare il #b[forwarding X11] su un server remoto, è necessario modificare il *file di configurazione di SSH*.

Il file di configurazione di SSH si trova in `/etc/ssh/sshd_config` e la direttiva da modificare è `X11Forwarding`.

```bash
X11Forwarding yes
# X11DisplayOffset 10
# X11UseLocalhost yes
```

== Connessione al Server Remoto

Per connettersi al server remoto con il forwarding X11 abilitato, è necessario usare l'opzione `-X` di `ssh`.

```bash
$ ssh -X user@remote-server
```

Una volta connessi, è possibile avviare applicazioni grafiche sul server remoto e visualizzarle sul
client locale.

```bash
$ xeyes
```

Per comprimere i dati X11 trasmessi, si può usare l'opzione `-C`:

```bash
$ ssh -XC user@remote-server
```

== Limitazioni del Forwarding X11

Il forwarding X11 è un metodo semplice per visualizzare applicazioni grafiche da un server remoto,
ma ha alcune #b[limitazioni]:

- #fa-warning() *Sicurezza* #fa-warning(): il forwarding X11 non è sicuro, poiché i dati X11 non sono crittografati
- *Velocità*: il forwarding X11 può essere lento su connessioni lente
- *Compatibilità*: alcune applicazioni grafiche non supportano il forwarding X11

== Server Grafici: Wayland

#slide[
  *Wayland* è la #b[next-generation display server] per sistemi _Unix-like_ progettato per sostituire il sistema X Window.

  Wayland è stato progettato per essere più #b[moderno], #b[efficiente] e #b[sicuro] rispetto a X.
][
  #figure(image("images/Wayland_Logo.svg"))
]

== Design High-Level di Wayland

Ogni computer ha dispositivi di #b[input] e #b[output] che vengono condivise tra le applicazioni.

Il ruolo del *Compositor di Wayland* è quello di distribuire gli eventi di input agli appropriati *client Wayland* e di visualizzarle correttamente in output.

Il processo di "raccogliere" tutte le finestre e delle applicazioni e renderle sullo schermo è chiamato #b[compositing]. Il *compositor* è responsabile di questo processo.

Il #b[server] wayland è il *compositor*, mentre le applicazioni sono i #b[client wayland].

== Un protocollo non un'implementazione

Wayland definisce un *protocollo* che viene usato dalle applicazioni per rendersi visibili sullo schermo 
e prendere input dall'utente. Spesso ci si rifereisce a *Wayland* come architettura.

Non esiste un singolo server Wayland come #b[Xorg] lo è per #b[X11],
ma ogni environment grafico fornisce la propria implementazione del compositor *Wayland*.

Una parte core dell'architettura Wayland è `libwayland`, una libreria C che implementa una _inter-process communication_ (IPC) che traduce la definizione del protocollo in #b[XML] ad #b[API C].

Questa non è una implementazione di Wayland, ma #b[codifica] e #b[decodifica] i messaggi del protocollo.

== Architettura di Wayland comparata con X

#slide(composer: (1fr, auto))[
  #only("1")[
    Per comprendere l'architettura di *Wayland* è utile confrontarla con quella di #b[X].

    1. Il kernel prende eventi dai dispositivi di input e li passa al server #b[traducendo] i singoli protocolli in un formato standard (`evdev`).
    2. Il server #[X] determina quale finestra è coinvolta dall'evento e lo passa al client. Il server #b[X] non sa l'effettiva posizione delle finestre in quanto gestito dal #b[compositor].
    3. Il client gestisce l'evento e decide come reagire.
  ]
  #only("2")[
    4. Quando il server #b[X] riceve la richiesta di *rerendering* calcolando le nuove bounding region delle finestre e lo comunica al #b[compositor] (_damage event_).
    5. Il compositor riorganizza parte dello schermo dove la finestra è visibile. È anche responsabile di #b[renderizzare] l'intero schermo passando dal server #b[X] per il rendereing.
    6. Il server #b[X] riceve la richiesta di rerendering e #b[copia] il buffer del compositor per essere renderizzato.
  ]
  
][
  #align(center)[Architettura di #b[X]]
  #figure(image("images/x-architecture.png"))
]

== Problemi di questo approccio

- Il server #b[X] non ha *sufficienti informazioni* per decidere quale finestra deve ricevere l'evento.
- Non riesce a convertire le coordinate dello schermo in coordinate della finestra locali.
- Anche se #b[X] ha lasciato la responsabilità del rendering al #b[compositor], il server #b[X] deve comunque #b[gestire] il rendering.
- Molte parti *complesse* per la gestione di #b[X] ora sono disponibili nel kernel o in librerie.

In generale #b[X] è un *componente di mezzo* tra le applicazioni e il compositor, ma anche tra l'hardware e il compositor.

== Architettura di Wayland

#slide(composer: (1fr, auto))[

  In Wayland il *compositor* è il #b[display server].

  1. Il kernel recupera gli #b[eventi] e li invia al *compositor* (simile a #b[X])
  2. Il compositor determina se ci sono fisetre che devono ricevere l'evento e lo invia al #b[client].
      Essendo lo _sceenegraph_ conosciuto, il compositor sa esattamente quale finestra è coinvolta.
  3. Come per #b[X] il client gestisce l'evento e decide come reagire. Ma in Wayland il client è responsabile di #b[renderizzare] la finestra e notificare il compositor della regione che è cambiata.
  4. Il compositor riceve le notifica di cambiamento e #b[renderizza] la regione interessata.
][
  #align(center)[Architettura di #b[Wayland]]
  #figure(image("images/wayland-architecture.png"))
]

== Vantaggi di Wayland

- *Sicurezza*: Wayland è progettato per essere più sicuro di X. I client non possono accedere a memoria di altri client.
- *Efficienza*: Wayland è progettato per essere più efficiente di X. Il compositor sa esattamente cosa deve essere renderizzato.
- *Semplicità*: Wayland è progettato per essere più semplice di X. Il protocollo è più semplice e più facile da implementare.
- *Modernità*: Wayland è progettato per essere più moderno di X. Supporta le tecnologie moderne come le composizioni.
- *Compatibilità*: Wayland è progettato per essere compatibile con X. È possibile eseguire applicazioni X su Wayland tramite XWayland.
- *High DPI*: Wayland è progettato per supportare meglio gli schermi ad alta risoluzione.

== XWayland

XWayland è un server X che gira sopra Wayland e permette di *eseguire applicazioni X* su un compositor Wayland.

=== Note su XWayland

- *Sicurezza*: XWayland è di fatto un server X. Non applica quindi le stesse restrizioni di sicurezza di Wayland.
- *Prestazioni*: XWayland ha performance pressoché identiche a X. Qualche degradazione è possibile, soprattutto su schede video #b[NVIDIA].
- *Compatibilità*: XWayland non è *pienamente compatibile* con X11. Alcune applicazioni potrebbero non funzionare correttamente su XWayland.

== Toolkit e Wayland

I toolkit grafici come #b[GTK] e #b[Qt] sono stati aggiornati per supportare Wayland.

- *GTK*: supporta Wayland dalla versione 3.20.
- *Qt*: supporta Wayland dalla versione 5.4.

La maggior parte delle #b[applicazioni moderne] supporta Wayland, ma alcune applicazioni più vecchie potrebbero non funzionare correttamente.

== QT e GTK su Wayland

=== GTK
GTK utilizza Wayland *di default* se disponibile. Per forzare l'uso di X11, è possibile settare la variabile d'ambiente `GDK_BACKEND=x11`.

=== QT
Per abilitare il supporto a #b[wayland] in QT, è necessario installare il pacchetto `qtwayland5` o `qt5-wayland` (il nome dipende dalla distribuzione).
Le applicazioni QT *supporteranno Wayland* se il compositor è Wayland.

Generalmente non è necessario, ma è possibile forzare l'ude di Wayland usando `-platform wayland` oppure `QT_QPA_PLATFORM=wayland`.

Per forzare invece l'uso di X11 in una sessione Wayland, è possibile settare `QT_QPA_PLATFORM=xcb`.

== Configurazione Electron per Wayland

Se si utilizza una applicazione basata su #b[Electron] su un sistema Wayland, è possibile che l'applicazione non si comporti correttamente.

Per forzare l'uso di XWayland, è possibile adottare la seguente configurazione:

File `~/.config/electron-flags.conf`:
```
--enable-features=WaylandWindowDecorations
--ozone-platform-hint=auto
```

Per vecchie versioni di electron \<25 :

```
--enable-features=UseOzonePlatform
--ozone-platform=wayland
```

== Distingure finestra X e Wayland

Per capire se si sta utilizzando X o Wayland, è possibile usare il comando `echo $XDG_SESSION_TYPE`.

Tuttavia, visto che XWayland potrebbe essere attivo, potrebbe non essere chiaro *quale* applicazione 
sta utilizzando #b[X] o #b[Wayland].

=== xeyes

Per capire quale server grafico sta utilizzando un'applicazione, è possibile usare `xeyes`.

Se `xeyes` si muove con il mouse, allora l'applicazione sta utilizzando X. Se invece `xeyes` non si muove con il mouse, allora l'applicazione sta utilizzando Wayland.

=== extramaus

Un altro metodo per capire quale server grafico sta utilizzando un'applicazione è utilizzare `extramaus`.

Se il mouse diventa #text(fill: red)[rosso] allora si tratta di una applicazione #b[X], altrimenti si tratta di una applicazione #b[Wayland].

// =================================== Linux Embedded ====================================
// =======================================================================================

= Linux Embedded --- #b[Yocto Project]

== Cos'è il progetto Yocto?

#slide(composer: (2fr, 1fr))[
  Il #b[progetto Yocto] è una iniziativa #underline[open source] per facilitare la realizzazione di sistemi _Linux-based_ specfici per sistemi embedded *indipendentemente* dall'architettura hardware.

  Fornisce un insieme di #b[strumenti] e #b[ambienti di sviluppo] per la creazione di sistemi embedded sfruttando *best practices* e *standard*.
][
  #figure(image("images/Yocto_Project_logo.svg"))
]

== Yocto overview

#figure(image("images/yocto-official-overview.png"))

== Feature di Yocto

- *Ampiamente adottata nell'industria*: molti vendor noti forniscono #b[supporto] per Yocto
- *Agnostica dall'architettura*: Yocto supporta #b[Intel], #b[ARM], #b[MIPS], #b[AMD], #b[PPC] e altre architetture
- *Flessibilità*: Possibilità di creare distribuzioni Linux #b[custom] mediante _configurazioni_ e _layer_
- *Ideale per sistemi embedded e dispositivi IoT*: Possibilità di #b[ottimizzare] l'immagine per risorse hardware limitate
- *Modello a Layer*: consente di #b[isolare] funzionalità riducendo la complessità e la ridondanza

== #fa-warning() Sfide di Yocto

- *Curva di apprendimento*: Yocto ha una curva di apprendimento #b[ripida]. Molti task possono essere fatti in modi diversi: difficile trovare il modo migliore.
- *Workflow intricato*: A differenza dello sviluppo su PC, che solitamente prevede binari pre-compilati, Yocto richiede la #b[compilazione da sorgenti] e la #b[configurazione manuale].
- *Ambiente cross-compilato*: Yocto richiede le toolchain #b[cross-compilate] per la compilazione su architetture diverse. Questo può essere complicato quando si sviluppa per una specifica architettura.
- #fa-clock() *Tempi di compilazione*: Tempi di compilazione lunghi, specialmente per la prima build sono inevitabili dal memento che ogni pacchetto è #b[compilato dai sorgenti].

== Modello a Layer di Yocto

Il #b[modello a layer] di *Yocto* è un modello di sviluppo che lo distingue da altri sistemi di build.

Questo modello supporta contemporaneamente la #b[collaborazione] e la #b[personalizzazione].

I *layer* sono #b[repository] che contengono un #b[set di istruzioni] per indicare a *OpenEmbedded* cosa fare.

Un *layer* può contenere cambiamenti per #b[precedenti istruzioni] o #b[override di impostazioni]. Questo permette di #b[personalizzare] layer preesistenti per adattare la build alle proprie esigenze.

#pagebreak()

Si usano i *layer* per #b[organizzare] e #b[separare logicamente] le informazioni nella build.

Ad esempio, possiamo dover gestire *GUI*, *configurazioni di sistema*, *applicazioni*, ecc. e metterli in un unico layer #b[limita] e #b[complica] la gestione futura e il riuso.

Inizialmente si tende a voler mettere #b[tutte le funzionalità] in un unico layer,
ma più modulari sono i *Metadata* più facile sarà #b[gestire] e #b[estendere] il sistema in futuro.

=== Note sull'adozione dei layer

- Utilizzare i #b[Board Package Support] (BSP) forniti dai produttori hardware
- Familiarizzare con #underline[#link("https://www.yoctoproject.org/software-overview/layers/", "Yocto Project Compatible Layers")] e #underline[#link("https://layers.openembedded.org/", "OpenEmbedded Layer Index")]
- Prediligere layer segnalati con #b[YP Compatible]

#align(center)[#text(size: 1.3em)[Tipicamente i *layer* hanno un nome che inizia con `meta-`]]

== Componenti e Strumenti

*Yocto* mette a disposizione una serie di #b[componenti] e #b[strumenti] per la creazione di distro personalizzate.
Di seguito una panoramica dei principali componenti:

=== Strumenti di sviluppo

- *CROPS*: fornisce un ambiente di sviluppo cross-plaform sfruttando #b[Docker]
- *devtool*: strumento a linea di comando parte dell'#b[extensible SDK] (eSDK). Aiuta a creare, testare e distribuire pacchetti software dentro eSDK.
- *eSDK*: fornisce un ambiente di sviluppo cross-compilato per creare applicazioni per il sistema target.
- *Toaster*: interfaccia web per la gestione delle build Yocto.
- *Estensione VScode*: estensione per #b[Visual Studio Code] per lo sviluppo delle ricette Yocto.

#pagebreak()

=== Strumenti per la produzione

- *Auto Upgrade Helper*: gestisce l'aggiornamento delle ricette che sono basate su nuove versioni pubblicate in upstream.
- *Recipe Reporting System*: traccia le versioni disponibili per Yocto.
- *AutoBuilder*: AutoBuilder è un progetto che automatizza la compilazione, il test e la quality assurance (QA).

=== Open-Embedded Build System Components

- *BitBake*: il cuore del sistema di build Yocto. BitBake è un task scheduler che legge file testuali per capire cosa deve essere fatto e dove.
- *OpenEmbedded-Core*: insieme di ricette e classi di base per la creazione di distribuzioni Linux.

== Distribuzione di Riferimento #b[Poky]

È la distribuzione di *riferimento* del progetto Yocto. Contiene #b[OpenEmbedded Build System] (BitBake e OpenEmbedded-Core) e diversi metadati per la creazione di distribuzioni Linux personalizzate.

#figure(image("images/yocto-official-overview.png"))

== Terminologia

/ Configuration File: file contenente le definizioni di #b[variabili] globali, definite dall'utente e infromazioni sulle #b[configurazioni hardware].
/ Recipe: forma più comune di #b[metadata]. Contiene una lista di #b[configurazioni] e #b[task] per la compilazione di un componente software.
  Una #b[ricetta] descrive come recuperare e compilare un componente software e quali eventuali #b[patch] applicare.
  Descrivono anche #b[dipendenze] per librerie o altre ricette.
  Sono memorizzate nei #b[layer].
/ Layer: insieme di #b[ricette]. Un layer consente di organizzare ricette correlate tra loro per personalizzare la build.
  I layer sono #b[gerarchici] in quanto è possibile fare _override_ di ricette in layer successivi.
/ Metadata: includono #b[ricette], #b[file di configurazioni], e #b[altre informazioni] necessarie per controllare quali cose verrano incluse nella build e come verranno costruite.
/ OpenEmbedded-Core: metadata contenente le #b[ricette] e le #b[classi] di base per la creazione di distribuzioni Linux. Ricette curate dalla comunità OpenEmbedded.
/ Poky: distribuzione di #b[riferimento] per sistemi embedded e riferimento per configurazioni di test per:
  (i) fornire funzionalità base per una distro funzionante, e (ii) testare componenti Yocto.
/ Build System -- "Bitbake": #b[scheduler] e #b[execution engine] che parse le istruzioni (ricette) e dati di configurazione.
  Crea un #b[dependency tree] per definire l'ordine e fare scheduling dei task di compilazione e costruire la distribuzione specificata.
  Strumento simila a #b[make].
/ Packages: output del processo di #b[build] per creare l'immagine finale.
/ Extensible Software Development Kit (eSDK): SDK custom per sviluppatori che vogliono #b[incoprorare] le proprie librerie nell'immagine per rendere il proprio codice disponibile ad altre applicazioni o sviluppatori.
/ Image: fomato binario di una #b[distribuzione] (sistema operativo) che può essere installato su un dispositivo target.

== Workflow di Yocto

1. Viene specificata una #b[architettura], #b[policies], #b[patches] e #b[configurazioni].
2. Il #b[build system] recupera e scarica i sorgenti. Diversi formati e modi di recuperare i sorgenti sono supportati.
3. Una volta scaricati, vengono estratti all'interno di una #b[cartella locale] dove vengono applicate eventuali #b[patch] e gli step per configurare e compilare il software vengono eseguiti.
4. Il software viene quindi installato una #b[staging area temporanea] dove viene usato il #b[formato di pacchetto selezionato] (`deb`, `rpm`, o `ipk`) verrà usato per installare il software.
5. Diversi controlli #b[QA] vengono eseguiti durante l'intero processo di build.
6. Viene creata l'immagine del #b[file system] finale.

== Yocto Project Development Environment

=== Filosofia Open Source

Il progetto *Yocto* è un progetto #b[open source] e #b[comunitario].
Differentemente da progetti #b[closed source], Yocto permette a #b[sviluppatori] e #b[aziende] di contribuire e migliorare il progetto.

In ambienti open source i #b[prodotti finali], #b[sorgenti], #b[documentazione] sono disponibili *pubblicamente* senza costi.

== Development Host

Il development host o *Build Host* è fondamentale per utilizzare Yocto.

L'obiettivo di #b[Yocto] è quello di sviluppare immagini per #b[sistemi embedded] e quindi lo sviluppo di quelle immagini e applicazioni avviene su un host non pensato per eseguirle: il *development host*.

Come #b[Build Host] non è necessario avere una macchina Linux, ma è sufficiente avere un sistema che sia in grado di eseguirlo, come ad Docker.

Per configurare un Build Host è possibile utilizzare #b[CROPS] (CROss PlatformS) tramite Docker. Questo mette a disposizione una shell interattiva con tutti gli strumenti necessari per lo sviluppo.

#align(center)[#text(size: 1.3em)[Faremo riferimento a *CROPS* per configurare il Build Host.]]

== Yocto Project Source Repositories

Il team di *Yocto* mantiene una lista completa di #b[repository] per tutti i componenti del progetto all'indirizzo #underline[#link("https://git.yoctoproject.org/", "git.yoctoproject.org")].

Il sito organizza i repository in #b[categorie] per funzioni come _Plugin per IDE_, _Matchbox_, _Poky_, _Yocto Linux Kernel_ e altri.

È possibile interagire con i repository, ad esempio clonarli, tramite #b[Git] per avere una copia locale dei sorgenti.

== Interazione Tramite Repository con Git

Il modo *consigliato* per integrare i #b[repository] di Yocto nella distribuzione è tramite #b[Git].

- Questo consente di #b[seguire] le modifiche e #b[aggiornamenti] dei repository.
- È possibile #b[contribuire] al progetto Yocto.

Prestare attenzione ad utilizzare lo stesso #b[branch] per tutti i repository per evitare problemi di #b[compatibilità].

Ad esempio se si utilizza il branch `scarthgap` per `poky`, utilizzare lo stesso branch per `meta-openembedded`, `meta-intel`, ecc.

== Progetto Yocto e Git

#slide(composer: (1fr, auto))[
  Sviluppare con *Yocto* richiede una discreta conoscenza di #b[Git].

  #b[Git] è un sistema di controllo di versione distribuito che permette di tenere traccia delle modifiche ai file e coordinare il lavoro tra più persone.

  - *Yocto* organizza e mantiene i file in #b[branch] tramite i quali #b[Git] traccia le modifiche.
  - Generalmente ogni #b[branch] corrisponde a una #b[release] di Yocto.
  - I #b[tag] sono usati per marcare #b[release] e #b[versioni] specifiche.

  ```git
  $ cd ~
  $ git clone git://git.yoctoproject.org/poky
  $ cd poky
  $ git fetch --tags
  $ git checkout tags/rocko-18.0.0 -b my_rocko-18.0.0
  ```
][
  #figure(image("images/Git_icon.svg"))
]

== Prontuario Git

- `git init`: inizializza un repository
- `git clone <url>`: clona un repository
- `git add <file>`: aggiunge un file al repository
- `git commit -m "message"`: committa le modifiche
- `git status`: mostra lo stato del repository
- `git checkout branch`: cambia branch
- `git checkout -b <branch>`: crea e fa checkout su un nuovo branch
- `git branch -a`: mostra tutti i branch locali e remoti
- `git pull`: scarica le modifiche dal repository remoto
- `git push`: carica le modifiche sul repository remoto
- `git log`: mostra la cronologia delle modifiche
- `git diff`: mostra le modifiche non committate

== Licenze

Il progetto *Yocto* è rilasciato sotto la #b[licenza MIT].

Questa licenza permette il riuso di software all'interno di progetti open source e #b[commerciali].
Più informazioni sulla licenza sono disponibili: #underline[#link("https://spdx.org/licenses/MIT.html", "MIT License")].

Quando si costruisce un'immagine, il processo di build usa una lista di #b[licenze note] per verificare che i pacchetti siano conformi alle licenze.

Questa lista si trova in `meta/files/common-licenses`. Al termine della build, tutte le licenze trovate e usate durante la build sono salvate in `tmp/deploy/licenses`.

Se un modulo richiede una licenza che non è parte di questa lista, il processo di build solleva in #b[warning].
Questo approccio aiuta gli sviluppatori a garantire che i pacchetti siano conformi alle licenze.

// Fine prima ora

== Bitbake

*BitBake* è lo strumento al cuore di #b[OpenEmbedded] ed è responsabile di fare il parsing dei #b[Metadata] generando una #b[lista di task] per poi #b[eseguirli] in modo efficiente.

Per vedere la lista delle opzioni supportate da *BitBake* è possibile usare i comandi:

```bash
$ bitbake --help
$ bitbake-layers --help # utility per la gestione dei layer
$ bitbake-getvar --help # utility per ottenere variabili
```

Il modo più comune per utilizzare *BitBake* è tramite il comando `bitbake <recipe>`.
La `recipe` è il nome della ricetta che si vuole compilare (detta anche #b[target]).

Il target spesso è il prefisso del nome del file con estensione `.bb`, ad esempio la ricetta `foo_1.2.3.bb` ha come target `foo`.

```bash
$ bitbake foo
```

Possono esserci più versioni di una ricetta, *BitBake* sceglierà quella definita nel file di configurazione.

*BitBake* eseguirà anche tutti i #b[task dipendenti] prima di eseguire il task richiesto.

Ad esempio prima di compilare il pacchetto `matchbox-desktop` verrà compilato il compilatore e la `glibc`, se non già compilati prima.

=== Similarità con Make

Concettualmente *BitBake* e *Make* sono simili ma con alcune differenze:

- BitBake esegue task secondo i #b[metadata] forniti in cui sono specificate le istruzioni su quali task eseguire ed eventuali #b[dipendenze].
- BitBake consente di fare #b[fetching] di librerie per ottenere i sorgenti da diverse fonti.
- Le istruzioni per ogni unità che deve essere compilata è conosciuta come #b[ricetta] e definisce informazioni sulla unità.
- BitBake ha una architettura #b[client/server] e può essere utilizzato via CLI oppure come servizio tramite XML-RPC.

== Recipes

Le *ricette* BitBake sono file con estensione `.bb` e sono i file più basici contenenti metadati.

Una ricetta fornisce le seguenti informazioni:
- #b[Descrizione] del pacchetto (autori, homepage, licenza, ecc.)
- La #b[versione] della ricetta
- #b[Dipendenze] del pacchetto
- Dove #b[risiede] il codice sorgente e #b[come] recuperarlo
- Se è richiesta una #b[patch] #b[dove] trovarla e #b[come] applicarla
- Come #b[configurare] e #b[compilare] i sorgenti
- Come #b[assemblare] e generare #b[artefatti] in uno o più pacchetti installabili
- #b[Dove] installare il pacchetto o i pacchetti nell'immagine target

#pagebreak()

Un esempio di ricetta che #b[compila] ed #b[installa] un semplice programma `hello`:

```bash
SUMMARY = "Hello World"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://COPYING;md5=59530bdf33659b29e73d4adb9f9f6552"

SRC_URI = "file://hello.c"

do_compile() {
    ${CC} ${CFLAGS} ${LDFLAGS} -o hello hello.c
}

do_install() {
    install -d ${D}${bindir}
    install -m 0755 hello ${D}${bindir}
}

FILES_${PN} = "${bindir}/hello"
```
== Configuration Files

I *file di configurazione* hanno estensione `.conf` e definiscono #b[variabili] di configurazione che governano il processo di build del progetto.

Questi file si trovano in diverse aree dalla #b[configurazione della macchina], #b[configurazione della distribuzione], #b[tuning della compilazione],
#b[configurazioni generali] e #b[configurazioni utente].

Il file di configurazione *principale* è `local.conf` che si trova nella cartella `conf` del layer principale.

```bash
# Set the machine to build for
MACHINE = "qemux86"

# Set the distribution to build
DISTRO = "poky"

# Set the package management system
PACKAGE_CLASSES ?= "package_rpm"
```

== Classes

Le *classi* sono file con estensione `.bbclass` che contengono #b[infromazioni] che possono essere condivise tra #b[metadati].

Il source tree di BitBake contiene una classe di base chiamata `base.bbclass` che è inclusa in tutte le ricette di default.
Questa classe definisce i task di base come `do_fetch`, `do_configure`, `do_compile`, `do_install`, ecc.

Questi task sono generalmente #b[sovrascritti] o #b[estesi] da altre classi durante lo sviluppo del progetto.

```bash
inherit base

do_configure() {
    # Add custom configuration here
}
```

== Layers

Consentono di *isolare* diverse customizzazioni tra loro.

Per mantenere la modularità, le personalizzazioni per una macchina specifica vanno collocate in un #b[livello dedicato],
chiamato Board Support Package (BSP), separato dai livelli generali.

Ad esempio, le configurazioni della macchina devono restare #b[distinte] da ricette e metadati relativi a un nuovo ambiente GUI.

Il livello BSP può comunque #b[aggiungere modifiche] specifiche della macchina alle ricette del livello GUI senza contaminare quest'ultimo,
utilizzando file di tipo BitBake append (`.bbappend`).

== Append Files

I *file di append* (append files) sono file con estensione `.bbappend` che estendono le ricette esistenti o fanno #b[override] di variabili e task.

BitBake si aspetta che ogni file `.bbappend` corrisponda ad una #b[ricetta].
È altresì possibile definire un file `.bbappend` che ha la stessa radice del file `.bb` che si vuole estendere,
ad esempio `foo_1.2.3.bb` può essere esteso da `foo_1.2.3.bbappend`.

Quando si usa il `%` nel nome di un append file, BitBake consente di applicarlo a tutte le ricette che iniziano con quel prefisso.
Ad esempio:

```bash
busybox_1.21.%.bbappend
```

Questo file di append verrà applicato a tutte le versioni di `busybox` che iniziano con `1.21`. Quindi il file di append verrà applicato alle seguenti ricette:

```bash
busybox_1.21.0.bb
busybox_1.21.1.bb
busybox_1.21.2.bb
```

== Sintassi e Operatori

I file BitBake hanno una #b[sintassi] specifica simile ad altri linguaggi, ma con #b[peculiarità].

=== Definizione variabili

L'esempio seguente definisce una variabile `MY_VAR` con valore `hello`:

```bash
MY_VAR = "hello"
```

Come atteso, se nel contenuto della variabile sono presenti #b[spazi] prima o dopo, questi vengono *preservati*.

```bash
MY_VAR = " hello "
MY_VAR2 = " hello"
```

Si possono usare i #b["single quote"] per definire una variabile. In questo modo possiamo avere valori che contengono il carattere `"`.

```bash
MY_VAR = 'hello "world"'
```

=== Modifica variabili

Spesso capita di dover #b[modificare] una variabile già definita.

Ad esempio:

- Personalizzare una #b[ricetta] che definisce certe variabili
- Cambiare il valore di #b[default] di una variabile in un file `*.bbclass`
- Cambiare una variabile in un file `*.bbappend` per fare #b[override] di una variabile nella ricetta originale
- Cambiare una variabile in un file `*.conf` per fare #b[override] di una configurazione esistente

```bash
$ bitbake -e
```

Mostra i valori delle variabili dopo che i #b[file di configurazione] sono stati processati.

```bash
$ bitbake -e | grep VARIABLENAME=\"
```

=== Line joining

Al di fuori delle funzioni, BitBake unisce le linee che terminano con `\`.

```bash
MY_VAR = "hello \
         world"
```

In questo caso `MY_VAR` avrà valore `hello world`.

```bash
MY_VAR = "helloword"
MY_VAR = "hello\
world"
```

In questo caso `MY_VAR` avrà valore `helloworld` in entrambi i casi.

#pagebreak()

=== Variable Expansion

Le variabili possono avere un #b[riferimento] al contenuto di altre variabili:

```bash
MY_VAR = "hello"
MY_VAR2 = "${MY_VAR} world"
```

Il risultato di `MY_VAR2` sarà `hello world`. Le parentesi graffe `{}` sono obbligatorie.

L'operatore `=` non esapnde immediatamente le variabili:

```bash
A = "${B} baz"
B = "${C} bar"
C = "foo"
*At this point, ${A} equals "foo bar baz"*
C = "qux"
*At this point, ${A} equals "qux bar baz"*
B = "norf"
*At this point, ${A} equals "norf baz"*
```

Il comportamento #b[speculare] a questo è dato dall'operatore `:=` che espande immediatamente le variabili.

Se l'espansione di una variabile è usata su una variabile non definita, la stringa corrispondente verrà usata:

```bash
BAR = "${FOO}"
```

Questo assegnerà a `BAR` il valore `"${FOO}"`, dal momento che `FOO` non è definita.

#pagebreak()

=== Valore di default

Si può fare uso dell'operatore `?=` per assegnare un valore di default a una variabile.

Questo assegnamento consente di definire una variabile che se non è già definita, verrà assegnato il valore di default.

```bash
MY_VAR ?= "hello"
```

Se `MY_VAR` è già definita quando questo statement viene processato, allora manterrà il suo valore.
Se `MY_VAR` non è definita, allora verrà assegnato il valore `hello`.

Questo operatore assegna *immediatamente* il valore di default (quando non definita prima la variabile).
Se ci sono chiamate multiple dell'operatore `?=` sulla stessa variabile, #b[solo il primo assegnamento] avrà effetto.

#pagebreak()

=== Weak default

Il valore di default "weak" è il valore che viene espanso se non c'è nessun valore associato alla variabile.

L'operatore `??=` ha #b[effetto immediato] rimpiazzando qualsiasi altro "weak value" precedentemente assegnato.

#components.side-by-side(columns: 2)[
  ```bash
  W ??= "x"
  A := "${W}" # Immediate variable expansion
  W ??= "y"
  B := "${W}" # Immediate variable expansion
  W ??= "z"
  C = "${W}"
  W ?= "i"
  ```
][
  ```bash

  A = "x"

  B = "y"

  C = "i"
  W = "i"
  ```
]

#pagebreak()

=== Espansione immediata

L'operatore `:=` espande *immediatamente* le variabili invece che espandere solo quando la variabile è usata.

#components.side-by-side(columns: 2)[
  ```bash
  T = "123"
  A := "test ${T}"
  T = "456"
  B := "${T} ${C}"
  C = "cval"
  C := "${C}append"
  ```
][
  ```bash

  A = "test 123"

  B = "456 cvalappend"
  C = "cvalappend"


  ```
]

#pagebreak()

=== Append e prepend con spazi

#b[Appendere] o #b[prependere] è comune e viene fatto con gli operatori `+=` e `=+`.
Questi operatori *aggiungono uno spazio* tra il valore corrente e il valore da aggiungere.

```bash
B = "bval"
B += "additionaldata"
C = "cval"
C =+ "test"
```

In questo caso `B` avrà valore `bval additionaldata` e `C` avrà valore `test cval`.

Se non si vuole aggiungere uno spazio, si può fare uso degli operatori `.=` e `=.`.

#pagebreak()

=== Append e prepend (override syntax)

Si può anche appendere o prependere il valore di una variabile utilizzando la #b[sintassi di override].
Quando si usa questa sintassi, #b[non vengono aggiunti spazi].

Questi operatori differiscono da `:=`, `=:`, `+=`, `=+` in quanto sono applicati in fase di *espansione* e non immediatamente.

```bash
B = "bval"
B:append = " additional data"
C = "cval"
C:prepend = "additional data "
D = "dval"
D:append = "additional data"
```

#pagebreak()

=== Rimozione (override syntax)

È possibile *rimuovere* valori da liste utilizzando la sintassi `VARIABLE:remove`.
Differentmente da `:append` e `:prepend` non è necessario aggiungere spazi vuoti.

```bash
FOO = "123 456 789 123456 123 456 123 456"
FOO:remove = "123"
FOO:remove = "456"
FOO2 = " abc def ghi abcdef abc def abc def def"
FOO2:remove = "\
    def \
    abc \
    ghi \
    "
``` 

Anche in questo caso, la rimozione avviene in fase di #b[espansione].

#pagebreak()

=== Variable flag syntax

Le *variable flags* sono una implementazione di BitBake per aggiungere #b[proprietà] o #b[attributi] alle variabili.

Tutti gli operatori precedentemente visti possono essere usati con le *variable flags*.

```bash
FOO[a] = "abc"
FOO[b] = "123"
FOO[a] += "456"
```

Un esempio comune è quello di aggiungere una #b[breve documentazione] alla variabile:

```bash
CACHE[doc] = "The directory holding the cache of the metadata."
```

#pagebreak()

=== Inline Python variable expansion

BitBake supporta l'espansione di variabili usando #b[Python].

```bash
DATE = "${@time.strftime('%Y%m%d',time.gmtime())}"
```

Questo esempio associa alla variabile `DATE` il valore della data corrente.

Più comunemente si usa questa #b[feature] per estrarre valori da variabili interne di BitBake:

```bash
PN = "${@bb.parse.vars_from_file(d.getVar('FILE', False),d)[0] or 'defaultpkgname'}"
PV = "${@bb.parse.vars_from_file(d.getVar('FILE', False),d)[1] or '1.0'}"
```

== Condivisione funzionalità

BitBake usa la variabile `BBPATH` per trovare i file di #b[configurazione] e i file delle #b[classi].

Per far sì che `include` e `class` file siano individuabili da BitBake, devono essere inclusi in una cartella "classes"
a sua volta definita in `BBPATH`.

== Direttiva `inherit`

Quando si sviluppa una #b[ricetta] o una #b[classe] si può fare uso della direttiva `inherit` per ereditare funzionalità da altre classi (`.bbclass`).

Ad esempio se una ricetta richiede l'uso di `autotools` per la compilazione, si può fare uso della classe `autotools.bbclass`:

```bash
inherit autotools
```

In questo caso BitBake cerca la directory `classes/autotools.bbclass` in `BBPATH` e la include.

È possibile ereditare più classi:

```bash
inherit autotools pkgconfig
```

== Direttiva `include`

Questa direttiva permette di inserire un file specificato #b[all'interno] del file corrente.

Questa direttiva è più generica di `inherit` in quanto è applicabile a qualsiasi file, non solo a classi.

```bash 
include test_defs.inc
```

#fa-warning() *Attenzione*: se il file non viene trovato, BitBake #b[non] solleva un errore. Se il file è richiesto, meglio usare `require`.

== Direttiva `require`

Questa direttiva è simile a `include` ma solleva un errore se il file non viene trovato.

```bash
require foo.inc
```

Questa direttiva è utile quando si hanno #b[versioni multiple] di una ricetta e si vuole raccogliere gli elementi comuni in un #b[file separato].

Ogni ricetta può includere il file comune con `require`.

== Funzioni

Come in molti linguaggi le *funzioni* sono i blocchi fondamentali che permettono di #b[organizzare] il codice.

BitBake supporta i seguenti tipi di funzioni:

- #b[Shell Functions]: funzioni scritte in _shell script_ ed eseguite direttamente come *funzioni*, *task*, o *entrambi*.
- #b[BitBake-Style Python Functions]: funzioni scritte in _Python_ ed eseguite da BitBake o altre funzioni Python usando `bb.build.exec_func()`.
- #b[Python Functions]: funzioni scritte in _Python_ ed eseguite da Python.
- #b[Anonymous Python Functions]: funzioni scritte in _Python_ ed eseguite automaticamente durante il parsing.

== Shell Functions

Le *funzioni shell* sono scritte in _shell script_ e possono essere eseguite direttamente come *funzioni*, *task*, o *entrambi*.

```bash
some_function () {
    echo "Hello World"
}
```

Queste funzioni sono eseguite via `/bin/sh` e quindi non posso fare uso di funzionalità avanzate di #b[Bash].

#b[Overrides] e #b[operatori di override] come `:append` e `:prepend` possono essere usati con funzioni shell.

```bash
do_foo() {
    bbplain first
    fn
}

fn:prepend() {
    bbplain second
}

fn() {
    bbplain third
}

do_foo:append() {
    bbplain fourth
}
```

== Python functions

Le *funzioni Python* sono scritte in _Python_ e possono essere eseguite da BitBake o altre funzioni Python usando `bb.build.exec_func()`.

```python
python some_python_function () {
    d.setVar("TEXT", "Hello World")
    print d.getVar("TEXT")
}

python do_foo() {
    bb.plain("second")
}

python do_foo:append() {
    bb.plain("third")
}
```

Siccome `bb` e `os` sono importate, non è necessario importarle esplicitamente.

In queste funzioni la variabile `d` è una #b[variabile globale] ed è sempre disponibile.

== Python Functions

Queste funzioni sono scritte in _Python_ e sono eseguite da altro codice python.

Un esempio di funzioni _Python_ sono funzioni di utilità che sono pensate per essere chiamate in modo #b[inline] da altre funzioni _Python_.

```python
def get_depends(d):
    if d.getVar('SOMECONDITION'):
        return "dependencywithcond"
    else:
        return "dependency"

SOMECONDITION = "1"
DEPENDS = "${@get_depends(d)}"
```

In questo tipo di funzioni la variabile `d` #b[non] è disponibile in automatico.

== Anonymous Python Functions

Le *funzioni Python anonime* sono scritte in _Python_ e sono eseguite automaticamente durante il parsing.

```python
python () {
    d.setVar("TEXT", "Hello World")
    print d.getVar("TEXT")
}
```

Queste funzioni sono eseguite #b[automaticamente] durante il parsing e non possono essere chiamate esplicitamente.

== Tasks

I *task* sono unità di esecuzione che definisco gli #b[step] che BitBake può eseguire per una data ricetta.

I *task* sono supportati solo su #b[classi] e #b[ricette] (file `.bb`).

Per #b[convenzione], i task sono definiti con il prefisso `do_`.

=== Task `do_build`

Task di *default* per tutte le #b[ricette]. Questo task dipende da tutti gli altri task richiesti per compilare una ricetta.

=== Task `do_compile`

Questo task *compila* il codice sorgente. Questo task viene eseguito nella #b[cartella corrente di lavoro] settata a `${B}`.

Di default, questo task esegue la funzione `oe_runmake` se un `Makefile`, `makefile` o `GNUmakefile` è presente;
altrimenti non esegue nulla.

=== Task `do_fetch`

Questo task *recupera* il codice sorgente. Questo task usa la variabile `SRC_URI` per recuperare il codice sorgente e l'argument prefix per determinare il modo di recuperare il codice.

=== Task `do_install`

Questo task *copia* i file che devono essere impacchettati nel #b[holding area] `${D}`.
Questo task esegue nella cartella corrente di lavoro `${B}`.

=== Task `do_patch`

Questo task *applica* le patch al codice sorgente. Questo task esegue nella cartella corrente di lavoro `${B}`.

== Features

Le *features* forniscono un meccanismo per lavorare con #b[pacchetti] che devono essere inclusi nell'immagine finale.

Le #b[distribuzioni] selezionano quali *features* vogliono supportare attraverso la variabile #underline[#link("https://docs.yoctoproject.org/ref-manual/features.html#distro-features", `DISTRO_FEATURES`)].

Features relative all'hardware sono selezionate attraverso la variabile #underline[#link("https://docs.yoctoproject.org/ref-manual/features.html#machine-features", `MACHINE_FEATURES`)].

Queste due variabili #b[controllano] quali *moduli del kernel*, *utilities* e *pacchetti* includere.

Una data #b[distribuzione] può supportare un cert subset di feature così che alcune feature di #b[macchine] (machine) non verranno incluse se non supportate dalla distribuzione.

La variabile #underline[#link("https://docs.yoctoproject.org/ref-manual/features.html#image-features", `IMAGE_FEATURES`)] controlla quali *features* includere nell'immagine finale.

== Variabili comuni

Le variabili più #b[utili] e #b[comuni] a tutte le ricette e classi.

Alcune di queste sono:

- `PN` (Package Name): il nome del pacchetto
- `PV` (Package Version): la versione del pacchetto
- `PR` (Package Revision): la revisione del pacchetto
- `S` (Source): la directory sorgente
- `B` (Build): la directory di build
- `D` (Destination): la directory di destinazione
- `WORKDIR`: la directory di lavoro

La lista completa delle variabili comuni è disponibile nella #underline[#link("https://docs.yoctoproject.org/ref-manual/variables.html", "documentazione ufficiale")].

// OLD

// == Architettura sistema Linux (semplificata)

// #figure(image("images/linux-architecture.png"))

// == Linux Embedded

// - *BSP* (Board Support Package): pacchetto software che contiene i driver e il codice necessario per far funzionare il sistema operativo su una specifica piattaforma hardware.
// - *System Integration*: assemblaggio dei componenti in user space (applicazioni, librerie, ecc.) necessari per il sistema e loro configurazione
// - *Sviluppo applicazioni*: sviluppo di applicazioni e librerie custom per il sistema embedded.

// == System integration: diverse possibilità

// #show table.cell: set text(size: 0.8em)

// #table(
//   columns: (auto, auto, auto),
//   fill: (luma(250), green.transparentize(90%), red.transparentize(90%)),
//   inset: 0.5em,
//   table.header(
//     [], align(center)[#text(green, weight: "bold")[Pro]], align(center)[#text(red, weight: "bold")[Contro]]
//   ),
//   text(weight: "bold")[Compilazione manuale], [
//     - Controllo totale
//     - Flessibilità
//     - Formativo
//   ],
//   [
//     - Problemi di dipendenze (dependecy hell)
//     - Conoscenza approfondita del sistema
//     - Compatibilità tra versioni
//   ],
//   [
//     #text(weight: "bold")[Distribuzione binaria] \
//     (debian, fedora, ecc.)
//   ],
//   [
//     - Facile da creare
//   ],
//   [
//     - Non disponibile per tutte le architetture
//     - Molte dipendenze
//     - Difficile da ottimizzare
//   ],
//   text(weight: "bold")[Build system],
//   [
//     - Estremamente flessibile
//     - Pacchetti specifici per embedded
//     - Compilato dai sorgenti
//     - Cross-compilazione
//   ],
//   [
//     - Tempi di compilazione
//   ]
// )

// == Linux Embedded: Principi
// #figure(image("images/linux-embedded-principles.png"))

// - Compilare da sorgenti --> elevata *flessibilità*
// - Cross-compilazione --> compilazione su un *sistema diverso* da quello target
// - "Ricette" per costruire componenti --> *facilità* di realizzazione

// == Build system per Linux Embedded

// - Ampio panorama: _Yocto/OpenEmbedded, Buildroot, PTXdist, OpenWRT_, ecc.
// - Ad oggi, *due* soluzioni sono tra le più popolari:
//   - *Yocto/OpenEmbedded* \ Creazione di distribuzioni Linux complete. #text(weight: "bold")[Molto potente] ma #underline[complesso].
//   - *Buildroot* \ Creazione di filesystem minimi, no pacchetti binari. Più #underline[semplice] da usare ma #text(weight: "bold")[meno flessibile].

// = Yocto Project: Overeview

// == Yocto: About

// - *Yocto Project* è un progetto open source per la creazione di distribuzioni Linux embedded #b[custom].
// - Ha origine nel 2010 dalla #b[Linux Foundation] e correntemente manutenuta.

// #v(2em)

// #figure(image("images/Yocto_Project_logo.svg"))

// == Yocto: Principi

// #figure(image("images/yocto-principles.png"))

// - Yocto compila sempre pacchetti binari (*distribuzione*)
// - Il filesystem finale è generato dalla distribuzione (*image*)

// == Componenti Yocto: `bitbake`

// Su Yocto, il _build engine_ è implementato dal programma `bitbake`

//   - `bitbake` è *task scheduler*, simile a `make`
//   - `bitbake` legge file testuali per capire *cosa* deve essere fatto e *dove*
//   - Implementato in *Python* (richiesto `Python 3` per lo sviluppo)

// == Componenti Yocto: `recipes`
// #slide[
// - Il principale tipo di file testuale gestito da `bitbake` sono le *recipes*
//   - Una recipes descrive uno specifico *componente software*
// - Ogni *Recipes* descrive come #b[recuperare] e #b[compilare] un componente software
//   - programma
//   - libreria
//   - immagine
// - Le recipes hanno una *sintassi specifica*
// - `bitbake` può costruire ogni "ricetta", compilando le sue #b[dipendenze] in modo automatico
// ][
//   #figure(image("images/recipes.png", width: 90%))
// ]

// == Componenti Yocto: `tasks`
// #slide[
// - Il processo di build implementato da una "ricetta" è diviso in *tasks*
// - Ogni task esegue uno specifico *step* nel processo di build
//   - recupera il codice sorgente
//   - configura il codice sorgente
//   - compila il codice sorgente
//   - installa il codice sorgente
// - Più tasks possono *dipendere* da altri tasks (inclusi quelli di altre "ricette")
// ][
//   #figure(image("images/task-dependencies.png"))
// ]

// == Componenti Yocto: `layers e metadati`

// - `bitbake` prende in input *metadati*
// - I metadati includono #b[file di configurazione], #b[ricette], #b[file da includere], ecc.
// - I metadati sono organizzati in *layers*
//   - Un layer è un insieme di #b[recipes], #b[file di configurazione] e #b[classi con scopi comuni]
//   - Più layers possono essere combinati per creare una *distribuzione*
// - `openembedded-core` è il layer base di Yocto
//   - Tutti gli altri layer sono costruiti sopra `openembedded-core`
//   - Supporta `ARM`, `x86`, `MIPS`, `PowerPC`, `RISC-V` ecc.
//   - Supporta `QEMU` per emulare macchine con queste architetture

// == Componenti Yocto: `Poky`

// - La parola *Poky* assume diversi significati
//   - *Poky* è un repository `git` che è assemblato da altri repository: `bitbake`, `openembedded-core`, `yocto-docs` e `meta-yocto`
//   - *Poky* è anche la distro di riferimento fornita dal _Progetto Yocto_
//   - `meta-poky` è il layer fornito come rifefimento per la distro *Poky*

// == Yocto Overview

// #figure(image("images/yocto-overview.png"))

// #meanwhile

// - Il progetto Yocto *non è usato* come insieme finto di layer e strumenti
// - Al contrario, fornisce *una base comune* di #b[tools] e #b[layers] sopra i quali è possibile specificarne di #b[custom] in base alle proprie esigenze

// == Esempio Yocto Project basato su BSP

// - Per costruire un'immagine per _BeagleBone Black_ ci serve:
//   - *Poky* che fornisce le *ricette comuni* e i *tool*
//   - Il layer `meta-ti-bsp` che fornisce una serie di ricette specifiche per #b[Texas Instruments] (azienda produttrice del processore di BeagleBone Black)
// - Tutte le modifiche *DEVONO* essere fatte in un layer separato. Modificare Poky o un layer esistente è *SBAGLIATO*

// Prepariamo questo tipo di ambiente!

#focus-slide[Configurazione ambiente di sviluppo Yocto]

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

#align(center)[#fa-warning() Si consiglia di usare *CROPS* come ambiente di sviluppo per Yocto. #fa-warning()]

== Getting started: Poky reference system

Tutti i repository che fanno parte del progetto Yocto sono disponibili su: \
#underline[#link("https://git.yoctoproject.org", `https://git.yoctoproject.org`)]

Per iniziare, cloniamo il repository `poky`:
```bash
$ git clone -b scarthgap git://git.yoctoproject.org/poky
$ git checkout scarthgap-5.0.5
```

Ogni #b[6 mesi] viene rilasciata una nuova versione di Yocto e menutenuta per #b[7 mesi].
Versioni #b[LTS] sono supportate per #b[4 anni].

Ogni _release_ ha un *codename* come `kirkstone` o `honister` corrispondente a un *release number*.
Un riepilogo delle versioni è disponibile su: \
#underline[#link("https://wiki.yoctoproject.org/wiki/Releases", `https://wiki.yoctoproject.org/wiki/Releases`)]

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
├── meta-yocto-bsp        # Configurazione per Yocto reference hardware board support package
├── oe-init-build-env     # Script per inizializzare l'ambiente di build
├── scripts               # Script di supporto per la build, lo sviluppo e il flashing
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
  - `MACHINE`: definisce la macchina target per la build

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