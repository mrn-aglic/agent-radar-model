__includes
[
  "nls_files/file-utilities.nls"
  "nls_files/setup.nls"
  "nls_files/utilities.nls"
  "nls_files/decision_functions.nls"
  "nls_files/evaluation-utilities.nls"
  "nls_files/projections.nls"
  "nls_files/test.nls"
  "nls_files/behaviour.nls"
  "nls_files/waves.nls"
  "nls_files/sensor.nls"
  "nls_files/decisionmaking.nls"
  "nls_files/movableobjects.nls"
  "nls_files/relationquadrant.nls"
  "nls_files/experimental.nls"
]

globals
[
  ;; agents
  agent
  scope
  searcher-zero
  rq-antenna

  clock-state

  max-distance
  ms
  minn
  maxx

  ;; parameters for analysis
  number-of-steps
  patches-trail

  ;; obstacle memory patch color
  memory-pcolor-min
  memory-pcolor-max

  ;; trail memory patch color
  trail-pcolor-min
  trail-pcolor-max

  ;; failsafe if all searchers die
  f_array

  ;; testing
  counter

  record-distances
  record-headings

  dis-distances
  dis-headings

  number-of-collisions
  collisioned-with

]

breed [ waves ]
breed [ antennas ]
breed [ scopes ]
breed [ scope-markers ]
breed [ searchers ]

breed [ m-objects ]

breed [ rq-antennas ]
breed [ rq-m-objects ]

waves-own [ time bounced? found-goal? ]

searchers-own
[
  df
  on-goal?
  k
  d-closest
]

scope-markers-own [ time found-goal? ]

m-objects-own [ rq-object ]

patches-own [ goal? is-mapped? ]

to startup

  setup

end

to go

  if ( pen-down? )
  [ ask antennas [ pd ] ]

  start-behaviour

  distances-distribution
  headings-distribution

end


to distances-distribution

  set-current-plot "Histogram distance"

  set-current-plot-pen "default"

  set-histogram-num-bars 10

  histogram dis-distances

end

to headings-distribution

  set-current-plot "Histogram heading"

  set-current-plot-pen "default"

  set-histogram-num-bars 10

  histogram dis-headings

end
@#$#@#$#@
GRAPHICS-WINDOW
207
10
1088
522
33
18
13.0
1
10
1
1
1
0
0
0
1
-33
33
-18
18
0
0
1
ticks
30.0

BUTTON
12
10
120
43
Set simulation
startup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
11
94
183
127
scope-radius
scope-radius
2
10
4
2
1
NIL
HORIZONTAL

SLIDER
1124
448
1285
481
sweep-angle
sweep-angle
1
9
6
2
1
NIL
HORIZONTAL

BUTTON
12
53
129
86
Start simulation
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SWITCH
22
134
157
167
waves-visible?
waves-visible?
0
1
-1000

SLIDER
5
178
177
211
resolution
resolution
0.1
1
0.7
0.2
1
NIL
HORIZONTAL

BUTTON
1130
67
1281
100
Draw static objects
if ( mouse-down? )\n[\n  ask patch mouse-xcor mouse-ycor \n  [\n    set pcolor gray\n    set goal? false\n  ]\n]
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
1130
125
1342
158
Remove static objects or goal
if ( mouse-down? )\n[\n  ask patch mouse-xcor mouse-ycor \n  [\n   set pcolor black\n   set goal? false\n  ]\n]
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
12
659
253
692
memory-fade-parameter
memory-fade-parameter
0
28
0
1
1
NIL
HORIZONTAL

SLIDER
14
401
170
434
weight-param-a
weight-param-a
0
1
0.1
0.1
1
NIL
HORIZONTAL

SLIDER
8
473
168
506
weight-param-b
weight-param-b
0
1
0.1
0.1
1
NIL
HORIZONTAL

BUTTON
1141
174
1227
207
Save map
save-map
NIL
1
T
OBSERVER
NIL
S
NIL
NIL
1

BUTTON
1142
216
1224
249
NIL
load-map
NIL
1
T
OBSERVER
NIL
L
NIL
NIL
1

CHOOSER
13
310
167
355
decision-function
decision-function
"default" "function"
1

SWITCH
1113
263
1256
296
hide-searchers?
hide-searchers?
1
1
-1000

SWITCH
1115
309
1295
342
activate-m-objects?
activate-m-objects?
1
1
-1000

SLIDER
1117
402
1274
435
num-m-objects
num-m-objects
1
10
3
1
1
NIL
HORIZONTAL

TEXTBOX
17
365
135
393
Change weight of closest-patch-distance
11
0.0
1

TEXTBOX
11
443
179
471
Change weight of deflection-angle
11
0.0
1

TEXTBOX
284
557
1136
616
The parameters weight-param-a and weight-param-b affect the selection of which heading to take only if the choose-path-method is set to function. The function calculating which heading to take is of the form: \n f = a * closest-patch-distance - b * deflection-angle
11
0.0
1

SLIDER
13
608
256
641
trail-memory-fade-parameter
trail-memory-fade-parameter
0
28
4
1
1
NIL
HORIZONTAL

MONITOR
298
620
421
665
trail fade quotient
trail-memory-fade-parameter / 4
17
1
11

BUTTON
1289
66
1382
99
Draw goal
if ( mouse-down? )\n[\n  ask patch mouse-xcor mouse-ycor \n  [\n   set pcolor magenta\n   set goal? true\n  ]\n]
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SWITCH
12
525
138
558
pen-down?
pen-down?
0
1
-1000

MONITOR
293
672
421
717
memory fade quotient
memory-fade-parameter / 4
17
1
11

SLIDER
1126
491
1298
524
width-of-world
width-of-world
5
133
67
2
1
NIL
HORIZONTAL

BUTTON
1124
573
1385
606
Set width and height to default values
set width-of-world 67\nset height-of-world 37
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
1124
533
1296
566
height-of-world
height-of-world
5
133
37
2
1
NIL
HORIZONTAL

MONITOR
1246
169
1363
214
Loaded file name
file-name
17
1
11

INPUTBOX
479
614
1028
760
command
NIL
1
1
String (commands)

BUTTON
707
774
815
833
Fix
choose-directory-and-fix-files-in-directory task command\n
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SWITCH
12
562
137
595
leave-trail?
leave-trail?
1
1
-1000

TEXTBOX
1222
668
1372
710
103\n79\n8
11
0.0
1

SWITCH
1120
355
1292
388
enable-user-message?
enable-user-message?
1
1
-1000

SLIDER
14
229
186
262
area-of-interest-r
area-of-interest-r
0
scope-radius
4
1
1
NIL
HORIZONTAL

SLIDER
15
268
187
301
step-size
step-size
0.1
1
1
0.1
1
NIL
HORIZONTAL

BUTTON
1117
19
1234
52
NIL
move-objects
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

PLOT
1416
10
1848
340
Histogram distance
NIL
NIL
-0.5
1.5
0.0
1000.0
true
false
"set dis-distances []" ""
PENS
"default" 1.0 1 -16777216 true "" ""

PLOT
1415
370
1853
712
Histogram heading
NIL
NIL
-0.5
1.5
0.0
1000.0
true
false
"set dis-headings []" ""
PENS
"default" 1.0 1 -16777216 true "" ""

CHOOSER
1037
618
1214
663
normalize-distance-with
normalize-distance-with
"default" "circle area" "rpi" "max-distance"
0

SLIDER
13
766
253
799
seed
seed
0
500
200
1
1
NIL
HORIZONTAL

SWITCH
12
718
130
751
set-seed?
set-seed?
0
1
-1000

@#$#@#$#@
## WHAT IS IT?

This section could give a general understanding of what the model is trying to show or explain.

## HOW IT WORKS

This section could explain what rules the agents use to create the overall behavior of the model.

## HOW TO USE IT

This section could explain how to use the model, including a description of each of the items in the interface tab.

## THINGS TO NOTICE

This section could give some ideas of things for the user to notice while running the model.

## THINGS TO TRY

This section could give some ideas of things for the user to try to do (move sliders, switches, etc.) with the model.

## EXTENDING THE MODEL

This section could give some ideas of things to add or change in the procedures tab to make the model more complicated, detailed, accurate, etc.

## NETLOGO FEATURES

This section could point out any especially interesting or unusual features of NetLogo that the model makes use of, particularly in the Procedures tab.  It might also point out places where workarounds were needed because of missing features.

## RELATED MODELS

This section could give the names of models in the NetLogo Models Library or elsewhere which are of related interest.

## CREDITS AND REFERENCES

This section could contain a reference to the model's URL on the web if it has one, as well as any other necessary credits or references.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

antenna
true
0
Polygon -7500403 false true 0 150 46 256 148 299 255 255 298 151 225 240 181 255 120 255 74 241
Polygon -7500403 false true 119 254 150 150 180 255

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

phosphor
false
5
Circle -10899396 true true 0 0 300

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

scope-frame
false
5
Circle -16777216 true false 15 15 270
Circle -10899396 false true 15 15 270
Line -10899396 true 0 15 300 15

scope-sweep
true
5
Line -10899396 true 150 15 150 150

sheep
false
0
Rectangle -7500403 true true 151 225 180 285
Rectangle -7500403 true true 47 225 75 285
Rectangle -7500403 true true 15 75 210 225
Circle -7500403 true true 135 75 150
Circle -16777216 true false 165 76 116

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wave
true
2
Line -955883 true 15 119 150 180
Line -955883 true 150 180 285 120

wave-return
true
2
Polygon -955883 true true 15 120 28 104 150 179 271 105 284 122 150 203

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270

@#$#@#$#@
NetLogo 5.3
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="experiment" repetitions="10" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <final>output-collisioned-with</final>
    <timeLimit steps="5000"/>
    <enumeratedValueSet variable="scope-radius">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="memory-fade-parameter">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="command">
      <value value="&quot;&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="pen-down?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hide-searchers?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="weight-param-b">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="leave-trail?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="resolution">
      <value value="0.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="area-of-interest-r">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="weight-param-a">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="decision-function">
      <value value="&quot;function&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num-m-objects">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="waves-visible?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="sweep-angle">
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="activate-m-objects?">
      <value value="false"/>
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed">
      <value value="200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="trail-memory-fade-parameter">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="enable-user-message?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="normalize-distance-with">
      <value value="&quot;default&quot;"/>
      <value value="&quot;circle area&quot;"/>
      <value value="&quot;rpi&quot;"/>
      <value value="&quot;max-distance&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="height-of-world">
      <value value="37"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="set-seed?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="step-size">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="width-of-world">
      <value value="67"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

@#$#@#$#@
0
@#$#@#$#@
