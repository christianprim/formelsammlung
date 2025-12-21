#import "@preview/unify:0.7.1": unit, qty, num, add-unit
#import "@preview/ccicons:1.0.1": ccicon
#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.3"
#import "@preview/zap:0.5.0"

// Version
#let version = "4.0.2"

// Einrichtung
#set page(paper: "a5")
#set text(
  font: "TeX Gyre Pagella", 
  lang: "de",
  region: "CH",
)

// Format für die Standardseite
#let standard = (
  columns: (1.55fr,0.25fr,2fr,1.1fr), 
  inset: (x:0pt, y:5pt)
)

// Format für die mathematische Formelsammlung
#let mathe = (
  columns: (1fr,1.5fr,1fr), 
  inset: (x:0pt, y:5pt)
)

// Einheiten
#add-unit("mm Quecksilbersäule", "mmHg", "upright(\"mmHg\")")
#add-unit("astronomische Einheit", "AE", "upright(\"AE\")")
#add-unit("Lichtjahr", "LJ", "upright(\"LJ\")")
#add-unit("Lichtsekunde", "Ls", "upright(\"Ls\")")
#add-unit("Dioptrie", "dpt", "upright(\"dpt\")")

// Farbe für Winkel
#let winkel = rgb("2A008C")

// Schattierungen:
// für Kugel
#let kugel = gradient.radial(white, gray, center: (25%, 25%))
// für pos. Ladung
#let positiv = gradient.radial(white, red.transparentize(50%), center: (25%, 25%))
// für neg. Ladung
#let negativ = gradient.radial(white, blue.transparentize(50%), center: (25%, 25%))

// Einstellungen für Schaltschemen mit zap
#let zap-style = (
  scale: (x: 0.5, y: 0.5), 
  stroke: 0.5pt, 
  decoration: (
    symbol: none, 
    current: (
      symbol: "barbed", 
      stroke: red
    ), 
    voltage: (
      stroke: blue, 
      start: (-.3, .0), 
      end: (.3, .0), 
      center: (0, .2)
    )
  )
)

#set list(marker: ([#sym.compose], [‣], [–]))

// Globale Formate
#show heading: set block(
  above: 0.8em,
  below: 0.8em,
)
#show heading: it => text(font: "TeX Gyre Heros")[#it]
#show heading.where(level: 1): it => emph[#it]
#show math.equation: set text(font: "TeX Gyre Pagella Math")

// Titelseite
#block(width:100%,{
  set align(center)
  set text(size: 20pt,  font: "TeX Gyre Heros")
  v(1.5fr)
  text("Formelsammlung Physik")
  
  v(0.2fr)
  set text(size: 10pt)
  text("Kantonsschule Zürich Nord")

  v(2.5fr)
  text[Version #version]
})
#pagebreak()

// Seitenzahlen
#set page(
  binding: left,
  margin: (
    top: 1.5cm,
    bottom: 1.25cm,
    inside: 1.5cm,  // Grösserer Rand für die Bindung
    outside: 1cm, // Kleinerer Rand aussen
  ),
  numbering: "1",
  footer: context {
    let page_nr = counter(page).get().first()
    let alignment = if calc.odd(page_nr) {
      right
    } else {
      left
    }
    align(alignment)[
      #page_nr
    ]
  },
)
#set text(size: 9.5pt)

// Vorgehen
= Tipps zum Lösen von Physikaufgaben

== 1. Überblick verschaffen und Situation analysieren

- *Aufgabentext genau lesen*: Welche Grössen sind _gegeben_? Was wird _gesucht_?
- *Gebiet erkennen*: Zu welchem physikalischen Bereich gehört die Aufgabe?
  - *Mechanik*: 
    - Zeichnen Sie den Situationsplan und bei gerichteten Grössen (wie Kräfte #text(fill: red)[$arrow(F)$], Geschwindigkeiten #text(fill: blue)[$arrow(v)$] oder Impulsen #text(fill: blue)[$arrow(p)$]) den Additionsplan: #v(-.5em) #align(center)[
        #cetz.canvas({
          import cetz.draw: *
          set-style(stroke: 0.5pt)
      
          // Impuls nach dem Stoss
          let FN = calc.atan(2)
          let FR = FN + 90deg
          let FN_b = calc.sin(FN)
          let FR_b = calc.cos(FN)
        
          // Situationsplan
          rect((-2,1), (-1.5,0.5))
          line((-1.6, 0.9), (-1.9, 0.9), (-1.9, 0.75), (-1.6, 0.75), (-1.6, 0.6), (-1.9, 0.6))
      
          line((-1, 0.5), (1, -0.5), name: "ebene")
          line((0.1, -0.5), (1, -0.5), stroke: (dash: "dotted"), name: "boden")
          
          line(
            (0,0.1), (rel: (0, -1)), 
            mark: (
              end: "barbed",
              size: 8pt,
            ),
            stroke: red,
            name: "F_G",
          )
        
          line(
            (0,0.1), (rel: (FR, FR_b)), 
            mark: (
              end: "barbed",
              size: 8pt,
            ),
            stroke: red,
            name: "F_R",
          )
          
          line(
            (0.0, 0.1), (rel: (FN, FN_b)), 
            stroke: red, 
            mark: (
              end: "barbed", 
              size: 8pt
            ), 
            name: "F_N")
            
          on-layer(-1, {cetz.angle.angle("F_N.start", "F_N", "F_R", radius: 0.18, label-radius: 0.12, label: box(baseline: -0.2em)[$dot$])})
    
          cetz.angle.angle("boden.end", "ebene", "boden", radius: 0.6, label: box(baseline: -0.2em)[$alpha$], label-radius: 0.4)
          
          circle((0, 0.1), radius: 2pt, fill: black)
      
          set-origin((0, 0.1))
              
          content("F_G.50%",text(fill: red)[$arrow(F)_G$], anchor: "east", padding: 2pt)
          content("F_R.50%",text(fill: red)[$arrow(F)_R$], anchor: "south", padding: 2pt)
          content("F_N.50%",text(fill: red)[$arrow(F)_N$], anchor: "north-west", padding: 2pt)

          set-origin((0, -0.1))
        
          // Additionsplan
          rect((2.5, 1), (3, 0.5))
          line((2.6, 0.6), (2.6, 0.9), (2.9, 0.9), (2.9, 0.6))
          line((2.6, 0.75), (2.9, 0.75))
      
          line(
            (3.5,0.5), (rel: (0, -1.5)), 
            mark: (
              end: "barbed",
              size: 8pt,
            ),
            stroke: red,
            name: "F_G",
          )
    
          line(
            (), (rel: (FN, 1.5*FN_b)), 
            mark: (
              end: "barbed",
              size: 8pt,
            ),
            stroke: red,
            name: "F_N",
          )
    
          line(
            (), (3.5,0.5), 
            mark: (
              end: "barbed",
              size: 8pt,
            ),
            stroke: red,
            name: "F_R",
          )
          on-layer(-1, {cetz.angle.angle("F_N.end", "F_R", "F_N", radius: 0.18, label: box(baseline: -0.2em)[$dot$])})
    
          cetz.angle.angle("F_N.start", "F_N", "F_G", radius: 0.6, label: box(baseline: -0.2em)[$alpha$], label-radius: 0.4)
        
          content("F_G.50%",text(fill: red)[$arrow(F)_G$], anchor: "east", padding: 2pt)
          content("F_N.60%",text(fill: red)[$arrow(F)_N$], anchor: "north-west", padding: 2pt)
          content("F_R.20%",text(fill: red)[$arrow(F)_R$], anchor: "south", padding: 2pt)
        })
      ]
    - Spezialfall Energieerhaltung: Identifizieren und nummerieren Sie die relevanten _Situationen_ und ordnen Sie diesen die wesentlichen Grössen mittels Index zu. Legen Sie die _Nullniveaus_ fest.
  - *Wärmelehre*: Heben Sie Zustände unterschiedlicher Temperatur farblich hervor: #v(-2em) #align(center)[
    #cetz.canvas({
      import cetz.draw: *

      // Gefäss mit warmem Wasser
      set-style(stroke: 0.5pt + red)

      merge-path(fill: red.transparentize(80%), {
        line((), (0, -0.8))
        bezier((), (0.2, -1), (0, -1))
        line((), (0.8, -1))
        bezier((), (1, -0.8), (1, -1))
        line((), (1, 0))
      })
      
      line((0,0), (0, 0.2))
      line((1,0), (1, 0.2))

      content((0.5, -0.5), text(fill: red)[$theta.alt_1, m_1$])

      // Kalte Eiswürfel
      set-style(stroke: 0.5pt + blue)

      rotate(20deg)
        rect((1, 0.1), (rel: (0.15, 0.15)), fill: blue.transparentize(80%))
      rotate(10deg)
        rect((0.9, 0.1), (rel: (0.15, 0.15)), fill: blue.transparentize(80%))
      rotate(5deg)
        rect((1.1, 0.1), (rel: (0.15, 0.15)), fill: blue.transparentize(80%))
      rotate(-35deg)

      content((1,1.2), text(fill: blue)[$theta.alt_2, m_2$])

      // Gefäss mit Mischwasser
      set-style(stroke: 0.5pt + purple)

      merge-path(fill: purple.transparentize(80%), {
        line((4, 0), (4, -0.8))
        bezier((), (4.2, -1), (4, -1))
        line((), (4.8, -1))
        bezier((), (5, -0.8), (5, -1))
        line((), (5, 0))
      })

      line((4,0), (4, 0.2))
      line((5,0), (5, 0.2))

      content((4.5, -0.5), text(fill: purple)[$theta.alt_M$])

      content((2.5, -0.2), text(size: 25pt, fill: gray, stroke: 0.5pt + white)[$==>$])
    })
  ]
  - *Elektrizitätslehre*: Erstellen Sie einen Schaltplan.
  - *Geometrische Optik*: Fertigen Sie eine Skizze des Strahlengangs an.
- *Weitere Visualisierungen nutzen*: Diagramme können in vielen Gebieten (z. B. Kinematik _$->$ #ref(<Diagramme>, form: "page")_) zur Veranschaulichung hilfreich sein.
#v(.75em)

== 2. Formale Lösung entwickeln
- *Grundformeln notieren*: Schreiben Sie die wesentlichen Formeln auf, die zur Lösung benötigt werden.
- *Formel anpassen*: Modifizieren Sie die Formel gegebenenfalls für die spezifische Aufgabe (z. B. Vorzeichen beachten!).
- *Nach gesuchter Grösse auflösen*: Lösen Sie die angepasste Formel _algebraisch_ nach der gesuchten Grösse auf.
#v(.75em)

== 3. Numerische Lösung berechnen

- *Basiseinheiten verwenden*: Rechnen Sie in Basiseinheiten, um die Konsistenz der Einheiten zu gewährleisten. Geben Sie die Einheit im Endergebnis an.
- *Signifikante Stellen beachten*: Das Endergebnis sollte nur so viele signifikante Stellen aufweisen, wie die am ungenauesten gemessene Grösse vorgibt.

#pagebreak()

// Mathematische Formeln
= Wichtige mathematische Formeln

== Kreis und Kugel

#grid(..mathe, 

[Kreisumfang], [$#text(fill: purple)[$U$] = 2 pi #text(fill: green)[$r$]=pi #text(fill: blue)[$d$]$], grid.cell(rowspan: 6)[#cetz.canvas({
  import cetz.draw: *
  circle((0, 0), radius: 1.5, stroke: 0.5pt + purple, fill: red.transparentize(80%))
  line(
    (0,0), (1.5,0),
    mark: (
      end: "barbed"
    ),
    stroke: green,
    name: "radius"
  )
  content(
    "radius.50%", [#text(fill: green)[$r$]],
    anchor: "south",
    padding: 3pt
  )
  line(
    (-135deg, 1.5), (45deg, 1.5), 
    mark: (
      start: "barbed", end: "barbed",
      size: 8pt,
    ),
    stroke: blue,
    name: "durchmesser",
  )
  content(
    "durchmesser.50%", [#text(fill: blue)[$d$]],
    anchor: "south-east",
    padding: 2pt
  )
})],
[Kreisinhalt], [$#text(fill: red)[$A$]=pi #text(fill: green)[$r$]^2=1/4 pi #text(fill: blue)[$d$]^2$],

[Bogenmass], [$alpha ["Bogenmass"]=pi/#qty(180, "deg") dot alpha ["°"]$],

[Kugeloberfläche], [$S=4 pi #text(fill: green)[$r$]^2$],

[Kugelvolumen], [$V=(4 pi)/3 #text(fill: green)[$r$]^3=pi/6 #text(fill: blue)[$d$]^3$],

[Zylindervolumen], [$V=#text(fill: red)[$A$] h=pi #text(fill: green)[$r$]^2 h=1/4 pi #text(fill: blue)[$d$]^2 h$]
)

== Rechtwinklige Dreiecke

#grid(..mathe, 
[], [$sin alpha=#text(fill: blue)[Gegenkathete]/#text(fill: red)[Hypothenuse]=#text(fill: blue)[$a$]/#text(fill: red)[$c$]$], grid.cell(rowspan: 4)[#cetz.canvas({
  import cetz.draw: *
  //import cetz.calc: add
  set-style(stroke: 0.5pt)

  line((3, 2), (3, 0), stroke: blue, name: "a")
  line((3, 0), (0, 0), stroke: green, name: "b")
  line((0, 0), (3, 2), stroke: red, name: "c")

  on-layer(-1, {cetz.angle.angle("b.start", "a", "b", radius: 0.3, label: box(baseline: -0.2em)[$dot$], label-radius: 0.16)})

  on-layer(-1, {cetz.angle.angle("b.end", "b", "c", radius: 0.7, label: box(baseline: -0.2em)[$alpha$], label-radius: 0.5)})
  
  content("a.50%",text(fill: blue)[$a$], anchor: "west", padding: 2pt)
  content("b.50%",text(fill: green)[$b$], anchor: "north", padding: 2pt)
  content("c.50%",text(fill: red)[$c$], anchor: "south-east", padding: 2pt)
})],

[Winkelfunktionen], [$cos alpha=#text(fill: green)[Ankathete]/#text(fill: red)[Hypothenuse]=#text(fill: green)[$b$]/#text(fill: red)[$c$]$],
[], [$tan alpha=#text(fill: blue)[Gegenkathete]/#text(fill: green)[Ankathete]=#text(fill: blue)[$a$]/#text(fill: green)[$b$]$#v(1em)],
smallcaps[Pythagoras], [$#text(fill: blue)[$a$]^2+#text(fill: green)[$b$]^2=#text(fill: red)[$c$]^2$]
)

== Spezielle Winkel

#set table.hline(stroke: 0.5pt, start: 1)
#table(
  stroke: none,
  columns: 6,
  inset: (x: 5pt, y: 10pt),
  align: center,
  [], [0°], [30°], [45°], [60°], [90°],
  table.hline(),
  [$sin alpha$], [0], [$1/2$], [$sqrt(2)/2$], [$sqrt(3)/2$], [1],
  [$cos alpha$], [1], [$sqrt(3)/2$], [$sqrt(2)/2$], [$1/2$], [0],
  [$tan alpha$], [0], [$sqrt(3)/3$], [1], [$sqrt(3)$], [—]
)

== Verhältnisse

#grid(..mathe,
[Strahlensatz], [$#text(fill: blue)[$a$]/#text(fill: green)[$b$]=#text(fill: red)[$g$]/#text(fill: purple)[$h$]$], []
)

#place(
  dx: 7cm, // 2 cm von links
  dy: -2cm, // 1 cm von oben
  cetz.canvas({
    import cetz.draw: *
    set-style(stroke: 0.5pt)
  
    line((1, 0), (0, 2), name: "a_gerade")
    line((0, 0), (4.5, 1.7), name: "steigende_diagonale")
    line((-0.1, 1.9), (5, 0), name: "fallende_diagonale")
    line((4.8, -0.2), (3.8, 1.8), name: "b_gerade")

    intersections("x", "a_gerade", "fallende_diagonale")
    intersections("y", "a_gerade", "steigende_diagonale")
    line("x.0", "y.0", stroke: blue, name: "a")
    intersections("u", "b_gerade", "fallende_diagonale")
    intersections("v", "b_gerade", "steigende_diagonale")
    line("u.0", "v.0", stroke: green, name: "b")
    intersections("m", "steigende_diagonale", "fallende_diagonale")
    line("x.0", "m.0", stroke: red, name: "g")
    line("m.0", "u.0", stroke: purple, name: "h")
    line((3.75, 1.5), (3.95, 1.8), stroke: gray)
    line((3.8, 1.45), (4, 1.75), stroke: gray)
    line((0.8, 0), (1, 0.3), stroke: gray)
    line((0.85, -0.05), (1.05, 0.25), stroke: gray)
    
    content("a.50%",text(fill: blue)[$a$], anchor: "west", padding: 3pt)
    content("b.50%",text(fill: green)[$b$], anchor: "west", padding: 3pt)
    content("g.50%",text(fill: red)[$g$], anchor: "south", padding: 2pt)
    content("h.50%",text(fill: purple)[$h$], anchor: "north", padding: 2pt)
  })
)

== Additionstheoreme (Auszug)

#grid(..mathe,
[Addition], grid.cell(colspan: 2)[$sin(alpha plus.minus beta)=sin alpha dot cos beta plus.minus cos alpha dot sin beta$],
[Doppelter Winkel], grid.cell(colspan: 2)[$sin(2 alpha)=2sin alpha dot cos alpha$],
[Summe], grid.cell(colspan: 2)[$sin alpha + sin beta=2sin((alpha + beta)/2)cos((alpha -beta)/2)$]
)
#pagebreak()

// Hauptbereich
// ============
//

// Statik
= Mechanik
== Statik

#grid(..standard,

[Kräftegleichgewicht], grid.cell(colspan: 3)[Ein Körper ist im Kräftegleichgewicht, wenn die resultierende Kraft $#text(fill: red)[$arrow(F)_"res"$]$ Null ist.],
[], grid.cell(colspan: 3)[
  #cetz.canvas({
  import cetz.draw: *
  set-style(stroke: 0.5pt)

  // Situationsplan
  rect((-2,1), (-1.5,0.5))
  line((-1.6, 0.9), (-1.9, 0.9), (-1.9, 0.75), (-1.6, 0.75), (-1.6, 0.6), (-1.9, 0.6))
  
  line(
    (0,0), (180deg, 2), 
    mark: (
      end: "barbed",
      size: 8pt,
    ),
    stroke: red,
    name: "F_2",
  )

  line(
    (0,0), (0deg, 2), 
    mark: (
      end: "barbed",
      size: 8pt,
    ),
    stroke: red,
    name: "F_1",
  )

  circle((0, 0), radius: 1pt, fill: black)
    
  content("F_1.50%",text(fill: red)[$arrow(F)_1$], anchor: "south", padding: 2pt)
  content("F_2.50%",text(fill: red)[$arrow(F)_2$], anchor: "south", padding: 2pt)

  // Additionsplan
  rect((2.5,1), (3,0.5))
  line((2.6, 0.6), (2.6, 0.9), (2.9, 0.9), (2.9, 0.6))
  line((2.6, 0.75), (2.9, 0.75))

  line(
    (4.5,0), (2.5, 0), 
    mark: (
      end: "barbed",
      size: 8pt,
    ),
    stroke: red,
    name: "F_2",
  )

  line(
    (2.5,0.1), (4.5, 0.1), 
    mark: (
      end: "barbed",
      size: 8pt,
    ),
    stroke: red,
    name: "F_1",
  )

  content("F_1.50%",text(fill: red)[$arrow(F)_1$], anchor: "south", padding: 2pt)
  content("F_2.50%",text(fill: red)[$arrow(F)_2$], anchor: "north", padding: 4pt)
})
],

[Drehmoment], grid.cell(colspan: 2)[$#text(fill: red)[$M$]=#text(fill: red)[$F$] #text(fill: green)[$r$]$], [$[M]=qty("1", "Newton meter")$],

[], [#text(fill: red)[$F$]], [Kraft ($perp$ zum Kraftarm #text(fill: green)[$r$])], [$[F]=qty("1", "N")$],
[], [#text(fill: green)[$r$]], [Kraftarm #linebreak() (Abstand DA - Wirkungslinie)], [$[r]=qty("1", "m")$],

[], [], grid.cell(colspan: 2)[
  #cetz.canvas({
  import cetz.draw: *
  set-style(stroke: 0.5pt)

  // Kraft
  line(
    (0,0), (150deg, 2), 
    mark: (
      end: "barbed",
      size: 8pt,
    ),
    stroke: red,
    name: "F_1",
  )
  circle((0, 0), radius: 1pt, fill: red, stroke: red)

  content("F_1.50%",text(fill: red)[$arrow(F)$], anchor: "south", padding: 3pt)

  // Wirkungslinie
  line(
    (150deg, 2), (150deg, 2.7), 
    stroke: (paint: red, dash: "dashed"),
    name: "Wirkungslinie"
  )  
    
  // Drehachse
  circle((-2.4, 0.5), radius: 1pt, fill: blue, stroke: blue, name: "DA")

  content("DA", text(fill: blue)[DA], anchor: "north", padding: 3pt)

  // Kraftarm
  line("DA", (rel: (60deg, 1)), name: "Kraftarm_Gerade", stroke: none)
  intersections("x", "Kraftarm_Gerade", "Wirkungslinie")
  line("DA", "x.0", stroke: green, name: "Kraftarm")

  set-origin("x.0")
  arc(
    (240deg, 0.3),
    start: 240deg,
    stop: 330deg,
    radius: 0.3,
    stroke: green
  )

  circle((285deg, 0.16), radius: 0.5pt, stroke: green, fill: green)

  content("Kraftarm.50%", text(fill: green)[$r$], anchor: "east", padding: 2pt)
})
],

[Momenten-#linebreak()gleichgewicht #v(1em)], grid.cell(colspan: 3)[$sum #text(fill: red)[$M_"linksdrehend"$]=sum #text(fill: red)[$M_"rechtsdrehend"$]$],

[Gleichgewichtsarten], grid.cell(colspan: 3)[stabil, labil, indifferent #v(1em)],

[Hebelgesetz], grid.cell(colspan: 3)[$#text(fill: red)[$F_1$] #text(fill: green)[$r_1$] = #text(fill: red)[$F_2$] #text(fill: green)[$r_2$]$],
[], [#text(fill: green)[$r_i$]], [Kraftarme#v(1em)], [$[r_i]=qty("1", "m")$],

[Schwerpunkt], grid.cell(colspan: 2)[$x_s=(sum x_i m_i)/(sum m_i)$; $y_s=(sum y_i m_i)/(sum m_i)$],[$[m_i]=qty("1", "kg")$],
[], [$x_i$], [$x$-Koordinate des Schwerpunktes der Masse $m_i$], [$[x_i]=qty("1", "m")$],
[], [$y_i$], [$y$-Koordinate des Schwerpunktes der Masse $m_i$#v(1em)], [$[y_i]=qty("1", "m")$],

[Schiefe Ebene], grid.cell(colspan: 3)[$#text(fill: red)[$F_||$]/#text(fill: red)[$F_G$]=#text(fill: blue)[Gegenkathete]/#text(fill: red)[Hypothenuse]=#text(fill: blue)[$a$]/#text(fill: red)[$c$]=sin alpha$],
grid.cell(rowspan: 3)[
  #cetz.canvas({
    import cetz.draw: *
    set-style(stroke: 0.5pt)
    
    line((), (3, 1.5), name: "c")
    line((), (3, 0), name: "a")
    line((), (0, 0), name: "b")

    let alfa = calc.atan(0.5)
    let betrag = 1

    scope({
      rotate(alfa)
      rect((1.6, 0), (rel: (1, 0.3)), name: "gegenstand")
    })

    line("gegenstand.center", (rel: (0,-betrag)), stroke: red, mark: (end: "barbed", scale: 0.5), name: "F_G")
    line("gegenstand.center", (rel: (90deg+alfa,-betrag*calc.cos(alfa))), stroke: red, mark: (end: "barbed", scale: 0.5), name: "F_senkrecht")
    line("gegenstand.center", (rel: (alfa,-betrag*calc.sin(alfa))), stroke: red, mark: (end: "barbed", scale: 0.5), name: "F_parallel")
    line("F_parallel.end", "F_G.end", "F_senkrecht.end", stroke: (dash: "dotted"))

    content("a.50%",text(fill: blue)[$a$], anchor: "west", padding: 2pt)
    content("b.50%",text(fill: green)[$b$], anchor: "north", padding: 2pt)
    content("c.40%",text(fill: red)[$c$], anchor: "south-east", padding: 2pt)

    content("F_G.70%", text(fill: red)[$arrow(F)_G$], anchor: "east", padding: 1pt)
    content("F_senkrecht.70%", text(fill: red)[$arrow(F)_perp$], anchor: "south-west", padding: 1pt)
    content("F_parallel.70%", text(fill: red)[$arrow(F)_||$], anchor: "south", padding: 3pt)

    cetz.angle.angle("b.end", "b", "c", radius: 0.7, label: box(baseline: -0.2em)[$alpha$], label-radius: 0.5)
    cetz.angle.angle("b.start", "a", "b", radius: 0.3, label: box(baseline: -0.2em)[$dot$], label-radius: 0.16)
  })
], grid.cell(colspan: 3)[$#text(fill: red)[$F_perp$]/#text(fill: red)[$F_G$]=#text(fill: green)[Ankathete]/#text(fill: red)[Hypothenuse]=#text(fill: green)[$b$]/#text(fill: red)[$c$]=cos alpha$],
[#text(fill: red)[$F_perp$]], [Kraft senkrecht zur Ebene], [$[F_perp]=qty("1", "N")$],
[#text(fill: red)[$F_||$]], [Kraft parallel zur Ebene#v(1em)], [$[F_||]=qty("1", "N")$]
)
#pagebreak()

// Spezielle Kräfte
== Spezielle Kräfte

#grid(..standard,

[Gewichtskraft], grid.cell(colspan: 2)[$#text(fill: red)[$F_G$]=m #text(fill: red)[$g$]$], [$[F_G]=qty("1", "N")$],
[], [$m$], [Masse des Körpers], [$[m]=qty("1", "kg")$],
[], text(fill: red)[$g$], grid.cell(colspan: 2)[Ortsfaktor/Fallbeschleunigung#linebreak()$qty("9.81","N/kg")=qty("9.81","m/s^2")$#v(1em)],

[Gravitationskraft#v(1em)], grid.cell(colspan: 3)[_$->$ #ref(<F_G>, form: "page") _],

[Federkraft], grid.cell(colspan: 2)[$#text(fill: red)[$F_F$]=D #text(fill: green)[$y$]$], [$[F_F]=qty("1","N")$],
[], [$D$], [Federkonstante/Federhärte], [$[D]=qty("1","N/m")$],
[], text(fill: green)[$y$], [Dehnung der Feder#v(1em)], [$[y]=qty("1","m")$],

[Normalkraft], grid.cell(colspan: 3)[Die Kraft, mit der zwei Körper senkrecht zur Berührungsfläche aufeinander einwirken.#v(1em)],

[Gleitreibungskraft], grid.cell(colspan: 2)[$#text(fill: red)[$F_R$]=mu_G #text(fill: red)[$F_N$]$], [$[F_R]=qty("1","N")$],
[], [$mu_G$], [Gleitreibungszahl], [$[mu_G]=1$],
[], text(fill: red)[$F_N$], [Normalkraft#v(1em)], [$[F_N]=qty("1","N")$],

[Haftkraft], grid.cell(colspan: 2)[$0<=#text(fill: red)[$F_R$]<=mu_H #text(fill: red)[$F_N$]$], [$[F_R]=qty("1","N")$],
[], [$mu_H$], [Haftreibungszahl], [$[mu_H]=1$],
[], text(fill: red)[$F_N$], [Normalkraft#v(1em)], [$[F_N]=qty("1","N")$],

[Auftrieb#v(1em)], grid.cell(colspan: 3)[_$->$ #ref(<F_A>, form: "page")_],

[#smallcaps[Coulomb]-Kraft#v(1em)], grid.cell(colspan: 3)[_$->$ #ref(<F_C>, form: "page")_],

[#smallcaps[Lorentz]-Kraft#v(1em)], grid.cell(colspan: 3)[_$->$ #ref(<F_L>, form: "page")_],

[Stromdurchfl. Leiter#v(1em)], grid.cell(colspan: 3)[_$->$ #ref(<F_Leiter>, form: "page")_],


)

#pagebreak()

// Flüssigkeiten
== Flüssigkeiten

#grid(..standard, 

[Dichte], grid.cell(colspan: 2)[$rho=m/V$], [$[rho]=qty("1", "kg/m^3")$],
[_$->$ @rho _], [$m$], [Masse], [$[m]=qty("1", "kg")$],
[], [$V$], [Volumen#v(1em)], [$[V]=qty("1", "m^3")$],

[Stempeldruck], grid.cell(colspan: 2)[$#text(fill: blue)[$p$]=#text(fill: red)[$F$]/A$], [$[p]=qty("1","Pa")$],
[], text(fill: red)[$F$], [Kraft $perp$ zur Fläche $A$], [$[F]=qty("1", "N")$],
[], [$A$], [Fläche#v(1em)], [$[A]=qty("1", "m^2")$],

[Schweredruck], grid.cell(colspan: 2)[$#text(fill: blue)[$p$]=rho #text(fill: red)[$g$] #text(fill: green)[$h$]$], [$[p]=qty("1","Pa")$],
[], [$rho$], [Dichte des Mediums], [$[rho]=qty("1", "kg/m^3")$],
[], text(fill: red)[$g$], [Ortsfaktor/Fallbeschleunigung], [$[g]=qty("1", "m/s^2")$],
[], text(fill: green)[$h$], [Tiefe, Höhe des Mediums#v(1em)], [$[h]=qty("1", "m")$],

[Gesamtdruck], grid.cell(colspan: 2)[$#text(fill: blue)[$p_"tot"$]=#text(fill: blue)[$p_0$]+rho #text(fill: red)[$g$] #text(fill: green)[$h$]$], [$[p_"tot"]=qty("1", "Pa")$],
[], text(fill: blue)[$p_0$], [Luftdruck: $qty("1", "atm")$, wenn nichts angegeben ist#v(1em)], [$[p_0]=qty("1", "Pa")$],

[Auftrieb <F_A>], grid.cell(colspan: 2)[$#text(fill: red)[$F_A$]=rho #text(fill: red)[$g$] #text(fill: purple)[$V_E$]$], [$[F_A]=qty("1","N")$],
grid.cell(rowspan: 3)[
  #cetz.canvas({
    import cetz.draw: *
    set-style(stroke: 0.5pt)

    rect((0, 0), (rel: (1, 1)), name: "gegenstand")

    line((0.51, 0.5), (rel: (0,-1)), stroke: red, mark: (end: "barbed", scale: 0.5), name: "F_G")

    line((0.49, 0.35), (rel: (0, 1)), stroke: red, mark: (end: "barbed", scale: 0.5), name: "F_A")

    on-layer(-1, rect((0, 0), (1, 0.7), stroke: none, fill: purple.transparentize(80%)))

    line((-1, 0.7), (2, 0.7), stroke: blue)

    content("F_G.80%", text(fill: red)[$arrow(F)_G$], anchor: "east", padding: 1pt)
    content("F_A.70%", text(fill: red)[$arrow(F)_A$], anchor: "south-west", padding: 1pt)
    content((0.25, 0.35), text(fill: purple)[$V_E$])
    content((1.5, -0.1), [$rho$])
  })
], [$rho$], [Dichte des verdrängten Mediums], [$[rho]=qty("1","kg/m^3")$],
text(fill: purple)[$V_E$], [eingetauchtes Volumen], [$[V_E]=qty("1","m^3")$],
text(fill: red)[$g$], grid.cell(colspan: 2)[Ortsfaktor/Fallbeschleunigung#linebreak()$qty("9.81","N/kg")=qty("9.81","m/s^2")$#v(1em)],

[Kontinuitätsgleichung], grid.cell(colspan: 3)[$#text(fill: blue)[$v_1$]A_1=#text(fill: blue)[$v_2$]A_2="konstant"$],
[], text(fill: blue)[$v_i$], [Strömungsgeschwindigkeit], [$[v_i]=qty("1", "m/s")$],
[], [$A_i$], [Strömungsquerschnitt#v(1em)], [$[A_i]=qty("1", "m^2")$],

[Gesetz von #smallcaps[Bernoulli]], grid.cell(colspan: 3)[$#text(fill: blue)[$p$]+1/2 rho #text(fill: blue)[$v$]^2+rho #text(fill: red)[$g$] #text(fill: green)[$h$]="konstant"$],

[
  #place(dx: 8cm, dy: 0.7cm)[
    #cetz.canvas({
      import cetz.draw: *
      
      set-style(stroke: 0.5pt)

      line((-1, -1), (rel: (4, 0)), stroke: gray)
      
      scope({
        rotate(45deg)
        circle((0, 0), radius: (0.6,1), name: "eingang")
      })
      circle((0, 0), radius: 0.5pt)

      scope({
        set-origin((2.2, 0.6))
        arc((0, 0), start: -90deg, stop: 90deg, radius: (0.2, 0.4), name: "ausgang")
      })

      scope({
        set-origin((2.2, 0.6))
        arc((0, 0), start: -90deg, delta: -180deg, radius: (0.2, 0.4), stroke: gray)
      })
      circle((2.2, 1), radius: 0.5pt)

      arc-through("eingang.98%", (0.6, 1.3), "ausgang.end")
      arc-through("eingang.52%", (1.9, 0.5), "ausgang.start")

      arc-through("eingang.center", (1, 0.7), (2.2, 1), stroke: red)

      line((0, 0), (45deg, 0.4), stroke: blue, mark: (end: "barbed", scale: 0.5), name: "v_1")
      line((2.2, 1), (rel: (0deg, 0.9)), stroke: blue, mark: (end: "barbed", scale: 0.5), name: "v_2")
     
      line((0, -1), (0, 0), stroke: green, name: "h_1")
      line((2.2, -1), (2.2, 1), stroke: green, name: "h_2")
      
      content("h_1", text(fill: green)[$h_1$], anchor: "west", padding: 2pt)
      content("h_2", text(fill: green)[$h_2$], anchor: "west", padding: 2pt)
      content("v_1", text(fill: blue)[$arrow(v)_1$], anchor: "south-east", padding: 2pt)
      content("v_2", text(fill: blue)[$arrow(v)_2$], anchor: "south", padding: 2pt)
      content((-0.5, 0.5), [$A_1$])
      content((2.2, 1.2), text(size: 8pt)[$A_2$])
      content((1, 0.9), text(fill: red, size: 8pt)[Stromlinie], angle: 20deg)
      content((0, 1.3), text(size: 8pt)[Stromröhre], angle: 20deg)
    })
  ]
], text(fill: blue)[$v$], [Strömungsgeschwindigkeit#v(1em)], [$[v]=qty("1", "m/s")$],

[Wichtige Umrechnungen], grid.cell(colspan: 3)[
$qty("1", "bar") &= qty("1e5", "Pa") \ 
qty("1", "milli bar") &= qty("1", "hPa") \
qty("1", "atm") &= qty("101325", "Pa") \
qty("1", "mmHg") &approx qty("133.3", "Pa")
$]
)

#pagebreak()

// Kinematik
== Kinematik

=== Geradlinige Bewegung <Diagramme>

#grid(..standard,
[Gleichförmig], grid.cell(colspan: 3)[ #grid(columns: (1fr, 1fr),
  // x-t-Diagramm
  [#cetz.canvas({
    import cetz-plot: *
    import cetz.draw: *
    
    set-style(axes: (overshoot: 7pt, shared-zero: false, stroke: 0.5pt, tick: (stroke: 0.5pt), x: (mark: (end: "barbed")), y: (mark: (end: "barbed"))), stroke: 0.5pt)

    plot.plot(axis-style: "left", size: (2,1.5), x-tick-step: none, y-tick-step: none, x-label: [$t$], y-label: text(fill: green)[$x$], x-ticks: ((1, [$t$]), ), y-ticks: ((0.3, [#text(fill: green)[$x_0$]]), ), name: "xt", {
      plot.add(((0,0.3), (1.1, 1)), style: (stroke: green))
      plot.add(((1, 0), (1, 0.3)), style: (stroke: (paint: black, dash: "dashed")))
      plot.add(((1, 0.3), (1, 0.93)), style: (stroke: green))
      plot.add(((0, 0.3), (1, 0.3)), style: (stroke: black))
      plot.add-anchor("t", (0.5, 0.15))
      plot.add-anchor("x", (1, 0.61))
    })
    content("xt.t", [$Delta t$])
    content("xt.x", text(fill: green)[$Delta x$], anchor: "west", padding: 1pt)
  })], 
  // v-t-Diagramm
  [#cetz.canvas({
    import cetz-plot: *
    import cetz.draw: *
    
    set-style(axes: (overshoot: 7pt, shared-zero: false, stroke: 0.5pt, tick: (stroke: 0.5pt), x: (mark: (end: "barbed")), y: (mark: (end: "barbed"))), stroke: 0.5pt)

    plot.plot(axis-style: "left", size: (2,1.5), x-tick-step: none, y-tick-step: none, x-label: [$t$], y-label: text(fill: blue)[$v$], x-ticks: ((1, [$t$]), ), y-ticks: ((0.8, [#text(fill: blue)[$v_0$]]), ), name: "vt", {
      plot.add(((0,0.8), (1, 0.8)), style: (stroke: blue))
      plot.add-fill-between(((0, 0.8), (1, 0.8)), ((0, 0), (1, 0)), style: (stroke: none, fill: green.transparentize(80%))) 
      plot.add(((0, 0), (0, 1)), style: (stroke: none))
      plot.add(((1, 0), (1, 0.8)), style: (stroke: (paint: black, dash: "dashed")))
      plot.add-anchor("x", (0.5, 0.4))
    })
    content("vt.x", text(fill: green)[$Delta x$])  
  })])
],
[], grid.cell(colspan: 2)[$#text(fill: green)[$x$]=#text(fill: green)[$x_0$]+#text(fill: green)[$Delta x$]=#text(fill: green)[$x_0$]+#text(fill: blue)[$v_0$]t$], [$[x]=qty("1", "m")$],
[], text(fill: green)[$x_0$], [Ort zu Beginn der Messung], [$[x_0]=qty("1", "m")$],
[], text(fill: blue)[$v$], [Geschwindigkeit], [$[v]=qty("1", "m/s")$],
[], [$t$], [Zeit], [$[t]=qty("1", "s")$])

#grid(columns: (0.9fr,3.4fr),
[Gleichmässig beschleunigt], [ #grid(columns: (1fr, 1fr, 1fr), gutter: 10pt,
  // x-t-Diagramm
  [#cetz.canvas({
    import cetz-plot: *
    import cetz.draw: *
    
    set-style(axes: (overshoot: 7pt, shared-zero: false, stroke: 0.5pt, tick: (stroke: 0.5pt), x: (mark: (end: "barbed")), y: (mark: (end: "barbed"))), stroke: 0.5pt)

    plot.plot(axis-style: "left", size: (2,1.5), x-tick-step: none, y-tick-step: none, x-label: [$t$], y-label: text(fill: green)[$x$], x-ticks: ((1, [$t$]), ), y-ticks: ((0.3, [#text(fill: green)[$x_0$]]), ), name: "xt", {
      plot.add(((1, 0), (1, 0.3)), style: (stroke: (paint: black, dash: "dashed")))
      plot.add(((1, 0.3), (1, 1.5)), style: (stroke: green))
      plot.add(((0, 0.3), (1, 0.3)), style: (stroke: black))
      plot.add(domain: (0, 1), x => calc.pow(x, 2)*0.7+0.5*x+0.3, style: (stroke: green))
      plot.add-anchor("t", (0.5, 0.15))
      plot.add-anchor("x", (1, 0.9))
    })
    content("xt.t", [$Delta t$])
    content("xt.x", text(fill: green)[$Delta x$], anchor: "west", padding: 1pt)
  })],
  // v-t-Diagramm
  [#cetz.canvas({
    import cetz-plot: *
    import cetz.draw: *
    
    set-style(axes: (overshoot: 7pt, shared-zero: false, stroke: 0.5pt, tick: (stroke: 0.5pt), x: (mark: (end: "barbed")), y: (mark: (end: "barbed"))), stroke: 0.5pt)

    plot.plot(axis-style: "left", size: (2,1.5), x-tick-step: none, y-tick-step: none, x-label: [$t$], y-label: text(fill: blue)[$v$], x-ticks: ((1, [$t$]), ), y-ticks: ((0.3, [#text(fill: blue)[$v_0$]]), ), name: "vt", {
      plot.add(((0,0.3), (1.1, 1)), style: (stroke: blue))
      plot.add-fill-between(((0, 0.3), (1, 0.93)), ((0, 0), (1, 0)), style: (stroke: none, fill: green.transparentize(80%)))
      plot.add(((1, 0), (1, 0.3)), style: (stroke: (paint: black, dash: "dashed")))
      plot.add(((1, 0.3), (1, 0.93)), style: (stroke: blue))
      plot.add(((0, 0.3), (1, 0.3)), style: (stroke: black))
      plot.add-anchor("t", (0.5, 0))
      plot.add-anchor("x_1", (0.5, 0.15))
      plot.add-anchor("x_2", (0.7, 0.5))
      plot.add-anchor("v", (1, 0.61))
    })
    content("vt.t", [$Delta t$], anchor: "north", padding: 1pt)
    content("vt.v", text(fill: blue)[$Delta v$], anchor: "west", padding: 1pt)
    content("vt.x_1", text(fill: green)[$Delta x_1$])
    content("vt.x_2", text(fill: green)[$Delta x_2$])
  })],
  // a-t-Diagramm
  [#cetz.canvas({
    import cetz-plot: *
    import cetz.draw: *
    
    set-style(axes: (overshoot: 10pt, shared-zero: false, stroke: 0.5pt, tick: (stroke: 0.5pt), x: (mark: (end: "barbed")), y: (mark: (end: "barbed"))), stroke: 0.5pt)

    plot.plot(axis-style: "left", size: (2,1.5), x-tick-step: none, y-tick-step: none, x-label: [$t$], y-label: text(fill: red)[$a$], x-ticks: ((1, [$t$]), ), y-ticks: ((0.8, [#text(fill: red)[$a$]]), ), name: "at", {
      plot.add(((0,0.8), (1, 0.8)), style: (stroke: red))
      plot.add(((0, 0), (0, 1)), style: (stroke: none))
      plot.add-fill-between(((0, 0.8), (1, 0.8)), ((0, 0), (1, 0)), style: (stroke: none, fill: blue.transparentize(80%))) 
      plot.add(((1, 0), (1, 0.8)), style: (stroke: (paint: black, dash: "dashed")))
      plot.add-anchor("v", (0.5, 0.4))
    })
    content("at.v", text(fill: blue)[$Delta v$])  
  })])
],
)
#grid(..standard, 
[], grid.cell(colspan: 2)[$#text(fill: green)[$x$]=#text(fill: green)[$x_0$]+#text(fill: green)[$Delta x_1$]+#text(fill: green)[$Delta x_2$]=#text(fill: green)[$x_0$]+#text(fill: blue)[$v_0$]t+1/2#text(fill: red)[$a$]t^2$], [$[x]=qty("1", "m")$],
[], grid.cell(colspan: 2)[$#text(fill: blue)[$v$]=#text(fill: blue)[$v_0$]+#text(fill: blue)[$Delta v$]=#text(fill: blue)[$v_0$]+#text(fill: red)[$a$]t$], [$[v]=qty("1", "m/s")$],
[], grid.cell(colspan: 2)[$#text(fill: blue)[$dash(v)$]=(#text(fill: green)[$Delta x$])/(Delta t)$], [$[dash(v)]=qty("1", "m/s")$],
[], grid.cell(colspan: 3)[$2#text(fill: red)[$a$] (#text(fill: green)[$x$]-#text(fill: green)[$x_0$])=#text(fill: blue)[$v$]^2-#text(fill: blue)[$v_0$]^2$],
[], text(fill: blue)[$v$], [Momentangeschwindigkeit], [$[v]=qty("1", "m/s")$],
[], text(fill: blue)[$dash(v)$], [Mittlere Geschwindigkeit], [$[dash(v)]=qty("1", "m/s")$],
[], text(fill: blue)[$v_0$], [Anfangsgeschwindigkeit], [$[v_0]=qty("1", "m/s")$],
[], text(fill: red)[$a$], [Beschleunigung#v(1em)], [$[a]=qty("1", "m/s^2")$],

grid.cell(rowspan: 2)[Horizontaler Wurf#linebreak()für $x_0=0$ und $y_0=h$], grid.cell(colspan: 2)[$#text(fill: green)[$x$]=#text(fill: blue)[$v_0$]t$], [$[x]=qty("1", "m")$],
grid.cell(colspan: 2)[$#text(fill: green)[$y$]=#text(fill: green)[$h$]-1/2#text(fill: red)[$g$]t^2$], [$[y]=qty("1", "m")$],
[], text(fill: blue)[$v_0$], [Anfangsgeschwindigkeit], [$[v_0]=qty("1", "m/s")$],
[], text(fill: green)[$h$], [Abwurfhöhe], [$[h]=qty("1", "m")$],
[], text(fill: red)[$g$], [Ortsfaktor/Fallbeschleunigung#linebreak()$qty("9.81","N/kg")=qty("9.81","m/s^2")$], [$[g]=qty("1", "m/s^2")$]
)
#pagebreak()

=== Gleichförmige Kreisbewegung

#grid(..standard, 
grid.cell(rowspan: 3)[Winkelkoordinate \ 
#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    set-style(stroke: 0.5pt)
    circle((0, 0), stroke: gray)
    line((0, 0), (170deg, 1), stroke: green, name: "r")
    line((0, 0), (1,0), stroke: (dash: "dotted"), name: "null")
    line((0, 0), (45deg, 1), stroke: (dash: "dotted"), name: "x")
    //arc((0.55, 0), start: 0deg, stop: 45deg, radius: 0.55, stroke: winkel)
    on-layer(-1, {cetz.angle.angle("x.start", "null", "x", radius: 0.5, label-radius: 0.34, label: box(baseline: -0.2em)[#text(fill: winkel)[$phi$]], stroke: winkel)})
    line("x.end", (rel: (135deg, 1)), stroke: blue, mark: (end: "barbed"), name: "v")
    line("x.end", (rel: (225deg, 0.6)), stroke: red, mark: (end: "barbed"), name: "a")
    cetz.angle.angle("x.end", "v", "x", radius: 0.18, label-radius: 0.1, label: box(baseline: -0.2em)[$dot$])
    
    arc((1,0), start: 0deg, stop: 45deg, stroke: aqua, name: "b")

    content("b.50%", text(fill: aqua)[$b$], anchor: "south-west", padding: 1pt)
    content("r.50%", text(fill: green)[$r$], anchor: "north")
    content("v.50%", text(fill: blue)[$arrow(v)$], anchor: "south-west")
    content("a.50%", text(fill: red)[$arrow(a_z)$], anchor: "south-east", padding: 1pt)    
  })
]
], grid.cell(colspan: 2)[$#text(fill: winkel)[$phi$]=#text(fill: aqua)[$b$]/#text(fill: green)[$r$]$], [$[phi]=qty("1","")$],
text(fill: aqua)[$b$], [Bogenlänge], [$[b]=qty("1", "m")$],
text(fill: green)[$r$], [Kreisradius#v(1em)], [$[r]=qty("1", "m")$],

[Winkelgeschwindigkeit], grid.cell(colspan: 2)[$#text(fill: purple)[$omega$]=(#text(fill: winkel)[$Delta phi$])/(Delta t)$], [$[omega]=qty("1", "1/s")$],
[], text(fill: winkel)[$Delta phi$], [Drehwinkel (Bogenmass!), der \ in der Zeitspanne $Delta t$ überstrichen wird#v(1em)], [$[phi]=1$],

[Bahngeschwindigkeit#v(1em)], grid.cell(colspan: 2)[$#text(fill: blue)[$v$]=#text(fill: purple)[$omega$]#text(fill:green)[$r$]$], [$[v]=qty("1", "m/s")$],

[Umlaufzeit, Periode#v(1em)], grid.cell(colspan: 2)[$T=(2 pi #text(fill: green)[$r$])/#text(fill: blue)[$v$]=(2 pi)/#text(fill: purple)[$omega$]$], [$[T]=qty("1", "s")$],

[Frequenz, Drehzahl#v(1em)], grid.cell(colspan: 2)[$f=1/T$], [$[f]=qty("1", "Hz")$],

[Zentripetalbeschl.#v(1em)], grid.cell(colspan: 2)[$#text(fill: red)[$a_z$]=#text(fill: blue)[$v$]^2/#text(fill: green)[$r$]=#text(fill: purple)[$omega$]^2#text(fill: green)[$r$]$], [$[a_z]=qty("1", "m/s^2")$]
)

=== Gleichmässig beschleunigte Kreisbewegung, Rotation

#grid(..standard, 
[Winkelbeschleunigung#v(1em)], grid.cell(colspan: 2)[$#text(fill: red)[$alpha$]=(#text(fill: purple)[$Delta omega$])/(Delta t)$], [$[alpha]=qty("1", "1/s^2")$],

[Bahnbeschleunigung#v(1em)], grid.cell(colspan: 2)[$#text(fill: red)[$a$]=#text(fill: red)[$alpha$]#text(fill: green)[$r$]$], [$[a]=qty("1", "m/s^2")$],

[Bewegungsgleichungen], grid.cell(colspan: 2)[$#text(fill: winkel)[$phi$]=#text(fill: winkel)[$phi_0$]+#text(fill: purple)[$omega_0$]t+1/2#text(fill: red)[$alpha$]t^2$], [$[phi]=qty("1", "")$],
[], grid.cell(colspan: 2)[$#text(fill: purple)[$omega$]=#text(fill: purple)[$omega_0$]+#text(fill: red)[$alpha$]t$], [$[omega]=qty("1", "1/s")$],

grid.cell(rowspan: 5)[
  #cetz.canvas({
    import cetz.draw: *
    set-style(stroke: 0.5pt)
    
    rotate(z: -45deg) 
    catmull((-1,0), (0,1.5), (1,0), (0,-1), (-1,-0.5), (-1,0), tension: .5, stroke: black)

    rotate(x: 40deg)
    line((0,0,-1.5), (0,0,1), stroke : (paint: blue, dash: "dash-dotted"), name: "DA")
    circle((0, 0), stroke: gray, radius: 0.9)
    arc((-0.06, 5, -0.2), start: 110deg, delta: 330deg, radius: 0.2, stroke: purple, mark: (end: "barbed", scale: 0.5), name: "omega")
    line((0, 0), (170deg, 0.9), stroke: green, name: "r")
    line((0, 0), (0.9,0), stroke: (dash: "dotted"))
    line((0, 0), (45deg, 0.9), stroke: (dash: "dotted"), name: "x")
    arc((0.55, 0), start: 0deg, stop: 45deg, radius: 0.55, stroke: (winkel))
    line("x.end", (rel: (135deg, 1)), stroke: red, mark: (end: "barbed", scale: 0.5), name: "a")
    arc("x.80%", start: 225deg, stop: 135deg, radius: 0.2)
    set-origin("x.end")
    circle((180deg, 0.1), radius: 0.2pt, fill: black)
    set-origin("x.start")

    content("r.50%", text(fill: green)[$r$], anchor: "north")
    content("a.50%", text(fill: red)[$arrow(a)$], anchor: "south-west", padding: 1pt)
    content((26deg, 0.4), text(fill: winkel, size: 5pt)[$phi$])
    content("DA.end", text(fill: blue)[DA], anchor: "east", padding: 4pt)
    content("omega", text(fill: purple)[$omega$], anchor: "east", padding: 5pt)
  })
  
], text(fill: winkel)[$phi$], [überstrichener Winkel], [$[phi]=1$],
text(fill: winkel)[$phi_0$], [Winkel zu Messbeginn], [$[phi_0]=1$],
text(fill: purple)[$omega$], [Momentane Winkelgeschwindig.], [$[omega]=qty("1", "1/s")$],
text(fill: purple)[$omega_0$], [Winkelgeschw. zu Messbeginn], [$[omega_0]=qty("1", "1/s")$],
text(fill: red)[$alpha$], [Winkelbeschleunigung], [$[alpha]=qty("1", "1/s^2")$]
)

#pagebreak()

== Dynamik
=== #smallcaps[Newtonsche] Axiome

#grid(..standard,
[Trägheitsprinzip], grid.cell(colspan: 3)[Ein Körper, auf den keine Kraft wirkt, führt eine geradlinige, gleichförmige Bewegung aus oder verharrt in Ruhe.#v(1em)],

[Aktionsprinzip], grid.cell(colspan: 2)[$#text(fill: red)[$arrow(F)_"res"$]=m#text(fill: red)[$arrow(a)$]$], [$[F_"res"]=qty("1", "N")$],
[], text(fill: red)[$arrow(F)_"res"$], [resultierende Kraft], [],
[], [$m$], [Masse des Körpers], [$[m]=qty("1", "kg")$],
[], text(fill: red)[$arrow(a)$], [Beschleunigung des Körpers#v(1em)], [$[a]=qty("1", "m/s^2")$],

[Wechselwirkungsprinzip#v(1em)], grid.cell(colspan: 3)[$#text(fill: red)[$arrow(F)_"1 auf 2"$]=-#text(fill: red)[$arrow(F)_"2 auf 1"$]$]
)

=== Gleichförmige Kreisbewegung

#place(dx: 0.5cm, dy: 0.6cm)[
  #cetz.canvas({
    import cetz.draw: *

    set-style(stroke: 0.5pt)
    circle((0, 0), stroke: gray)
    line((0, 0), (170deg, 1), stroke: green, name: "r")
    line((0, 0), (45deg, 1), stroke: (dash: "dotted"), name: "x")
    line("x.end", (rel: (135deg, 1)), stroke: blue, mark: (end: "barbed"), name: "v")
    line("x.end", (rel: (225deg, 0.6)), stroke: red, mark: (end: "barbed"), name: "a")
    on-layer(0, {cetz.angle.angle("x.end", "v", "x", radius: 0.18, label-radius: 0.1, label: box(baseline: -0.2em)[$dot$])})

    content("r.50%", text(fill: green)[$r$], anchor: "north")
    content("v.50%", text(fill: blue)[$arrow(v)$], anchor: "south-west")
    content("a.60%", text(fill: red)[$arrow(F_z)$], anchor: "south-east", padding: 1pt)
  })
]
#grid(..standard, 
[Zentripetalkraft], grid.cell(colspan: 2)[$#text(fill: red)[$F_z$]=m#text(fill: purple)[$omega$]^2#text(fill: green)[$r$]=m (#text(fill:blue)[$v$]^2)/#text(fill: green)[$r$]$], [$[F_z]=qty("1", "N")$],
[], text(fill: green)[$r$], [Bahnradius], [$[r]=qty("1", "m")$],
[], text(fill: purple)[$omega$], [Winkelgeschwindigkeit], [$[omega]=qty("1", "1/s")$],
[], text(fill: blue)[$v$], [Bahngeschwindigkeit], [$[v]=qty("1", "m/s")$],
[$$#v(1em)], text(fill: red)[$a_z$], [Zentripetalbeschleunigung], [$[a_z]=qty("1", "m/s^2")$]
)

=== Gleichmässig beschleunigte Kreisbewegung, Rotation

#grid(..standard,
[Grundgleichung], grid.cell(colspan: 2)[$#text(fill: red)[$M_"res"$]=J#text(fill: red)[$alpha$]$], [$[M_"res"]=qty("1", "N m")$],
[], text(fill: red)[$M_"res"$], [resultierendes Drehmoment], [],
[], [$J$], [Trägheitsmoment], [$[J]=qty("1", "kg m^2")$],
[], text(fill: red)[$alpha$], [Winkelbeschleunigung#v(1em)], [$[alpha]=qty("1", "1/s^2")$],

[Trägheitsmomente], grid.cell(colspan: 3)[_$->$ @J _#v(1em)],

[Satz von #smallcaps[Steiner]], grid.cell(colspan: 2)[$J=J_"SP"+m#text(fill: green)[$r$]^2$], [$[J]=qty("1", "kg m^2")$],
[], [$J$], grid.cell(colspan: 2)[für eine parallele #text(fill:blue)[DA] im Abstand #text(fill: green)[$r$]],
[], [$J_"SP"$], grid.cell(colspan: 2)[für eine #text(fill:blue)[DA] durch den Schwerpunkt],
[], [$m$], [Masse des Körpers], [$[m]=qty("1", "kg")$]
)

#pagebreak()

== Gravitation <F_G>

#grid(..standard,
[Gravitationskraft], grid.cell(colspan: 2)[$#text(fill: red)[$F_G$]=G (m_1 m_2)/#text(fill: green)[$r$]^2$], [$[F_G]=qty("1","N")$],
[], [$m_i$], [Massen der beiden Körper], [$[m_i]=qty("1","kg")$],
[], text(fill: green)[$r$], [Schwerpunktsabstand], [$[r]=qty("1","m")$],
[], [$G$], grid.cell(colspan: 2)[Gravitationskonstante#linebreak()$qty("6.67e-11","N m^2/kg^2")$],
) #v(-1em)
#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    set-style(stroke: 0.5pt)

    let erdkugel = gradient.radial(
    white, 
    blue, 
    center: (25%, 25%))

    let mondkugel = gradient.radial(
    white, 
    gray, 
    center: (25%, 25%))
    
    circle((-4, 0), stroke: blue, fill: erdkugel, radius: 0.9)
    circle((2,0), stroke: gray, fill: mondkugel, radius: 0.2)
    line((-4, 0), (2, 0), stroke: green, name: "r")
    line((-4, 0.02), (-2, 0.02), stroke: red, mark: (end: "barbed"), name: "F_1")
    line((2, 0.02), (0, 0.02), stroke: red, mark: (end: "barbed"), name: "F_2")
    
    content("r.50%", text(fill: green)[$r$], anchor: "north")
    content("F_1.80%", text(fill: red)[$arrow(F)_G$], anchor: "south-east", padding: 1pt)
    content("F_2.30%", text(fill: red)[$-arrow(F)_G$], anchor: "south-east", padding: 1pt)
  })
]

== #smallcaps[Keplersche] Gesetze

#grid(..standard, 
[1. #smallcaps[Keplersches] Gesetz], grid.cell(colspan: 3)[Planeten bewegen sich auf Ellipsen. Die Sonne befindet sich in einem Brennpunkt der Ellipse#v(1em)],

[2. #smallcaps[Keplersches] Gesetz], grid.cell(colspan: 3)[Die Verbindungslinie zwischen Sonne und Planet überstreicht in gleichen Zeitspannen $Delta t$ gleiche Flächeninhalte #text(fill: red)[$Delta A$].],
grid.cell(colspan: 4)[
  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
  
      set-style(stroke: 0.5pt)

      let a = 1.4 // Halbachse a
      let b = 0.8 // Halbachse b
      let e = calc.sqrt(calc.pow(a,2) - calc.pow(b,2)) // Exzentrizität
      let winkel1 = 280deg
      let winkel2 = 325deg
      anchor("S", (-e, 0)) // Sonne (Brennpunkt)

      circle((0,0), radius: (a, b))
      arc((0,0), start: winkel1, stop: winkel2, radius: (a, b), anchor: "origin", stroke: red, fill: red.transparentize(80%), name: "arc1")

      line((0, 0), (a, 0), stroke: aqua, name: "a")
      line((0, 0), (0, b), stroke: blue, name: "b")
      line((0, 0), "S", stroke: purple, name: "e")
      line("S", "arc1.start", "arc1.end", stroke: none, fill: red.transparentize(80%))
      line("S", "arc1.start", stroke: red)
      line("S", "arc1.end", stroke: red)
      line((a,0), (a, 0.3), stroke: blue, mark: (end: "barbed", scale: 0.5), name: "v_A")
      line((-a,0), (-a, -1), stroke: blue, mark: (end: "barbed", scale: 0.5), name: "v_P")
 
      circle("S", radius: 1pt, stroke: yellow, fill: yellow) // Sonne

      content("a.50%", text(fill: aqua)[$a$], anchor: "south", padding: 2pt)
      content("b.50%", text(fill: blue)[$b$], anchor: "west", padding: 2pt)
      content("e.50%", text(fill: purple)[$e$], anchor: "south", padding: 2pt)
      content((0.3, -0.5), text(fill: red)[$Delta A$])
      content("v_A.50%", text(fill: blue)[$arrow(v)_A$], anchor: "west", padding: 2pt)
      content("v_P.50%", text(fill: blue)[$arrow(v)_P$], anchor: "east", padding: 2pt)
    })
  ]
],
[3. #smallcaps[Keplersches] Gesetz], grid.cell(colspan: 3)[$T_1^2/T_2^2=#text(fill: aqua)[$a_1$]^3/#text(fill: aqua)[$a_2$]^3$],
[], text(fill: aqua)[$a_i$], [grosse Halbachse der Planeten], [$[a_i]=qty("1", "m")$],
[], [$T_i$], [Umlaufzeit der Planeten#v(1em)], [$[T_i]=qty("1", "s")$],

[Numerische Exzentrizität], grid.cell(colspan: 2)[$epsilon=#text(fill: purple)[$e$]/#text(fill: aqua)[$a$]$], [$[epsilon]=qty("1", "1")$],
[], text(fill: purple)[$e$], [lineare Exzentrizität#linebreak()$#text(fill: purple)[$e$]^2=#text(fill: aqua)[$a$]^2-#text(fill: blue)[$b$]^2$], [$[e]=qty("1", "m")$],
[], text(fill: blue)[$b$], [kleine Halbachse des Planeten#v(1em)], [$[b]=qty("1", "m")$],

[Astronomische Einheit], grid.cell(colspan: 3)[$qty("1", "AE")=qty("149597870700", "m")$],
[], grid.cell(colspan: 3)[$qty("1", "LJ")= qty("63240","AE")=qty("9.4605e15", "m")$#v(1em)],
[Astronomische Daten], grid.cell(colspan: 3)[_$->$ @planet _]
)

#pagebreak()

== Erhaltungsgrössen

=== Arbeit

#grid(..standard,
[Definition], grid.cell(colspan: 2)[$#text(fill: aqua)[$W$]=#text(fill: red)[$F_s$]#text(fill:green)[$s$]$], [$[W]=qty("1", "J")$],
grid.cell(rowspan: 2)[
  #cetz.canvas({
    import cetz-plot: *
    import cetz.draw: *
    
    set-style(axes: (overshoot: 5pt, shared-zero: false, stroke: 0.5pt, tick: (stroke: 0.5pt), x: (mark: (end: "barbed", scale: 0.7)), y: (mark: (end: "barbed", scale: 0.7))), stroke: 0.5pt)

    plot.plot(axis-style: "left", size: (2,1), x-tick-step: none, y-tick-step: none, x-label: text(fill: green)[$s$], y-label: text(fill: red)[$F_s$], name: "Fs", {
      plot.add(((0,0.8), (1, 0.8)), style: (stroke: red))
      plot.add(((0, 0), (0, 1)), style: (stroke: none))
      plot.add-fill-between(((0, 0.8), (1, 0.8)), ((0, 0), (1, 0)), style: (stroke: none, fill: aqua.transparentize(80%))) 
      plot.add(((1, 0), (1, 0.8)), style: (stroke: (paint: black, dash: "dashed")))
      plot.add-anchor("W", (0.5, 0.4))
    })
    content("Fs.W", text(fill: aqua)[$W$])  
  })
], text(fill: red)[$F_s$], [Kraft in Wegrichtung], [$[F_s]=qty("1", "N")$],
text(fill: green)[$s$], [Wegstrecke], [$[s]=qty("1", "m")$]
)

=== Energie

#grid(..standard,
[Definition], grid.cell(colspan: 2)[$#text(fill: aqua)[$Delta E$]=#text(fill: aqua)[$W$]$], [$[Delta E]=qty("1", "J")$],
[$$#v(1em)], text(fill: aqua)[$W$], [Arbeit], [$[W]=qty("1", "J")$],

[Lageenergie], grid.cell(colspan: 2)[$#text(fill: green)[$E_"pot"$]=m g#text(fill: green)[$h$]$], [$[E_"pot"]=qty("1", "J")$],
grid.cell(rowspan: 3)[
  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      set-style(stroke: 0.5pt)
  
      circle((0,1.3), radius: 0.1, fill: kugel, name: "kugel")
  
      line((-1,0), (1,0), stroke: (paint: green, dash: "dashed"), name: "NN")
      line((0, 0), "kugel.center", stroke: green, name: "h")
  
      content("NN.end", text(fill: green)[NN], anchor: "west", padding: 2pt)
      content("h.50%", text(fill: green)[$h$], anchor: "east", padding: 2pt)
      content("kugel.east", [$m$], anchor: "north-west", padding: 2pt)
    })
  ]
], [$m$], [Masse des Körpers], [$[m]=qty("1", "kg")$],
[$g$], [Ortsfaktor/Fallbeschleunigung], [$[g]=qty("1", "m/s^2")$],
text(fill: green)[$h$#v(1em)], [Höhe über dem Bezugsniveau], [$[h]=qty("1", "m")$],

[Bewegungsenergie], grid.cell(colspan: 2)[$#text(fill: blue)[$E_"kin"$]=1/2 m #text(fill: blue)[$v$]^2$], [$[E_"kin"]=qty("1", "J")$],
grid.cell(rowspan: 2)[
  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      set-style(stroke: 0.5pt)
  
      circle((), radius: 0.1, fill: kugel, name: "kugel")
  
      line("kugel.center", (rel: (1,0)), stroke: blue, mark: (end: "barbed"), name: "v")
  
      content("v.50%", text(fill: blue)[$arrow(v)$], anchor: "south", padding: 2pt)
      content("kugel.north", [$m$], anchor: "south", padding: 2pt)
    })
  ]
], [$m$], [Masse des Körpers], [$[m]=qty("1", "kg")$],
text(fill: blue)[$v$#v(1em)], [Geschwindigkeit des Körpers], [$[v]=qty("1", "m/s")$],

[Spannenergie], grid.cell(colspan: 2)[$#text(fill: red)[$E_"spann"$]=1/2 D#text(fill: red)[$y$]^2$], [$[E_"spann"]=qty("1", "J")$],
grid.cell(rowspan: 2)[
  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      set-style(stroke: 0.5pt)
  
      circle((0,0.5), radius: 0.1, fill: kugel, name: "kugel")
  
      line((-1,1), (1,1), stroke: (paint: red, dash: "dashed"), name: "NN")
      line((-0.25, 1.55), (0.25, 1.55), stroke: 1mm + gray.lighten(50%))
      line((-0.25, 1.5), (0.25, 1.5), name: "decke")

      cetz.decorations.coil(line("decke", "kugel"), amplitude: 0.2)

      line((-0.3, 1), (-0.3, 0.5), stroke: red, name: "y")

      line("y.end", "kugel", stroke: (dash: "dotted"))
  
      content("NN.end", text(fill: red)[NN], anchor: "west", padding: 2pt)
      content("y.50%", text(fill: red)[$y$], anchor: "east", padding: 4pt)
      content("kugel.east", [$m$], anchor: "south-west", padding: 2pt)
    })
  ]
], [$D$], [Federkonstante/Federhärte], [$[D]=qty("1", "N/m")$],
text(fill: red)[$y$#v(1em)], [Dehnung der Feder], [$[y]=qty("1", "m")$],

[Rotationsenergie], grid.cell(colspan: 2)[$#text(fill: purple)[$E_"rot"$]=1/2 J#text(fill: purple)[$omega$]^2$], [$[E_"rot"]=qty("1", "J")$],
grid.cell(rowspan: 2)[#align(center)[
  #cetz.canvas({
    import cetz.draw: *
    import cetz.vector: *

    set-style(stroke: (thickness: 0.5pt, cap: "round"))

    
    let r = 0.5
    let h = 0.2
    let O = (0, 0) 
    let M = (h, 0)

    rotate(
      x: -20deg,
      y: -20deg, 
    )
    arc(add(O, (0,r)), radius: r, start: 90deg, delta: 180deg)

    line(add(O, (0, -r)), add(M, (0, -r)))
    line(add(O, (0, r)), add(M, (0, r)))
    line((h,0.0), (rel: (1, 0)), stroke: (paint:blue, dash: "dash-dotted"), name: "DA")
    arc((0.8, 0.2, 0), start: 110deg, delta: 330deg, radius: 0.2, stroke: purple, mark: (end: "barbed", scale: 0.5), name: "omega")
  
    circle(M, radius: r)
    content("DA.end", text(fill: blue)[DA], anchor: "west")
    content("omega.end", text(fill: purple)[$arrow(omega)$], anchor: "south", padding: 2pt)
    content("DA.start", [$J$], anchor: "south-east")
  })]
], [$J$], [Trägheitsmoment (_$->$ @J)_], [$[J]=qty("1", "kg m^2")$],
text(fill: purple)[$omega$#v(1em)], [Winkelgeschwindigkeit], [$[omega]=qty("1", "1/s")$],

[Elektrische Energie], grid.cell(colspan: 2)[$E_"el"=#text(fill: blue)[$U$]q$], [$[E_"el"]=qty("1", "J")$],
grid.cell(rowspan: 2)[
  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      set-style(stroke: 0.5pt)
  
      circle((), radius: 0.1, fill: positiv, stroke: red, name: "ladung")

      for feldlinie in (-0.35, 0.35){
        line((0.75, feldlinie), (rel: (-2.5, 0)), stroke: purple, mark: (end: "barbed", scale: 0.7), name: "E")
      }

      line((-1, -0.4), (-1, 0.4), stroke: (paint: blue, dash: "dashed"), name: "NN")
      line((-1, 0), "ladung.center", stroke: blue, name: "U")
  
      content("NN.end", text(fill: blue)[NN], anchor: "south", padding: 1pt)
      content("E.start", text(fill: purple)[$arrow(E)$], anchor: "west", padding: 4pt)
      content("U.50%", text(fill: blue)[$U$], anchor: "north", padding: 2pt)
      content("ladung.east", [$q$], anchor: "south-west", padding: 1pt)
    })
  ]
], text(fill: blue)[$U$], [Spannung zum Bezugsniveau], [$[U]=qty("1", "V")$],
[$q$#v(1em)], [Ladung des Teilchens], [$[q]=qty("1", "C")$],

[Energieerhaltung], grid.cell(colspan: 3)[In einem abgeschlossenen System bleibt die Gesamtenergie $E_"tot"$ erhalten.#v(1em)]
)

=== Leistung

#grid(..standard,
[Mittlere Leistung], grid.cell(colspan: 2)[$P=(#text(fill: aqua)[$Delta E$])/(Delta t)=#text(fill: red)[$F$]#text(fill: blue)[$v$]$], [$[P]=qty("1", "W")$],
grid.cell(rowspan: 3)[
  #cetz.canvas({
    import cetz-plot: *
    import cetz.draw: *
    
    set-style(axes: (overshoot: 5pt, shared-zero: false, stroke: 0.5pt, tick: (stroke: 0.5pt), x: (mark: (end: "barbed", scale: 0.7)), y: (mark: (end: "barbed", scale: 0.7))), stroke: 0.5pt)

    plot.plot(axis-style: "left", size: (2,1), x-tick-step: none, y-tick-step: none, x-label: text(fill: blue)[$v$], y-label: text(fill: red)[$F$], name: "Fv", {
      plot.add(((0,0.8), (1, 0.8)), style: (stroke: red))
      plot.add(((0, 0), (0, 1)), style: (stroke: none))
      plot.add-fill-between(((0, 0.8), (1, 0.8)), ((0, 0), (1, 0)), style: (stroke: none, fill: gray.transparentize(80%))) 
      plot.add(((1, 0), (1, 0.8)), style: (stroke: (paint: black, dash: "dashed")))
      plot.add-anchor("P", (0.5, 0.4))
    })
    content("Fv.P", text(fill: black)[$P$])  
  })
], text(fill: aqua)[$Delta E$], [Arbeit, die in der Zeitspanne $Delta t$ verrichtet wird], [$[Delta E]=qty("1", "J")$],
text(fill: red)[$F$], [Kraft in Bewegungsrichtung], [$[F]=qty("1", "N")$],
text(fill: blue)[$v$#v(1em)], [Geschwindigkeit des Körpers], [$[v]=qty("1", "m/s")$],

[Wirkungsgrad], grid.cell(colspan: 2)[$eta=P^arrow.tr/P^arrow.bl$], [$[eta]=1$],
[], [$P^arrow.tr$], [Nutzleistung], [$[P^arrow.tr]=qty("1", "W")$],
[$$#v(1em)], [$P^arrow.bl$], [Eingangsleistung], [$[P^arrow.bl]=qty("1", "W")$],

[Umrechnung], grid.cell(colspan: 3)[$1 "kWh"=qty("3.6", "MJ")$]
)

=== Impuls

#grid(..standard, 
[Definition], grid.cell(colspan: 2)[$#text(fill: blue)[$arrow(p)$]=m#text(fill: blue)[$arrow(v)$]$], [$[p]=qty("1", "N s")$],
[], [$m$], [Masse des Körpers], [$[m]=qty("1", "kg")$],
[$$#v(1em)], text(fill: blue)[$arrow(v)$], [Geschwindigkeit des Körpers], [$[v]=qty("1", "m/s")$],

[Kraftstoss], grid.cell(colspan: 3)[$#text(fill: red)[$arrow(F)$]Delta t=#text(fill: blue)[$Delta arrow(p)$]=#text(fill: blue)[$arrow(p)_"nach"$]-#text(fill: blue)[$arrow(p)_"vor"$]$], 
[], text(fill: blue)[$Delta arrow(p)$], [Impulsänderung], [$[Delta p]=qty("1", "N s")$],
[$$#v(1em)], text(fill: red)[$arrow(F)$], [konstante, mittlere Kraft], [$[F]=qty("1", "N")$],

[], grid.cell(colspan: 3)[
  #cetz.canvas({
    import cetz.draw: *
    set-style(stroke: 0.5pt)

    // Impuls nach dem Stoss
    let Fres = calc.atan(2)
    let pnach = 2*Fres - 90deg
  
    // Situationsplan
    rect((-2,1), (-1.5,0.5))
    line((-1.6, 0.9), (-1.9, 0.9), (-1.9, 0.75), (-1.6, 0.75), (-1.6, 0.6), (-1.9, 0.6))

    line((-1, 0.5), (1, -0.5))
    line(
      (0,0.1), (rel: (0, -1)), 
      mark: (
        end: "barbed",
        size: 8pt,
      ),
      stroke: blue,
      name: "p_vor",
    )
  
    line(
      (0,0.1), (rel: (pnach, 1)), 
      mark: (
        end: "barbed",
        size: 8pt,
      ),
      stroke: blue,
      name: "p_nach",
    )
    
    line(
      (0.0, 0.1), (rel: (Fres, 1.5)), 
      stroke: red, 
      mark: (
        end: "barbed", 
        size: 8pt
      ), 
      name: "F")
    
    line((0,0.1), (rel: (0, 1)), stroke: (dash: "dotted"))
  
    circle((0, 0.1), radius: 2pt, fill: black)

    set-origin((0, 0.1))

    arc((pnach, 0.6), start: pnach, stop: 90deg, radius: 0.6)
      
    content("p_vor.50%",text(fill: blue)[$arrow(p)_"vor"$], anchor: "east", padding: 2pt)
    content("p_nach.50%",text(fill: blue)[$arrow(p)_"nach"$], anchor: "north-west", padding: 2pt)
    content("F.50%",text(fill: red)[$arrow(F)$], anchor: "south-east", padding: 2pt)
    content((pnach+(Fres - pnach)/2, 0.5), [$alpha$])
    content((Fres+(Fres - pnach)/2, 0.5), [$alpha$])
  
    // Additionsplan
    rect((2.5,1), (3,0.5))
    line((2.6, 0.6), (2.6, 0.9), (2.9, 0.9), (2.9, 0.6))
    line((2.6, 0.75), (2.9, 0.75))
  
    line(
      (3,-1), (rel: (pnach, 1)), 
      mark: (
        end: "barbed",
        size: 8pt,
      ),
      stroke: blue,
      name: "p_nach",
    )

    line(
      (), (rel: (90deg, 1)), 
      mark: (
        end: "barbed",
        size: 8pt,
      ),
      stroke: blue,
      name: "p_vor",
    )
  
    line(
      (), (3, -1), 
      mark: (
        start: "barbed",
        size: 8pt,
      ),
      stroke: blue,
      name: "F",
    )
  
    content("p_vor.50%",text(fill: blue)[$-arrow(p)_"vor"$], anchor: "west", padding: 2pt)
    content("p_nach.50%",text(fill: blue)[$arrow(p)_"nach"$], anchor: "north-west", padding: 2pt)
    content("F.50%",text(fill: blue)[$Delta arrow(p)$], anchor: "south-east", padding: 2pt)
  })
],

[Impulserhaltung], grid.cell(colspan: 3)[Der Gesamtimpuls #text(fill: blue)[$arrow(p)_"tot"$] in einem abgeschlossenen System hat einen konstanten Betrag und eine konstante Richtung. Er wird von Vorgängen im System nicht beeinflusst.]
)
#pagebreak()

// Zentrale Stösse
=== Zentrale Stösse

#grid(..standard, 
[Unelastischer Stoss], grid.cell(colspan: 3)[
  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      set-style(stroke: 0.5pt)
  
      circle((-2.5, 0), stroke: gray, fill: kugel, radius: 0.2)
      circle((-4, 0), stroke: gray, fill: kugel, radius: 0.2)
      circle((-0.5,0), stroke: gray, fill: kugel, radius: 0.2)
      circle((-0.1,0), stroke: gray, fill: kugel, radius: 0.2)
      line((-4.5, -0.21), (-1.6, -0.21))
      line((-1.4, -0.21), (1.4, -0.21))
      line((-4, 0), (-2.8, 0), stroke: blue, mark: (end: "barbed"), name: "v_1")
      line((-2.5, 0), (-1.7, 0), stroke: blue, mark: (end: "barbed"), name: "v_2")
      line((-0.3, 0), (0.8, 0), stroke: blue, mark: (end: "barbed"), name: "u")

      content("v_1.50%", text(fill: blue)[$arrow(v)_1$], anchor: "south", padding: 1pt)
      content("v_2.50%", text(fill: blue)[$arrow(v)_2$], anchor: "south", padding: 1pt)
      content("u.50%", text(fill: blue)[$arrow(u)$], anchor: "south", padding: 1pt)
      content((-4,0.5), [$m_1$])
      content((-2.5,0.5), [$m_2$])
      content((-0.3,0.5), [$m_1+m_2$])
    })#v(1em)
  ]
],
[], grid.cell(colspan: 2)[$#text(fill: blue)[$arrow(u)$]=(m_1#text(fill: blue)[$arrow(v)_1$]+m_2#text(fill: blue)[$arrow(v)_2$])/(m_1+m_2)$], [$[u]=qty("1","m/s")$],
[], [$m_i$], [Massen der Körper], [$[m_i]=qty("1", "kg")$],
[$$#v(1em)], text(fill: blue)[$v_i$], [Geschwindigkeiten vor dem Stoss], [$[v_i]=qty("1", "m/s")$],

[Elastischer Stoss], grid.cell(colspan: 3)[
  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      set-style(stroke: 0.5pt)
  
      let kugel = gradient.radial(
      white, 
      gray, 
      center: (25%, 25%))

      circle((-2.5, 0), stroke: gray, fill: kugel, radius: 0.2)
      circle((-4, 0), stroke: gray, fill: kugel, radius: 0.2)
      circle((-0.6,0), stroke: gray, fill: kugel, radius: 0.2)
      circle((-0.1,0), stroke: gray, fill: kugel, radius: 0.2)
      line((-4.5, -0.21), (-1.6, -0.21))
      line((-1.4, -0.21), (1.4, -0.21))
      line((-4, 0), (-2.8, 0), stroke: blue, mark: (end: "barbed"), name: "v_1")
      line((-2.5, 0), (-1.7, 0), stroke: blue, mark: (end: "barbed"), name: "v_2")
      line((-0.6, 0), (-1.5, 0), stroke: blue, mark: (end: "barbed"), name: "u_1")
      line((-0.1, 0), (1.2, 0), stroke: blue, mark: (end: "barbed"), name: "u_2")

      content("v_1.50%", text(fill: blue)[$arrow(v)_1$], anchor: "south", padding: 1pt)
      content("v_2.50%", text(fill: blue)[$arrow(v)_2$], anchor: "south", padding: 1pt)
      content("u_1.50%", text(fill: blue)[$arrow(u)_1$], anchor: "south", padding: 1pt)
      content("u_2.50%", text(fill: blue)[$arrow(u)_2$], anchor: "south", padding: 1pt)
      content((-4,0.5), [$m_1$])
      content((-2.5,0.5), [$m_2$])
      content((-0.6,0.5), [$m_1$])
      content((-0.1,0.5), [$m_2$])
    })#v(1em)
  ]
],
[], grid.cell(colspan: 2)[$#text(fill: blue)[$arrow(u)_1$]=(2m_2#text(fill: blue)[$arrow(v)_2$]+(m_1-m_2)#text(fill: blue)[$arrow(v)_1$])/(m_1+m_2)$], [$[u_1]=qty("1","m/s")$],
[], grid.cell(colspan: 2)[$#text(fill: blue)[$arrow(u)_2$]=(2m_1#text(fill: blue)[$arrow(v)_1$]+(m_2-m_1)#text(fill: blue)[$arrow(v)_2$])/(m_1+m_2)$], [$[u_2]=qty("1","m/s")$],
[], [$m_i$], [Massen der Körper], [$[m_i]=qty("1", "kg")$],
[$$#v(1em)], text(fill: blue)[$v_i$], [Geschwindigkeiten vor dem Stoss], [$[v_i]=qty("1", "m/s")$],
)

=== Drehimpuls

#grid(..standard, 
[Definition], grid.cell(colspan: 2)[$#text(fill: blue)[$arrow(L)$]=J #text(fill: purple)[$arrow(omega)$]$], [$[L]=qty("1", "kg m^2/s")$],
grid.cell(rowspan: 2)[#align(center)[
  #cetz.canvas({
    import cetz.draw: *
    import cetz.vector: *

    set-style(stroke: (thickness: 0.5pt, cap: "round"))

    
    let r = 0.5
    let h = 0.2
    let O = (0, 0) 
    let M = (h, 0)

    rotate(
      x: -20deg,
      y: -20deg, 
    )
    arc(add(O, (0,r)), radius: r, start: 90deg, delta: 180deg)

    line(add(O, (0, -r)), add(M, (0, -r)))
    line(add(O, (0, r)), add(M, (0, r)))
    line((h,0.0), (rel: (1.5, 0)), stroke: (paint:blue, dash: "dash-dotted"), name: "DA")
    line((h,0.0), (rel: (0.9, 0)), stroke: blue, mark: (end: "barbed"), name: "L")
    arc((1.2, 0.2, 0), start: 110deg, delta: 330deg, radius: 0.2, stroke: purple, mark: (end: "barbed", scale: 0.5), name: "omega")
  
    circle(M, radius: r)
    content("DA.end", text(fill: blue)[DA], anchor: "west")
    content("omega.end", text(fill: purple)[$arrow(omega)$], anchor: "south", padding: 2pt)
    content("L.30%", text(fill: blue)[$arrow(L)$], anchor: "south", padding: 2pt)
    })]
], [$J$], [Trägheitsmoment des Körpers], [$[J]=qty("1", "kg m^2")$],
text(fill: purple)[$arrow(omega)$], [Winkelgeschwindigkeit], [$[omega]=qty("1", "1/s")$],

[Drehimpulsänderung], grid.cell(colspan: 2)[$#text(fill: blue)[$Delta L$]=#text(fill: red)[$arrow(M)$] Delta t$], [$[Delta L]=qty("1", "kg m^2 /s")$],
align(center)[
  #cetz.canvas({
    import cetz.draw: *
    import cetz.vector: *

    set-style(stroke: (thickness: 0.5pt, cap: "round"))

    
    let r = 0.5
    let h = 0.2
    let O = (0, 0) 
    let M = (h, 0)

    rotate(
      x: -20deg,
      y: -20deg, 
    )
    arc(add(O, (0,r)), radius: r, start: 90deg, delta: 180deg)

    line(add(O, (0, -r)), add(M, (0, -r)))
    line(add(O, (0, r)), add(M, (0, r)))
    line((h,0.0), (rel: (1.5, 0)), stroke: (paint:blue, dash: "dash-dotted"), name: "DA")
    line((h/2, 0, r), (rel: (0, 0, 1)), stroke: (paint:blue, dash: "dash-dotted"), name: "MA")
    line((h,0.0), (rel: (0.9, 0)), stroke: blue, mark: (end: "barbed"), name: "L")
    line((h/2, 0, r), (rel: (0, 0, 0.5)), stroke: red, mark: (end: "barbed"), name: "M")
    line("L.end", (rel: (0, 0, 1.2)), stroke: blue, mark: (end: "barbed"), name: "DeltaL")
    arc((1.2, 0.2, 0), start: 110deg, delta: 330deg, radius: 0.2, stroke: purple, mark: (end: "barbed", scale: 0.5), name: "omega")
    arc((h/2, 0.05, 1.3), start: 180deg, delta: 330deg, radius: (0.2, 0.2), stroke: red, mark: (end: "barbed", scale: 0.5), name: "M_arc")
  
    circle(M, radius: r)
    content("DA.end", text(fill: blue)[DA], anchor: "west")
    content("MA.end", text(fill: blue)[DA], anchor: "east")
    content("omega.end", text(fill: purple)[$arrow(omega)$], anchor: "south", padding: 2pt)
    content("L.30%", text(fill: blue)[$arrow(L)$], anchor: "south", padding: 2pt)
    content("DeltaL.60%", text(fill: blue)[$Delta arrow(L)$], anchor: "north-west", padding: 2pt)
    content("M.50%", text(fill: red)[$arrow(M)$], anchor: "south", padding: 6pt)
    })],
text(fill: red)[$arrow(M)$], [mittleres Drehmoment], [$[M]=qty("1", "N m")$],

[Drehimpulssatz], grid.cell(colspan: 3)[Der Gesamtdrehimpuls #text(fill: blue)[$arrow(L)_"tot"$] in einem abgeschlossenen System hat einen konstanten Betrag und eine konstante Richtung. Er wird von Vorgängen im System nicht beeinflusst.]
)
#pagebreak()

= Wärmelehre

== Temperatur

#grid(..standard,
[#smallcaps[Celsius]-Temperatur], grid.cell(colspan: 2)[$theta.alt=T-T_n$], [$[theta.alt]=qty("1", "Celsius")$],
[$$#v(0.5em)], [$T_n$], grid.cell(colspan: 2)[Normtemperatur $qty("273.15", "Kelvin")$],

[#smallcaps[Kelvin]-Temperatur#v(0.5em)], grid.cell(colspan: 2)[$T=theta.alt+T_n$], [$[T]=qty("1", "K")$],

[#smallcaps[Fahrenheit]-Temperatur#v(0.5em)], grid.cell(colspan: 3)[$[unit("Fahrenheit")]=1.8 dot theta.alt+32$],

[Temperaturdifferenz#v(0.5em)], grid.cell(colspan: 3)[$Delta theta.alt=Delta T$],

[Längenänderung], grid.cell(colspan: 2)[$#text(fill: green)[$Delta l$]=#text(fill: blue)[$alpha$]#text(fill: green)[$l_0$]Delta T"; "#text(fill: green)[$l$]=#text(fill: green)[$l_0$] (1 + #text(fill: blue)[$alpha$]Delta T)$], [$[Delta l]=qty("1", "m")$],
[$->$ _@thermo _], text(fill: blue)[$alpha$], [Längenausdehnungskoeffizient], [$[alpha]=qty("1", "1/K")$],
[], text(fill: green)[$l_0$], [ursprüngliche Länge], [$[l_0]=qty("1", "m")$],
[$$#v(1em)], text(fill: green)[$l$], [neue Länge], [$[l]=qty("1", "m")$],

[Volumenänderung], grid.cell(colspan: 2)[$Delta V=#text(fill: red)[$gamma$]V_0 Delta T"; "V=V_0 (1 + #text(fill: red)[$gamma$]Delta T)$], [$[Delta V]=qty("1", "m^3")$],
[$->$ _@thermo _], text(fill: red)[$gamma$], [Volumenausdehnungskoeffizient], [$[gamma]=qty("1", "1/K")$],
[], [$V_0$], [ursprüngliches Volumen], [$[V_0]=qty("1", "m^3")$],
[], [$V$], [neues Volumen], [$[V]=qty("1", "m^3")$],
[], grid.cell(colspan: 3)[$#text(fill: red)[$gamma$]approx 3 #text(fill: blue)[$alpha$]$],
//[Ausdehnungskoeffizient], grid.cell(colspan: 3)[ _Siehe @thermo _] 
)

== Ideales Gas

#grid(..standard,
[Vergleich], grid.cell(colspan: 3)[$(#text(fill: blue)[$p_1$] V_1)/T_1=(#text(fill: blue)[$p_2$] V_2)/T_2$],
[], text(fill:blue)[$p_i$], [absoluter Druck], [$[p_i]=qty("1", "Pa")$],
[], [$V_i$], [Gasvolumen], [$[V_i]=qty("1", "m^3")$],
[$$#v(1em)], [$T_i$], [absolute Temperatur], [$[T_i]=qty("1", "K")$],
[Zustandsgleichung], grid.cell(colspan: 3)[$#text(fill: blue)[$p$]V=n R T=N k T$],
[], [$N$], [Teilchenzahl], [$[N]=1$],
[], [$n$], [Stoffmenge], [$[n]=qty("1", "mol")$],
[], [$R$], grid.cell(colspan: 2)[universelle Gaskonstante \ $qty("8.31446262", "J/mol/K ")$],
[], [$k$], grid.cell(colspan: 2)[#smallcaps[Boltzmann]-Konstante \ $qty("1.380649e-23", "J/K")$]
)

#pagebreak()

== Stoffmenge

#grid(..standard,
[Definition], grid.cell(colspan: 2)[$n=N/N_A=m/M$], [$[n]=qty("1", "mol")$],
[], [$N_A$], grid.cell(colspan: 2)[#smallcaps[Avogadro]-Konstante \ $qty("6.02214076e23", "1/mol")$],
[], [$M$], [Molare Masse], [$[M]=qty("1", "g/mol")$]
)

== Wärmemenge

#grid(..standard,
[Temperaturänderung], grid.cell(colspan: 2)[$#text(fill: aqua)[$Q$]=#text(fill: maroon)[$c$]m Delta theta.alt$], [$[Q]=qty("1", "J")$],
[_$->$ @thermo _], text(fill: maroon)[$c$], [spezifische Wärmekapazität], [$[c]=qty("1", "J/kg/K")$],
[$$#v(1em)], [$m$], [Masse des Mediums], [$[m]=qty("1", "kg")$],

[Schmelzen/Erstarren], grid.cell(colspan: 2)[$#text(fill: aqua)[$Q$]=#text(fill: purple)[$L_f$]m$], [$[Q]=qty("1", "J")$],
[_$->$ @thermo _#v(1em)], text(fill: purple)[$L_f$], [spezifische Schmelzwärme], [$[L_f]=qty("1", "J/kg")$],

grid.cell(rowspan: 2)[Verdampfen/Kondensieren \ _$->$ @thermo _], grid.cell(colspan: 2)[$#text(fill: aqua)[$Q$]=#text(fill: fuchsia)[$L_v$]m$], [$[Q]=qty("1", "J")$],
text(fill: fuchsia)[$L_v$], [spezifische Verdampfungswärme], [$[L_v]=qty("1", "J/kg")$]
)

== Wärmetransport

#grid(..standard,
[Wärmeleitung], grid.cell(colspan: 2)[$#text(fill: aqua)[$Delta Q$]/(Delta t)=-lambda (Delta T)/(#text(fill: green)[$Delta x$])#text(fill: red)[$A$]$], [$[(Delta Q)/(Delta T)]=qty("1", "J/s")$],
[_$->$ @thermo _], [$lambda$], [Wärmeleitfähigkeit], text(size: 9.36pt)[$[lambda]=qty("1", "W/m /K")$],
grid.cell(rowspan: 3)[#cetz.canvas({
    import cetz-plot: *
    import cetz.draw: *
    
    set-style(axes: (overshoot: 7pt, shared-zero: false, stroke: 0.5pt, tick: (stroke: 0.5pt), x: (mark: (end: "barbed")), y: (mark: (end: "barbed"))), stroke: 0.5pt)

    plot.plot(axis-style: "left", size: (2,1), x-tick-step: none, y-tick-step: none, x-label: text(fill: green)[$x$], y-label: $T$, name: "Tx", {
      plot.add(((0,1), (0.3, 1), (0.7, 0.5), (1, 0.5)), style: (stroke: black))
      plot.add(((0.3, 0), (0.3, 1)), style: (stroke: (paint: black, dash: "dotted")))
      plot.add(((0.7, 0), (0.7, 0.5)), style: (stroke: (paint: black, dash: "dotted")))
      plot.add(((1, 0), (1, 0.5)), style: (stroke: (paint: black, dash: "dotted")))
      plot.add(((0, 0.5), (0.7, 0.5)), style: (stroke: (paint: black, dash: "dotted")))
      plot.add-anchor("deltaX", (0.5, 0.3))
      plot.add-anchor("deltaT", (0.15, 0.75))
      plot.add-anchor("pfeil", (0.5, 0.75))
      plot.add-anchor("deltaQ", (0.5,1.1))
    })
    content("Tx.deltaX", text(fill: green)[$Delta x$])
    content("Tx.deltaT", [$Delta T$])
    content("Tx.pfeil", text(fill: aqua, size: 12pt)[$==>$])
    content("Tx.deltaQ", [$#text(fill: aqua)[$Delta Q$]/(Delta t)$])
  })
], [$Delta T$], [Temperaturdifferenz], [$[Delta T]=qty("1", "K")$],
text(fill: green)[$Delta x$], [Schichtdicke], [$[Delta x]=qty("1", "m")$],
text(fill: red)[$A$], [Querschnittsfläche], [$[A]=qty("1", "m^2")$],

[Wärmedurchgangszahl], grid.cell(colspan: 2)[$k=lambda/x$], text(size: 9.36pt)[$[k]=qty("1", "W/m^2/K")$],
[], grid.cell(colspan: 3)[$1/k=sum #text(fill: green)[$x_i$]/lambda_i$],
[], text(fill: green)[$x_i$], [Schichtdicke des Materials $i$], [$[x_i]=qty("1", "m")$],
[$$#v(1em)], [$lambda_i$], [Wärmeleitfähigkeit von $i$], text(size: 9pt)[$[lambda_i]=qty("1", "W/m /K")$],

[Wärmestrahlung], grid.cell(colspan: 2)[$I=sigma T^4=#text(fill: aqua)[$Delta E$]/(#text(fill: red)[$A$] Delta t)$], [$[I]=qty("1", "W/m^2")$],
grid.cell(rowspan: 2)[
    #cetz.canvas({
      import cetz.draw: *

      let licht = gradient.radial(
      yellow, 
      white, 
      center: (50%, 50%))
  
      set-style(stroke: (thickness: 0.5pt, cap: "round"))
      ortho(name: "skizze",{
        on-yz({
          rect((), (rel: (1, 1)), name: "A", fill: red.transparentize(80%), stroke: red)
          content((0.8, 0.2), [#std.rotate(-10deg)[#skew(ay:-20deg)[#text(fill: red)[$A$]]]])
        })
      })
      circle((-1.5, 0.2), radius: 0.4, stroke: none, fill: licht)
      content((-0.08, 0.25), text(fill: aqua, size: 13pt)[$==>$])
      content((rel: (0.6, -0.09)), [$#text(fill: aqua)[$Delta E$]/(Delta t)$])
    })
], [$T$], [Körpertemperatur], [$[T]=qty("1", "K")$],
[$sigma$], grid.cell(colspan: 2)[#smallcaps[Stefan-Boltzmann]-Konstante \ $qty("5.67037442e-8", "W/m^2/K^4")$]
)

#pagebreak()

== Hauptsätze der Wärmelehre

#grid(..standard,
[1. Hauptsatz], grid.cell(colspan: 3)[In einem abgeschlossenen System bleibt die Gesamtenergie konstant: \ $#text(fill: aqua)[$Delta U$]=#text(fill: aqua)[$Q$]+#text(fill: aqua)[$W$]$],
[], text(fill: aqua)[$Delta U$], [innere Energie], [$[Delta U]=qty("1", "J")$],
[], text(fill: aqua)[$Q$], [Wärme], [$[Q]=qty("1", "J")$],
[$$#v(1em)], text(fill: aqua)[$W$], [Arbeit], [$[W]=qty("1", "J")$],

[2. Hauptsatz], grid.cell(colspan: 3)[Wärme strömt von selbst immer zu Orten mit tieferen Temperaturen.#v(1em)],

[Kompressionsarbeit], grid.cell(colspan: 2)[$#text(fill: aqua)[$W$]=-#text(fill: blue)[$p$] Delta V$], [$[W]=qty("1", "J")$],
[], text(fill: blue)[$p$], [Druck im Gefäss], [$[p]=qty("1", "Pa")$],
[$$#v(1em)], [$Delta V$], [Volumenänderung], [$[Delta V]=qty("1", "m^3")$],

[Thermische Energie], grid.cell(colspan: 2)[$#text(fill: aqua)[$E_"th"$]=#text(fill: maroon)[$H$]m$], [$[E_"th"]=qty("1", "J")$],
[_$->$ @H _], text(fill: maroon)[$H$], [Spezifischer Heizwert], [$[H]=qty("1", "J/kg")$],
[$$#v(0.5em)], [$m$], [Masse des Brennstoffs], [$[m]=qty("1", "kg")$]
)

== Thermodynamischer Wirkungsgrad

#grid(..standard, 
[Ideale Maschine], grid.cell(colspan: 2)[$eta_#smallcaps[Carnot]=(#text(fill: red)[$T_W$]-#text(fill: blue)[$T_K$])/#text(fill: red)[$T_W$]$], [$[eta_"Carnot"]=1$],
[], text(fill: red)[$T_W$], [Temperatur der Antriebswärme], [$[T_W]=qty("1", "K")$],
[$$#v(0.5em)], text(fill: blue)[$T_K$], [Temperatur der Abwärme], [$[T_K]=qty("1", "K")$]
)

== Teilchenmodell

#grid(..standard,
[Druck des idealen Gases], grid.cell(colspan: 2)[$#text(fill: blue)[$p$]=1/3 rho #text(fill: blue)[$dash(v)$]^2$], [$[p]=qty("1", "Pa")$],
[], [$rho$], [Dichte des Gases], [$[rho]=qty("1", "kg/m^3")$],
[], [#text(fill: blue)[$dash(v)$]], [mittlere Geschwindigkeit der Teilchen#v(1em)], [$[v]=qty("1", "m/s")$],

grid.cell(rowspan: 2)[Mittlere Energie eines Teilchens], grid.cell(colspan: 2)[$#text(fill: aqua)[$dash(E)_1$]=3/2 k T$], [$[dash(E)_1]=qty("1", "J")$],
[$k$], grid.cell(colspan: 2)[#smallcaps[Boltzmann]-Konstante \ $k=qty("1.380649e-23", "J/K")$],
[], [$T$], [absolute Temperatur], [$[T]=qty("1", "K")$]
)
#pagebreak()

= Elektrizitätslehre

== Elektrostatik

#grid(..standard,
[Kräfte zwischen Ladungen], grid.cell(colspan: 3)[gleichnamige Ladungen stossen sich ab, ungleichnamige ziehen sich an.],
[], grid.cell(colspan: 3)[
  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      set-style(stroke: (thickness: 0.5pt, cap: "round"))

      circle((), radius: 0.2, fill: positiv, stroke: red, name: "+1")
      content("+1", box(baseline: -0.15em)[#text(fill: red)[$+$]])

      circle((1, 0), radius: 0.2, fill: positiv, stroke: red, name: "+2")
      content("+2", box(baseline: -0.15em)[#text(fill: red)[$+$]])

      circle((3, 0), radius: 0.2, fill: negativ, stroke: blue, name: "-1")
      content("-1", box(baseline: -0.15em)[#text(fill: blue)[$-$]])

      circle((4, 0), radius: 0.2, fill: negativ, stroke: blue, name: "-2")
      content("-2", box(baseline: -0.15em)[#text(fill: blue)[$-$]])

      line("+1.west", (rel: (-0.5, 0)), stroke: red, mark: (end: "barbed", scale: 0.5), name: "F1_l")
      line("+2.east", (rel: (0.5, 0)), stroke: red, mark: (end: "barbed", scale: 0.5), name: "F1_r")
      content("F1_r.50%", text(fill: red)[$arrow(F)_C$], anchor: "south", padding: 2pt)

      line("-1.west", (rel: (-0.5, 0)), stroke: red, mark: (end: "barbed", scale: 0.5), name: "F1_l")
      line("-2.east", (rel: (0.5, 0)), stroke: red, mark: (end: "barbed", scale: 0.5), name: "F1_r")
      content("F1_l.60%", text(fill: red)[$-arrow(F)_C$], anchor: "south", padding: 2pt)

      line((1, -0.3), (3, -0.3), stroke: green, mark: (start: "|", end: "|"), name: "r")
      content("r.50%", text(fill: green)[$r$], anchor: "south", padding: 2pt)
      content((0.8,0.4), text(fill: red)[$Q_1$])
      content((3.2,0.4), text(fill: blue)[$Q_2$])
    })
  ]
],
[#smallcaps[Coulomb]-Kraft <F_C>], grid.cell(colspan: 2)[$#text(fill: red)[$F_C$]=1/(4 pi epsilon_0) (|#text(fill: red)[$Q_1$]| |#text(fill: blue)[$Q_2$]|)/#text(fill: green)[$r$]^2$], [$[F_C]=qty("1", "N")$],
[], [$Q_i$], [Punktladungen], [$[Q_i]=qty("1", "C")$],
[], text(fill: green)[$r$], [Abstand zwischen den Ladungen], [$[r]=qty("1", "m")$],
[], [$epsilon_0$], grid.cell(colspan: 2)[Elektrische Feldkonstante \ $epsilon_0 = qty("8.854187e-12", "C/V/m")$#v(1em)],

[Elektrische Feldstärke], grid.cell(colspan: 2)[$#text(fill: purple)[$arrow(E)$]=#text(fill: red)[$arrow(F)_"el"$]/q$], [$[E]=qty("1", "N/C")$],
[], text(fill: red)[$arrow(F)_"el"$], [Kraft, die auf Probeladung wirkt], [$[F_"el"]=qty("1", "N")$],
[$$#v(1em)], [$q$], [Probeladung], [$[q]=qty("1", "C")$],

[Spannung], grid.cell(colspan: 2)[$#text(fill: blue)[$U_"AB"$]=#text(fill: aqua)[$W_(#h(-2pt)"AB")$]/q$], [$[U_"AB"]=qty("1", "V")$],
grid.cell(rowspan: 2)[
  #cetz.canvas({
    import cetz.draw: *
    set-style(stroke: (thickness: 0.5pt, cap: "round"))

    let teiler = 1.8
    let anzahl_feldlinien = 4
    let x_pos = (anzahl_feldlinien - 1)/(2 * teiler)
    
    for feldlinie in range(anzahl_feldlinien){
      line((feldlinie/teiler, 0), (rel: (0, -2)), stroke: purple, mark: (end: "barbed"))
    }
    
    line((-0.2, -0.5), (2, -0.5), stroke: (paint: blue, dash: "dotted"), name: "A")
    line((-0.2, -1.5), (2, -1.5), stroke: (paint: blue, dash: "dotted"), name: "B")

    circle((x_pos, -0.5), radius: 0.05, fill: positiv, stroke: red, name: "q_oben")
    circle((x_pos, -1.5), radius: 0.05, stroke: 0.5pt + gray, name: "q_unten")

    line("q_oben", "q_unten", stroke: aqua, mark: (end: "barbed"))

    cetz.decorations.brace("A.90%", "B.90%", fill: blue, name: "U")
    content((1.85, -0.2), text(fill: purple)[$arrow(E)$])
    content("A.end", [A], anchor: "west", padding: 2pt)
    content("B.end", [B], anchor: "west", padding: 2pt)
    content((-0.4, -1), angle: 90deg, text(fill: blue, size: 6pt)[Äquipotentialflächen])
    content("U.spike", anchor: "west", text(fill: blue)[$U_"AB"$])
    content((x_pos, -0.2), [$q$])
  })
], text(fill: aqua)[$W_(#h(-2pt)"AB")$], [Arbeit des elektr. Feldes zum Verschieben der Probeladung von A nach B], [$[W_"AB"]=qty("1", "J")$],
[$q$#v(1em)], [Probeladung], [$[q]=qty("1", "C")$],

[Elektrische Energie], grid.cell(colspan: 2)[$E_"el"=#text(fill: blue)[$U$]q$], [$[E_"el"]=qty("1", "J")$],
grid.cell(rowspan: 2)[
  #cetz.canvas({
    import cetz.draw: *
    set-style(stroke: 0.5pt)

    circle((), radius: 0.05, fill: positiv, stroke: red, name: "ladung")

    for feldlinie in (-0.35, 0.35){
      line((1, feldlinie), (rel: (-2.7, 0)), stroke: purple, mark: (end: "barbed"), name: "E")
    }

    line((-1, -0.4), (-1, 0.4), stroke: (paint: blue, dash: "dashed"), name: "NN")
    line((-1, 0), "ladung.center", stroke: blue, name: "U")

    content("NN.end", text(fill: blue)[NN], anchor: "south")
    content("E.start", text(fill: purple)[$arrow(E)$], anchor: "west", padding: 1pt)
    content("U.50%", text(fill: blue)[$U$], anchor: "north", padding: 2pt)
    content("ladung.east", [$q$], anchor: "south-west", padding: 1pt)
  })
], text(fill: blue)[$U$], [Spannung zum Bezugsniveau], [$[U]=qty("1", "V")$],
[$q$], [Ladung des Teilchens], [$[q]=qty("1", "C")$]
)

=== Plattenkondensator

#grid(..standard,
[Spannung], grid.cell(colspan: 2)[$#text(fill: blue)[$U$]=#text(fill: purple)[$E$]#text(fill: green)[$d$]$], [$[U]=qty("1", "V")$],
[], text(fill: purple)[$E$], [Elektrische Feldstärke], [$[E]=qty("1", "N/C")$],
[$$#v(1em)], text(fill: green)[$d$], [Plattenabstand], [$[d]=qty("1", "m")$],

[Kapazität], grid.cell(colspan: 2)[$C=epsilon_0 A/#text(fill: green)[$d$]=Q/#text(fill: blue)[$U$]$], [$[C]=qty("1", "F")$],
[], [$A$], [Fläche einer Platte], [$[A]=qty("1", "m^2")$]
)

#pagebreak()

== Elektrodynamik

#grid(..standard,
[Stromstärke], grid.cell(colspan: 2)[$#text(fill: red)[$I$]=(Delta Q)/(Delta t)$], [$[I]=qty("1", "A")$],
[], [$Delta Q$], [Ladung, die in der Zeitspanne $Delta t$ durch den Leiter fliesst#v(1em)], [],

[Ohmscher Widerstand], grid.cell(colspan: 2)[$R=#text(fill: blue)[$U$]/#text(fill: red)[$I$]$], [$[R]=qty("1", "Ohm")$],
[$$#v(1em)], text(fill: blue)[$U$], [Spannung], [$[U]=qty("1", "V")$],

[Widerstand langer Leiter], grid.cell(colspan: 2)[$R=rho_"el" #text(fill: green)[$l$]/#text(fill: red)[$A$]$], [$[R]=qty("1", "Ohm")$],
[_$->$ @rho_el _], [$rho_"el"$], [spezifischer Widerstand], [$[rho_"el"]=qty("1", "Ohm meter")$],
grid.cell(rowspan: 2)[
  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      import cetz.vector: *
  
      set-style(stroke: (thickness: 0.5pt, cap: "round"))
  
      
      let r = 0.1
      let h = 2.0
      let O = (0, 0) 
      let M = (h, 0)
  
      rotate(
        x: -20deg,
        y: -20deg, 
      )
      arc(add(O, (0,r)), radius: r, start: 90deg, delta: 180deg)
  
      line(add(O, (0, -r)), add(M, (0, -r)), stroke: green, name: "l")
      line(add(O, (0, r)), add(M, (0, r)))
    
      circle(M, radius: r, fill: red.transparentize(50%), name: "A")
      content("l.50%", text(fill: green)[$l$], anchor: "north", padding: 2pt)
      content("A.east", text(fill: red)[$A$], anchor: "west", padding: 2pt)
    })
  ]
], text(fill: green)[$l$], [Länge des Leiters], [$[l]=qty("1", "m")$],
text(fill:red)[$A$], [Querschnittsfläche des Leiters], [$[A]=qty("1", "m^2")$#v(1em)],

[Reihenschaltung], grid.cell(colspan: 2)[$R_"tot"=sum R_i$], [$[R_"tot"]=qty("1", "Ohm")$],
[
  #align(center)[
    #zap.circuit({
      import zap: *
      
      set-style(..zap-style)

      resistor("r1", (), (rel: (1.5, 0)), i: (content: text(fill: red)[$I$], anchor:"south"), u: (content: text(fill: blue)[$U_1$], label-distance: 6pt), label: (content: $R_1$, anchor: "south", distance: 2pt))
      resistor("r2", (1.5,0), (rel: (1.5, 0)), u: (content: text(fill: blue)[$U_2$], label-distance: 6pt), label: (content: $R_2$, anchor: "south", distance: 2pt))
    })
  ]  
], [$R_i$], [Einzelwiderstände], [$[R_i]=qty("1", "Ohm")$],

grid.cell(rowspan: 2)[Parallelschaltung \ #align(center)[
    #zap.circuit({
      import zap: *
      
      set-style(..zap-style)

      resistor("r1", (), (rel: (1.5, 0)), u: (content: text(fill: blue)[$U$], label-distance: 6pt), label: (content: $R_1$, anchor: "south", distance: 2pt))
      resistor("r2", (0, -0.74), (rel: (1.5, 0)), label: (content: $R_2$, anchor: "south", distance: 2pt))
      zwire((-0.5, -0.37), (0, 0), i: (content: text(fill: red, size: 8pt)[$I_1$], anchor:"east", distance: 3pt))
      zwire((-0.5, -0.37), (0, -0.74), i: (content: text(fill: red, size: 8pt)[$I_2$], anchor:"east", distance: 3pt))
      zwire((1.5, 0), (2, -0.37))
      zwire((1.5, -0.74), (1.75, -0.37), ratio: 100%)
    })
  ]], grid.cell(colspan: 2)[$R_"tot"=(sum 1/R_i)^(-1)" oder "1/R_"tot"=sum 1/R_i$], [$[R_"tot"]=qty("1", "Ohm")$],
[$R_i$], [Einzelwiderstände], [$[R_i]=qty("1", "Ohm")$],

[Elektrische Leistung], grid.cell(colspan: 2)[$P=#text(fill: blue)[$U$]#text(fill: red)[$I$]$], [$[P]=qty("1", "W")$],
[], text(fill: blue)[$U$], [Spannung], [$[U]=qty("1", "V")$],
[$$#v(1em)], text(fill: red)[$I$], [Stromstärke], [$[I]=qty("1", "A")$],

grid.cell(rowspan: 3)[Effektivwerte \ 
  #cetz.canvas({
    import cetz-plot: *
    import cetz.draw: *
    
    set-style(axes: (overshoot: 3pt, shared-zero: false, stroke: 0.5pt, tick: (stroke: 0.5pt), x: (mark: (end: "barbed", scale: 0.7)), y: (mark: (end: "barbed", scale: 0.7))), stroke: 0.5pt)

    plot.plot(axis-style: "left", size: (2,0.6), x-tick-step: none, y-tick-step: none, y-ticks: ((0.45, [$dash(P)$]), ), x-label: [$t$], y-label: [$P$], name: "Pt", {
      //plot.add(((0,0.8), (1, 0.8)), style: (stroke: red))
      plot.add-fill-between(((0, 0.9), (0.2, 0.9), (0.2, 0), (0.4, 0), (0.4, 0.9), (0.6, 0.9), (0.6, 0), (0.8, 0), (0.8, 0.9), (1, 0.9)), ((0, 0), (1, 0)), style: (stroke: black, fill: gray.transparentize(50%))) 
      plot.add(((1, 0), (1, 0.9)), style: (stroke: (paint: black, dash: "dashed")))
      plot.add(((0, 0.45), (1, 0.45)), style: (stroke: red))
    })  
  })

], grid.cell(colspan: 3)[$#text(fill: blue)[$U_"eff"$]=sqrt(dash(P) R)$ und $#text(fill:red)[$I_"eff"$]=sqrt(dash(P)/R)$], 
[$dash(P)$], [mittlere Leistung], [$[dash(P)]=qty("1", "W")$],
[$R$#v(1em)], [Widerstand], [$[R]=qty("1", "Ohm")$],

grid.cell(rowspan: 3)[Mittlere Leistung bei harmonischem Wechsel-strom], grid.cell(colspan: 2)[$dash(P)=#text(fill: blue)[$hat(U)$]^2/(2 R)=(#text(fill: red)[$hat(I)$]^2R)/2$], [$[dash(P)]=qty("1", "W")$],
text(fill: blue)[$hat(U)$], [Scheitelwert der Spannung], [$[hat(U)]=qty("1", "V")$],
text(fill: red)[$hat(I)$], [Scheitelwert der Stromstärke], [$[hat(I)]=qty("1", "A")$]
)

#pagebreak()

== Elektromagnetismus

#grid(..standard,
[#smallcaps[Lorentz]-Kraft <F_L>], grid.cell(colspan: 2)[$#text(fill: red)[$F_L$]=q#text(fill: blue)[$v$]#text(fill: aqua)[$B$]$], [$[F_L]=qty("1", "N")$],
grid.cell(rowspan: 3)[
  #cetz.canvas({
    import cetz.draw: *
    set-style(stroke: 0.5pt)

    for x in range(6){
      for y in range(4){
        content((x/2, y/2), text(fill: aqua)[$times.o$])
      }
    }
    
    // Positive Ladung
    
    circle((0.75, 0.75), radius: 0.05, fill: positiv, stroke: red, name: "ladung")

    line("ladung.center", (rel: (-1,0)), stroke: blue, mark: (end: "barbed"), name: "v")
    line("ladung.center", (rel: (0,-0.7)), stroke: red, mark: (end: "barbed"), name: "F")

    content((0.1, 1.25), text(fill: aqua)[$arrow(B)$], anchor: "west", padding: 1pt)
    content("v.50%", text(fill: blue)[$arrow(v)$], anchor: "north", padding: 2pt)
    content("F.80%", text(fill: red)[$arrow(F)_L$], anchor: "west", padding: 2pt)
    content("ladung", [$+q$], anchor: "south", padding: 3pt)

    cetz.angle.angle("v.start", "v", "F", radius: 0.2, label: box(baseline: -0.2em)[$dot$], label-radius: 0.12)

    // Negative Ladung
    
    circle((1.75, 0.75), radius: 0.05, fill: negativ, stroke: blue, name: "ladung")

    line("ladung.center", (rel: (1,0)), stroke: blue, mark: (end: "barbed"), name: "v")
    line("ladung.center", (rel: (0,-0.7)), stroke: red, mark: (end: "barbed"), name: "F")

    content((0.1, 1.25), text(fill: aqua)[$arrow(B)$], anchor: "west", padding: 1pt)
    content("v.50%", text(fill: blue)[$arrow(v)$], anchor: "north", padding: 2pt)
    content("F.80%", text(fill: red)[$arrow(F)_L$], anchor: "west", padding: 2pt)
    content("ladung", [$-q$], anchor: "south", padding: 3pt)

    cetz.angle.angle("v.start", "F", "v", radius: 0.2, label: box(baseline: -0.2em)[$dot$], label-radius: 0.12)
  })
], [$q$], [bewegte Ladung], [$[q]=qty("1", "C")$],
text(fill: blue)[$v$], [Geschwindigkeit des Teilchens], [$[v]=qty("1", "m/s")$],
text(fill: aqua)[$B$#v(1em)], [magnetische Flussdichte], [$[T]=qty("1", "T")$],

[Stromdurchfl. Leiter <F_Leiter>], grid.cell(colspan: 2)[$#text(fill: red)[$F$]=#text(fill: red)[$I$]#text(fill: green)[$l$]#text(fill: aqua)[$B$]$], [$[F]=qty("1", "N")$],
grid.cell(rowspan: 3)[
  #cetz.canvas({
    import cetz.draw: *
    set-style(stroke: 0.5pt)

    for x in range(6){
      for y in range(4){
        content((x/2, y/2), text(fill: aqua)[$times.o$])
      }
    }
    
    // Draht

    group({
      line((1.18, -0.15), (rel: (0, 1.8)))
      line((1.32, -0.15), (rel: (0, 1.8)))
    }, name: "draht")
    
    line((-0.25, 0.2), (0, 0.2), stroke: white) // um das Bild wie oben auszurichten
    line("draht.center", (rel: (-1,0)), stroke: red, mark: (end: "barbed"), name: "F")
    line((v => cetz.vector.add(v, (0, -0.5)), "draht.center"), (v => cetz.vector.add(v, (0, 0.5)), "draht.center"), stroke: red, mark: (end: "barbed", scale: 0.5), name: "I")
    line((1.75, -0.12), (rel: (0, 1.7)), stroke: green, mark: (start: "|", end: "|"), name: "l")

    content((0.1, 1.25), text(fill: aqua)[$arrow(B)$], anchor: "west", padding: 1pt)
    content("F.50%", text(fill: red)[$arrow(F)$], anchor: "north", padding: 3pt)
    content("I.43%", text(fill: red)[$arrow(I)$], anchor: "west", padding: 3pt)
    content("l.48%", text(fill: green)[$l$], anchor: "west", padding: 3pt)

    cetz.angle.angle("F.start", "F", "I", radius: 0.25, label: box(baseline: -0.2em)[$dot$], label-radius: 0.16)
  })
], text(fill: red)[$I$], [Stromstärke im Leiter], [$[I]=qty("1", "A")$],
text(fill: green)[$l$], [Länge des Leiters im Magnetfeld], [$[l]=qty("1", "m")$], 
text(fill: aqua)[$B$#v(1em)], [magnetische Flussdichte], [$[T]=qty("1", "T")$],

grid.cell(rowspan: 4)[Magnetische Flussdichte eines Leiters \ 
  #cetz.canvas({
    import cetz.draw: *
    set-style(stroke: 0.5pt)

    group({
      line((1.18, -1), (rel: (0, 1.6)))
      line((1.32, -1), (rel: (0, 1.6)))
    }, name: "draht")

    line((-0.25, 0.2), (0, 0.2), stroke: white) // um das Bild wie oben auszurichten

    arc((1.18, 0.2), start: 96deg, delta: 130deg, radius: (1, 0.4), stroke:aqua, mark: (end: "barbed", slant: -0.4))
    arc((), start: 96deg+130deg, delta: 180deg, radius: (1, 0.4), stroke:aqua, mark: (end: "barbed", slant: -0.5), name: "B")
    arc((), start: 96deg+310deg, delta: 42deg, radius: (1, 0.4), stroke:aqua)

    line("draht.center", (rel: (0, 0.5)), stroke: red, mark: (end: "barbed", scale: 0.5))
    line("draht.center", (rel: (0, -0.3)), stroke: red)
    line("draht.center", (rel: (330deg, 0.66)), stroke: green, name: "r")

    content("B.end", text(fill: aqua)[$arrow(B)$], anchor: "south-west", padding: 2pt)
    content("draht.center", text(fill: red)[$arrow(I)$], anchor: "east", padding: 4pt)
    content("r", text(fill: green)[$r$], anchor: "south-west", padding: 1pt)
    
  })
], grid.cell(colspan: 2)[$#text(fill: aqua)[$B$]=mu_0 #text(fill: red)[$I$]/(2 pi #text(fill: green)[$r$])$], [$[B]=qty("1", "T")$],
text(fill: red)[$I$], [Stromstärke], [$[I]=qty("1", "A")$],
text(fill: green)[$r$], [Abstand $perp$ zum Leiter], [$[r]=qty("1", "m")$],
[$mu_0$], grid.cell(colspan: 2)[magnetische Feldkonstante \ $mu_0=4 pi dot 10 ^(-7) unit("V s / A / m")$#v(1em)],

grid.cell(rowspan: 5)[Magnetische Flussdichte einer schlanken Spule \ 
  #place(dx: 0.25cm, dy: 1em)[
    #cetz.canvas({
      import cetz.draw: *
      set-style(stroke: 0.5pt)
  
      cetz.decorations.coil(line((), (rel: (2, 0))), segments: 11)
      line((0, -0.5), (0, 0), stroke: red, mark: (start: "barbed", scale: 0.5), name: "I")
      line((0, -1), (0, -0.5))
      line((2.01, 0), (2, -1))
      line((0.2, -0.7), (rel: (1.6, 0)), stroke: green, mark: (symbol: "|"), name: "l")

      for draht in range(11){
        line((draht/5.76+0.015, 0), (rel: (0.14, 0)), stroke: aqua)
      }
      line((), (rel: (0.3, 0)), stroke: aqua, mark: (end: "barbed", scale: 0.5), name: "B")
      line((-0.2, 0), (-0.01, 0), stroke: aqua)
      
      content("I.50%", text(fill: red)[$arrow(I)$], anchor: "east", padding: 2pt)
      content("l.50%", text(fill: green)[$l$], anchor: "north", padding: 2pt)
      content("B.end", text(fill: aqua)[$arrow(B)$], anchor: "south-west", padding: 2pt)
      content((1, 0.7), $N=10$)
    })
  ]
], grid.cell(colspan: 2)[$#text(fill: aqua)[$B$]=mu_0 N/#text(fill: green)[$l$] #text(fill: red)[$I$]$], [$[B]=qty("1", "T")$],
text(fill: red)[$I$], [Stromstärke], [$[I]=qty("1", "A")$],
[$N$], [Windungszahl], [$[N]=num("1")$],
text(fill: green)[$l$], [Länge der Spule], [$[l]=qty("1", "m")$],
[$mu_0$], grid.cell(colspan: 2)[magnetische Feldkonstante \ $mu_0=4 pi dot 10 ^(-7) unit("V s / A / m")$#v(1em)],

grid.cell(rowspan: 3)[Magnetischer Fluss \
#align(center)[
  #cetz.canvas({
      import cetz.draw: *
  
      set-style(stroke: (thickness: 0.5pt, cap: "round"))
      ortho(name: "skizze", 
        //x: 0deg, 
        y: 60deg,
        z: 10deg,
        {
        on-yz({
          rotate(x: -40deg)
          rect((0, 0.6), (rel: (0.6, 0.4)), stroke: red, fill: red.transparentize(50%))
          on-layer(1,line((0.6, 0.6), (rel: (0, 0.4)), (rel: (-0.6, 0)), stroke: red))
        })
        on-xz({
          rect((1, 0), (rel: (0.6, 0.6)))
        })
        for x in (-0.2, 0, 0.2){
          for z in (-0.2, 0, 0.2){       
            let a = (x + 0.2)*0.5 + 0.7
            line((x + 1.3, 0, z + 0.3),(rel: cetz.vector.scale((-1.3, 1, 0), a)), stroke: aqua, mark: (end: "barbed", scale: 0.2))
          }
        }
        
      })
      
      content((0.4, 0.4), [#std.rotate(27deg)[#skew(ay:-50deg)[#text(fill: red, size: 6pt)[$A$]]]]) 
      // content((0.6, 0), [#std.rotate(-12deg)[#skew(ax:20deg)[#text(fill: aqua)[$arrow(B)$]]]]) // otho-B
      content((0.6, 0), text(fill: aqua)[$arrow(B)$])
      content((1, -0.45), [#std.rotate(-17deg)[#skew(ax:40deg)[#text(size: 5pt)[Spule]]]])
    })
  ]
], grid.cell(colspan: 2)[$italic(Phi)=#text(fill: red)[$A$]#text(fill: aqua)[$B$]$], [$[italic(Phi)]=qty("1", "Wb")$],
text(fill: red)[$A$], [Fläche $perp$ zum Magnetfeld], [$[A]=qty("1", "m^2")$],
text(fill: aqua)[$B$#v(1em)], [magnetische Flussdichte], [$[B]=qty("1", "T")$],

grid.cell(rowspan: 4)[Induktionsgesetz \
  #cetz.canvas({
    import cetz-plot: *
    import cetz.draw: *
    
    set-style(axes: (overshoot: 5pt, shared-zero: false, stroke: 0.5pt, tick: (stroke: 0.5pt), x: (mark: (end: "barbed", scale: 0.7)), y: (mark: (end: "barbed", scale: 0.7))), stroke: 0.5pt)

    plot.plot(axis-style: "school-book", size: (2,1), x-tick-step: none, y-tick-step: none, x-label: [$t$], y-label: text(size: 8pt, fill: blue)[$U_"ind"$], name: "Fs", {
      plot.add(((0, 0), (0.2,0.8), (0.8, 0.8), (1, 0)), style: (stroke: black))
      plot.add(((0, -0.5), (0.2, -0.5), (0.2, 0), (0.8, 0), (0.8, 0.5), (1, 0.5), (1, 0)), style: (stroke: blue))
      plot.add(((0.2, 0), (0.2, 0.8)), style: (stroke: (paint: black, dash: "dashed")))
      plot.add(((0.8, 0), (0.8, 0.8)), style: (stroke: (paint: black, dash: "dashed")))
    })
    content((0.22, 1.32), text(size: 8pt)[$italic(Phi)$])
  })
], grid.cell(colspan: 2)[$#text(fill: blue)[$U_"ind"$]=-N (Delta italic(Phi))/(Delta t)=-N dot(italic(Phi))$], [$[U_"ind"]=qty("1", "V")$],
[$-$], grid.cell(colspan: 2)[Vorzeichen: #smallcaps[Lenz]sche Regel],
[$N$], [Windungszahl der Spule], [$[N]=1$],
[$(Delta italic(Phi))/(Delta t)$], [zeitliche Änderung des magnetischen Flusses], [$[(Delta italic(Phi))/(Delta t)]=qty("1", "V")$]
)

#pagebreak()

= Schwingungen und Wellen

== Harmonische Schwingung

#grid(columns: (1fr, 1fr, 1fr), gutter: 10pt,
  // x-t-Diagramm
  [#cetz.canvas({
    import cetz-plot: *
    import cetz.draw: *
    
    set-style(axes: (overshoot: 7pt, shared-zero: false, stroke: 0.5pt, tick: (stroke: 0.5pt), x: (mark: (end: "barbed")), y: (mark: (end: "barbed"))), stroke: 0.5pt)

    plot.plot(axis-style: "school-book", size: (2,1.5), x-tick-step: none, y-tick-step: none, x-label: [$t$], y-label: text(fill: green)[$y$], x-ticks: ((2*calc.pi, [$T$]), ), y-ticks: ((1, [#text(fill: green)[$hat(y)$]]), ), name: "yt", {
      plot.add(y => (calc.sin(y - calc.pi/2)), domain: (0, 2.5*calc.pi), style: (stroke: green))
      plot.add(((0, 1), (calc.pi, 1)), style: (stroke: (paint: green, dash: "dotted")))
      plot.add(((0, 0), (calc.pi/2, 0)), style: (stroke: winkel.lighten(50%)))
      plot.add-anchor("phi_0", (calc.pi/4, 0))
    })
    content("yt.phi_0", text(fill: winkel)[$phi_0$], anchor: "south", padding: 2pt)
  })],
  // v-t-Diagramm
  [#cetz.canvas({
    import cetz-plot: *
    import cetz.draw: *
    
    set-style(axes: (overshoot: 7pt, shared-zero: false, stroke: 0.5pt, tick: (stroke: 0.5pt), x: (mark: (end: "barbed")), y: (mark: (end: "barbed"))), stroke: 0.5pt)

    plot.plot(axis-style: "school-book", size: (2,1.5), x-tick-step: none, y-tick-step: none, x-label: [$t$], y-label: text(fill: blue)[$v$], x-ticks: ((2*calc.pi, [$T$]), ), y-ticks: ((1, [#text(fill: purple)[$omega$]#text(fill: green)[$hat(y)$]]), ), name: "vt", {
      plot.add(y => (calc.cos(y - 0.5*calc.pi)), domain: (0, 2.5*calc.pi), style: (stroke: blue))
      plot.add(((0, 1), (calc.pi/2, 1)), style: (stroke: (paint: blue, dash: "dotted")))
      plot.add(((0, 0), (calc.pi/2, 0)), style: (stroke: winkel.lighten(50%)))
      plot.add-anchor("phi_0", (calc.pi/4, 0))
      plot.add(((calc.pi/2, 0), (calc.pi/2, 1)), style: (stroke: (paint: black, dash: "dotted")))
    })
    content("vt.phi_0", text(fill: winkel)[$phi_0$], anchor: "north")
  })],
  // a-t-Diagramm
  [#cetz.canvas({
    import cetz-plot: *
    import cetz.draw: *
    
    set-style(axes: (overshoot: 10pt, shared-zero: false, stroke: 0.5pt, tick: (stroke: 0.5pt), x: (mark: (end: "barbed")), y: (mark: (end: "barbed"))), stroke: 0.5pt)

    plot.plot(axis-style: "school-book", size: (2,1.5), x-tick-step: none, y-tick-step: none, x-label: [$t$], y-label: text(fill: red)[$a$], x-ticks: ((2*calc.pi, [$T$]), ), y-ticks: ((1, [$#text(fill: purple)[$omega$]^2$#text(fill: green)[$hat(y)$]]), ), name: "at", {
      plot.add(y => (-calc.sin(y - 0.5*calc.pi)), domain: (0, 2.5*calc.pi), style: (stroke: red))
      plot.add(((0, 0), (calc.pi/2, 0)), style: (stroke: winkel.lighten(50%)))
      plot.add-anchor("phi_0", (calc.pi/4, 0))
    })
    content("at.phi_0", text(fill: winkel)[$phi_0$], anchor: "north")  
  })])
#v(-.5em)
#grid(..standard,
[Frequenz], grid.cell(colspan: 2)[$f=1/T$], [$[f]=qty("1", "Hz")$],
[$$#v(1em)], [$T$], [Periode/Schwingungsdauer], [$[T]=qty("1", "s")$],

[Kreisfrequenz#v(1em)], grid.cell(colspan: 2)[$#text(fill: purple)[$omega$]=(2 pi)/T=2 pi f$], [$[omega]=qty("1", "1/s")$],

[Elongation], grid.cell(colspan: 2)[$#text(fill: green)[$y$]=#text(fill: green)[$hat(y)$] sin(#text(fill: purple)[$omega$] t - #text(fill: winkel)[$phi_0$])$], [$[y]=qty("1", "m")$],
[], text(fill: green)[$hat(y)$], [Amplitude], [$[hat(y)]=qty("1", "m")$],
[$$#v(1em)], text(fill: winkel)[$phi_0$], [Nullphase], [$[phi_0]=1$],

[Geschwindigkeit#v(1em)], grid.cell(colspan: 2)[$#text(fill: blue)[$v$]=#text(fill: purple)[$omega$]#text(fill: green)[$hat(y)$] cos (#text(fill: purple)[$omega$] t - #text(fill: winkel)[$phi_0$])$], [$[v]=qty("1", "m/s")$],

[Beschleunigung#v(1em)], grid.cell(colspan: 2)[$#text(fill: red)[$a$]=-#text(fill: purple)[$omega$]^2#text(fill: green)[$hat(y)$]sin (#text(fill: purple)[$omega$] t - #text(fill: winkel)[$phi_0$])$], [$[a]=qty("1", "m/s^2")$],

[Kraftgesetz], grid.cell(colspan: 2)[$#text(fill: red)[$arrow(F)$]=-k#text(fill: green)[$arrow(y)$]$], [$[F]=qty("1", "N")$],
[$$#v(1em)], [$k$], [Richtgrösse], [$[k]=qty("1", "N/m")$],

[Schwingungsdauer], grid.cell(colspan: 2)[$T=2 pi sqrt(m/k)$], [$[T]=qty("1", "s")$],
[], [$m$], [Masse des Schwingers], [$[m]=qty("1", "kg")$],
[$$#v(1em)], [$k$], [Richtgrösse], [$[k]=qty("1", "N/m")$],

[- Federpendel], grid.cell(colspan: 2)[$T=2 pi sqrt(m/D)$], [$[T]=qty("1", "s")$],
[], [$m$], [Masse des Schwingers], [$[m]=qty("1", "kg")$],
[$$#v(1em)], [$D$], [Federkonstante/Federhärte], [$[D]=qty("1", "N/m")$],

[- Fadenpendel], grid.cell(colspan: 2)[$T=2 pi sqrt(#text(fill: green)[$l$]/#text(fill: red)[$g$])$], [$[T]=qty("1", "s")$],
[], text(fill: green)[$l$], [Fadenlänge], [$[l]=qty("1", "m")$],
[], text(fill: red)[$g$], [Ortsfaktor/Fallbeschleunigung#linebreak()$qty("9.81","N/kg")=qty("9.81","m/s^2")$], [$[g]=qty("1", "m/s^2")$]
)

#pagebreak()

== Harmonische Welle

#grid(..standard,
[Wellenlänge], grid.cell(colspan: 2)[$lambda=c/f$], [$[lambda]=qty("1", "m")$],
[], [$c$], [Ausbreitungsgeschwindigkeit \ Licht: $c=qty("299792458", "m/s")$ \ Schall: $c=qty("340", "m/s")$ bei $qty("20", "Celsius")$#v(1em)], [$[c]=qty("1", "m/s")$],

[Wellenfunktion], grid.cell(colspan: 3)[$#text(fill: green)[$y$] (x, t)=#text(fill: green)[$hat(y)$] sin (2 pi(t/T minus.plus x/lambda))$],
[], [$-$ \ $+$], grid.cell(colspan: 2)[$c$ in $x$-Achsenrichtung \ $c$ gegen $x$-Achsenrichtung],
[], text(fill: green)[$y$], [Elongation des Schwingers am Ort $x$ zur Zeit $t$], [$[y]=qty("1", "m")$],
[], text(fill: green)[$hat(y)$], [Amplitude], [$[hat(y)]=qty("1", "m")$],
[], [$T$], [Periode/Schwingungsdauer], [$[T]=qty("1", "s")$],
[$$#v(1em)], [$lambda$], [Wellenlänge], [$[lambda]=qty("1", "m")$],

[Superposition#v(1em)], grid.cell(colspan: 2)[$#text(fill: green)[$y_"res"$] (x, t)=#text(fill: green)[$y_1$] (x,t)+#text(fill: green)[$y_2$] (x, t)$], [$[y_"res"]=qty("1", "m")$],

[Schwebung], grid.cell(colspan: 2)[$f_"Schwebung"=| f_1-f_2 |$], [$[f]=qty("1", "Hz")$],
[], grid.cell(colspan: 2)[$f_"res"=(f_1+f_2)/2$], [$[f_"res"]=qty("1", "Hz")$],
[], [$f_i$], [Frequenz der einzelnen Schwingungen#v(1em)], [$[f_i]=qty("1", "Hz")$],

[Stehende Welle#v(1em)], grid.cell(colspan: 2)[$#text(fill: green)[$y$] (x,t)={2#text(fill: green)[$hat(y)$] cos(2 pi x/lambda)}{sin (2 pi t/T)}$], [$[y]=qty("1", "m")$],

[#smallcaps[Doppler]effekt], grid.cell(colspan: 2)[$f_B=f_S (c plus.minus #text(fill: blue)[$v_B$])/(c minus.plus #text(fill: blue)[$v_S$])$], [$[f_B]=qty("1", "Hz")$],
[], grid.cell(colspan: 3)[oberes Vorzeichen, falls die Geschwindigkeit zum anderen Objekt zeigt: 
  #cetz.canvas({
    import cetz.draw: *
    set-style(stroke: 0.5pt)

    let mach = 0.4
    let c = 0.15

    for i in range(5){
      circle((-i*c*mach, 0), radius: i*c, stroke: gray)
    }

    // Sender
    circle((0, 0), radius: 1pt, fill: black, name: "S")
    line((0, 0), (rel: (1, 0)), stroke: blue, mark: (end: "barbed", scale: 0.5), name: "vS")

    // Beobachter
    circle((1.5, 0), radius: 1pt, fill: black, name: "B")
    line((), (rel: (0.5, 0)), stroke: blue, mark: (end: "barbed", scale: 0.5), name: "vB")
    
    content("S", [$S$], anchor: "south", padding: 3pt) 
    content("vS.70%", text(fill: blue)[$v_S$], anchor: "north")
    content("B", [$B$], anchor: "south", padding: 3pt)
    content("vB.50%", text(fill: blue)[$v_B$], anchor: "north")
    content((4, 0), [hier: $f_B=f_S (c + #text(fill: blue)[$v_B$])/(c + #text(fill: blue)[$v_S$])$])
  })

],
[], [$f_B$], [beobachtete Frequenz], [$[f_B]=qty("1", "Hz")$],
[], [$f_S$], [Senderfrequenz], [$[f_S]=qty("1", "Hz")$],
[], text(fill: blue)[$v_B$], [Geschwindigkeit des Beobachters], [$[v_B]=qty("1", "m/s")$],
[], text(fill: blue)[$v_S$], [Geschwindigkeit des Senders], [$[v_S]=qty("1", "m/s")$]
)

#pagebreak()

== Interferenz

#grid(..standard, 
[konstruktive Interferenz], grid.cell(colspan: 3)[$#text(fill: green)[$Delta s$]=n lambda$],
[destruktive Interferenz], grid.cell(colspan: 3)[$#text(fill: green)[$Delta s$]=(2 n+1)/2 lambda$],
grid.cell(rowspan: 3)[
  #cetz.canvas({
    import cetz-plot: *
    import cetz.draw: *
    
    set-style(axes: (overshoot: 10pt, shared-zero: false, stroke: 0.5pt, tick: (stroke: 0.5pt), x: (mark: (end: "barbed")), y: (mark: (end: "barbed"))), stroke: 0.5pt)

    plot.plot(axis-style: "school-book", size: (2,1), x-tick-step: none, y-tick-step: none, x-label: [$x$], y-label: [$y$], x-ticks: ((2*calc.pi, [$lambda$]), ), y-ticks: ((1, [$hat(y)$]), ), name: "at", {
      plot.add(y => (calc.sin(y - calc.pi)), domain: (0, 2.5*calc.pi), style: (stroke: blue))
      plot.add(y => (calc.sin(y)), domain: (0, 2.5*calc.pi), style: (stroke: red))
      plot.add(((0, 0), (calc.pi, 0)), style: (stroke: green))
      plot.add(((0, 1), (2.5*calc.pi, 1)), style: (stroke: (paint: black, dash: "dotted")))
      plot.add-anchor("deltaS", (calc.pi/2, 0))
    })
    content("at.deltaS", text(fill: green)[$Delta s$], anchor: "north", padding: 2pt)  
  })
], text(fill: green)[$Delta s$], [Gangunterschied], [$[Delta s]=qty("1", "m")$],
[$lambda$], [Wellenlänge], [$[lambda]=qty("1", "m")$],
grid.cell(colspan: 3)[$n in NN_0$#v(1em)],

[Beugungsmaximum], grid.cell(colspan: 3)[$sin alpha=#text(fill: green)[$Delta s$]/#text(fill: green)[$d$]$], 
grid.cell(rowspan: 2)[
  #cetz.canvas({
    import cetz.draw: *
    set-style(stroke: 0.5pt)

    let alfa = 30deg
    let d = 1.4
    let deltaS = calc.sin(alfa)*d

    on-layer(2,circle((), radius: 1pt, fill: black, name: "q1"))
    cetz.decorations.wave(line("q1.center", (alfa, 1.5 + deltaS)), amplitude: 0.3, segment-length: deltaS, stroke: red)
    
    on-layer(2,circle((0, d), radius: 1pt, fill: black, name: "q2"))
    cetz.decorations.wave(line("q2.center", (rel: (alfa, 1.5))), amplitude: 0.3, segment-length: deltaS, stroke: red)
    
    line((0,d/2), (rel: (alfa, 1.5 + deltaS/2)), stroke: (paint: gray, dash: "dash-dotted"), name: "richtung")
    line((0, d/2), (rel: (0.6, 0)), stroke: (paint: gray, dash: "dash-dotted"), name: "lot")

    hide(line("q1.center", (rel: (alfa, deltaS)), name: "delta"))
    line((), ("q2.center"), stroke: (dash: "dotted"), name: "parallel")
    line("q1.center", "delta.end", stroke: green, name: "deltaS")
    on-layer(-1,line("q1.center", "q2.center", stroke: green, name: "d"))

    cetz.angle.angle("d", "lot", "richtung", radius: 0.6, label-radius: 0.45, label: box(baseline: -0.2em)[$alpha$])

    cetz.angle.angle("q2.center", "d", "parallel", radius: 0.5, label-radius: 0.35, label: box(baseline: -0.2em)[$alpha$])
    
    content("d", text(fill: green)[$d$], anchor: "east", padding: 3pt) 
    content("deltaS", text(fill: green)[$Delta s$], anchor: "north-west")
  })
], 
text(fill: green)[$Delta s$], [Gangunterschied], [$[Delta s]=qty("1", "m")$],
text(fill: green)[$d$#v(1em)], [Abstand zwischen den Quellen], [$[d]=qty("1", "m")$],

[Beugung am Doppelspalt], grid.cell(colspan: 2)[$#text(fill: green)[$d$]=(lambda #text(fill: blue)[$l$])/#text(fill: red)[$s$]$], [$[d]=qty("1", "m")$],
grid.cell(rowspan: 4)[
  #cetz.canvas({
    import cetz.draw: *
    set-style(stroke: 0.5pt)

    line((), (0, .3), stroke: 2pt)
    line((0, .35), (0, 0.7), stroke: 2pt)
    line((0, .75), (0, 1.1), stroke: 2pt)

    line((-0.25, .325), (-0.25, .725), stroke: green, mark: (symbol: "|"), name: "d")
    line((2.5, -.25), (2.5, 1.35), name: "schirm")
    line((0, -0.125), (2.5, -0.125), stroke: blue, mark: (symbol: "|"), name: "l")

    for y in (0, .45, .9){
      line((2.5, y), (rel: (0, .2)), stroke: red + 1pt)
    }

    line((2.75, .55), (2.75, 1), stroke: red, mark: (symbol: "|"), name: "s")

    line((0, .55), (2.5, .55), stroke: (paint: gray, dash: "dash-dotted"), name: "lot")
    on-layer(-1,line((0, .55), (2.5, 1), stroke: (paint: red, dash: "dotted"), name: "rot"))

    cetz.angle.angle("rot.start", "lot", "rot", radius: 1.3, label-radius: 1.15, label: box(baseline: -0.2em)[$alpha$])
    
    content("d", text(fill: green)[$d$], anchor: "east", padding: 3pt) 
    content("l", text(fill: blue)[$l$], anchor: "north", padding: 1pt)
    content("s.60%", text(fill: red)[$s$], anchor: "west", padding: 2pt)
  })
], 
[$lambda$], [Wellenlänge], [$[lambda]=qty("1", "m")$],
text(fill: blue)[$l$], [Abstand zum Schirm], [$[l]=qty("1", "m")$],
text(fill: red)[$s$#v(1em)], [Abstand zwischen 2 Maxima], [$[s]=qty("1", "m")$]
)

== Akustik

=== Saiteninstrument

#grid(..standard, 
[Grundfrequenz], grid.cell(colspan: 2)[$#text(fill: red)[$f_0$]=c/(2 #text(fill: green)[$l$])$], [$[f_0]=qty("1", "Hz")$],
grid.cell(rowspan: 2)[
#align(left)[
  #cetz.canvas({
    import cetz-plot: *
    import cetz.draw: *
    
    set-style(stroke: 0.5pt)

    plot.plot(axis-style: none, size: (2,0.5), {
      plot.add(calc.sin, domain: (0, calc.pi), style: (stroke: red))
      plot.add(y => (-calc.sin(y)), domain: (0, calc.pi), style: (stroke: red))
      plot.add(y => (0.5*calc.sin(2*y)), domain: (0, calc.pi), style: (stroke: blue))
      plot.add(y => (-0.5*calc.sin(2*y)), domain: (0, calc.pi), style: (stroke: blue))
      plot.add(((calc.pi, -0.5), (calc.pi, 0.5)), style: (stroke: black + 1pt))
      plot.add(((0, -0.5), (0, 0.5)), style: (stroke: black + 1pt))

    })
    line((0, -0.4), (2, -0.4), stroke: green, mark: (symbol: "|"), name: "l")
    content("l.50%", text(fill: green)[$l$], anchor: "south", padding: 2pt)
  })
]
], [$c$], [Ausbreitungsgeschwindigkeit], [$[c]=qty("1", "m/s")$],
text(fill: green)[$l$#v(1em)], [Saitenlänge], [$[l]=qty("1", "m")$],

[Obertöne], grid.cell(colspan: 2)[$#text(fill: blue)[$f_n$]=(n+1)f_0$], [$[f_n]=qty("1", "Hz")$],
[$$#v(1em)], grid.cell(colspan: 3)[$n in NN$],

grid.cell(rowspan: 5)[Ausbreitungs-geschwindigkeit], grid.cell(colspan: 2)[$c=sqrt(#text(fill: red)[$F$]/(rho A))=sqrt(#text(fill: red)[$F$]/rho_L)$], [$[c]=qty("1", "m/s")$],
text(fill: red)[$F$], [Spannkraft], [$[F]=qty("1", "N")$],
[$rho$], [Dichte der Saite], [$[rho]=qty("1", "kg/m^3")$],
[$A$], [Querschnittsfläche der Saite], [$[A]=qty("1", "m^2")$],
[$rho_L$], [Längendichte der Saite], [$[rho_L]=qty("1", "kg/m")$]
)
#pagebreak()

=== Offene Pfeife

#grid(..standard, 
[Grundfrequenz], grid.cell(colspan: 2)[$#text(fill: red)[$f_0$]=c/(2 #text(fill: green)[$l$])$], [$[f_0]=qty("1", "Hz")$],
grid.cell(rowspan: 2)[
#align(left)[
  #cetz.canvas({
    import cetz-plot: *
    import cetz.draw: *
    
    set-style(stroke: 0.5pt)

    plot.plot(axis-style: none, size: (2,0.5), {
      plot.add(y => (calc.sin(y - calc.pi/2)), domain: (0, calc.pi), style: (stroke: red))
      plot.add(y => (-calc.sin(y - calc.pi/2)), domain: (0, calc.pi), style: (stroke: red))
      plot.add(y => (0.5*calc.sin(2*y - calc.pi/2)), domain: (0, calc.pi), style: (stroke: blue))
      plot.add(y => (-0.5*calc.sin(2*y - calc.pi/2)), domain: (0, calc.pi), style: (stroke: blue))
    })
    line((-0.3, -0.05), (0, 0.5), (0, -0.05), fill: gray)
    line((2, 0.55), (0, 0.55))
    line((-0.05, 0.55), (-0.5, 0.55), (-0.5, 0.3), (-0.7, 0.3))
    line((-0.7, 0.2), (-0.5, 0.2), (-0.5, -0.05), (2, -0.05))
    
    line((0, -0.4), (2, -0.4), stroke: green, mark: (symbol: "|"), name: "l")
    content("l.50%", text(fill: green)[$l$], anchor: "north", padding: 2pt)
  })
]
], [$c$], [Schallgeschwindigkeit \ $qty("340", "m/s")$ bei $qty("20", "Celsius")$], [$[c]=qty("1", "m/s")$],
text(fill: green)[$l$#v(1em)], [Länge der Luftsäule], [$[l]=qty("1", "m")$],

[Obertöne], grid.cell(colspan: 2)[$#text(fill: blue)[$f_n$]=(n+1)f_0$], [$[f_n]=qty("1", "Hz")$],
[$$#v(1em)], grid.cell(colspan: 3)[$n in NN$],
)

=== Gedackte Pfeife

#grid(..standard, 
[Grundfrequenz], grid.cell(colspan: 2)[$#text(fill: red)[$f_0$]=c/(4 #text(fill: green)[$l$])$], [$[f_0]=qty("1", "Hz")$],
grid.cell(rowspan: 2)[
#align(left)[
  #cetz.canvas({
    import cetz-plot: *
    import cetz.draw: *
    
    set-style(stroke: 0.5pt)

    plot.plot(axis-style: none, size: (1,0.5), {
      plot.add(y => (calc.sin(y - calc.pi/2)), domain: (0, calc.pi/2), style: (stroke: red))
      plot.add(y => (-calc.sin(y - calc.pi/2)), domain: (0, calc.pi/2), style: (stroke: red))
      plot.add(y => (0.5*calc.sin(3*y - calc.pi/2)), domain: (0, calc.pi/2), style: (stroke: blue))
      plot.add(y => (-0.5*calc.sin(3*y - calc.pi/2)), domain: (0, calc.pi/2), style: (stroke: blue))
    })
    line((-0.3, -0.05), (0, 0.5), (0, -0.05), fill: gray)
    line((1, 0.55), (0, 0.55))
    line((-0.05, 0.55), (-0.5, 0.55), (-0.5, 0.3), (-0.7, 0.3))
    line((-0.7, 0.2), (-0.5, 0.2), (-0.5, -0.05), (1, -0.05), (1, 0.55))
    line((0, -0.4), (1, -0.4), stroke: green, mark: (symbol: "|"), name: "l")
    content("l.50%", text(fill: green)[$l$], anchor: "north", padding: 2pt)
  })
]
], [$c$], [Schallgeschwindigkeit \ $qty("340", "m/s")$ bei $qty("20", "Celsius")$], [$[c]=qty("1", "m/s")$],
text(fill: green)[$l$#v(1em)], [Länge der Luftsäule], [$[l]=qty("1", "m")$],

[Obertöne], grid.cell(colspan: 2)[$#text(fill: blue)[$f_n$]=(2n+1)f_0$], [$[f_n]=qty("1", "Hz")$],
[$$#v(1em)], grid.cell(colspan: 3)[$n in NN$],
)

=== Tonsystem

#grid(..standard, 
[Tonintervall], grid.cell(colspan: 3)[$f_2/f_1$], 
[_$->$ @intervall _], [$f_1$], [Frequenz des Grundtons], [$[f_1]=qty("1", "Hz")$],
[$$#v(1em)], [$f_2$], [Frequenz des höheren Tons], [$[f_2]=qty("1", "Hz")$],
[Halbton (temperiert)#v(1em)], grid.cell(colspan: 3)[$f_2/f_1=root(12,2)$],
[Cent#v(1em)], grid.cell(colspan: 3)[$f_2/f_1=root(1200,2)$], 
[Kammerton a#v(1em)], grid.cell(colspan: 3)[$f_a=qty("440", "Hz")$],
[Lautstärke], grid.cell(colspan: 2)[$L=10 dot lg I/I_0$], [$[L]=qty("1", "dB")$],
[], [$I$], [Intensität des Klangs], [$[I]=qty("1", "W/m^2")$],
[], [$I_0$], [Intensität der Hörschwelle \ $I_0 = qty("1.0e-12", "W/m^2")$]
)

#pagebreak()

= Geometrische Optik

== Reflexion und Brechung

#align(center)[
  #cetz.canvas({
    import cetz.draw: *
    
    set-style(stroke: 0.5pt)

    let alpha1 = 50deg
    let n1 = 1.0
    let n2 = 1.5

    line((-4, 0), (4,0), stroke: 1pt, name: "oberfläche")
    line((0, -2), (0,2), stroke: (dash: "dashed"), name: "lot")
    circle((0, 0), radius: n2, stroke: gray, name: "glas")
    circle((), radius: n1, name: "luft")
    line((90deg + alpha1, n2 + 0.5), (0, 0), stroke: red, name: "einfallend")
    mark("einfallend.50%", (0, 0), symbol: "barbed", stroke: red)
    line((0, 0), (90deg - alpha1, n2 + 0.5), stroke: orange, name: "reflektiert")
    mark("reflektiert.50%", (90deg - alpha1, n2 + 0.5), symbol: "barbed", stroke: orange)
    line((0, 0), (-90deg + alpha1, n1), stroke: (dash: "dotted"))
    hide(line((), (rel: (0, -10)), name: "parallel"))
    intersections("i", "glas", "parallel")
    line((-90deg + alpha1, n1), "i.0", stroke: (dash: "dotted"))
    line((0, 0), ((0, 0), n2 + 0.5, "i.0"), stroke: fuchsia, name: "gebrochen")
    mark("gebrochen.50%", "i.0", symbol: "barbed", stroke: yellow)

    cetz.angle.angle((0, 0), (90deg, 1), "einfallend", radius: 0.6, stroke: red, label: box(baseline: -0.2em)[#text(fill: red)[$alpha_1$]], label-radius: 0.4)
    cetz.angle.angle((0, 0), "reflektiert", (90deg, 1), radius: 0.6, stroke: orange, label: box(baseline: -0.2em)[#text(fill: orange)[$alpha_r$]], label-radius: 0.4)
    cetz.angle.angle((0, 0), (-90deg, 1), "gebrochen", radius: 0.8, stroke: fuchsia, label: box(baseline: -0.2em)[#text(fill: fuchsia)[$alpha_2$]], label-radius: 0.6)
    
    content("einfallend.start", text(fill: red)[einfallender Strahl], anchor: "south-east", padding: 2pt)
    content("reflektiert.end", text(fill: orange)[reflektierter Strahl], anchor: "south-west", padding: 2pt)
    content("gebrochen.end", text(fill: fuchsia)[gebrochenener Strahl], anchor: "north-west", padding: 2pt)
    content("lot.end", [Lot], anchor: "south")
    content("luft.south-west", [$n_1$], anchor: "south-west")
    content("glas.south-west", text(fill: gray)[$n_2$], anchor: "north-east")
    content("oberfläche.90%", [Medium 1], anchor: "south", padding: 2pt)
    content("oberfläche.90%", text(fill: gray)[Medium 2], anchor: "north", padding: 2pt)
  })
]
#grid(..standard,
[Reflexionsgesetz], grid.cell(colspan: 3)[$#text(fill: orange)[$alpha_r$]=#text(fill: red)[$alpha_1$]$],
[], text(fill: red)[$alpha_1$], grid.cell(colspan: 2)[Einfallswinkel],
[$$#v(1em)], text(fill: orange)[$alpha_r$], grid.cell(colspan: 2)[Reflexionswinkel],

[Brechungsgesetz], grid.cell(colspan: 3)[$(sin #text(fill: red)[$alpha_1$])/(sin #text(fill: fuchsia)[$alpha_2$])=#text(fill: gray)[$n_2$]/n_1=c_1/#text(fill: gray)[$c_2$]$],
[_$->$ @n _], text(fill: fuchsia)[$alpha_2$], grid.cell(colspan: 2)[Brechungswinkel],
[], [$n_i$], [Brechzahlen der Medien], [$[n_i]=1$],
[$$#v(1em)], [$c_i$], [Lichtgeschwindigkeit in Medien], [$[c_i]=qty("1", "m/s")$],

[Grenzwinkel], grid.cell(colspan: 3)[$sin #text(fill: fuchsia)[$alpha_G$#v(1em)]=n_1/#text(fill: gray)[$n_2$]$ für $#text(fill: gray)[$n_2$]> n_1$]
)

=== Gekrümmter Spiegel

#grid(..standard,
[Brennweite], grid.cell(colspan: 2)[$f approx R/2$], [$[f]=qty("1", "m")$],
[$$], [$R$], [Krümmungsradius \ $R>0$: Hohlspiegel \ $R<0$: Wölbspiegel], [$[R]=qty("1", "m")$]
)

#grid(
  columns: (1fr, 1fr),
  align: center,
  [
    #cetz.canvas({
     import cetz.draw: *
      
      set-style(stroke: 0.5pt)
  
      let G = 0.5
      let g = 2.5
  
      line((-4, 0), (1,0), stroke: (dash: "dash-dotted"), name: "oA")

      on-layer(1, circle((-3, 0), radius: 1pt, fill: black, name: "M"))
      on-layer(1, circle((-1.5, 0), radius: 1pt, fill: black, name: "F"))
      line((0,-1.25), (0,1.25), name: "HE")
      line((-g, 0), (rel: (0, G)), stroke: 1pt, mark: (end: "barbed"), name: "G")
      intersections("i_b",
        hide(line("G.end", ("G.end", 4, "F"))),
        "HE"
      )
      // Brennstrahl
      line("G.end", "i_b.0", stroke: red)
      line("i_b.0", (rel: (-4, 0)), stroke: red, name: "brennstrahl")
      mark("brennstrahl.50%", (rel: (-1, 0)), symbol: "barbed", stroke: red)
      // Achsenparalleler Strahl
      line((-g, G), (0, G), stroke: blue)
      line((), ((), 4.2, "F"), stroke: blue, name: "achsenparallel")
      intersections("i", "brennstrahl", "achsenparallel")
      mark("achsenparallel.50%", "i.0", symbol: "barbed", stroke: blue)
      // Scheitelpunkt
      line("G.end", (0, 0), stroke: green)
      line((), ((), 4, "i.0"), stroke: green, name: "scheitelpunkt")
      mark("scheitelpunkt.50%", "i.0", symbol: "barbed", stroke: green)
      // Mittelpunktstrahl
      line("G.end", ("G.end", 2, "i.0"), stroke: purple, name: "mittelpunkt")
      mark("mittelpunkt.50%", "i.0", symbol: "barbed", stroke: purple)
      intersections("j", "oA", hide(line("i.0", (rel: (0, 3)))))
      line("i.0", "j.0", stroke: 1pt, mark: (start: "barbed"), name: "B")
      line("M", (rel: (0, -.9)), stroke: (dash: "dotted"))
      line((), (rel: (3,0)), mark: (symbol: "|"), name: "R")
      line("F", (rel: (0, 0.7)), stroke: (dash: "dotted"))
      line((), (rel: (1.5, 0)), mark: (symbol: "|"), name: "f")
      content("B.50%", [$B$], anchor: "east", padding: 3pt)
      content("G", [$G$], anchor: "west", padding: 3pt)
      content("M.north", [M], anchor: "south", padding: 2pt)
      content("F.south", [F], anchor: "north", padding: 2pt)
      content("f", [$f$], anchor: "south", padding: 2pt)
      content("R", [$R$], anchor: "north", padding: 2pt)
      content((-3, 1), [$B$: reell])
    })
  ],
  [
    #cetz.canvas({
     import cetz.draw: *
      
      set-style(stroke: 0.5pt)
  
      let G = 1
      let g = 1.3
  
      line((-1.7, 0), (3.5,0), stroke: (dash: "dash-dotted"), name: "oA")

      on-layer(1, circle((3, 0), radius: 1pt, fill: black, name: "M"))
      on-layer(1, circle((1.5, 0), radius: 1pt, fill: black, name: "F"))
      line((0,-1.25), (0,1.25), name: "HE")
      line((-g, 0), (rel: (0, G)), stroke: 1pt, mark: (end: "barbed"), name: "G")
      intersections("i_b",
        hide(line("G.end", ("G.end", 4, "F"))),
        "HE"
      )
      // Brennstrahl
      line("G.end", "i_b.0", stroke: red)
      line("i_b.0", (rel: (-2, 0)), stroke: red, name: "brennstrahl_r")
      mark("brennstrahl_r.50%", (rel: (-1, 0)), symbol: "barbed", stroke: red)
      line("i_b.0", "F", stroke: (paint: red, dash: "dotted"))
      // Achsenparalleler Strahl
      line((-g, G), (0, G), stroke: blue)
      line((), "F", stroke: (paint: blue, dash: "dashed"), name: "achsenparallel_i")
      line((0, G), ((0,G), -0.4, "F"), stroke: blue, name: "achsenparallel_r")
      mark("achsenparallel_r.90%", "achsenparallel_r.end", symbol: "barbed", stroke: blue)
      // Brennstrahl
      line("i_b.0", (rel: (1.7, 0)), stroke: (paint: red, dash: "dashed"), name: "brennstrahl_i")
      intersections("bild", "brennstrahl_i", "achsenparallel_i")     
      // Scheitelpunkt
      line("G.end", (0, 0), stroke: green)
      line((), ((), -2, "bild.0"), stroke: green, name: "scheitelpunkt_r")
      mark("scheitelpunkt_r", "scheitelpunkt_r.end", symbol: "barbed", stroke: green)
      line((0, 0), ((0, 0), 2, "bild.0"), stroke: (paint: green, dash: "dashed"))
      // Mittelpunktstrahl
      intersections("m", hide(line("G.end", "M")), "HE")
      line("G.end", "m.0", stroke: purple, name: "mittelpunkt_r")
      line("m.0", "M", stroke: (paint: purple, dash: "dashed"), name: "mittelpunkt_i")
      mark("mittelpunkt_r", "G.end", symbol: "barbed", stroke: purple)
      intersections("j", "oA", hide(line("bild.0", (rel: (0, -3)))))
      line("bild.0", "j.0", stroke: 1pt, mark: (start: "barbed"), name: "B")
      line("M", (rel: (0, -.7)), stroke: (dash: "dotted"))
      line((), (rel: (-3,0)), mark: (symbol: "|"), name: "R")
      line("F", (rel: (0, -0.5)), stroke: (dash: "dotted"))
      line((), (rel: (-1.5, 0)), mark: (symbol: "|"), name: "f")
      content("B.50%", [$B$], anchor: "east", padding: 3pt)
      content("G", [$G$], anchor: "west", padding: 3pt)
      content("M.north", [M], anchor: "south", padding: 2pt)
      content("F.north", [F], anchor: "south", padding: 2pt)
      content("f", [$f$], anchor: "south", padding: 2pt)
      content("R", [$R$], anchor: "north", padding: 2pt)
      content((2, 1), [$B$: virtuell])
    })
  #v(1em)],
  [Hohlspiegel ($R=qty("3", "cm")$)], [Wölbspiegel ($R=qty("-3", "cm")$)]
)
#pagebreak()

== Linsen

#grid(..standard,
[Brechkraft], grid.cell(colspan: 2)[$D=1/f$], [$[D]=qty("1", "dpt")$],
[$$#v(1em)], [$f$], [Brennweite], [$[f]=qty("1", "m")$],

[Dünne Linse], grid.cell(colspan: 2)[$D approx (1-n) (1/#text(fill: red)[$r_1$]+1/#text(fill: blue)[$r_2$])$], [$[D]=qty("1", "dpt")$],
grid.cell(rowspan: 2)[
  #cetz.canvas({
    import cetz.draw: *
      
    set-style(stroke: 0.5pt)

    let r_1 = 1
    let r_2 = 1.5

    let M_1 = (-1, 0)

    line((-2, 0), (0.5,0), stroke: (dash: "dash-dotted"), name: "oA")

    on-layer(1, circle(M_1, radius: 1pt, stroke: red, fill: red, name: "M_1"))

    scope({
      set-origin(M_1)
      arc((-60deg, r_1), start: -60deg, delta: 120deg)
      intersections("i", hide(circle((-60deg, r_1), radius: r_2)), "oA")
      let M_2 = "i.0"
      arc-through((-60deg, r_1), (v => cetz.vector.add(v, (r_2, 0)), M_2), (60deg, r_1))

      on-layer(1, circle(M_2, radius: 1pt, stroke: blue, fill: blue, name: "M_2"))

      line(M_2, (rel: (-20deg, r_2)), stroke: blue, mark: (end: "barbed"), name: "r_2")

      content("r_2", text(fill: blue)[$r_2$], anchor: "north-east")
    })
    line(M_1, (rel: (40deg, r_1)), stroke: red, mark: (end: "barbed"), name: "r_1")
    content("r_1", text(fill: red)[$r_1$], anchor: "south-east")
    content((-2, 0.5), [$#text(fill: red)[$r_1$]>0$ \ $#text(fill: blue)[$r_2$]<0$])
  })
], [$n$], [Brechzahl des Linsenmaterials], [$[n]=1$],
[$r_i$], [Linsenradien \ $r_i>0$: konvexe Linsenoberfläche \ $r_i<0$: konkave Linsenoberfläche], [$[r_i]=qty("1", "m")$]
)

#grid(
  columns: (1fr, 1fr),
  align: center,
  [
    #cetz.canvas({
     import cetz.draw: *
      
      set-style(stroke: 0.5pt)
  
      let G = 0.5
      let g = 1.8
  
      line((-2.5, 0), (2.5,0), stroke: (dash: "dash-dotted"), name: "oA")

      on-layer(1, circle((-1, 0), radius: 1pt, fill: black, name: "F_1"))
      on-layer(1, circle((1, 0), radius: 1pt, fill: black, name: "F_2"))
      line((0,-1.5), (0,1.5), mark: (symbol: "barbed"), name: "HE")
      line((-g, 0), (rel: (0, G)), stroke: 1pt, mark: (end: "barbed"), name: "G")
      intersections("i_b",
        hide(line("G.end", ("G.end", 4, "F_1"))),
        "HE"
      )
      // Brennstrahl
      line("G.end", "i_b.0", stroke: red)
      line("i_b.0", (rel: (2.5, 0)), stroke: red, name: "brennstrahl")
      mark("brennstrahl.50%", (rel: (1, 0)), symbol: "barbed", stroke: red)
      // Achsenparalleler Strahl
      line((-g, G), (0, G), stroke: blue)
      line((), ((), 2.8, "F_2"), stroke: blue, name: "achsenparallel")
      intersections("i", "brennstrahl", "achsenparallel")
      mark("achsenparallel.60%", "i.0", symbol: "barbed", stroke: blue)
      // Scheitelpunkt
      line("G.end", (0, 0), stroke: green)
      line((), ((), 2.7, "i.0"), stroke: green, name: "scheitelpunkt")
      mark("scheitelpunkt.50%", "i.0", symbol: "barbed", stroke: green)
      // Bild
      intersections("j", "oA", hide(line("i.0", (rel: (0, 3)))))
      line("i.0", "j.0", stroke: 1pt, mark: (start: "barbed"), name: "B")
      line("F_1", (rel: (0, -.9)), stroke: (dash: "dotted"))
      line((), (rel: (1,0)), mark: (symbol: "|"), name: "f_1")
      line("F_2", (rel: (0, 0.9)), stroke: (dash: "dotted"))
      line((), (rel: (-1, 0)), mark: (symbol: "|"), name: "f_2")
      content("B.50%", [$B$], anchor: "east", padding: 3pt)
      content("G", [$G$], anchor: "west", padding: 3pt)
      content("F_1.south", [$"F"_1$], anchor: "north", padding: 2pt)
      content("F_2.north", [$"F"_2$], anchor: "south", padding: 2pt)
      content("f_1", [$f$], anchor: "south", padding: 2pt)
      content("f_2", [$f$], anchor: "north", padding: 2pt)
      content((2, 1), [$B$: reell])
    })
  ],
  [
    #cetz.canvas({
     import cetz.draw: *
      
      set-style(stroke: 0.5pt, scale: 0.7)
  
      let G = 1
      let g = 2
  
      line((-2.5, 0), (2.5,0), stroke: (dash: "dash-dotted"), name: "oA")

      on-layer(1, circle((-1, 0), radius: 1pt, fill: black, name: "F_2"))
      on-layer(1, circle((1, 0), radius: 1pt, fill: black, name: "F_1"))
      line((0,-1.3), (0,1.3), mark: (symbol: "barbed", reverse: true), name: "HE")
      line((-g, 0), (rel: (0, G)), stroke: 1pt, mark: (end: "barbed"), name: "G")
      intersections("i_b",
        hide(line("G.end", ("G.end", 4, "F_1"))),
        "HE"
      )
      // Brennstrahl
      line("G.end", "i_b.0", stroke: red)
      line("i_b.0", (rel: (2, 0)), stroke: red, name: "brennstrahl_r")
      mark("brennstrahl_r.50%", (rel: (1, 0)), symbol: "barbed", stroke: red)
      line("i_b.0", "F_1", stroke: (paint: red, dash: "dotted"))
      line("i_b.0", (rel: (-2.5, 0)), stroke: (paint: red, dash: "dashed"), name: "brennstrahl_i")
      // Achsenparalleler Strahl
      line((-g, G), (0, G), stroke: blue)
      line((), "F_2", stroke: (paint: blue, dash: "dashed"), name: "achsenparallel_i")
      line((0, G), ((0,G), -0.6, "F_2"), stroke: blue, name: "achsenparallel_r")
      mark("achsenparallel_r.70%", "achsenparallel_r.end", symbol: "barbed", stroke: blue)
      intersections("bild", "brennstrahl_i", "achsenparallel_i")
      // Scheitelpunkt
      line("G.end", (0, 0), stroke: green)
      line((), ((), -2, "bild.0"), stroke: green, name: "scheitelpunkt_r")
      mark("scheitelpunkt_r", "scheitelpunkt_r.end", symbol: "barbed", stroke: green)
      // Bild
      intersections("j", "oA", hide(line("bild.0", (rel: (0, -3)))))
      line("bild.0", "j.0", stroke: 1pt, mark: (start: "barbed"), name: "B")
      line("F_1", (rel: (0, -.7)), stroke: (dash: "dotted"))
      line((), (rel: (-1,0)), mark: (symbol: "|"), name: "f_1")
      line("F_2", (rel: (0, -0.7)), stroke: (dash: "dotted"))
      line((), (rel: (1, 0)), mark: (symbol: "|"), name: "f_2")
      content("B.50%", [$B$], anchor: "east", padding: 3pt)
      content("G", [$G$], anchor: "west", padding: 3pt)
      content("F_1.south", [$"F"_1$], anchor: "north", padding: 2pt)
      content("F_2.south", [$"F"_2$], anchor: "north", padding: 2pt)
      content("f_1", [$f$], anchor: "north", padding: 2pt)
      content("f_2", [$f$], anchor: "north", padding: 2pt)
      content((1.5, 1), [$B$: virtuell])
    })
  #v(1em)],
  [Sammellinse ($f=qty("1", "cm")$)], [Streulinse ($f=qty("-1", "cm")$)#v(1em)]
)

== Abbildungsgleichungen

#grid(..standard,
[Linsen- & Spiegelformel], grid.cell(colspan: 3)[$1/#text(fill: green)[$f$]=1/#text(fill: red)[$g$]+1/#text(fill: blue)[$b$]$],
grid.cell(rowspan: 3)[
  #cetz.canvas({
     import cetz.draw: *
      
      set-style(stroke: 0.5pt)
  
      let G = 1
      let g = 1.3
  
      line((-1.5, 0), (1.5,0), stroke: (dash: "dash-dotted"), name: "oA")

      on-layer(1, circle((-.5, 0), radius: 1pt, fill: black, name: "F_1"))
      on-layer(1, circle((.5, 0), radius: 1pt, fill: black, name: "F_2"))
      line((0,-1.5), (0,1.5), mark: (symbol: "barbed"), name: "HE")
      line((-g, 0), (rel: (0, G)), stroke: 1pt + red, mark: (end: "barbed"), name: "G")
      intersections("i_b",
        hide(line("G.end", ("G.end", 4, "F_1"))),
        "HE"
      )
      // Brennstrahl
      line("G.end", "i_b.0", stroke: gray)
      line("i_b.0", (rel: (1, 0)), stroke: gray, name: "brennstrahl")
      // Achsenparalleler Strahl
      line((-g, G), (0, G), stroke: gray)
      line((), ((), 2, "F_2"), stroke: gray, name: "achsenparallel")
      intersections("i", "brennstrahl", "achsenparallel")
      
      // Bild
      intersections("j", "oA", hide(line("i.0", (rel: (0, 3)))))
      line("i.0", "j.0", stroke: 1pt + blue, mark: (start: "barbed"), name: "B")
      line((), (0, 0), stroke: blue, name: "b")
      line((), (-g, 0), stroke: red, name: "g")
      line((-g, G), "i.0", stroke: gray)
      line("F_1", (rel: (0, -.7)), stroke: (dash: "dotted"))
      line((), (rel: (0.5,0)), stroke: green, mark: (symbol: "|"), name: "f")
      content("B.50%", text(fill: blue)[$B$], anchor: "west", padding: 3pt)
      content("G", text(fill: red)[$G$], anchor: "west", padding: 3pt)
      content("F_1.north", [$"F"_1$], anchor: "south", padding: 2pt)
      content("F_2.north", [$"F"_2$], anchor: "south", padding: 2pt)
      content("f", text(fill: green)[$f$], anchor: "north", padding: 2pt)
      content("g", text(fill: red)[$g$], anchor: "north", padding: 2pt)
      content("b", text(fill: blue)[$b$], anchor: "north", padding: 2pt)
    })
], text(fill: green)[$f$], [Brennweite \ $f>0$: Hohlspiegel, Sammellinse \ $f<0$: Wölbspiegel, Streulinse], [$[f]=qty("1", "m")$],
text(fill: red)[$g$], [Gegenstandsweite, $g>0$], [$[g]=qty("1", "m")$],
text(fill: blue)[$b$], [Bildweite \ $b>0$: reelles Bild \ $b<0$: virtuelles Bild#v(1em)], [$[b]=qty("1", "m")$],

[Abbildungsmassstab], grid.cell(colspan: 2)[$A=#text(fill: blue)[$B$]/#text(fill: red)[$G$]=#text(fill: blue)[$b$]/#text(fill: red)[$g$]$], [$[A]=1$],
[], text(fill: blue)[$B$], [Bildgrösse \ $B>0$: reelles Bild \ $B<0$: virtuelles Bild], [$[B]=qty("1", "m")$],
[$$#v(1em)], text(fill: red)[$G$], [Gegenstandsgrösse, $G>0$], [$[G]=qty("1", "m")$]
)

#pagebreak()

== Vergrösserung

#grid(..standard, 
[Definition], grid.cell(colspan: 2)[$V=(tan #text(fill: red)[$alpha'$])/(tan alpha)$], [$[V]=1$],
[], text(fill: red)[$alpha'$], grid.cell(colspan: 2)[Sehwinkel mit optischem Gerät], 
[#v(1em)], [$alpha$], grid.cell(colspan: 2)[Sehwinkel ohne optischem Gerät],

grid.cell(colspan: 4)[Lupe],
[- Auge entspannt], grid.cell(colspan: 2)[$V=s_0/#text(fill: green)[$f$]$], [$[V]=1$],
grid.cell(rowspan: 2)[
   #cetz.canvas({
     import cetz.draw: *
      
      set-style(stroke: 0.5pt)
  
      let G = 0.4
      let g = 0.5
  
      line((-0.8, 0), (2.5,0), stroke: (dash: "dash-dotted"), mark: (end: "barbed", scale: 2, stroke: (dash: none), width: 6pt), name: "oA")
      arc((2.12, 0.13), start: 160deg, delta: 40deg, radius: 0.39, name: "iris")
      on-layer(1, circle("iris.arc-center", radius: (0.5pt, 1.5pt), name: "auge"))

      on-layer(1, circle((-.5, 0), radius: 1pt, fill: black, name: "F_1"))
      on-layer(1, circle((.5, 0), radius: 1pt, fill: black, name: "F_2"))
      on-layer(1, line((0,-0.5), (0,.5), mark: (symbol: "barbed"), name: "HE"))
      line((-g, 0), (rel: (0, G)), stroke: 1pt + red, mark: (end: "barbed"), name: "G")
      line("G.end", "auge", stroke: gray, name: "alpha")
      line("G.end", (0, 0), stroke: red, name: "alpha_strich")
      line((0, 0), (-g, 0), stroke: green, name: "f")
      line("F_1", (rel: (0, -.59)), stroke: (dash: "dotted"))
      line((), (rel: (2.6,0)), mark: (symbol: "|"), name: "s_0")

      cetz.angle.angle((0, 0), "alpha_strich", (-180deg, 1), radius: 0.4, inner: true, stroke: red, label: box(baseline: -0.1em)[#text(fill: red, size: 6pt)[$alpha'$]], label-radius: 0.3)
      cetz.angle.angle("auge", "alpha", (-180deg, 1), radius: 1, inner: true, label: box(baseline: -0.15em)[#text(size: 6pt)[$alpha$]], label-radius: 0.9)
      content("G", text(fill: red)[$G$], anchor: "east", padding: 3pt)
      // content("F_1.north", [$"F"_1$], anchor: "south", padding: 2pt)
      content("f", text(fill: green)[$f$], anchor: "north", padding: 2pt)
      content("s_0", [$s_0$], anchor: "south", padding: 2pt)
      content((2.4, 0.3),text(fill: gray)[$oo$])
    })
], [$s_0$], [deutliche Sehweite], [$[s_0]=qty("1", "m")$],
text(fill: green)[$f$#v(1em)], [Brennweite der Lupe], [$[f]=qty("1", "m")$], 
[- Auge angespannt], grid.cell(colspan: 2)[$V=s_0/#text(fill: green)[$f$]+s_0/(s_0-d)$], [$[V]=1$],
grid.cell(rowspan: 3)[
   #cetz.canvas({
     import cetz.draw: *
      
      set-style(stroke: 0.5pt)
  
      let G = 0.62
      let g = 0.5
  
      line((-1, 0), (2.3,0), stroke: (dash: "dash-dotted"), mark: (end: "barbed", scale: 2, stroke: (dash: none), width: 6pt), name: "oA")
      arc((1.92, 0.13), start: 160deg, delta: 40deg, radius: 0.39, name: "iris")
      on-layer(1, circle("iris.arc-center", radius: (0.5pt, 1.5pt), name: "auge"))

      on-layer(1, circle((-.5, 0), radius: 1pt, fill: black, name: "F_1"))
      on-layer(1, circle((.5, 0), radius: 1pt, fill: black, name: "F_2"))
      on-layer(1, line((0,-0.5), (0,.5), mark: (symbol: "barbed"), name: "HE"))
      line((-g -0.2, 0), (rel: (0, G)), stroke: 1pt + blue, mark: (end: "barbed"), name: "B")
      line((-g +0.05, 0), (rel: (0, 0.4)), stroke: red, mark: (end: "barbed", scale: 0.5), name: "G")
      line("B.end", (0, 0), stroke: red, name: "alpha_strich")
      line((0, 0), (-g, 0), stroke: green, name: "f")
      line((-g -0.2, 0), (rel: (0, -.59)), stroke: (dash: "dotted"))
      line((), (rel: (2.6,0)), mark: (symbol: "|"), name: "s_0")
      line((0, 0), (rel: (0, .59)), stroke: (dash: "dotted"))
      line((), (rel: (1.9,0)), mark: (symbol: "|"), name: "d")

      cetz.angle.angle((0, 0), "alpha_strich", (-180deg, 1), radius: 0.4, inner: true, stroke: red, label: box(baseline: -0.1em)[#text(fill: red, size: 6pt)[$alpha'$]], label-radius: 0.3)
      content("G", text(fill: red, size: 8pt)[$G$], anchor: "east", padding: 1pt)
      content("B", text(fill: blue)[$B$], anchor: "east", padding: 3pt)
      content("f", text(fill: green)[$f$], anchor: "north", padding: 2pt)
      content("s_0", [$s_0$], anchor: "south", padding: 2pt)
      content("d", [$d$], anchor: "south", padding: 2pt)
      content((2.2, 0.3),text(fill: gray)[$s_0$])
    })  
], [$s_0$], [deutliche Sehweite], [$[s_0]=qty("1", "m")$],
text(fill: green)[$f$], [Brennweite der Lupe], [$[f]=qty("1", "m")$],
[$d$#v(1em)], [Abstand Auge -- Lupe], [$[d]=qty("1", "m")$],

[Mikroskop], grid.cell(colspan: 2)[$V=(s_0 t)/(#text(fill: fuchsia)[$f_"Ok"$] #text(fill: purple)[$f_"Ob"$])$], [$[V]=qty("1", "m")$],
grid.cell(rowspan: 4)[
     #cetz.canvas({
     import cetz.draw: *
      
      set-style(stroke: 0.5pt)
  
      let G = 0.2
      let g = 0.107
      let lampe = (0, -1)
      let f_l = 0.2
      let f_Ob = 0.1
      let f_Ok = 1

      // Optische Achse und Auge
      line((0, -1), (0, 2.7), stroke: (paint: gray, dash: "dash-dotted"), mark: (end: "barbed", scale: 2, stroke: (paint: black, dash: none), width: 6pt), name: "oA")
      arc((-0.13, 2.32), start: 250deg, delta: 40deg, radius: 0.39, name: "iris")
      on-layer(1, circle("iris.arc-center", radius: (1.5pt, .5pt), name: "auge"))     
      
      // Kondensor
      on-layer(1, circle(lampe, radius: 0.5pt, fill: green, stroke: green, name: "F_l2"))
      on-layer(1, circle((v => cetz.vector.add(v, (0, 2*f_l)), lampe), radius: 0.5pt, fill: green, stroke: green, name: "F_l1"))
      line((v => cetz.vector.add(v, (-0.25, f_l)), lampe), (rel: (0.5, 0)), mark: (symbol: "barbed", scale: 0.5), stroke: green, name: "kondensor")

      // Objektiv
      on-layer(1, line((-0.3,-0.4), (rel: (0.6, 0)), mark: (symbol: "barbed", scale: 0.5), name: "Ob"))
      on-layer(1, circle((v => cetz.vector.add(v, (0, f_Ob)), "Ob"), radius: 0.5pt, fill: black, name: "F_Ob1"))
      on-layer(1, circle((v => cetz.vector.add(v, (0, -f_Ob)), "Ob"), radius: 0.5pt, fill: black, name: "F_Ob2"))

      // Gegenstand
      line((v => cetz.vector.add(v, (-G/2, -g)), "Ob"), (rel: (G, 0)), stroke: red, mark: (end: "barbed", scale: 0.5), name: "G")

      // Zwischenbild
      let b = 1/(1/f_Ob - 1/g)
      let B = G * b/g
      
      line((v => cetz.vector.add(v, (-B/2, b)), "Ob"), (rel: (B, 0)), stroke: blue + 1pt, mark: (start: "barbed", scale: 0.5), name: "B")

      // Okular
      line((v => cetz.vector.add(v, (-0.5, b+f_Ok)), "Ob"), (rel: (1, 0)), mark: (symbol: "barbed", scale: 0.5), name: "Ok")
      circle((v => cetz.vector.add(v, (0, b)), "Ob"), radius: 0.5pt, fill: black, name: "F_Ok")

      // Lichtweg
      on-layer(-1, line(
        lampe, 
        (v => cetz.vector.add(v, (-G/2, f_l)), lampe),
        (-G/2, -0.4),
        "B.end",
        "B",
        "Ok.55%",
        (rel: (0, 0.15)),
        (v => cetz.vector.add(v, (0, 0.15)), "Ok.45%"),
        "Ok.45%",
        "B",
        "B.start",
        (G/2, -0.4),
        (v => cetz.vector.add(v, (G/2, f_l)), lampe),
        lampe,
        stroke: yellow, fill: yellow.transparentize(90%)
      ))
      
      // Lampe
      content(lampe, text(fill: yellow, baseline: -0.02em)[$times.o$])

      // Beschriftungen
      let t = b - f_Ob
      line("F_Ob1", (rel: (-0.8, 0)), stroke: (dash: "dotted"))
      line("Ob.start", (rel: (-0.5, 0)), stroke: (dash: "dotted"))   
      line((), (rel: (0, f_Ob)), mark: (symbol: "|"), stroke: purple, name: "f_Ob")
      line((), (rel: (0, t)), mark: (symbol: "|"), name: "t")
      line((), (rel: (0, f_Ok)), mark: (symbol: "|"), stroke: fuchsia, name: "f_Ok")
      line((), "Ok.start", stroke: (dash: "dotted"))
      
      content("G", text(fill: red)[$G$], anchor: "east", padding: 8pt)
      content("B.end", text(fill: blue)[$B$], anchor: "west", padding: 3pt)
      content("Ok.end", [Okular], anchor: "west", padding: 2pt)
      content("Ob.end", [Objektiv], anchor: "west", padding: 2pt)
      content("kondensor.end", text(fill: green)[Kondensor], anchor: "west", padding: 2pt)
      content("f_Ob", text(fill: purple)[$f_"Ob"$], anchor: "east", padding: 2pt)
      content("t", [$t$], anchor: "east", padding: 2pt)
      content("f_Ok", text(fill: fuchsia)[$f_"Ok"$], anchor: "east", padding: 2pt)
      content((0.3, 2.5),text(fill: gray)[$oo$])
    })  
], [$s_0$], [deutliche Sehweite], [$[s_0]=qty("1", "m")$],
[$t$], [optische Tubuslänge], [$[t]=qty("1", "m")$],
text(fill: purple)[$f_"Ob"$], [Brennweite des Objektivs], [$[f_"Ob"]=qty("1", "m")$],
text(fill: fuchsia)[$f_"Ok"$#v(1em)], [Brennweite des Okulars], [$[f_"Ok"]=qty("1", "m")$],

[Teleskop], grid.cell(colspan: 2)[$V=#text(fill: purple)[$f_"Ob"$]/#text(fill: fuchsia)[$f_"Ok"$]$], [$[V]=1$],
[], text(fill: purple)[$f_"Ob"$], [Brennweite des Objektivs], [$[f_"Ob"]=qty("1", "m")$],
[], text(fill: fuchsia)[$f_"Ok"$#v(1em)], [Brennweite des Okulars], [$[f_"Ok"]=qty("1", "m")$]
)

#align(center + horizon)[
  #cetz.canvas({
     import cetz.draw: *
      
      set-style(stroke: 0.5pt)
  
      let B = 2
      let f_Ob = 6
      let f_Ok = 2
  
      // Optische Achse und Auge
      line((-1 -f_Ob, 0), (.6 + f_Ok, 0), stroke: (dash: "dash-dotted"), mark: (end: "barbed", scale: 2, stroke: (dash: none), width: 6pt), name: "oA")
      arc((2.22, 0.13), start: 160deg, delta: 40deg, radius: 0.39, name: "iris")
      on-layer(1, circle("iris.arc-center", radius: (0.5pt, 1.5pt), name: "auge"))

      line((0, 0), (rel: (0, -B)), stroke: 1pt + blue, mark: (end: "barbed"), name: "B")

      on-layer(1, circle((0, 0), radius: 1pt, fill: black, name: "F"))
      on-layer(1, line((f_Ok,-0.5), (f_Ok,.5), mark: (symbol: "barbed"), name: "Ok"))
      on-layer(1, line((-f_Ob, -0.75), (-f_Ob, 0.75), mark: (symbol: "barbed"), name: "Ob"))

      // Lichstrahlen durchs Objektiv
      let alpha_strich = calc.atan(-B/f_Ob)
      line("B.end", ("B.end", 7.3, "Ob"), stroke: yellow, name: "Ob_mitte")
      line("B.end", "Ob.70%", stroke: yellow, name: "Ob_oben")
      line((), (rel: (alpha_strich, -1)), stroke: yellow)
      line("B.end", "Ob.30%", stroke: yellow, name: "Ob_unten")
      line((), (rel: (alpha_strich, -.9)), stroke: yellow)

      // Lichstrahlen durchs Okular
      let alpha_o = calc.atan(B/f_Ok)
      line("B.end", ("B.end", 3.5, "Ok"), stroke: yellow, name: "Ok_mitte")
      line("B.end", "Ok.70%", stroke: yellow, name: "Ok_oben")
      line((), (rel: (alpha_o, 0.6)), stroke: yellow)
      line("B.end", "Ok.30%", stroke: yellow, name: "Ok_unten")
      line((), (rel: (alpha_o, 0.7)), stroke: yellow)

      cetz.angle.angle("Ok", (-180deg, 1), "Ok_mitte", radius: 0.4, inner: true, stroke: red, label: box(baseline: -0.1em)[#text(fill: red, size: 6pt)[$alpha'$]], label-radius: 0.3)
      cetz.angle.angle("Ob", "Ob_mitte", (180deg, -1), radius: 0.6, inner: true, stroke: black, label: box(baseline: -0.1em)[#text(size: 6pt)[$alpha$]], label-radius: 0.5)
      cetz.angle.angle("Ob", "Ob_mitte.end", (-f_Ob - 1, 0), radius: 0.6, inner: true, stroke: black, label: box(baseline: -0.1em)[#text(size: 6pt)[$alpha$]], label-radius: 0.5)

      // Beschriftungen
      line("F", (0, .3), stroke: (dash: "dotted"))  
      line((), (rel: (-f_Ob, 0)), mark: (symbol: "|"), stroke: purple, name: "f_Ob")
      line((0, .3), (rel: (f_Ok, 0)), mark: (symbol: "|"), stroke: fuchsia, name: "f_Ok")
      
      content("B", text(fill: blue)[$B$], anchor: "east", padding: 3pt)
      content("f_Ob", text(fill: purple)[$f_"Ob"$], anchor: "south", padding: 2pt)
      content("f_Ok", text(fill: fuchsia)[$f_"Ok"$], anchor: "south", padding: 2pt)
      content((0, 0), [$"F"_"Ob" = "F"_"Ok"$], anchor: "north", padding: 2pt)
      content((2.5, 0.3),text(fill: gray)[$oo$])
    })  
]

#pagebreak()

= Physik des 20. Jahrhunderts

== Kernphysik

#grid(..standard, 
[Zerfallsgesetz], grid.cell(colspan: 2)[$#text(fill: blue)[$N$]=#text(fill: blue)[$N_0$] e^(-lambda t)$], [$[N]=1$],
grid.cell(rowspan: 3)[
  #cetz.canvas({
    import cetz-plot: *
    import cetz.draw: *
    
    set-style(axes: (overshoot: 5pt, shared-zero: false, stroke: 0.5pt, tick: (stroke: 0.5pt), x: (mark: (end: "barbed", scale: 0.5)), y: (mark: (end: "barbed", scale: 0.5))), stroke: 0.5pt)

    let N_0 = 1
    let T_Halb = 2
    let lambda_ = calc.ln(2)/T_Halb

    plot.plot(axis-style: "school-book", size: (2,0.7), x-tick-step: none, y-tick-step: none, x-label: text(size: 8pt)[$t$], y-label: text(size: 8pt, fill: blue)[$N$], x-ticks: ((T_Halb, text(size: 8pt)[$T_½$]), ), y-ticks: ((1, text(size: 8pt, fill: blue)[$N_0$]), ), name: "at", {
      plot.add(y => (N_0*calc.exp(-lambda_ * y)), domain: (0, 2.5*calc.pi), style: (stroke: blue))
      plot.add(((T_Halb, 0), (T_Halb, N_0/2)), style: (stroke: (paint: black, dash: "dotted")))
      plot.add(((0, N_0/2), (T_Halb, N_0/2)), style: (stroke: (paint: black, dash: "dotted")))
    })
  })
], text(fill: blue)[$N_0$], [ursprüngliche Anzahl Isotope], [$[N_0]=1$],
[$lambda$], [Zerfallskonstante], [$[lambda]=qty("1", "1/s")$],
[$t$#v(.75em)], [verstrichene Zeit], [$[t]=qty("1", "s")$],

[Halbwertszeit], grid.cell(colspan: 2)[$T_½=(ln 2)/lambda$], [$[T_½]=qty("1", "s")$],
[$$#v(.75em)], [$lambda$], [Zerfallskonstante], [$[lambda]=qty("1","1/s")$],

grid.cell(rowspan: 4)[#smallcaps[Lambert-Beersches]\ Gesetz \ #v(-0.75em)
  #cetz.canvas({
    import cetz-plot: *
    import cetz.draw: *
    
    set-style(axes: (overshoot: 5pt, shared-zero: false, stroke: 0.5pt, tick: (stroke: 0.5pt), x: (mark: (end: "barbed", scale: 0.5)), y: (mark: (end: "barbed", scale: 0.5))), stroke: 0.5pt)

    let I_0 = 1
    let d_Halb = 2
    let mu_ = calc.ln(2)/d_Halb

    plot.plot(axis-style: "school-book", size: (2,0.5), x-tick-step: none, y-tick-step: none, x-label: text(size: 8pt)[$x$], y-label: text(size: 8pt, fill: red)[$I$], x-ticks: ((d_Halb, text(size: 8pt)[$d_½$]), ), y-ticks: ((1, text(size: 8pt, fill: red)[$I_0$]), ), name: "at", {
      plot.add(y => (I_0*calc.exp(-mu_ * y)), domain: (0, 2.5*calc.pi), style: (stroke: red))
      plot.add(((d_Halb, 0), (d_Halb, I_0/2)), style: (stroke: (paint: black, dash: "dotted")))
      plot.add(((0, I_0/2), (d_Halb, I_0/2)), style: (stroke: (paint: black, dash: "dotted")))
    })
    line((-.6,-0.1), (0, -0.1), stroke: white)
  })
], grid.cell(colspan: 2)[$#text(fill: red)[$I$]=#text(fill: red)[$I_0$] e^(-mu x)$], [$[I]=qty("1", "W/m^2")$],
text(fill: red)[$I_0$], [Strahlungsintensität vorher], [$[I_0]=qty("1", "W/m^2")$],
[$mu$], [Absorptionskoeffizient], [$[mu]=qty("1", "1/m")$],
[$x$], [Schichtdicke], [$[x]=qty("1", "m")$],

[Halbwertsdicke], grid.cell(colspan: 2)[$d_½=(ln 2)/mu$], [$[d_½]=qty("1", "m")$],
[$$#v(.75em)], [$mu$], [Absorptionskoeffizient], [$[mu]=qty("1", "1/m")$],

[Bindungsenergie], grid.cell(colspan: 2)[$#text(fill: aqua)[$Delta E$]=Delta m c^2$], [$[Delta E]=qty("1", "J")$],
[], [$Delta m$], [Massendefekt \ $=Z(m_p +m_e)+(A-Z) m_n-m_A$], [$[Delta m]=qty("1", "kg")$],
[$$#v(.75em)], [$c$], [Lichtgeschwindigkeit im Vakuum], [$[c]=qty("1", "m/s")$],

[Aktivität], grid.cell(colspan: 2)[$A=-(Delta N)/(Delta t)=lambda N$], [$[A]=qty("1", "Bq")$],
[], [$Delta N$], [Zerfälle im Zeitintervall $Delta t$], [$[Delta N]=1$],
[], [$N$], [aktuelle Anzahl Isotope], [$[N]=1$],
[$$#v(.75em)], [$lambda$], [Zerfallskonstante], [$[lambda]=qty("1", "1/s")$],

[Energiedosis], grid.cell(colspan: 2)[$D=(#text(fill: aqua)[$Delta E$])/m$], [$[D]=qty("1", "Gy")$],
[], text(fill: aqua)[$Delta E$], [absorbierte Strahlungsenergie], [$[Delta E]=qty("1", "J")$],
[$$#v(.75em)], [$m$], [absorbierende Masse], [$[m]=qty("1", "kg")$],

[Äquivalentdosis], grid.cell(colspan: 2)[$H=q D$], [$[H]=qty("1", "Sv")$],
[_$->$ @q _], [$q$], [Qualitätsfaktor], [$[q]=1$],
[], [$D$], [Energiedosis], [$[D]=qty("1", "Gy")$]
)

#pagebreak()

== Spezielle Relativitätstheorie

#grid(..standard,
[Relativitätsfaktor], grid.cell(colspan: 2)[$gamma=1/(sqrt(1-(#text(fill: blue)[$v$]/c)^2))$], [$[gamma]=1$],
[], text(fill: blue)[$v$], [Geschwindigkeit des Körpers], [$[v]=qty("1", "m/s")$],
// [$$#v(1em)], [$c$], [Lichtgeschwindigkeit im Vakuum], [$[c]=qty("1", "m/s")$],
[], [$c$], grid.cell(colspan: 2)[Lichtgeschwindigkeit im Vakuum \ $c=qty("299792458", "m/s")$#v(1em)], 

[Zeitdilatation], grid.cell(colspan: 2)[$Delta t=gamma Delta t_0$], [$[Delta t]=qty("1", "s")$],
[], [$Delta t_0$], [Zeitspanne im System, in dem der Körper ruht#v(1em)], [$[Delta t_0]=qty("1", "s")$],

[Längenkontraktion], grid.cell(colspan: 2)[$#text(fill: green)[$l$]=#text(fill: green)[$l_0$]/gamma$], [$[l]=qty("1", "m")$],
[], text(fill: green)[$l_0$], [Länge des Objekts im System, in dem es ruht#v(1em)], [$[l_0]=qty("1", "m")$],

grid.cell(rowspan: 3)[#smallcaps[Lorentz]transformation \

  #cetz.canvas({
    import cetz.draw: *
    
    set-style(stroke: 0.5pt)

    let E = (1.3, .9)

    line((), (2, 0), mark: (end: "barbed"), name: "x-achse")
    line((0, 0), (0, 1), mark: (end: "barbed"), name: "y-achse")

    line((1, .2), (rel: (2, 0)), stroke: red, mark: (end: "barbed"), name: "x'-achse")
    line((1, .2), (rel: (0, 1)), stroke: red, mark: (end: "barbed"), name: "y'-achse")

    line((1, .3), (rel: (1, 0)), stroke: blue, mark: (end: "barbed"), name: "v")

    circle(E, radius: 0.5pt, fill: black, name: "E")

    content((2.25, .9), text(size: 6pt)[$"E"(x, y)=#text(fill: red)[$"E"'(x', y')$]$])
    content("x-achse.end", [$x$], anchor: "west", padding: 2pt)
    content("y-achse.end", [$y$], anchor: "south", padding: 2pt)
    content("x'-achse.end", text(fill: red)[$x'$], anchor: "west", padding: 2pt)
    content("y'-achse.end", text(fill: red)[$y'$], anchor: "south", padding: 2pt)
    content("v", text(fill: blue)[$arrow(v)$], anchor: "south", padding: 2pt)
  })

], grid.cell(colspan: 3)[$#text(fill: red)[$x'$]=gamma(x-#text(fill: blue)[$v$]t)$; $x=(#text(fill: red)[$x'$]+#text(fill: blue)[$v$]#text(fill: red)[$t'$])$ \
$#text(fill: red)[$y'$]=y$ \
$#text(fill: red)[$z'$]=z$ \
$#text(fill: red)[$t'$]=gamma(t-#text(fill: blue)[$v$]/c^2 x)$; $t=gamma(#text(fill: red)[$t'$]+#text(fill: blue)[$v$]/c^2#text(fill: red)[$x'$])$],
text(fill: blue)[$v$], [Geschwindigkeit von #text(fill: red)[$I'$] bzgl. $I$ in $x$-Richtung], [$[v]=qty("1", "m/s")$],
[$c$], grid.cell(colspan: 2)[Lichtgeschwindigkeit im Vakuum \ $c=qty("299792458", "m/s")$#v(1em)],

grid.cell(rowspan: 4)[Addition der Geschwindigkeiten \

  #cetz.canvas({
    import cetz.draw: *
    
    set-style(stroke: 0.5pt)

    let E = (1.3, .9)
    let u_strich = 0.5
    let c = 3
    let v = 1

    line((), (2, 0), mark: (end: "barbed"), name: "x-achse")
    line((0, 0), (0, 1), mark: (end: "barbed"), name: "y-achse")

    line((1, .2), (rel: (2, 0)), stroke: red, mark: (end: "barbed"), name: "x'-achse")
    line((1, .2), (rel: (0, 1)), stroke: red, mark: (end: "barbed"), name: "y'-achse")

    line((1, .3), (rel: (v, 0)), stroke: blue, mark: (end: "barbed"), name: "v")
    line((1.3, .93), (rel: (u_strich, 0)), stroke: red, mark: (end: "barbed"), name: "u'")
    let u = (u_strich + v)/(1 + (u_strich * v/c/c))
    line((1.3, .87), (rel: (u, 0)), mark: (end: "barbed"), name: "u")
    

    circle(E, radius: 2pt, fill: black, name: "E")

    content("x-achse.end", [$x$], anchor: "west", padding: 2pt)
    content("y-achse.end", [$y$], anchor: "south", padding: 2pt)
    content("x'-achse.end", text(fill: red)[$x'$], anchor: "west", padding: 2pt)
    content("y'-achse.end", text(fill: red)[$y'$], anchor: "south", padding: 2pt)
    content("v", text(fill: blue)[$arrow(v)$], anchor: "south", padding: 2pt)
    content("u'", text(fill: red)[$arrow(u')$], anchor: "south", padding: 3pt)
    content("u", [$arrow(u)$], anchor: "north", padding: 3pt)
  })

], grid.cell(colspan: 3)[$#text(fill: red)[$u'$]=(#text(fill: black)[$u$]-#text(fill: blue)[$v$])/(1-(#text(fill: black)[$u$]#text(fill: blue)[$v$])/c^2)$; 
$#text(fill: black)[$u$]=(#text(fill: red)[$u'$]+#text(fill: blue)[$v$])/(1+(#text(fill: red)[$u'$]#text(fill: blue)[$v$])/c^2)$],
text(fill: black)[$u$], [$x$-Komponente der Geschwindigkeit in $I$], [$[u]=qty("1", "m/s")$],
text(fill: red)[$u'$], [$x$-Komponente der Geschwindigkeit in #text(fill: red)[$I'$]], [$[u']=qty("1", "m/s")$],
text(fill: blue)[$v$], [Geschwindigkeit von #text(fill: red)[$I'$] bzgl. $I$ in $x$-Richtung#v(1em)], [$[v]=qty("1", "m/s")$],

[Relativistische Masse], grid.cell(colspan: 2)[$m_"rel"=gamma m_0$], [$[m_"rel"]=qty("1", "kg")$],
[], [$m_0$], [Ruhemasse des Teilchens], [$[m_0]=qty("1", "kg")$],
[$$#v(1em)], [$gamma$], [Relativitätsfaktor], [$[gamma]=1$]
)

#pagebreak()

#grid(..standard,
[Impuls], grid.cell(colspan: 2)[$#text(fill: blue)[$arrow(p)$]=gamma m_0 #text(fill: blue)[$arrow(v)$]$], [$[p]=qty("1", "N s")$],
[], [$m_0$], [Ruhemasse des Teilchens], [$[m_0]=qty("1", "kg")$],
[], text(fill: blue)[$arrow(v)$], [Geschwindigkeit des Teilchens], [$[v]=qty("1", "m/s")$],
[$$#v(1em)], [$gamma$], [Relativitätsfaktor], [$[gamma]=1$],

[Ruheenergie], grid.cell(colspan: 2)[$E_0=m_0 c^2$], [$[E_0]=qty("1", "J")$],
[], [$m_0$], [Ruhemasse des Teilchens], [$[m_0]=qty("1", "kg")$],
[], [$c$], grid.cell(colspan: 2)[Lichtgeschwindigkeit im Vakuum \ $c=qty("299792458", "m/s")$#v(1em)],

[Gesamtenergie], grid.cell(colspan: 2)[$E=gamma E_0=sqrt((m_0 c^2)^2+(#text(fill: blue)[$p$] c)^2)$], [$[E]=qty("1", "J")$],
[], [$E_0$], [Ruheenergie], [$[E_0]=qty("1", "J")$],
[], [$m_0$], [Ruhemasse des Teilchens], [$[m_0]=qty("1", "kg")$],
[], text(fill: blue)[$p$], [Impuls des Teilchens], [$[p]=qty("1", "N s")$],
[], [$gamma$], [Relativitätsfaktor], [$[gamma]=1$],
[], [$c$], grid.cell(colspan: 2)[Lichtgeschwindigkeit im Vakuum \ $c=qty("299792458", "m/s")$#v(1em)],

[Bewegungsenergie], grid.cell(colspan: 2)[$E_"kin"=E-E_0=(gamma-1)m_0 c^2$], [$[E_"kin"]=qty("1", "J")$],
[], [$E$], [Gesamtenergie], [$[E]=qty("1", "J")$],
[$$#v(1em)], [$E_0$], [Ruheenergie], [$[E_0]=qty("1", "J")$]
)

=== #smallcaps[Minkowski]-Diagramm

#grid(..standard,
[Winkel zw. den Achsen], grid.cell(colspan: 3)[$tan alpha=#text(fill: blue)[$v$]/c$#v(1em)],
[Zeicheneinheit], grid.cell(colspan: 2)[$#text(fill: red)[$e'$]=e sqrt(1+(#text(fill: blue)[$v$]/c)^2)/sqrt(1-(#text(fill: blue)[$v$]/c)^2)$], [$[e']=qty("1", "Ls/cm")$],
grid.cell(rowspan: 3)[
#v(-1em)
#cetz.canvas({
    import cetz.draw: *
    
    set-style(stroke: 0.5pt)

    let v = 0.9
    let c = 3
    let e = 2
    
    let alpha_ = calc.atan(v/c)

    let e_strich = e * calc.sqrt(1+calc.pow(v/c, 2)/calc.sqrt(1-calc.pow(v/c, 2)))

    line((-.1, 0), (2.5, 0), mark: (end: "barbed"), name: "x-achse")
    line((0, -.1), (0, 2.5), mark: (end: "barbed"), name: "y-achse")
    line((e, 0), (e, -.1), name: "x_1")
    line((0, e), (-.1, e), name: "y_1")

    line((0, 0), (rel: (alpha_, 2.7)), stroke: red, mark: (end: "barbed"), name: "x'-achse")
    line((0, 0), (rel: (90deg - alpha_, 2.7)), stroke: red, mark: (end: "barbed"), name: "y'-achse")
    line((alpha_, e_strich), (rel: (alpha_ - 90deg, 0.1)), stroke: red, name: "x'_1")
    line((90deg - alpha_, e_strich), (rel: (180deg - alpha_, 0.1)), stroke: red, name: "y'_1")

    cetz.angle.angle((0, 0), "x-achse", "x'-achse", radius: 0.9, inner: true, stroke: red, label: box(baseline: -0.2em)[#text(fill: red)[$alpha$]], label-radius: 0.75)
    cetz.angle.angle((0, 0), "y'-achse", "y-achse", radius: 0.9, inner: true, stroke: red, label: box(baseline: -0.2em)[#text(fill: red)[$alpha$]], label-radius: 0.75)

    cetz.decorations.brace((e, 0), (0, 0), name: "brace_x")
    cetz.decorations.brace((0, 0), (0, e), name: "brace_y")
    cetz.decorations.brace((0, 0), (alpha_, e_strich), fill: red, name: "brace_x'")
    cetz.decorations.brace((90deg - alpha_, e_strich), (0, 0), fill: red, name: "brace_y'")
    
    content("x-achse.end", [$x$], anchor: "west", padding: 2pt)
    content("y-achse.end", align(center)[$c t$], anchor: "south", padding: 2pt)
    content("x'-achse.end", text(fill: red)[$x'$], anchor: "west", padding: 2pt)
    content("y'-achse.end", text(fill: red)[$c t'$], anchor: "south", padding: 2pt)
    content("x_1.end", text(size: 6pt)[$qty("1", "Ls")$], anchor: "north", padding: 2pt)
    content("y_1.end", text(size: 6pt)[$qty("1", "Ls")$], anchor: "east", padding: 2pt)
    content("x'_1.end", text(size: 6pt, fill: red)[$qty("1", "Ls")$], anchor: "north", padding: 2pt)
    content("y'_1.end", text(size: 6pt, fill: red)[$qty("1", "Ls")$], anchor: "east", padding: 2pt)
    content("brace_x.spike", [$e$], anchor: "north")
    content("brace_y.spike", [$e$], anchor: "east", padding: 2pt)
    content("brace_x'.spike", text(fill: red)[$e'$], anchor: "south")
    content("brace_y'.spike", text(fill: red)[$e'$], anchor: "west", padding: 1pt)
  })
  
], [$e$], [Zeicheneinheit in $I$], [$[e]=qty("1", "Ls/cm")$],
text(fill: blue)[$v$], [Relativgeschwindigkeit von $I$ bzgl. #text(fill: red)[$I'$]], [$[v]=qty("1", "m/s")$],
[$c$], grid.cell(colspan: 2)[Lichtgeschwindigkeit im Vakuum \ $c=qty("299792458", "m/s")$#v(1em)]
)

#pagebreak()

== Quantenphysik

#grid(..standard,
[Energie des Photons], grid.cell(colspan: 2)[$E_"Ph"=h f= (h c)/lambda$], [$[E_"Ph"]=qty("1", "J")$],
[], [$f$], [Frequenz des Lichts], [$[f]=qty("1", "Hz")$],
[], [$lambda$], [Wellenlänge des Lichts], [$[lambda]=qty("1", "m")$],
[], [$h$], grid.cell(colspan: 2)[#smallcaps[Planck]sches Wirkungsquantum \ 
$h=qty("6.62607015e-34", "J s")$], 
[], [$c$], grid.cell(colspan: 2)[Lichtgeschwindigkeit im Vakuum \ $c=qty("299792458", "m/s")$#v(1em)],

[Impuls des Photons], grid.cell(colspan: 2)[$#text(fill: blue)[$p$]=h/lambda$], [$[p]=qty("1", "N s")$],
[], [$lambda$], [Wellenlänge des Lichts], [$[lambda]=qty("1", "m")$],
[], [$h$], grid.cell(colspan: 2)[#smallcaps[Planck]sches Wirkungsquantum \ 
$h=qty("6.62607015e-34", "J s")$#v(1em)],

[#smallcaps[De Broglie]], grid.cell(colspan: 3)[Energie und Impuls des Photons gelten auch für Teilchen#v(1em)],

[Äusserer Photoeffekt], grid.cell(colspan: 2)[$E_"Ph"=#text(fill: aqua)[$W_A$]+#text(fill: blue)[$E_"kin"$]$], [$[E_"Ph"]=qty("1", "J")$],
[], text(fill: aqua)[$W_A$], [Elektronenaustrittsarbeit], [$[W_A]=qty("1", "J")$],
[$$#v(1em)], text(fill: blue)[$E_"kin"$], [Bewegungsenergie der $e^-$], [$[E_"kin"]=qty("1", "J")$],

grid.cell(rowspan: 2)[#smallcaps[Heisenberg]sche Unschärferelation], grid.cell(colspan: 3)[$#text(fill: green)[$Delta x$] #text(fill: blue)[$Delta p_x$] >= h$; $#text(fill: aqua)[$Delta E$] Delta t >= h$], 
text(fill: green)[$Delta x$], [Ortsunschärfe bei gleichzeitiger Messung von $x$ und $p_x$], [$[Delta x]=qty("1", "m")$],
[], text(fill: blue)[$Delta p_x$], [Impulsunschärfe bei gleich-zeitiger Messung von $x$ und $p_x$], [$[Delta p]=qty("1", "N s")$],
[], text(fill: aqua)[$Delta E$], [Energieunschärfe bei gleich-zeitiger Messung von $E$ und $t$], [$[Delta E]=qty("1", "J")$],
[], [$Delta t$], [Zeitunschärfe bei gleichzeitiger Messung von $E$ und $t$], [$[Delta t]=qty("1", "s")$],
[], [$h$], grid.cell(colspan: 2)[#smallcaps[Planck]sches Wirkungsquantum \ 
$h=qty("6.62607015e-34", "J s")$]
)

#pagebreak()

//Tabellen
//========
// Planetendaten
= Tabellen

#show table.cell.where(x: 0): it => align(left)[#it]
#figure(
  table(
  columns: (1fr, auto, 1fr, 1fr,1fr,1fr),
  inset: 4pt,
  stroke: none,
  table.header(
    align(horizon)[Name], [$m \ "in "qty("e24", "kg")$], [$#text(fill: green)[$r$] \ "in "qty("e6", "m")$], [$#text(fill: aqua)[$a$] \ "in "qty("e9", "m")$], [$T\ "siderisch"$], align(horizon)[$epsilon$]
  ),
  table.hline(start: 0, stroke: 0.5pt),
  //table.vline(x: 1, start: 0, stroke: 0.5pt), 
  
  [Merkur], [0.3301], [2.440], [57.91], [$qty("87.97", "d")$], [0.206],
  [Venus], [4.867], [6.052], [108.2], [$qty("224.7", "d")$], [0.00677],
  [Erde], [5.972], [6.378], [149.6], [$qty("1.000", "a")$], [0.0167],
  [Mars], [0.6417], [3.396], [227.9], [$qty("1.881", "a")$], [0.0934],
  [Jupiter], [1899], [71.49], [778.5], [$qty("11.86", "a")$], [0.0485],
  [Saturn], [568.5], [60.27], [1433], [$qty("29.46", "a")$], [0.0555],
  [Uranus], [86.82], [25.56], [2872], [$qty("84.01", "a")$], [0.0463],
  [Neptun], [102.5], [24.76], [4495], [$qty("164.8", "a")$], [0.00899],

  table.hline(start: 0, stroke: (thickness: 0.5pt, dash: "dotted")),

  [Pluto], [0.0146], [1.195], [5906], [$qty("247.9", "a")$], [0.244],

  table.hline(start: 0, stroke: 0.5pt),

  [Erdmond], [0.07346], [1.7374], [0.3844], [$qty("27.32", "d")$], [0.0549],
  [Sonne], [$qty("1.98e30", "kg")$], [696.0], [], [], [],
  table.hline(start: 0, stroke: 0.5pt),

),caption: [Astronomische Daten])<planet>

#grid(columns: (1fr, 0.75fr), 
[
  #figure(
      table(
        columns: 2,
        stroke: none,
       
        table.header(
          [Strahlungsart], [$q$-Faktor]
        ),
        table.hline(start: 0, stroke: 0.5pt),
        [Röntgen- und $gamma$-Strahlung], [1],
        [$beta$-Strahlung], [1],
        [thermische Neutronen], [3],
        [$alpha$-Strahlung], [10],
        [Protonen], [10],
        [schwere Rückstosskerne], [20],
        table.hline(start: 0, stroke: 0.5pt),
      )
    ,caption: [Qualitätsfaktor]
  )<q>
],
[
  #figure(
    table(
      columns: (3cm, 1cm),
      stroke: none,
      table.header(
        [Material], [$n$]
      ),
      table.hline(start: 0, stroke: 0.5pt),
      [Luft], [1.00],
      [Eis], [1.31],
      [Wasser], [1.33],
      [Plexiglas], [1.49],
      [Glas], [1.50],
      [Diamant], [2.42],
      table.hline(start: 0, stroke: 0.5pt),
    ),
    caption: [Brechzahl]
  )<n>
])

#figure(
  table(
      columns: 2*(3cm, 2.5cm),
      align: (left, center),
      stroke: none,
      table.header(
        align(horizon)[Brennmaterial], align(center)[#text(fill: maroon)[$H$] \ in $qty("e6", "J/kg")$], align(horizon)[Brennmaterial], align(center)[#text(fill: maroon)[$H$]\ in $qty("e6", "J/kg")$],
      ),
      table.hline(start: 0, stroke: 0.5pt),
      table.vline(x: 2, start: 1, stroke: 0.5pt),
      [Anthrazit], [$num("32")$], [Methan], [$num("50.1")$],
      [Butan], [$num("45.7")$], [Methanol], [$num("22.7")$],
      [Erdgas], [$num("38")$], [Benzin], [$num("43.5")$],
      [Ethanol], [$num("26.7")$], [Paraffin], [$num("45")$],
      [Heizöl], [$num("42.7")$], [Propan], [$num("46.4")$],
      [Koks], [$num("29")$], [Tannenholz], [$num("15")$],

      table.hline(start: 0, stroke: 0.5pt)
    ),
  caption: [Spezifischer Heizwert bei $qty("25", "Celsius")$ und Normdruck]
)<H>



#pagebreak()
// Dichte
#set table(
  align: (left, right)
)

#figure(
  grid(columns: 1,
    row-gutter: 25pt,
    [#table(
      columns: 3*(2fr, 1fr),
      stroke: none,
      table.header(
        table.cell(colspan: 6)[Feste Stoffe bei $qty("20", "Celsius")$ in $unit("kg/m^3")$]
      ),
      table.hline(start: 0, stroke: 0.5pt),
      table.vline(x: 2, stroke: 0.5pt),
      table.vline(x: 4, stroke: 0.5pt),
      [Aluminium], [$num("2700")$], [Kork], [$num("300")$], [Silber], [$num("10500")$],
      [Beton], [$num("2200")$], [Kupfer], [$num("8920")$], [Silizium], [$num("2420")$],
      [Blei], [$num("11340")$], [Marmor], [$num("2700")$], [Stahl V2A], [$num("7900")$], 
      [Buchenholz], [$num("700")$], [Messing], [$num("8470")$], [Styropor], [$num("20")$],
      [Diamant], [$num("3510")$], [Natrium], [$num("970")$], [Tannenholz], [$num("500")$],
      [Eis bei $qty("0", "Celsius")$], [$num("917")$], [Nickel], [$num("8900")$], [Uran], [$num("18700")$],
      [Eisen], [$num("7860")$], [Paraffin], [$num("900")$], [Wolfram], [$num("19300")$],
      [Glas], [$num("2500")$], [Platin], [$num("21450")$], [Ziegelstein], [$num("1600")$],
      [Gold], [$num("19290")$], [Plexiglas], [$num("1180")$], [Zink], [$num("7140")$], 
      [Graphit], [$num("2240")$], [Porzellan], [$num("2400")$], [Zinn], [$num("7290")$],
      [Invar], [$num("8000")$], [Quarzglas], [$num("2200")$],
      table.hline(start: 0, stroke: 0.5pt)
    )],
    [#table(
      columns: 3*(2fr, 1fr),
      stroke: none,
      table.header(
        table.cell(colspan: 6)[Flüssigkeiten bei $qty("20", "Celsius")$ in $unit("kg/m^3")$]
      ),
      table.hline(start: 0, stroke: 0.5pt),
      table.vline(x: 2, stroke: 0.5pt),
      table.vline(x: 4, stroke: 0.5pt),
      [Aceton], [$num("791")$], [Glycerin], [$num("1261")$], [Schwefelsäure], [$num("1840")$], 
      [Benzol], [$num("879")$], [Heizöl], [$num("840")$], [Tetrachlorkohlenst.], [$num("1594")$],
      [Benzin], [$num("744")$], [Methanol], [$num("792")$], [Wasser], [$num("998")$],
      [Diethylether], [$num("714")$], [Olivenöl], [$num("920")$], [$"D"_2"O"$], [$num("1105")$], 
      [Ethanol], [$num("789")$], [Quecksilber], [$num("13546")$], 
      table.hline(start: 0, stroke: 0.5pt)
    )],
    [#table(
      columns: 3*(2fr, 1fr),
      stroke: none,
      table.header(
        table.cell(colspan: 6)[Gase bei $qty("0", "Celsius")$ und $qty("1.013e5", "Pa")$ in $unit("kg/m^3")$]
      ),
      table.hline(start: 0, stroke: 0.5pt),
      table.vline(x: 2, stroke: 0.5pt),
      table.vline(x: 4, stroke: 0.5pt),
      [Ammoniak], [$num("0.771")$], [Kohlenmonoxid], [$num("1.250")$], [Schwefeldioxid], [$num("2.926")$], 
      [Argon], [$num("1.784")$], [Luft], [$num("1.293")$], [Stickstoff], [$num("1.250")$],
      [Butan], [$num("2.732")$], [Methan], [$num("0.717")$], [Wasserstoff], [$0.0899$],
      [Erdgas], [$num("0.830")$], [Neon], [$num("0.900")$], [Xenon], [$num("5.897")$], 
      [Helium], [$num("0.179")$], [Propan], [$num("2.010")$], [], [],
      [Kohlendioxid], [$num("1.977")$], [Sauerstoff], [$num("1.429")$], 
      table.hline(start: 0, stroke: 0.5pt)  
    )]
  ),
  caption: [Dichte]
)<rho>

#pagebreak()

// Thermische Eigenschaften
#figure(
  grid( columns: 1, gutter: 7pt,
    [#table(
      columns: (1.5fr, 1fr, 1fr, 1fr, 1fr, 1fr),
      align: (left, right, right, right, right, right),
      stroke: none,
      table.header(
        align(left + horizon)[Festkörper], align(center)[#text(fill: blue)[$alpha$] $qty("e-6", "1/K")$], align(center)[#text(fill: maroon)[$c$] $unit("J/kg/K")$], align(center)[#text(fill: purple)[$L_f$]  $qty("e5", "J/kg")$], align(center)[#text(fill: fuchsia)[$L_v$] $qty("e5", "J/kg")$], align(center)[$lambda$ $unit("W/m/K")$]  
      ),
      table.hline(start: 0),
      [Aluminium], [$num("23.8")$], [$num("896")$], [$num("3.970")$], [$num("109.0")$], [$num("239")$],
      [Blei], [$num("31.3")$], [$num("129")$], [$num("0.230")$], [$num("86.0")$], [$num("34.8")$],
      [Eis bei $qty("0", "Celsius")$], [$num("37.0")$], [$num("2100")$], [$num("3.338")$], [$num("22.5")$], [$2.2$],
      [Eisen], [$num("12.0")$], [$num("450")$], [$num("2.770")$], [$num("63.4")$], [$num("80")$],
      [Glas], [$num("8.5")$], [$num("800")$], [], [], [$num("1.0")$],
      [Holztäfer], [$num("4.0")$], [$num("2100")$], [], [], [$num("0.13")$],
      [Kork], [$num("62.0")$], [$num("1800")$], [], [], [$num("0.05")$],
      [Kupfer], [$num("16.8")$], [$num("383")$], [$num("2.050")$], [$num("47.9")$], [$num("390")$],
      [Silber], [$num("19.7")$], [$num("235")$], [$num("1.045")$], [$num("23.5")$], [$num("428")$],
      [Stahl V2A], [$num("16.0")$], [$num("510")$], [], [], [$num("14")$],
      [Wolfram], [$num("4.3")$], [$num("134")$], [$num("1.920")$], [$num("43.5")$], [$num("177")$],
      table.hline(start: 0)
    )
  ],
  [#table(
      columns: (1.5fr, 1fr, 1fr, 1fr, 1fr, 1fr),
      align: (left, right, right, right, right, right),
      stroke: none,
      table.header(
        align(left + horizon)[Flüssigkeiten], align(center)[#text(fill: red)[$gamma$] $qty("e-3", "1/K")$], align(center)[#text(fill: maroon)[$c$]$unit("J/kg/K")$], align(center)[#text(fill:purple)[$L_f$]  $qty("e5", "J/kg")$], align(center)[#text(fill: fuchsia)[$L_v$] $qty("e5", "J/kg")$], align(center)[$lambda$ $unit("W/m/K")$]  
      ),
      table.hline(start: 0),
      [Aceton], [$num("1.49")$], [$num("2160")$], [$num("0.98")$], [$num("5.25")$], [$num("0.162")$], 
      [Benzin], [$num("0.90")$], [$num("2020")$], [$num("")$], [$num("")$], [$num("0.130")$], 
      [Ethanol], [$num("1.10")$], [$num("2430")$], [$num("1.08")$], [$num("8.40")$], [$num("0.165")$], 
      [Glycerin], [$num("0.50")$], [$num("2390")$], [$num("2.01")$], [$num("8.54")$], [$num("0.285")$], 
      [Heizöl EL], [$num("0.92")$], [$num("")$], [$num("")$], [$num("")$], [$num("0.140")$], 
      [Quecksilber], [$num("0.18")$], [$num("139")$], [$num("0.12")$], [$num("2.85")$], [$num("8.200")$], 
      [Wasser], [$num("0.21")$], [$num("4182")$], [$num("3.34")$], [$num("22.56")$], [$num("0.598")$], 
      table.hline(start: 0)
    )
  ],
  [#table(
      columns: (1.5fr, 1fr, 1fr, 1fr, 1fr, 1fr),
      align: (left, right, right, right, right, right),
      stroke: none,
      table.header(
        align(left + horizon)[Gase], [], align(center)[#text(fill: maroon)[$c_p$] $unit("J/kg/K")$], align(center)[#text(fill: purple)[$L_f$]  $qty("e5", "J/kg")$], align(center)[#text(fill: fuchsia)[$L_v$] $qty("e5", "J/kg")$], align(center)[$lambda$ $unit("W/m/K")$]  
      ),
      table.hline(start: 0),
      [Helium], [], [$num("5230")$], [$num("")$], [$num("0.20")$], [$num("0.143")$], 
      [Kohlendioxid], [], [$num("837")$], [$num("1.81")$], [$num("1.37")$], [$num("0.015")$], 
      [Luft], [], [$num("1005")$], [$num("")$], [$num("")$], [$num("0.024")$], 
      [Methan], [], [$num("2219")$], [$num("0.59")$], [$num("5.10")$], [$num("0.030")$], 
      [Sauerstoff], [], [$num("917")$], [$num("0.14")$], [$num("2.13")$], [$num("0.024")$], 
      [Stickstoff], [], [$num("1038")$], [$num("0.26")$], [$num("1.98")$], [$num("0.024")$], 
      [Wasserstoff], [], [$num("14320")$], [$num("0.60")$], [$num("4.50")$], [$num("0.171")$], 
      table.hline(start: 0)
    )
  ]), 
  caption: [Thermische Eigenschaften]
)<thermo>

#pagebreak()

#grid(
  columns: 2,
  align: bottom,
  gutter: 10pt,
  
// Spezifischer Widerstand
[
  #figure(
    grid(columns: 1,
      row-gutter: 15pt,
      [#table(
        columns: 2*(3.5cm, 1cm),
        align: (left, right),
        stroke: none,
        table.header(
          table.cell(colspan: 4)[Leiter bei $qty("20", "Celsius")$ in $qty("e-8", "Ohm meter")$]
        ),
        table.hline(start: 0, stroke: 0.5pt),
        table.vline(x: 2, stroke: 0.5pt),
        [Aluminium], [$num("2.65")$], [Nickel], [$num("6.93")$],
        [Blei], [$num("20.8")$], [Platin], [$num("10.5")$],
        [Eisen], [$num("9.7")$], [Silber], [$num("1.59")$],
        [Gold], [$num("2.2")$], [Wolfram], [$num("5.3")$],
        [Kohle], [$num("5000")$], [Wolfram bei $qty("1000", "Celsius")$], [$num("33")$],
        [Konstantan], [$num("49")$], [Wolfram bei $qty("2000", "Celsius")$], [$num("70")$],
        [Kupfer (rein)], [$num("1.7")$], [Wolfram bei $qty("3000", "Celsius")$], [$num("113")$],
        [Messing], [$num("7")$], [Zink], [$num("5.8")$],
        table.hline(start: 0, stroke: 0.5pt)
      )],
      [#table(
        columns: 2*(3cm, 1.5cm),
        align: (left, right),
        stroke: none,
        table.header(
          table.cell(colspan: 4)[Halbleiter bei $qty("20", "Celsius")$ in $unit("Ohm meter")$]
        ),
        table.hline(start: 0, stroke: 0.5pt),
        table.vline(x: 2, stroke: 0.5pt),
        [Germanium], [$num("0.46")$], [Silizium], [$num("3e3")$],
        
        table.hline(start: 0, stroke: 0.5pt)
      )],
      [#table(
        columns: 2*(3cm, 1.5cm),
        align: (left, right),
        stroke: none,
        table.header(
          table.cell(colspan: 4)[Isolatoren bei $qty("20", "Celsius")$ in $unit("Ohm meter")$]
        ),
        table.hline(start: 0, stroke: 0.5pt),
        table.vline(x: 2, stroke: 0.5pt),
        [Bernstein], [$num("1e18")$], [Plexiglas], [$num("1e13")$],
        [Glimmer], [$num("5e14")$], [PVC], [$num("1e13")$],
        [Hartgummi], [$num("1e16")$], [Quarzglas], [$num("3e14")$],
        table.hline(start: 0, stroke: 0.5pt)
      )]
    ), caption: [Spezifischer elektrischer Widerstand] 
  )<rho_el>
],
[
  // Intervalle
  
  #figure(
    table(
      columns: 2,
      align: (left, center),
      stroke: none,
     
      table.header(
        [Name], [$f_2:f_1$]
      ),
      table.hline(start: 0, stroke: 0.5pt),
      [Prime], [$1:1$],
      [Sekunde], [$9:8$],
      [Terz], [$5:4$],
      [Quarte], [$4:3$],
      [Quinte], [$3:2$],
      [Sexte], [$5:3$],
      [Septime], [$15:8#h(0.5em)$],
      [Oktave], [$2:1$],
      table.hline(start: 0, stroke: 0.5pt),
    ),caption: [Intervalle]
  )<intervall>
])

// Spektrum
#figure(
  [#table(stroke: none)[
    #cetz.canvas({
      import cetz.draw: *
      set-style(stroke: 0.5pt)
      scale(0.95)
  
      // Wellenlänge
      line((-8,0), (4.2,0))
  
      for lambda in range(-16, 9, step: 2) {
        line(( lambda / 2, 0), (rel: (0, -0.2)))
        content((), [$num(#str("e"+str(lambda)))$], anchor: "north", padding: 2pt)
      }

      // Frequenz
      line((-8,2), (4.2,2))

      for f in range(24, -1, step: -2){
        line(( (24-f) / 2 - 7.8, 2), (rel: (0, 0.2)))
        content((), [$num(#str("e"+str(f)))$], anchor: "south", padding: 2pt)
      }
      // Box
      rect((-8, 0), (4.2, 2), stroke: none, fill: gray.lighten(80%))

      // Legenden
      content((1.5, 3), [$<-$ zunehmende Frequenz $f$ in Hz])
      content((1.5, -1), [zunehmende Wellenlänge $lambda$ in m $->$])

      // Unterteilung
      line((-5.5, 0), (rel: (0,2)))
      line((-4.1, 0), (rel: (0,2)))
      line((-1.5, 0), (rel: (0,2)))
      line((0, 0), (rel: (0,2)))
      line((0.5, 0), (rel: (0,2)), stroke: (dash: "dotted"))
      line((1, 0), (rel: (0,2)), stroke: (dash: "dotted"))
      line((1.5, 0), (rel: (0,2)))
      rect((-3.3, 0), (-3.1,2), stroke: none, fill: gradient.linear(..color.map.spectral, angle: -180deg))

      // Beschriftung der Unterteilung
      content((-6.75, 1), [$gamma$-Strahlen])
      content((-4.8, 1), text(size: 9pt)[Röntgen-#linebreak()Strahlen])
      content((-3.7, 1), [UV])
      content((-2.3, 1), [IR])
      content((-0.75, 1), [Mikro-#linebreak()Wellen])
      content((0.25, 1.5), text(size: 8pt)[FM])
      content((1.25, 1.5), text(size: 8pt)[AM])
      content((0.75, 0.7), [Radio-#linebreak()Wellen])
      content((2.75, 1), [Längstwellen])

      // sichtbares Licht
      rect((-6, -1.5), (0,-2.5), stroke: none, fill: gradient.linear(..color.map.spectral, angle: -180deg))
      line((-3.3, 0), (-3.3, -1), (-6, -1.5), stroke: (dash: "dotted"))
      line((-3.1, 0), (-3.1, -1), (0, -1.5), stroke: (dash: "dotted"))
      // feine Skala
      for lambda in range(-60, 1, step: 2) {
        line((lambda/10, -2.5), (rel: (0, -0.1)))
      }
      // grobe Skala
      for (strich, lambda) in ((-6, 400), (-4, 500), (-2, 600), (0, 700)){
        line((strich, -2.6), (rel: (0, -0.1)))
        content((), [#lambda nm], anchor: "north", padding: 1pt)
      }
    })
  ]
], caption: [Spektrum der elektromagnetischen Wellen])

#pagebreak()

// Trägheitsmomente
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  align: horizon + center,
  // Dünner Stab
  [#cetz.canvas({
    import cetz.draw: *
    import cetz.vector: *

    set-style(stroke: (thickness: 0.5pt, cap: "round"))

    
    let r = 0.1
    let h = 2.0
    let O = (0, 0) 
    let M = (h, 0)

    line((0.75,-0.09), (rel: (0, 0.5)), stroke: (paint:blue, dash: "dash-dotted"), name: "DA")

    line((0.75,-0.3), (rel: (0, -0.3)), stroke: (paint:blue, dash: "dash-dotted"))

    rotate(
      x: -20deg,
      y: -20deg, 
    )
    arc(add(O, (0,r)), radius: r, start: 90deg, delta: 180deg)

    line(add(O, (0, -r)), add(M, (0, -r)), stroke: green, name: "l")
    line(add(O, (0, r)), add(M, (0, r)))
  
    // --- 3. Die obere Deckfläche zeichnen ---
    circle(M, radius: r)
    content("l.60%", text(fill: green)[$l$], anchor: "north", padding: 2pt)
    content("DA.end", text(fill: blue)[DA], anchor: "south")
    })
  ],

  // Quader
  [#cetz.canvas({
    import cetz.draw: *

    set-style(stroke: (thickness: 0.5pt, cap: "round"))

    scale(z: 0.5)

    let a = (0, 0)
    let b = (1, 0)
    let c = (1, 1)
    let d = (0, 1)
  
    let a1 = (-0.2, 0, 1)
    let b1 = (0.8, 0, 1)
    let c1 = (0.8, 1, 1)
    let d1 = (-0.2, 1, 1)

    let mitte-oben = (0.4, 1, 0.5)
    let unten = (0.5, 0, 1)
 
    line(b, c, d)
  
    line(a1, b1, stroke: blue, name: "a")
    line(b1, c1, d1)
    line(a1, d1, stroke: red, name: "c")
  
    line(b, b1, stroke: green, name: "b")
    line(c, c1)
    line(d, d1)

    // Um den Quader zu zentrieren
    line((1.2,0), (1.2,1), stroke: white)

    
    // DA
    line(mitte-oben, (rel: (0,0.5)), stroke: (paint: blue, dash: "dash-dotted"), name: "DA")
    line(unten, (rel: (0, -0.3)), stroke: (paint: blue, dash: "dash-dotted"))

    content("a.50%", text(fill: blue)[$a$], anchor: "north")
    content("b.50%", text(fill: green)[$b$], anchor: "north-west")
    content("c.50%", text(fill: red)[$c$], anchor: "east", padding: 1pt)
    content("DA.end", text(fill: blue)[DA], anchor: "south")
    })#v(0.5em)
  ],

  // Vollzylinder
  [#cetz.canvas({
    import cetz.draw: *
    import cetz.vector: *

    set-style(stroke: (thickness: 0.5pt, cap: "round"))

    
    let r = 0.7
    let h = 1
    let O = (0, 0) 
    let M = (0, h)

    line(M, (rel: (0, 0.5)), stroke: (paint:blue, dash: "dash-dotted"), name: "DA_p")
    line(add(O, (0,-r/4)), (rel: (0, -0.2)), stroke: (paint:blue, dash: "dash-dotted"))

    line((r, h/2), (rel: (0.3, 0)), stroke: (paint:blue, dash: "dash-dotted"), name: "DA_s")
    line((-r, h/2), (rel: (-0.3, 0)), stroke: (paint:blue, dash: "dash-dotted"))

    arc(add(O, (r,0)), radius: (r, r/4), start: 0deg, delta: -180deg)

    line(add(O, (-r, 0)), add(M, (-r, 0)), stroke: blue, name: "h")
    line(add(O, (r, 0)), add(M, (r, 0)))
  
    circle(M, radius: (r,r/4))
    line(M, (rel: (r,0)), stroke: green, mark: (end: "barbed", scale: 0.5), name: "r")

    // Um den Quader zu zentrieren
    line((-1.6,0), (-1.2,1), stroke: white)

    content("h.10%", text(fill: blue)[$h$], anchor: "east", padding: 2pt)
    content("r.end", text(fill: green)[$r$], anchor: "west", padding: 1pt)
    content("DA_p.end", text(fill: blue)[$"DA"_||$], anchor: "south")
    content("DA_s.end", text(fill: blue)[$"DA"_perp$], anchor: "west")
    })#v(1em)
  ],

  [#cetz.canvas({
    import cetz.draw: *
    import cetz.vector: *

    set-style(stroke: (thickness: 0.5pt, cap: "round"))
    
    let r1 = 0.7
    let r2 = 1.0
    let h = 0.6
    let O = (0, 0) 
    let M = (0, h)

    line(add(M, (0,-r1/4)), (rel: (0, 0.7)), stroke: (paint:blue, dash: "dash-dotted"), name: "DA")
    line(add(O, (0,-r2/4)), (rel: (0, -0.2)), stroke: (paint:blue, dash: "dash-dotted"))


    arc(add(O, (r2,0)), radius: (r2, r2/4), start: 0deg, delta: -180deg)

    line(add(O, (-r2, 0)), add(M, (-r2, 0)), stroke: blue, name: "h")
    line(add(O, (r2, 0)), add(M, (r2, 0)))
  
    circle(M, radius: (r2,r2/4))
    circle(M, radius: (r1, r1/4))
    
    line(M, (rel: (r2,0)), stroke: red, mark: (end: "barbed", scale: 0.5), name: "r2")
    line(M, (rel: (-130deg,0.23)), stroke: green, mark: (end: "barbed", scale: 0.5), name: "r1")
    
    content("h.50%", text(fill: blue)[$h$], anchor: "east", padding: 2pt)
    content("r1.end", text(fill: green)[$r_1$], anchor: "south-east", padding: 1pt)
    content("r2.end", text(fill: red)[$r_2$], anchor: "west", padding: 1pt)
    content("DA.end", text(fill: blue)[$"DA"$], anchor: "south")
    })#v(1em)
  ],
  [Dünner Stab#v(1em)], [Quader#v(1em)], [Vollzylinder#v(1em)], [Hohlzylinder#v(1em)]
)

#figure(table(
  columns: (1.55fr,0.25fr,2fr,1.1fr),
  align: (left),
  stroke: none,
  table.hline(start: 0, stroke: 0.5pt),
  [Dünner Stab], table.cell(colspan: 3)[$J_"SP"=1/12 m #text(fill: green)[$l$]^2$], 
  [#h(1em)Achse $perp$ zum Stab#v(1em)], text(fill: green)[$l$], [Länge des Stabes], [$[l]=qty("1", "m")$],
  
  [Quader], table.cell(colspan: 3)[$J_"SP"=1/12 m(#text(fill: blue)[$a$]^2+#text(fill: green)[$b$]^2)$],
  [#h(1em)Achse || zu #text(fill: red)[$c$]], text(fill: blue)[$a$], [Länge des Quaders], [$[a]=qty("1", "m")$],
  [#v(1em)$$], text(fill: green)[$b$], [Breite des Quaders], [$[b]=qty("1", "m")$],
  
  [Vollzylinder], table.cell(colspan: 3)[$J_"SP"=1/2m#text(fill: green)[$r$]^2$],
  [#h(1em)Achse || zu #text(fill: blue)[$h$]#v(1em)], text(fill: green)[$r$], [Zylinderradius], [$[r]=qty("1", "m")$],
  
  [Vollzylinder], table.cell(colspan: 3)[$J_"SP"=m(#text(fill: green)[$r$]^2/4+#text(fill: blue)[$h$]^2/12)$],
  [#h(1em)Achse $perp$ zu #text(fill: blue)[$h$]], text(fill: green)[$r$], [Zylinderradius], [$[r]=qty("1", "m")$],
  [#v(1em)$$], text(fill: blue)[$h$], [Höhe des Zylinders], [$[h]=qty("1", "m")$],

  [Hohlzylinder], table.cell(colspan: 3)[$J_"SP"=1/2m(#text(fill: green)[$r_1$]^2+#text(fill: red)[$r_2$]^2)$],
  [#h(1em)Achse || zu #text(fill: blue)[$h$]], text(fill: green)[$r_1$], [Innenradius], [$[r_1]=qty("1", "m")$],
  [#v(1em)$$], text(fill: red)[$r_2$], [Aussenradius], [$[r_2]=qty("1", "m")$],

  [Vollkugel], table.cell(colspan: 3)[$J_"SP"=2/5 m#text(fill: green)[$r$]^2$],
  [#v(1em)$$], text(fill: green)[$r$], [Kugelradius], [$[r]=qty("1", "m")$],

  [Hohlkugel], table.cell(colspan: 3)[$J_"SP" approx 2/3m#text(fill: green)[$r$]^2$],
  [#h(1em) sehr kl. Wandstärke], text(fill: green)[$r$], [äusserer Kugelradius], [$[r]=qty("1", "m")$],
  table.hline(start: 0, stroke: 0.5pt),
), caption: [Trägheitsmoment])<J>


// Lizenz
#align(right + bottom)[#text(size: 7pt)[#ccicon("cc-by-sa//de", link: true) Diese Formelsammlung ist lizenziert mit einer CC-BY-SA 4.0 International Lizenz durch Christian Prim]]
#pagebreak()

#set page(footer: none)

// Allgemeine Konstanten, Zehnervorsätze
#figure(
  table(
    columns: (6cm, 1fr, 2fr, 0.2fr, 1fr, 2.5fr),
    align: (left, center, left, center, left, left),
    inset: 4pt,
    stroke: none,
    table.hline(start: 0, stroke: 0.5pt),
    
    [Gravitationskonstante], [$G$], [6.67430], [$dot$], [$10^(-11)$], [$unit("N m^2/kg^2")$],
    [Lichtgeschwindigkeit], [$c$], [2.99792458], [$dot$], [$10^8$], [$unit("m/s")$],
    [Magnetische Feldkonstante], [$mu_0$], [$4 pi$], [$dot$], [$10^(-7)$], [$unit("V s/A/m")$],
    [Elektrische Feldkonstante], [$epsilon_0$], [8.85418782], [$dot$],[$10^(-12)$], [$unit("A s / V / m")$],
    [Elementarladung], [$e$], [1.60217663], [$dot$], [$10^(-19)$], [$unit("C")$],
    [#smallcaps[Planck]sches Wirkungsquantum], [$h$], [	6.62607015], [$dot$], [$10^(-34)$], [$unit("J s")$],
    [Masse des Elektrons], [$m_e$], [9.10938371], [$dot$], [$10^(-31)$], [$unit("kg")$],
    [Masse des Protons], [$m_p$], [1.67262193], [$dot$], [$10^(-27)$], [$unit("kg")$],
    [Masse des Neutrons], [$m_n$], [1.67492750], [$dot$], [$10^(-27)$], [$unit("kg")$],
    [Atomare Masseneinheit], [$u$], [1.66053907], [$dot$], [$10^(-27)$], [$unit("kg")$],
    [#smallcaps[Bohr]scher Radius], [$r_1$], [5.29177210], [$dot$], [$10^(-11)$], [$unit("m")$],
    [Ortsfaktor/Fallbeschleunigung], [$g$], [9.81], [], [], [$unit("m/s^2")$],
    [Normdruck], [$p_n$], [101325], [], [], [$unit("Pa")$],
    [Normtemperatur], [$T_n$], [273.15], [], [], [$unit("K")$],
    [Molares Normvolumen], [$V_n$], [22.4139695], [$dot$], [$10^(-3)$], [$unit("m^3/mol")$],
    [#smallcaps[Avogadro]-Konstante], [$N_A$], [6.02214076], [$dot$], [$10^(23)$], [$unit("1/mol")$],
    [Universelle Gaskonstante], [$R$], [8.31446262], [], [], [$unit("J/mol/K")$],
    [#smallcaps[Boltzmann]-Konstante], [$k$], [1.380649], [$dot$], [$10^(-23)$], [$unit("J/K")$],
    [#smallcaps[Stefan-Boltzmann]-Konstante], [$sigma$], [5.67037442], [$dot$], [$10^(-8)$], [$unit("W/m^2/K^4")$],
    [Solarkonstante], [$S$], [1361], [], [], [$unit("W/m^2")$],
    [#smallcaps[Feigenbaum]-Konstante], [$delta$], [4.66920160], [], [], [],
    [Deutliche Sehweite], [$s_0$], [0.25], [], [], [$unit("m")$],
    [Intensität der Hörschwelle], [$I_0$], [1.0], [$dot$], [$10^(-12)$], [$unit("W/m^2")$],
    table.hline(start: 0, stroke: 0.5pt),
), caption: [Allgemeine Konstanten]
)
#v(1fr)
#figure(
  table(
    columns: 3*(1.5fr, 1fr, 2fr),
    align: 3*(left, center, left),
    stroke: none,
    table.hline(start: 0, stroke: 0.5pt),
    table.vline(x: 3, stroke: 0.5pt),
    table.vline(x: 6, stroke: 0.5pt),
    [$10^(-24)$], [y], [Yokto], [$10^(-3)$], [m], [Milli], [$10^6$], [M], [Mega], 
    [$10^(-21)$], [z], [Zepto], [$10^(-2)$], [c], [Zenti], [$10^9$], [G], [Giga],
    [$10^(-18)$], [a], [Atto], [$10^(-1)$], [d], [Dezi], [$10^(12)$], [T], [Tera],
    [$10^(-15)$], [f], [Femto], [], [], [], [$10^(15)$], [P], [Peta],
    [$10^(-12)$], [p], [Pico], [$10^1$], [da], [Deka], [$10^(18)$], [E], [Exa],
    [$10^(-9)$], [n], [Nano], [$10^2$], [h], [Hekto], [$10^(21)$], [Z], [Zetta],
    [$10^(-6)$], [$upright(mu)$], [Mikro], [$10^3$], [k], [Kilo], [$10^(24)$], [Y], [Yotta],
    table.hline(start: 0, stroke: 0.5pt)  
  ), caption: [Zehnervorsätze]
)