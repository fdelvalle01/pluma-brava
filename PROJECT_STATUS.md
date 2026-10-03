# Pluma Brava — estado y siguiente tarea

**Última actualización de este registro:** 2026-10-03.  
**Origen del estado inicial:** conversación y capturas de Francisco; no una inspección directa del repositorio.  
**Prioridad:** probar la animación importada del oficinista y su sincronización con el golpe. Francisco confirmó previamente el ciclo jugable de completos y zombi.

## 1. Confirmado hasta ahora

| Elemento | Evidencia disponible |
| --- | --- |
| Proyecto `PlumaBrava` creado en GameMaker. | Capturas del editor y ejecución. |
| Sprite `spr_player` de 32 × 32, dibujado a mano. | Captura del editor de imagen; paloma visible. |
| Origen del jugador abajo al centro. | `spr_player.yy`: origen `(16, 32)` en un sprite de 32 × 32. |
| Recursos `spr_ground`, `obj_player`, `obj_solid` y `Room1`. | Registrados en `PlumaBrava.yyp` e inspeccionados en disco. |
| Eventos Crear y Paso en `obj_player`. | Registrados en `obj_player.yy`; GML inspeccionado antes de PB-003. |
| Suelo colocado y dos plataformas elevadas en el escenario. | Suelo confirmado por Francisco; instancias observadas en `Room1.yy`. |
| El proyecto compiló y abrió una ventana de juego. | Confirmación explícita de Francisco después de la reparación con Codex. |
| La paloma se mueve horizontalmente. | Reporte explícito: «solo me puedo mover en x». |
| La paloma salta. | Confirmación explícita de Francisco el 2026-10-03. |
| Gravedad, colisiones generales con `obj_solid` y orientación izquierda/derecha. | Confirmación explícita de Francisco; las pruebas específicas junto a paredes y techos no están documentadas. |
| `spr_player_jump` en el aire y `spr_player` al aterrizar. | Confirmación de Francisco y cambio de sprite existente en `Step_0.gml`. |
| Máscara explícita de `obj_player`. | `obj_player.yy` asigna `spr_player` como `spriteMaskId`, incluso cuando se dibuja `spr_player_jump`. |

La confirmación del salto no equivale a haber probado las colisiones laterales, con techos o al aterrizar sobre las plataformas.

## 2. Pendiente de verificar

- La caída y el aterrizaje sobre suelo y plataformas sin atravesarlos.
- Si las colisiones laterales y contra la parte inferior de los bloques funcionan.
- Si el jugador puede reaparecer al caer fuera del escenario; no hay implementación confirmada.
- Si la orientación conserva la dirección al detenerse y no atasca al jugador junto a un bloque.
- La nueva mecánica de aleteo y planeo durante una prueba jugable completa.
- Los valores reales de la room, cámara y escalado.

**El salto está confirmado por Francisco.** Las demás pruebas jugables de colisión permanecen pendientes.

## 3. Inventario inicial para localizar recursos

| Recurso | Tipo | Papel esperado |
| --- | --- | --- |
| `PlumaBrava.yyp` | Proyecto | Entrada del proyecto. |
| `spr_player` | Sprite | Paloma dibujada por Francisco. |
| `spr_player_jump` | Sprite | Animación aérea existente. |
| `obj_player` | Objeto | Jugador; utiliza `spr_player`. |
| `spr_ground` | Sprite | Bloque de suelo. |
| `obj_solid` | Objeto | Bloques usados por las colisiones. |
| `Room1` | Room | Escenario de pruebas actual. |

Rutas habituales que el agente debe confirmar, no crear a ciegas:

```text
objects/obj_player/obj_player.yy
objects/obj_player/Create_0.gml
objects/obj_player/Step_0.gml
objects/obj_solid/obj_solid.yy
sprites/spr_player/spr_player.yy
sprites/spr_ground/spr_ground.yy
rooms/Room1/Room1.yy
```

En la preparación se utilizaron variables llamadas `hsp`, `vsp`, `move_speed`, `jump_speed` y `gravity_force`. Los valores de referencia vistos/propuestos fueron `2.5`, `-6` y `0.3` para las últimas tres. El código real del repositorio manda: no sustituirlo por un ejemplo de la conversación sin leerlo.

## 4. Entorno observado

Windows, GameMaker LTS 2026, edición GML y VS Code. Las capturas iniciales mostraron IDE `2026.0.0.16` y los logs runtime `2026.0.0.23`.

Son versiones observadas, no una orden para instalar, actualizar o fijar versiones. La configuración actual debe inspeccionarse localmente. Los agentes no conocen automáticamente las rutas o permisos disponibles en otra sesión.

## 5. Incidencia de compilación ya superada

Al ejecutar y al limpiar apareció:

```text
GMAssetCompiler.dll exited with non-zero status (-1)
FAILED: Run Program Complete
FAILED : Clean Program Complete
```

La pestaña de errores de compilación estaba vacía. Después de la revisión/reparación con Codex, Francisco confirmó que el proyecto compiló y arrancó.

**No se dispone aquí del diagnóstico completo ni del diff de esa reparación.** No atribuir retrospectivamente el problema al antivirus, a la caché o al runtime como si se hubiera demostrado. No rehacer la reparación ni borrar archivos del entorno sin una nueva evidencia de fallo.

Una salida genérica `-1` y una pestaña vacía no bastan para descartar errores de recursos, metadatos o código.

## 6. Backlog de avance

Estados: `pendiente`, `en_curso`, `implementado_sin_verificar`, `verificado` y `bloqueado`. Solo `verificado` significa que hay evidencia de que se cumple el resultado esperado.

| ID | Tarea | Estado inicial | Resultado esperado |
| --- | --- | --- | --- |
| PB-001 | Base del proyecto y ejecución. | verificado | Se abre el juego con paloma, bloques y movimiento horizontal. |
| PB-002 | Verificar/corregir salto, gravedad y colisiones. | implementado_sin_verificar | El salto está confirmado; faltan pruebas de caída, aterrizaje, paredes y techos. |
| PB-002A | Aleteo por pulsaciones y planeo aéreo. | implementado_sin_verificar | Aletea repetidamente sin mantener vuelo automático y desciende lentamente al soltar Espacio. |
| PB-003 | Orientación al moverse. | implementado_sin_verificar | Dirección izquierda/derecha confirmada por Francisco; falta una prueba específica de giro junto a bloques. |
| PB-004 | Reaparición básica al caer. | pendiente | Puede retomarse la prueba después de salir del escenario. |
| PB-005 | Encuadre y escalado del prototipo. | pendiente | El jugador y el espacio jugable tienen una escala acordada y legible. |
| PB-006 | Disparo de pistola y objetivo simple. | pendiente | El proyectil sale hacia el lado correcto, impacta y se elimina. |
| PB-007 | Vida, daño y primer enemigo. | pendiente | Hay un encuentro básico con posibilidad de perder y reintentar. |
| PB-008 | Completazo y cambio de arma. | pendiente | Recoger la segunda arma cambia de forma perceptible el ataque. |
| PB-009 | Recorrido corto y segundo enemigo. | pendiente | El escenario enseña las mecánicas de manera gradual. |
| PB-010 | Punto de control y jefe. | pendiente | Combate completo con un ataque inicial, derrota y victoria. |
| PB-011 | Animaciones, audio y ajustes de demo. | pendiente | Demo corta con presentación y respuestas claras. |

Esta tabla expresa un orden propuesto. No autoriza implementar las tareas siguientes ni impide que Francisco cambie la prioridad. Las animaciones pueden incorporarse antes cuando sean útiles.

## 7. PB-002A — aleteo y planeo pendiente de validación

### Objetivo

Permitir aleteos repetidos mediante nuevas pulsaciones de Espacio en el aire y una caída más lenta al dejar de pulsar, sin vuelo automático al mantener la tecla.

### Revisión e implementación

Se inspeccionaron Create, Step, `spr_player`, `spr_player_jump`, la máscara explícita y el registro del proyecto. El bloque existente de Step cambia entre ambos sprites según el apoyo; la animación aérea no se reinicia desde el nuevo código.

Create define `flap_force = 3.0`, `flap_max_rise_speed = 9.0`, `glide_gravity = 0.12` y `glide_max_fall_speed = 2.2`. Step conserva `facing`, `hsp` y las colisiones existentes. Una pulsación de Espacio en el suelo mantiene `jump_speed`; cada nueva pulsación en el aire resta `flap_force` a `vsp` hasta el límite de ascenso. Sin nuevas pulsaciones, la gravedad reduce el ascenso y luego el descenso usa `glide_gravity` y un límite de caída. Mantener la tecla no repite el impulso.

No se añadieron recursos, estamina, interfaz ni sonidos. El futuro límite por estamina se podrá colocar en la rama de aleteo sin sustituir el movimiento actual.

### Criterios de aceptación

- [ ] Caminar y saltar desde el suelo siguen funcionando.
- [ ] Una nueva pulsación de Espacio en el aire produce un aleteo; varias pulsaciones permiten ganar altura.
- [ ] Mantener Espacio no repite impulsos y dejar de pulsar termina en descenso lento, con velocidad máxima.
- [ ] Se aterriza y se puede repetir la secuencia; no se atraviesa `obj_solid`.
- [ ] `spr_player_jump` anima durante el vuelo y la dirección izquierda/derecha se conserva.
- [ ] No aparecen errores ni bloqueos durante la prueba.

### Verificación

Revisión estática: Create y Step conservan el movimiento horizontal, salto inicial, bloque de colisiones y cambio de sprite; el aleteo depende de `keyboard_check_pressed`. Compilación: Igor del runtime 2026.0.0.23, destino Windows Compile sobre `PlumaBrava.yyp`, finalizó con código `0` el 2026-10-03. Prueba jugable de PB-002A: pendiente de Francisco.

### Siguiente acción

Francisco debe recargar `PlumaBrava.yyp` y probar suelo → salto → varias pulsaciones aéreas → soltar → aterrizar → repetir. No avanzar a estamina ni otra mecánica.

## 8. Bitácora

### 2026-10-03 — ataque animado del oficinista

Francisco importó la base East en `spr_zombie_oficinista` (68×68, origen 34, 68) y el ataque en `spr_zombie_oficinista_attack` (84×84, cinco frames). Se inspeccionaron todas las imágenes: el tercer frame aún lleva el maletín hacia atrás; el cuarto lo lleva delante. Por eso `attack_hit_frame = 3` (cuarto frame) define el golpe, en lugar del tercer frame sugerido antes de ver el recurso real.

Create ajusta únicamente en memoria el origen del ataque a (42, 76), compensando ocho píxeles de margen por lado respecto al lienzo base. Step muestra frames 0–2 durante los 30 pasos de anticipación, frame 3 durante los 8 pasos activos y frame 4 durante 8 pasos de recuperación; después vuelve a la base hasta completar la pausa. Las transiciones se resuelven antes del daño y de elegir el frame para mantener ambos sincronizados.

Se conserva reflejo East/West, máscara explícita de la base, patrulla, vida, alcance, invulnerabilidad y un impacto por ataque. Los colores provisionales de aviso/golpe se sustituyen por las poses; permanece el destello rojo al recibir daño. No se editaron imágenes ni metadatos. El jugador ya había confirmado «lo probe y funciona bien» sobre el encuentro anterior; esta nueva animación aún requiere validación.

Revisión estática y registro de sprites realizados; compilación y prueba jugable pendientes. Estado `implementado_sin_verificar`. Siguiente acción: recargar, acercarse desde ambos lados, comprobar pies estables al atacar, maletín delante al recibir daño, salto para esquivar y retorno a patrulla. Ajustes: `windup_steps`, `strike_steps`, `recovery_steps`, `recovery_pose_steps` y origen de ataque en Create.

### 2026-10-03 — disparo PixelLab conectado

Francisco creó `spr_player_shoot_pixellab`. Aunque informó cuatro frames, el recurso guardado contiene cinco imágenes de 40×40; se inspeccionaron y se conservaron todas. Su origen guardado es (0, 0); Create lo ajusta en memoria a (20, 36), igual que el vuelo. Step utiliza el nuevo sprite y su número real de frames para finalizar el ataque. Se conservan el reflejo izquierda/derecha y el lanzamiento único en el tercer frame (índice 2). La tabla del pico se amplió a cinco entradas y su índice se limita a la longitud de la tabla. Los offsets anteriores son provisionales: falta calibrar el alimento con las nuevas poses al jugar.

El ataque mantiene 0.2 frames por paso, ahora con duración aproximada de 25 pasos. Al finalizar vuelve a suelo o vuelo PixelLab. No se editaron imágenes, metadatos, máscara, daño ni proyectiles. Revisión estática y recursos verificados; sin nueva compilación o prueba jugable. Estado `implementado_sin_verificar`. Siguiente acción: recargar, recoger un completo y pulsar Z en ambos sentidos y en el aire; comprobar salida en el tercer frame, ausencia de repetición y alineación de cuerpo/pico.

### 2026-10-03 — prueba visual PixelLab

Francisco importó `spr_player_pixellab` (32×32, un frame) y `spr_player_fly_pixellab` (40×40, ocho frames). Ambos están registrados y sus metadatos conservan origen (0, 0). Se conectaron en Create/Step del jugador para suelo y aire. Create ajusta los orígenes en memoria a (16, 32) y (20, 36): el vuelo conserva el centro relativo del lienzo de 32×32 con cuatro píxeles adicionales por lado. Se fija el vuelo a 10 FPS en ejecución; hay que validar visualmente esta alineación inicial. No se editaron imágenes ni metadatos.

La orientación existente utiliza `image_xscale = facing`: 1 derecha, -1 izquierda, y conserva la última al detenerse. Ambas imágenes revisadas miran a la derecha y el mismo reflejo se aplica en suelo, vuelo y ataque. Se conserva la máscara explícita `spr_player`, así como el disparo anterior. Se reinicia el frame solo al cambiar de sprite, no durante cada paso de vuelo.

Hallazgo: la imagen importada como base tiene las alas abiertas; no es la paloma de pie de `Idle_normal/rotations/east.png`. Se conservó la elección del usuario para la prueba. El ataque aún usa el dibujo antiguo y los offsets del completo pueden necesitar ajuste visual.

Verificación: revisión de GML, registro y metadatos de sprites; sin nueva compilación ni prueba jugable. Estado `implementado_sin_verificar`. Siguiente acción: caminar a derecha/izquierda, detenerse, saltar y girar en el aire; comprobar alineación al aterrizar, ausencia de cambios de colisión y posición del completo. El ajuste en memoria afecta estos sprites mientras se ejecuta el juego; no cambia sus valores guardados en el editor.

### 2026-10-03 — PB-007: primer oficinista zombi y daño

Francisco creó `spr_zombie_oficinista` de 48×48 con origen (24, 48), el objeto con máscara explícita y eventos Create/Step, y dos instancias en Room1. Se completaron los eventos GML registrados sin editar sprites, metadatos ni escenario.

El zombi cae hasta el suelo, patrulla a 0.6 píxeles por paso dentro de 96 píxeles de su punto inicial, gira ante paredes/bordes y se detiene cuando la paloma está cerca a una altura compatible y sin un sólido entre ambos. Anuncia 30 pasos en amarillo, mantiene un golpe frontal de alcance 20 durante 8 pasos en rojo y descansa 40 pasos. La orientación del ataque se fija durante el aviso. Es una representación provisional del golpe de maletín con el sprite estático; no hay animación nueva. Saltar fuera del área de golpe permite esquivarlo; el contacto pasivo no daña.

Balance provisional: zombi con `hp = 2`, completo con `damage_amount = 1`; solo el completo lanzado causa daño y se consume al primer impacto. Se comprueban impactos al inicio y en cada subpaso del proyectil, dando prioridad a sólidos. El zombi cambia brevemente de color al recibir daño y desaparece al agotarse su vida.

La paloma tiene `hp = 3`, recibe 1 por golpe y obtiene 60 pasos de invulnerabilidad con parpadeo rojo. Cada ataque daña una sola vez. Al agotarse la vida se reinicia Room1, recuperando jugador, enemigos y completos. No se añadió HUD ni pantalla de derrota.

Archivos: Create/Step de `obj_zombie_oficinista`, `obj_player` y `obj_completo`. Ajustes en Create: `hp`, `patrol_speed`, `patrol_radius`, `detection_range`, `attack_reach`, `windup_steps`, `strike_steps`, `recovery_steps`, `attack_damage`, `damage_amount` y `hurt_duration`.

Verificación: revisión estática y comprobación de registro de eventos/recursos; no se ha compilado ni probado esta versión en GameMaker. Estado `implementado_sin_verificar`. Siguiente acción: recargar el proyecto, observar patrulla y aviso, acertar dos completos a un mismo zombi, saltar un golpe y recibir tres golpes separados para comprobar el reinicio. Revisar también paredes, bordes, ataque hacia ambos lados, dos enemigos cercanos y conservación de recogida, salto y aleteo.

### 2026-10-03 — completos probados y primer enemigo elegido

Francisco confirmó que recoger y lanzar completos resulta divertido y añadió más completos al escenario. Esto confirma el ciclo básico de PB-006B, sin inferir pruebas exhaustivas de paredes o caducidad del proyectil.

Eligió como primer enemigo al oficinista zombi de Santiago: patrullar un tramo, detenerse para anunciar el ataque y dar un golpe corto con el maletín. La paloma podrá saltarlo o atacarlo con completos; se incorporarán vida y daño al implementar este encuentro. Sustituye a la micro como primera implementación de enemigo. Bolsa embrujada, micro poseída y vendedor neutral que persigue al robarle quedan como ideas posteriores.

Inspección: aún no existen sprite ni objeto del zombi. Siguiente acción de Francisco: crear `spr_zombie_oficinista`, `obj_zombie_oficinista`, asignar el sprite, añadir Create y Step y colocar una instancia en Room1. Los recursos se preparan desde GameMaker según AGENTS.md. No se implementó comportamiento ni daño todavía.

### 2026-10-03 — PB-006B: recoger y lanzar un completo

Francisco preparó `obj_completo` con `spr_completo`, eventos Create y Step registrados y una instancia en Room1. Los eventos registrados estaban vacíos y no tenían aún archivos GML; se añadió su código sin modificar metadatos ni la room.

El completo cae hasta el suelo y se recoge al tocarlo si la paloma no lleva otro ni está atacando. Se transporta visible junto al pico, con posiciones ajustables por frame de ataque. Z requiere un completo y lanza esa misma instancia horizontalmente en el tercer frame (índice 2); mantener Z no repite. Al soltarlo queda libre la boca. El proyectil no puede recogerse de nuevo y desaparece al chocar con `obj_solid`, salir de la room o agotar 180 pasos. Avanza en subpasos de un píxel para evitar atravesar paredes finas. No hay todavía enemigos, daño, explosiones ni inventario múltiple.

Archivos: Create y Step de `obj_player` y `obj_completo`. Parámetros: `launch_speed`, `flight_steps_left`, `food_gravity`, `food_max_fall_speed`, `beak_offset_x/y`, `shoot_beak_x/y` y `shoot_frame_step`. Se conserva el origen (0, 0) del completo y se compensa al posicionarlo en ambos sentidos.

Estado: `implementado_sin_verificar`. Revisión estática realizada; compilación y prueba jugable de esta implementación pendientes. La compilación histórica del movimiento no valida este cambio.

Siguiente acción: recargar el proyecto, tocar el completo, caminar y girar para revisar su posición, pulsar Z y comprobar que sale en el tercer frame. Probar contra una pared, en el aire y sin comida; sin comida Z no debe iniciar otro ataque. Para repetir con la única instancia colocada, reiniciar la ejecución. Ajustar los offsets del pico según la prueba visual, sin redibujar sprites.

### 2026-10-03 — animación confirmada y recurso de completo

Francisco confirmó «quedo listo» tras conectar la animación con Z. Se registra la confirmación general del ataque visual; no se infieren pruebas específicas adicionales de colisiones o vuelo. También confirmó `spr_completo`, cuya carpeta existe en disco. Todavía no existe `obj_completo`: Francisco debe crearlo en GameMaker, asignarle ese sprite, añadir eventos Create y Step y colocar una instancia de prueba en Room1. La siguiente implementación será recoger el alimento, mantenerlo en el pico y lanzarlo con Z en el tercer frame. No se ha implementado aún esa mecánica.

### 2026-10-03 — PB-006A: animación de ataque con Z

Francisco creó `spr_player_shoot` y confirmó cuatro frames; se verificó en disco su registro en el proyecto, tamaño 32×32 y origen (16, 32). Autorizó Z como tecla de ataque. Se añadieron variables en Create y reproducción manual de los cuatro frames en Step. Una pulsación reproduce un ciclo; mantener Z no repite y las pulsaciones durante el ciclo se ignoran. El ataque tiene prioridad visual sobre suelo/aire, sin detener movimiento, gravedad ni aleteo. Al finalizar vuelve al sprite correspondiente y restaura la velocidad de animación anterior. La máscara sigue siendo `spr_player`.

Parámetro ajustable: `shoot_frame_step = 0.2` frames por paso (aproximadamente 20 pasos por ciclo). No se crean proyectiles, daño, munición ni recursos. Revisión estática realizada; esta modificación no se ha compilado ni probado jugando. Estado: `implementado_sin_verificar`.

Siguiente acción: recargar el proyecto y probar Z parado, caminando, mirando a ambos lados y en el aire; mantener Z para comprobar que no repite y volver a pulsar tras terminar. Verificar regreso al sprite de suelo o vuelo y que Espacio conserva salto/aleteo. La prueba pendiente de PB-002A no se considera cerrada por este cambio.

### 2026-10-03 — punto de partida

Francisco dibujó la paloma, preparó el suelo y colocó los recursos en el escenario. Se superó una incidencia de compilación con ayuda de Codex. El juego abrió y se confirmó movimiento horizontal. El siguiente paso es verificar el salto, no añadir combate.

### 2026-10-03 — salto confirmado y PB-003 implementado

Francisco confirmó que el juego compila, abre, se mueve horizontalmente y salta; también confirmó que hay suelo colocado. No confirmó colisiones de paredes o techos. Se añadió `facing` y el reflejo horizontal en los eventos Create y Step existentes de `obj_player`. La revisión estática y Windows Compile terminaron correctamente; la prueba jugable de la orientación sigue pendiente. Estado PB-003: `implementado_sin_verificar`.

### 2026-10-03 — aleteo y planeo implementados

Francisco confirmó movimiento horizontal, salto, gravedad y colisiones generales con `obj_solid`, orientación y el cambio entre `spr_player` y `spr_player_jump`. También confirmó que la máscara explícita de `obj_player` usa `spr_player`; se corroboró en `obj_player.yy`. Se añadieron cuatro parámetros en Create y la rama de aleteo/planeo en Step, sin modificar recursos ni el código de colisiones. Windows Compile terminó con código `0`. La prueba jugable de aleteo, descenso, aterrizaje y animación sigue pendiente. Estado PB-002A: `implementado_sin_verificar`.

## 9. Plantilla para la próxima actualización

Al terminar una tarea, el agente principal actualiza este documento, conserva la historia y deja una sola siguiente acción clara.

```text
Fecha y tarea:
Qué se cambió (o por qué no hizo falta cambiar nada):
Archivos afectados:
Revisión / compilación / prueba jugable: resultado de cada una
Evidencia: comando y salida relevante, o prueba confirmada por Francisco
Estado resultante:
Pendiente y siguiente acción:
```

No marcar pruebas no realizadas ni completar criterios por inferencia. Si la documentación contradice los archivos o una prueba nueva, explicar la diferencia y corregir este registro con esa evidencia.
