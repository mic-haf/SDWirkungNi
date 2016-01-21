# Dämpferwirkung
ESR  
21. Januar 2016  




# Schalldruckpegel Differenzen mit Referenzabschnitt

In Dieser Abschnitt werden die Differenzen der Spektren bzw. Levels zwischen  Referenzabschnitt und Dämpferabschnitt untersucht. Ziel ist die dämpferwirkung Abzuschätzen.

**Eine positive Differenz deutet auf eine positive Wirkung der Dämpfern*



## Differenz von Gesamtzugauswertung: alle Abschnitte

Die Differenzen von auswertungsintervall `full` sind für alle Abschnitte vorhanden und werden hier gezeigt

### Spektral
<img src="SD_wirkung_files/figure-html/unnamed-chunk-3-1.svg" title="" alt="" width="1000px" />

### Levels

<img src="SD_wirkung_files/figure-html/unnamed-chunk-4-1.svg" title="" alt="" width="500px" />


## Differenzen Wagenweise: Wagen , Trieb/Wagen: Abschnitt B2

Für den Abschnitt B2 ist es zusätzlich möglich die Differenzen je Auswertungsintervall `n` (je doppel Drehgestell) zu berechnen. Die Resultierende Wirkung sind die Folgende:

### Spektral

#### IC Züghe
<img src="SD_wirkung_files/figure-html/unnamed-chunk-5-1.svg" title="" alt="" width="1000px" />

#### Regio

<img src="SD_wirkung_files/figure-html/unnamed-chunk-6-1.svg" title="" alt="" width="1000px" />


### Levels

<img src="SD_wirkung_files/figure-html/unnamed-chunk-7-1.svg" title="" alt="" width="500px" />

##  Gemessne Wirkung  von Schinendämpfer in dBA

Die Indikatoren

 - mittelwert `av`
 - median `me`
 - Quantilen `Q25` und `Q75`
 - und Standardabweichung
 
 sind in die untere Tabellen für verschiedene Kombinationen aus Verkehr und Dämpfern berechnet.

####  Wirkung nach Dämpfertyp, Zugstyp und Drehgestelltyp
 Berechung für jede Kombination aus Dämpfertyp(Abschnitt), Zugstyp und Drehgestelltyp(Interval Kategorie) 
<!--html_preserve--><div id="htmlwidget-4168" style="width:100%;height:auto;" class="datatables"></div>
<script type="application/json" data-for="htmlwidget-4168">{"x":{"data":[["B2","B2","B2","B2","B2","B2","B4","B4","B3","B3"],["IC","IC","IC","Regio","Regio","Regio","IC","Regio","IC","Regio"],["Antrieb/Wagen","full","Wagen","Antrieb/Wagen","full","Wagen","full","full","full","full"],[0.8,-0.2,-0.7,1.1,1.2,1.6,2.4,2.4,0.4,0.4],[0.3,-0.1,-0.5,1.1,1.2,1.4,2.5,2.4,0.6,0.3],[-0.5,-0.2,-1.5,0.7,1.2,1.1,2.2,2.3,-0,0.3],[1.8,0.1,0.3,1.5,1.6,1.8,2.8,2.7,0.9,0.6],[1.6,0.8,1.2,0.6,0.5,1,0.6,0.7,0.7,0.4]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th>Absch.</th>\n      <th>Zugstyp</th>\n      <th>Drehgestell</th>\n      <th>av</th>\n      <th>me</th>\n      <th>Q25</th>\n      <th>Q75</th>\n      <th>sd</th>\n    </tr>\n  </thead>\n</table>","options":{"pageLength":10,"dom":"tip","columnDefs":[{"className":"dt-right","targets":[3,4,5,6,7]}],"order":[],"autoWidth":false,"orderClasses":false,"orderCellsTop":true},"callback":null,"filter":"top","filterHTML":"<tr>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"B2\">B2</option>\n        <option value=\"B4\">B4</option>\n        <option value=\"B3\">B3</option>\n      </select>\n    </div>\n  </td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"IC\">IC</option>\n        <option value=\"Regio\">Regio</option>\n      </select>\n    </div>\n  </td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"Antrieb/Wagen\">Antrieb/Wagen</option>\n        <option value=\"full\">full</option>\n        <option value=\"Wagen\">Wagen</option>\n      </select>\n    </div>\n  </td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"display: none; position: absolute; width: 200px;\">\n      <div data-min=\"-0.7\" data-max=\"2.4\"></div>\n      <span style=\"float: left;\"></span>\n      <span style=\"float: right;\"></span>\n    </div>\n  </td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"display: none; position: absolute; width: 200px;\">\n      <div data-min=\"-0.5\" data-max=\"2.5\"></div>\n      <span style=\"float: left;\"></span>\n      <span style=\"float: right;\"></span>\n    </div>\n  </td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"display: none; position: absolute; width: 200px;\">\n      <div data-min=\"-1.5\" data-max=\"2.3\"></div>\n      <span style=\"float: left;\"></span>\n      <span style=\"float: right;\"></span>\n    </div>\n  </td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"display: none; position: absolute; width: 200px;\">\n      <div data-min=\"0.1\" data-max=\"2.8\"></div>\n      <span style=\"float: left;\"></span>\n      <span style=\"float: right;\"></span>\n    </div>\n  </td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"display: none; position: absolute; width: 200px;\">\n      <div data-min=\"0.4\" data-max=\"1.6\"></div>\n      <span style=\"float: left;\"></span>\n      <span style=\"float: right;\"></span>\n    </div>\n  </td>\n</tr>"},"evals":[]}</script><!--/html_preserve-->

####  Wirkung nach Dämpfertyp und Zugstyp
 Berechung für jede Kombination aus Dämpfertyp(Abschnitt) und  Zugstyp
 
<!--html_preserve--><div id="htmlwidget-1797" style="width:100%;height:auto;" class="datatables"></div>
<script type="application/json" data-for="htmlwidget-1797">{"x":{"data":[["B2","B2","B4","B4","B3","B3"],["IC","Regio","IC","Regio","IC","Regio"],[-0.5,1.3,2.4,2.4,0.4,0.4],[-0.4,1.3,2.5,2.4,0.6,0.3],[-1.4,1,2.2,2.3,-0,0.3],[0.3,1.6,2.8,2.7,0.9,0.6],[1.3,0.8,0.6,0.7,0.7,0.4]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th>Absch.</th>\n      <th>Zugstyp</th>\n      <th>av</th>\n      <th>median</th>\n      <th>quantile25</th>\n      <th>quantile75</th>\n      <th>sd</th>\n    </tr>\n  </thead>\n</table>","options":{"pageLength":6,"dom":"tip","columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6]}],"order":[],"autoWidth":false,"orderClasses":false,"orderCellsTop":true,"lengthMenu":[6,10,25,50,100]},"callback":null,"filter":"top","filterHTML":"<tr>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"B2\">B2</option>\n        <option value=\"B4\">B4</option>\n        <option value=\"B3\">B3</option>\n      </select>\n    </div>\n  </td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"IC\">IC</option>\n        <option value=\"Regio\">Regio</option>\n      </select>\n    </div>\n  </td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"display: none; position: absolute; width: 200px;\">\n      <div data-min=\"-0.5\" data-max=\"2.4\"></div>\n      <span style=\"float: left;\"></span>\n      <span style=\"float: right;\"></span>\n    </div>\n  </td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"display: none; position: absolute; width: 200px;\">\n      <div data-min=\"-0.4\" data-max=\"2.5\"></div>\n      <span style=\"float: left;\"></span>\n      <span style=\"float: right;\"></span>\n    </div>\n  </td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"display: none; position: absolute; width: 200px;\">\n      <div data-min=\"-1.4\" data-max=\"2.3\"></div>\n      <span style=\"float: left;\"></span>\n      <span style=\"float: right;\"></span>\n    </div>\n  </td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"display: none; position: absolute; width: 200px;\">\n      <div data-min=\"0.3\" data-max=\"2.8\"></div>\n      <span style=\"float: left;\"></span>\n      <span style=\"float: right;\"></span>\n    </div>\n  </td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"display: none; position: absolute; width: 200px;\">\n      <div data-min=\"0.4\" data-max=\"1.3\"></div>\n      <span style=\"float: left;\"></span>\n      <span style=\"float: right;\"></span>\n    </div>\n  </td>\n</tr>"},"evals":[]}</script><!--/html_preserve-->
