Einleitung
==========

Im Rahmen der Projekts Erprobung Schienendämpfer (SD) wurden zwischen Niederwangen und Bümplitz SD eingebaut. Diese Teststrecke diente haupsächlich um Sicherheitsrelevanten infrastrukturseitigen Fragen zu prüfen. Die teststreck besteht aus 2 unterstrecken:

-   Niederwangen: Betonschwelle B91,
-   Bümpliz: Holzschwellen

in diesem Bericht wird nur den Teil mit Betonschwellen diskutiert. Diesem Teil besteht aus 5 Abschnitten 108m länghe. 4 Abschnitte(B1,B2,B3,B4) haben eingebaute Dämpfer, den letzte Abschnitt (B5) dient als Refernz.

Zusätzlich wurde die Teststrecke für die Akustischen erprobung von SD verwendet. Es wurden track decay rates (TDR), Schienenrauheit (SR) Spektren und Akustischen Messungen durchgeführt.

In diesem Bericht werden die Resultate der Akustische Erprobung, insbesodree die Resultate der Akustische messungen Vorgestellt und diskutiert.

**Ziel ist Wirkung von Schienenstegdämpfern Abschätzen für die Situation Niederwangen**

------------------------------------------------------------------------

Messungen
---------

#### Akustische Messung

Die Empa Abteilung Akustik/Lärmminderung wurde beauftragt, die Wirksamkeit von drei der vier Produkte anhand von Vorbeifahrts Schalldruckpegelmessungen zu ermitteln.

Im Bericht [Messbericht Vorbeifahrtsmessungen Niederwangen](Messbericht%20Vorbeifahrtsmessungen%20Niederwangen%20sig.pdf) sind eine detallierte Beschreibung und die erste Resultate der Wirkung von SD zu sehen. (Aufpassen dass in diesem Bericht die Abschnitte anders bennant worden)

Dazu hat EMPA folgende Daten der Messung gelifert:

-   Zeitsignalen ( Die Zeitsignalen sind in diesem repo nicht Verfügbar. Das benötigte Speicherplatz ist zu gross.):
    -   Die Signale der Mikrophonen (in \(Pa\)) für jede Durchfahrt und aufjeden Abschnitt. Die Signale sind als Matlab format gelifert worden und sind ist in Ordner `/Ereignisse` gespeichert.
    -   Für die Abschnitten vorgesehen mit Lichtschranken die Signalen der Lichtschranken.
-   Exceltabellen mit Informationen jede gültige Vorbeifahrt. Die Tabellen sind im ordner `/Tabellen` gespeichert. Diese Tabellen mit zusätzlichen Informationen sind in File `pass-by.json` überarbeitet worden um diese daten weiter verarbeiten zu können.

#### TDR Messungen

MBBM hat im Auftrag von SBB die TDR für alle Abschnitte mehrmals gemessen(vor und nach einbau von SD). Die detallierte Berichte sowohl die Daten der Messungen sind vorhanden aber nicht in diesem repo verfügbar. Die daten werden von einer lokale Datenbank abgerufen.

#### SR Messungen

SR-Spektren sind durch die firma MBBM für alle Abschnitte mehrmals gemessen nach einem schleifvorgang. Die detallierte Berichte sowohl die Daten der Messungen sind vorhanden aber nicht in diesem repo verfügbar. Die daten werden von einer lokale Datenbank abgerufen.

Berichtstruktur
---------------

Diesem Bericht besteht aus mehrere Teildokumente welche in einem git [repo](https://github.com/e-sr/ValFX) (hosted auf github) abgelegt sind. Die Dokumente welche den Bericht zusammenstallen sind so aufgebaut dass Reproduzierbarkeit im Vordergrund steht, d.h Scripts und Daten (sofern möglich) auf welche die teildokumente basieren sind auch im repo zu finden.

Für die Teildokumente wurden folgende programme/frameworks verwendet:

-   python: python ist eine Programmiersprache scriptssprache welche in verschieden Kontexte verwendet wird, unter anderem für wissenschaftliche Programmierung. Die `jupyter Notebook` (.ipynb) ermöglichen die die Integration von Berichterstattung und python Code (Auswertung) in einem einzigen Dokument. Für akustischen Auswertungen wurde speziell den Modul `python-acoustics` verwendet.

-   R: R ist eine Scriptssprache mit Schwerpunkt in Statistische Berechnungen. Um Integration von Bericht und Auswertungen zu ermöglichen sind die Dokumente in .Rmd Format Aufgebaut (ich Empfehle R im Verbindung mit Rstudio zu verwenden).

------------------------------------------------------------------------

Auswertung
==========

#### [Abschätzen der Wirkung von Schienendämpfer](https://cdn.rawgit.com/e-sr/SDWirkungNi/tree/967031f2ef6725a4087f82e9efffbd2735bed6cf/Vorbeifahrten.html)

#### [Abschätzen der Wirkung von Schienendämpfer](https://cdn.rawgit.com/e-sr/SDWirkungNi/tree/967031f2ef6725a4087f82e9efffbd2735bed6cf/SD_wirkung.html)

#### [Schienenrauheiten in Niederwangen](https://cdn.rawgit.com/e-sr/SDWirkungNi/tree/967031f2ef6725a4087f82e9efffbd2735bed6cf/SR_Ni.html)

#### [TDR in Niederwangen](https://cdn.rawgit.com/e-sr/SDWirkungNi/tree/967031f2ef6725a4087f82e9efffbd2735bed6cf/TDR_Ni.html)

------------------------------------------------------------------------

Fazit
-----

-...

------------------------------------------------------------------------

Anhang
------

### Postprocessing der Zeitsignalen

Aus die gelieferte Zeisignalen müssen Akustischen kenngrössen berechnet werden um die SD wirkung zu beurteilen. verarbeitet werden um die sind der mikrophone

-   [Erste Darstellungen von Zeitsignalen der Mikrophone](http://nbviewer.jupyter.org/github/e-sr/SDWirkungNi/tree/967031f2ef6725a4087f82e9efffbd2735bed6cf/darstellungMicSignale.ipynb)

-   [Auswertung der Lichtschrankensignalen](http://nbviewer.jupyter.org/github/e-sr/SDWirkungNi/tree/967031f2ef6725a4087f82e9efffbd2735bed6cf/analyseLS.ipynb)

-   [Spektren Berechnen](http://nbviewer.jupyter.org/github/e-sr/SDWirkungNi/tree/967031f2ef6725a4087f82e9efffbd2735bed6cf/SpektrenBerechnen.ipynb)

-   [Auswertung alle Vorbeifahrten](http://nbviewer.jupyter.org/github/e-sr/SDWirkungNi/tree/967031f2ef6725a4087f82e9efffbd2735bed6cf/DSPAuswertung.ipynb)

Den outpout der DSP wird in den Datensatz [DSPResults.json](DSPResults.json) gespeichert um dann in R verwendet zu werden.
