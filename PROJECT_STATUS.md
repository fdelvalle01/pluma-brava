# Pluma Brava — estado y siguiente tarea

**Última actualización de este registro:** 2026-10-04.
**Origen del estado inicial:** conversación y capturas de Francisco; no una inspección directa del repositorio.  
**Prioridad:** probar el golpe de ala con X contra zombis y ajustar su sincronía visual. Combo de tres golpes, daño de picada y comida curativa pendientes.

## Estado vigente — consolidación del 2026-10-04

Fase actual: prototipo jugable de movimiento y combate de la paloma, con escenario de pruebas de Santiago. Todavía no hay demo completa, jefe ni progresión. Este resumen prevalece sobre las entradas históricas que aparecen después.

### Funcionalidades y evidencia

| Área | Implementación actual | Validación disponible |
| --- | --- | --- |
| Movimiento | Flechas, orientación, gravedad y colisiones con obj_solid; máscara fija spr_player. | Movimiento y salto base confirmados por Francisco. Pruebas específicas de paredes/techos pendientes. |
| Salto y vuelo | Doble toque de Espacio en suelo (ventana 15 pasos); toques aéreos para aletear; descenso lento. | Código inspeccionado y controles simulados; prueba completa de la versión actual pendiente. |
| Carga e impulso | Mantener Espacio 12 pasos inicia carga en suelo o aire; animación en bucle, potencia máxima tras 36 pasos adicionales. Soltar impulsa; se recarga al aterrizar. | Francisco confirmó el resultado tras ajustar la repetición; falta una regresión completa de colisiones. |
| Completos | Recogida automática de uno, transporte en pico, lanzamiento con Z en el tercer frame; daño 1, colisión con sólidos y caducidad. | Recoger y lanzar confirmado jugando; casos límite de daño/colisiones pendientes. |
| Picada | Z en aire sin comida; preparación, caída rápida, pose sostenida y retorno al control al aterrizar. | Francisco confirmó la base jugable junto al efecto; revisión y simulación de lógica previas. |
| Polvo de impacto | obj_dive_impact aparece una vez al aterrizar de picada, siete frames a 12 FPS, desaparece al terminar. | Francisco confirmó funcionamiento y retocó el arte. No hace daño de área. |
| Golpe de ala | X reproduce nueve frames; daño frontal 1 en índice 4, una vez por enemigo, alcance 24 y bloqueo por pared. | Implementado, revisión y simulación de lógica; sin confirmación jugable posterior. |
| Zombi oficinista | Patrulla, detecta con línea de visión, persigue más rápido, anuncia golpe de maletín, recupera y vuelve a su zona. Tiene 2 hp. | Código y simulaciones revisados; balance y prueba integral pendientes. |
| Salud | 3 hp, cada golpe válido resta 1, invulnerabilidad de 60 pasos; a cero se reinicia la room. HUD dibuja un icono por hp. | Implementado; validación integral pendiente. El arte de pluma se cambió a corazón conservando spr_vida_pluma. |
| Abuelita | Animación por proximidad con espera entre ciclos; la paloma se dibuja delante. | Animación confirmada en conversación. No genera semillas ni cura todavía. |
| Escenario | Room1 de 1366×768, cámaras desactivadas, suelo, completos, paradero, zombis y abuelita. | Recursos inspeccionados; recorrido de demo y cámara pendientes. |
| Fondo de Santiago | spr_fondo_santiago importado a 512×288. | Background de Room1 sigue sin sprite asignado en disco; integración pendiente. |

### Controles actuales

- Flechas izquierda/derecha: desplazarse y orientar al personaje.
- Espacio: doble toque en suelo para saltar; cada nueva pulsación aérea aletea. Mantener carga; soltar ejecuta el impulso.
- Z con completo: dispara. Z en aire sin completo: picada. En suelo sin completo no ataca.
- X: golpe individual de ala, también en aire; detiene desplazamiento horizontal y conserva gravedad. No repite al mantener ni interrumpe otra acción activa.
- No existe aún el combo X-X-X ni un control implementado para shurikens.

### Arte y recursos

Francisco dirige, importa y retoca el arte. PixelLab proporciona borradores de animación; los agentes conectan GML. Se conservan las exportaciones fuente junto a los sprites del proyecto. Los sprites PixelLab de suelo, vuelo, disparo, carga, impulso, picada y golpe están conectados.

spr_vida_pluma conserva su nombre por compatibilidad pero contiene cuatro frames de corazón; Draw GUI utiliza solo el frame 0, por lo que no hay latido animado. spr_player_wing_attack_pixellab_1 está registrado con once frames, pero el código usa spr_player_wing_attack_pixellab de nueve; no asumir que la variante está conectada.

### Pendientes y siguiente paso

1. Probar X frente a un zombi, a ambos lados, comprobar daño una vez, recuperación y conservación de los controles anteriores. Ajustar ritmo/alcance con Francisco.
2. Diseñar las animaciones enlazadas del combo X-X-X: primer corte, corte contrario y remate giratorio con avance. Pendiente de implementación.
3. Plumas shuriken: munición independiente de los corazones, descontada al crear el proyectil; contador, recogibles y balance pendientes. C y 5/10 plumas son propuestas, no reglas cerradas.
4. Daño al impactar de picada, semillas curativas de la abuelita y asignación del fondo; tareas independientes aún pendientes.
5. Stamina, viento por altura, reaparición al caer fuera del mapa, cámara, checkpoints, audio, campaña y bosses siguen en backlog.

### Verificación y Git

Las simulaciones anteriores usan funciones de motor sustituidas: no son compilación GML ni pruebas jugables. La compilación histórica de movimiento no valida todas las mecánicas actuales. En esta consolidación se verificaron 27 recursos registrados, 19 sprites y 80 imágenes de frames: sin archivos faltantes ni referencias de sprites/objetos no registradas en el GML inspeccionado. La revisión de whitespace de Git pasó. No se ejecutó una nueva compilación ni partida.

Repositorio Git existente, rama actual development, remoto origin en github.com/fdelvalle01/pluma-brava. Francisco solicita guardar el estado completo y publicarlo en esa misma rama; no crear otra rama ni hacer force-push. El hash y resultado del envío se informan al finalizar, sin registrarlos por adelantado como hechos.

## 1. Confirmaciones históricas del punto de partida

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

## 2. Verificaciones pendientes del punto de partida

- La caída y el aterrizaje sobre suelo y plataformas sin atravesarlos.
- Si las colisiones laterales y contra la parte inferior de los bloques funcionan.
- Si el jugador puede reaparecer al caer fuera del escenario; no hay implementación confirmada.
- Si la orientación conserva la dirección al detenerse y no atasca al jugador junto a un bloque.
- La nueva mecánica de aleteo y planeo durante una prueba jugable completa.
- El escalado y encuadre definitivo. Room1 está verificada en 1366×768 y sin cámaras habilitadas.

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

## 7. PB-002A — registro histórico de aleteo y planeo

Esta sección conserva la implementación inicial del 2026-10-03. El doble toque, la carga y los sprites PixelLab posteriores se describen en el estado vigente; no utilizar este apartado como especificación actual de controles.

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

### 2026-10-04 — primer golpe de ala con X

Francisco importó spr_player_wing_attack_pixellab: nueve frames de 36×36. Create/Step de obj_player conectan una pulsación de X a una reproducción completa (0.35 frames por paso). El índice 4 dispara una comprobación de daño frontal de alcance 24 más allá de la máscara; cada zombi alcanzado recibe 1 daño y el destello existente, con destrucción al agotar hp. La comprobación ocurre una sola vez por ataque e incluye línea libre de sólidos. Dirección bloqueada y sin desplazamiento horizontal durante el golpe, con gravedad y colisiones conservadas; se permite iniciar en suelo o aire y llevando comida. No interrumpe disparo, carga, impulso ni picada; durante el golpe no se inician esas acciones. Al terminar restaura animación normal. Origen (18,34) ajustado en ejecución, sin editar arte ni metadatos.

Simulación Node del Step con motor sustituido pasó sincronía del daño, una aplicación por golpe, frente/espalda/alcance, ataque reflejado, obstrucción por pared, derrota, restauración y exclusión de otras acciones. Revisión estática/diff sin errores. No compilado ni probado jugando: `implementado_sin_verificar`. Siguiente acción: recargar el proyecto guardado, golpear un zombi a ambos lados con X y comprobar que dos golpes separados lo derrotan; mantener X no debe repetir. Revisar también pose, comida en pico, uso aéreo y regreso a controles normales. Parámetros ajustables: wing_frame_step, wing_hit_frame, wing_reach, wing_damage. El combo X-X-X y los shurikens todavía son diseño pendiente.

### 2026-10-04 — efecto de polvo al aterrizar de picada

Francisco creó obj_dive_impact con Create y Animation End registrados y spr_dive_impact de 64×32 con siete frames. Se añadieron Create_0.gml y Other_7.gml a esos eventos vacíos: origen centrado en ejecución (32,32), reproducción a 12 FPS y destrucción al terminar. El origen importado era (64,32). Step de obj_player crea una nube en (x, bbox_bottom + 1), delante del jugador, al salir de picada por contacto con suelo; los aterrizajes normales no la crean. Se conserva el arte y los metadatos. Efecto visual solamente; daño cercano pendiente.

Revisión estática de eventos, referencia y transición realizada; compilación y prueba jugable pendientes. Estado `implementado_sin_verificar`. Siguiente acción: recargar el mismo proyecto guardado y comprobar una nube por picada, su desaparición y ausencia de polvo en saltos normales.

### 2026-10-04 — picada aérea conectada

Sprite importado `spr_player_dive_pixellab`: siete frames de 36×36. Create/Step de obj_player conectan Z en aire sin comida y sin otra acción activa a una picada vertical: preparación, descenso de 10 píxeles por paso desde el índice 2, último frame sostenido y regreso al estado normal al aterrizar. Se bloquean aleteo, desplazamiento horizontal y recogida durante descenso. Movimiento vertical en subpasos de hasta un píxel para comprobar suelo. Origen provisional (18,34) en ejecución; máscara conservada. No incluye daño de impacto ni animación de golpe al suelo; son la siguiente tarea visual y funcional.

Estado `implementado_sin_verificar`. Diff revisado; simulación Node con motor sustituido pasó activación aérea, avance de frames, descenso, bloqueo de Espacio, aterrizaje con tolerancia inferior a un píxel, restauración, exclusión en suelo/disparo y pose final. No compilado ni probado en GameMaker. La pose final importada se ve inclinada y requiere revisión visual jugando. Siguiente acción: recargar el mismo proyecto guardado y pulsar Z sin completo a suficiente altura; revisar animación, aterrizaje y conservación del disparo con comida.

### 2026-10-03 — animación de carga en bucle

Francisco observó que la carga reproducía una sola secuencia y pidió repetición hasta soltar Espacio. Create/Step de obj_player ahora separan `charge_frame` del contador de potencia: los cinco frames se repiten a 0.15 frames por paso mientras mantiene la tecla, aunque la potencia ya esté completa. Soltar conserva el impulso existente. No se modificaron sprites ni otros controles. Estado `implementado_sin_verificar`; pendiente de compilación y prueba jugable. Siguiente acción: recargar el proyecto guardado, mantener Espacio varios ciclos y soltar para comprobar el lanzamiento.

### 2026-10-03 — doble toque y carga desde el suelo

Decisión vigente de Francisco: un toque aislado de Espacio no salta; dos pulsaciones dentro de 15 pasos saltan. Mantener 12 pasos inicia carga desde suelo o aire y soltar activa el impulso. Carga completa en 36 pasos adicionales, recorriendo los cinco frames y manteniendo el último; en suelo permanece quieta, en aire desciende lentamente. Se corrigió la cancelación incondicional al tocar suelo, que impedía conservar la animación de carga. El aleteo por pulsación aérea continúa igual. Estos controles sustituyen al salto inmediato descrito en entradas históricas.

Archivos: Create/Step de obj_player, sin modificar recursos. Revisión estática y diff sin errores; simulación Node del Step con entrada, suelo y motor simulados pasó toque único, doble toque, vencimiento de ventana, cinco frames, carga en suelo, lanzamiento al soltar, carga conservada al aterrizar y restauración de velocidad de animación. Estado `implementado_sin_verificar`: no compilado ni probado jugando en GameMaker. Siguiente acción: recargar el proyecto guardado y probar doble toque y carga completa desde suelo, luego repetir en aire.

### 2026-10-03 — carga e impulso aéreo

Francisco importó `spr_player_charge_pixellab` y `spr_player_burst_pixellab`, ambos de 40×40 con cinco frames. Se conectaron en Create/Step de `obj_player`, sin editar arte, metadatos ni rooms. Mantener Espacio 12 pasos en el aire inicia carga, completada tras otros 24; durante la carga desciende a 0.8 píxeles por paso. Soltar reproduce el impulso y aplica velocidad vertical de 7 a 11 en el tercer frame, según carga, con empuje horizontal de 1.5 durante el resto de la animación. Un impulso por aterrizaje; los toques breves conservan salto/aleteo. Z no inicia disparo durante carga/impulso y no se carga durante un disparo existente. Aterrizar cancela la acción y restaura la animación normal. Orígenes ajustados en ejecución a (20,36); máscara original conservada.

Estado: `implementado_sin_verificar`. Revisión estática y `git diff --check` sin errores; simulación con Node del bloque de control aéreo extraído del GML pasó salto, carga, descenso, impulso, restauración, límite por aterrizaje, aleteo y exclusión durante disparo. Esta simulación sustituye entradas y suelo: no compila GML ni valida colisiones reales. Pendientes compilación y prueba jugable en GameMaker, incluyendo sincronía visual del tercer frame, paredes/techos, aterrizaje mientras carga, giro, comida sostenida y Z después del impulso. No se implementó picado, golpe al suelo ni stamina. Siguiente acción: recargar el mismo proyecto y probar Espacio corto, mantenido y soltado en ambos sentidos.

### 2026-10-03 — persecución y HUD de plumas

Francisco pidió detección por proximidad, persecución más rápida y tres plumas de vida. Preparó `spr_vida_pluma` de 64×64, origen (32, 32), y registró Draw GUI en `obj_player`; se añadió el código a ese evento existente sin cambiar metadatos.

El zombi patrulla a 0.6 px/paso, detecta hasta 160 px horizontales y 64 verticales sin sólidos entre él y la paloma, y persigue a 2 px/paso (paloma: 2.5). Durante persecución puede verla hasta 220 px; recuerda su última posición 60 pasos al perderla. Mantiene aviso y golpe cercano, deteniéndose para atacar. Tras perderla o alejarse 240 px de su punto inicial, regresa a 1 px/paso; al volver cerca puede detectarla otra vez. Movimiento en subpasos; no salta, atraviesa paredes ni busca rutas alternativas. Ante obstáculos se detiene. Puede detectar a ambos lados.

Se conserva la vida existente: `max_hp = 3`, `hp = max_hp`, daño de 1 por golpe, invulnerabilidad de 60 pasos y reinicio de room al llegar a cero. Draw GUI dibuja solo las plumas restantes en la esquina superior izquierda, con tamaño visual de 32 px y margen de 16, compensando el origen del sprite sin modificarlo. No se añadió una animación de muerte ni curación automática.

Archivos: Create/Step del zombi; Create y Draw GUI del jugador. Parámetros de persecución y HUD ajustables en Create. Comprobación automatizada de lógica leyendo los archivos reales en un entorno con funciones de colisión simuladas: patrulla, aceleración, aviso/golpe, un daño por ataque, bloqueo de visión, regreso, borde y conteo/posición de plumas (3, 2, 1, 0) pasaron. Esto no sustituye compilación ni prueba en GameMaker, ambas pendientes.

Estado `implementado_sin_verificar`. Siguiente acción: recargar, comprobar tres plumas al iniciar, acercarse para activar persecución, escapar para observar regreso y recibir tres golpes separados (3→2→1→reinicio). Probar paredes, bordes y salto, y confirmar que las plumas permanecen fijas en pantalla.

### 2026-10-03 — orden visual de abuelita y paloma

Francisco confirmó que la animación de la abuelita funciona y mostró que oculta a la paloma al solaparse. Ambas instancias estaban en la capa Instances a profundidad 0. Step de la abuelita ahora mantiene su profundidad un nivel detrás del jugador, incluso durante la animación. No se modificaron room, sprites ni distancias: activa a 64 píxeles horizontales y 32 verticales, sin sólidos entre ambas, y espera 180 pasos tras cada ciclo. Revisión estática realizada; falta probar el nuevo orden visual en ejecución.

### 2026-10-03 — gesto de la abuelita

Francisco preparó `obj_abuelita`, con eventos Create/Step registrados, `spr_abuelita` de 48×48 y `spr_abuelita_feed` de 68×68 con cinco frames. Los eventos estaban vacíos; se completaron sin cambiar metadatos. No se encontró ninguna instancia de `obj_abuelita` en Room1 guardada en disco.

Create fija en memoria orígenes (24, 48) y (34, 58), compensando el margen del lienzo de animación, y conserva una máscara estable con la base. La abuelita permanece quieta mirando South. Al detectar a la paloma a 64 píxeles horizontalmente y 32 verticalmente, sin sólidos entre ambas, reproduce una vez los cinco frames a 0.15 frames por paso. Regresa a reposo y espera 180 pasos antes de ofrecer de nuevo si la paloma sigue cerca. Son valores iniciales ajustables en Create.

Solo se conectó el gesto visual: no aparecen semillas ni se modifica la vida. Para comida recogible curativa faltan sprite, objeto y eventos creados por Francisco. No se reutiliza el completo porque cumple la función de munición.

Revisión estática y registros comprobados; compilación y prueba jugable pendientes. Estado `implementado_sin_verificar`. Siguiente acción: colocar `obj_abuelita` con los pies sobre el suelo, guardar/recargar y acercar/alejar la paloma; comprobar alineación y pausa entre animaciones. No se modificaron Room1 ni arte.

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
