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

#set text(font: "Fira Sans", weight: "light", size: 18pt)
#show math.equation: set text(font: "Fira Math")
#set raw(tab-size: 4)
#show raw.where(block: false): set text(size: 1.5em)
#show raw: set text(size: 0.8em)
#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: (x: 1em, y: 1em),
  radius: 0.7em,
  width: 100%,
)

#let b(content) = text(weight: "bold", content)
#set list(marker: text(1.5em, [•]))

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
  (Quasi) tutte le distribuzioni Linux mantengono uno o più #alert[repository] ufficiali contenenti i pacchetti software.

  #components.side-by-side(columns: (2fr, 1fr))[
    I repository sono #alert[server] che contengono i pacchetti software e le informazioni necessarie per la loro installazione.
    
    Esempio di repository: \
    #link("http://archive.ubuntu.com/ubuntu/")[`http://archive.ubuntu.com/ubuntu/`]
  ][
    #figure(image("images/repository.png", width: 60%))
  ]

== Repository e metadati
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

#focus-slide[
  *Advanced Package Tool* (`APT`)
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


#focus-slide[*Esercitazione*: `01-apt`]

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

#focus-slide[*Esercitazione*: `02-update-alternatives`]

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

#focus-slide[*Esercitazione*: `03-apk`]

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

== Dov'è il server X?

Nella terminologia di _rete_, il sistema #b[client] è quello che è eseguito sul proprio computer,
mentre il #b[server] è "qualcosa" da qualche altra parte.

Nella terminologia di *X*,
il proprio computer esegue il #b[server],
mentre i #b[client] (applicazioni grafiche) possono risedere "altrove".

Le risorse gestire dal server X includono:
- *Schede video*
- *Pointing devices*: mouse, tastiera, touchpad, ...
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

In orami quasi tutte le distribuzioni come _Fedora_, _Manjaro_ (Arch) e _Ubuntu_,
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