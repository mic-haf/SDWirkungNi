-   Einleitung
    -   Abschnittnamen und eingebaute Dämpfern
    -   Postprocessing Resultate
    -   Sonst
-   Darstellungen von Spektren und Levels
    -   Abschnitten B5 und B2
        -   Levels von IC Züge für Intervalle der kategorie `Wagen`
        -   Spektren von IC Züge für Intervalle der kategorie `Wagen`
        -   Spektren und Levels von Regio Züge
    -   Alle Abschnitte
-   Fazit

------------------------------------------------------------------------

Einleitung
==========

Dieser Teil der Bericht analysiert die Resultate der postprocessing welche im File `DSPresults.json` enthalten sind.

**Ziel der Statistische Analyse ist die Wirkung von Schienendämpfern abzuschätzen**

------------------------------------------------------------------------

#### Abschnittnamen und eingebaute Dämpfern

Es besteht die folgende Relation zwischen Name der Abschnitten und deren eingebaute Dämpfern.

| Dämpfer | ValFX Abkürzung | Abkürzung Messung |
|---------|-----------------|-------------------|
| TATA    | B1              | nicht gemessen    |
| S&V     | B2              | Q4                |
| Vossloh | B3              | Q3                |
| STRAIL  | B4              | Q2                |
| Ref     | B5              | Q1                |

Es iss zu Bemerken dass die Abschnitte sind bei der Messung unterschiedlich als sonst wie im valFX Projekt benannt worden. **Ab jetzt wird die ValFX Abküzung verwendet um die Abschnitten zu unterscheiden**

------------------------------------------------------------------------

#### Postprocessing Resultate

Dias postprocessing der Mikrophonsignale liefert **Terzspektren und Gesamtpegel** des Schalldruck fur jede Vorbeifahrt([Details](http://nbviewer.ipython.org/github/e-sr/ValFX/blob/master/AkustischeMessungNiederwangen/SpektrenBerechnen.ipynb)).

Terzspektren aus den gesamte Signal oder auch Gesamtzug berechnet werden mit `full` bezeichnete.

Für deie Abschnitte B5 und B2 würden zusätzlich die Spektren Wagenbezogen berechnet.Von wagenmitte der n-te Wagen bis zur Wagenmitte der n+1 Wagen. Diese Spektren werden mit den entsprechende Zahl `n` Bezeichnet. Das war möglich da für diese Abschnitten Lichtschrankensignalen vorhanden sind.

Zusätzliche Informationene wurden zu jede Vorbeifahrt mithilfe von LS Signalen ([Details](http://nbviewer.ipython.org/github/e-sr/ValFX/blob/master/AkustischeMessungNiederwangen/analyseLS.ipynb)) gewonnen:

-   **Zugsgeschwindigkeit** Nur Vorbeifahrten mit aänliche Geschwindigkeit auf alle Abschnitte wurden

-   **Intevallbezeichnung** Die Intervalle mit `n` bezeicnet (nicht Gesamtzug) können `Trieb` sowohl `Wagen` Drehgestelle enthalten. Um Intervalle aus ähnlichen Drehgestelle zu vergleichen, müssen die Intervalle jede Vorbeifahrt in `Wagen` , `Trieb/Wagen` oder `Gesamtzug (full)` kategorisiert werden.

-   **Zugstyp** Wurde mithilfe von Achsmuster und Drehgestell abstand entdeckt. Zwei klasen von Zügen sind zu unterscheiden:

    1.  Regiozugen; wahrscheinlich handelt sich um einen Domino (Triebwagen-Inowa-Steuerwagen) in doppelte Komposition. Triebdrehgestelle mit einen Abstand von 2.7m ergeben konsistente werte
    2.  IC Zügen; diese Zügen bestehen aus (EWIV, IC2000, Steuerwagen und Re460). Der Anzahl wagen ist variabel.

In die nächste Graphik ist die mittlere Geschwindigkeit jede Vorbeifahrt auf die Abschnitte B5 und B2 dargestellt. Vorbeifahrten mit grosse Geschwindigkeitdifferenzen auf die Abschnitte B2 und B5 wurden Verworfen. In dieser Graphik sind nur die Gültige Vorbeifahrten dargestellt.

<img src="/figunnamed-chunk-7-1.svg" alt="Mittlere Zugsgeschwindigk" width="500px" />
<p class="caption">
Mittlere Zugsgeschwindigk
</p>

------------------------------------------------------------------------

#### Sonst

Quellencode diesem Teil ist im file [StatAusw.md](https://github.com/e-sr/ValFX/blob/master/AkustischeMessungNiederwangen/StatAuswe.Rmd) zu sehen.

------------------------------------------------------------------------

Darstellungen von Spektren und Levels
=====================================

Dieser Abschnitt dient um einen Gefühl mit die gemessene/ausgewertete daten zu bekommen.

Dazu wird die Streuung der berechnete Spektren bzw. Levelsuntersucht.

-   innerhalb die gleichen pass-by, indem unterschiedliche Auswertung Intervalle verglichen werden
-   innerhalb verschiedene pass-by der gleiche Zugs bzw. Geschwindigkeit Kategorie

**Spektern und Gesamtpegeln sind in dBA angegeben**

Abschnitten B5 und B2
---------------------

Für diese Abschnitte sind Spektren Wagenbezogen berechnet worden. Es ist somit möglich Spektren innerhalb die gleichen pass-by zu vergleichen. Passby 10,13 und 8 sind nicht dargestellt da langsämer gefahren sind. Alle andere passby hatten eine geschwindigkeit von ungefähr 140 km/h

### Levels von IC Züge für Intervalle der kategorie `Wagen`

<img src="/figunnamed-chunk-8-1.svg" title="" alt="" width="800px" />

**Diskussion**:

-   eine viel grössere Streuung als erwartet ist zu sehen. Zwischen unterschiedliche Intervalle der gleichen pass-by sind variationen bis 5 dB zu sehen

-   Die Variabilität innerhalb ein einziges Zug ist Grösser als die Variabilität Zwischen verschiedene pass-by

-   zwischen unterschiedliche pass-by (gleuche Zugstyp mit ähnlichen Geschwindigkeiten) sind bis zu 2-3dB Unterschieden zu sehen

-   die Streuung ist nicht konstant für ein gegebens passby auf beide Abschnitte.Damit ist es nichtmöglich die streuung zu Erklären aufgrund unterschidelich Radrauheiten.

### Spektren von IC Züge für Intervalle der kategorie `Wagen`

<img src="/figunnamed-chunk-9-1.svg" title="" alt="" width="1000px" /> Bemerkungen:

-   Die Spektren weisen ein sehr hohen tonales Anteil bei \(2000 Hz\) auf. Eine mögliche Erklärung ist der höhe Rauheitswert bei \(2\,cm\) Wellenänghe welche umgewandelt in Frequenz (für \(140 km/h\)) betragt \(1940 \, Hz\).

### Spektren und Levels von Regio Züge

Levels von Regio Züge für Intervalle der Kategorie `Wagen` und `Trieb/Wagen` sind nicht angezeigt da diese Züge nur aus 6 Wagen bestehen, davon 2 mit Triebfahrzeuge und deshalb hat man innerhalb ein einziges Zug nur wenige Intervalle zu Vergleichen.

Eine sehr grosse Variabilität der Schalldruckpegel wurde wie für IC Züghe auch festgestellt.

die spektern Spektren für Intervalle der kategorie `Trieb/Wagen` sind im folgende Bild dragestellt

<img src="/figunnamed-chunk-11-1.svg" title="" alt="" width="1000px" />

Diskussion:

-   die höhe tonalität bei 2000 Hz ist ausgeprägt wie beim IC Wagen.
-   Diese Züghe sind lauter als IC Züghe
-   dazu ist eine grose Streuung beit tiefe Frequenzen

Alle Abschnitte
---------------

Die Spektren berechnet aus Intervalle `full` werden hier gezeigt. Da für die Abschnitte B3 und B4 keine LS eingesetzt wurde ist es nicht möglich drehgestellweise auszuwerten. Den Anzahl von Levels ist deswege gering, jedoch gelten die bereits gemachten Bemerkungen über variabilität zwischen unterschiedliche Züghe der gleiche Klasse auch für die Abschnitten B3 und B4.

<img src="/figunnamed-chunk-12-1.svg" title="" alt="" width="1000px" /> <!--
## Leq vs. Geschwindigkeit für  IC Züghe

Für IC Züghe sind genügende Levels berechnetworden um sinnvoll eine  regression der Level Gegnüber die geschwindigkeit darzustellen. Die Frage die man beantworten will ist :

`Ist die Variabilität erklart aus die Geschwindigkeitunterschiede?`

Die Antwort ist`nein` und war  schon in Früheren Abbildungen zu raten. Die nächste Graphik, wo Leq Werte gegen die Geschwindigkeit dargestellt werden, versucht die Frage genauer zu bentworten.

Man erwartet zunehmender Leq mit zunehmender Geschwindigkeit ($leq \propto log_{10}v$).
-->

------------------------------------------------------------------------

Fazit
=====

-   wirkung quantifizieren
-   variabilität von akustische messung. grund rauheit? zu gross um kleine unterschiede zu messen.
-   die berechnete werte könnten somit zufall sein
-   ruhait korrektur nich möglich sihe rauheit

... \# TODO - capitoli - fazit - - Controllare un po tutto - Link - README
