# Pluma Brava — Diseño y backlog

Última consolidación: 2026-10-03.
Fuente: conversación «Aterrizar juego chileno» (6ac158bb-157c-83e8-9fdf-81975eecb190).

Documento vivo para reunir lo construido, las reglas deseadas y las ideas futuras. Ubicación prevista: raíz de PlumaBrava, junto a `PlumaBrava.yyp`, `AGENTS.md`, `CLAUDE.md`, `GAME_CONTEXT.md` y `PROJECT_STATUS.md`.

## Cómo mantenerlo

- `[x]` = implementado y confirmado en la conversación o probado jugando; en tareas documentales, entregado con evidencia.
- `[ ] Pendiente` = trabajo previsto sin cierre confirmado.
- `[ ] Por validar` = se describe como existente, pero falta evidencia suficiente de prueba.
- `[ ] Idea` = propuesta futura; todavía puede cambiar o descartarse.
- Añadir ideas en su sección, con un identificador estable. No renumerar las existentes.
- Para cerrar una mecánica, añadir una nota breve: fecha, prueba y resultado. Código escrito, compilación y prueba jugable son comprobaciones distintas.
- Las casillas reflejan la conversación y se contrastaron con GAME_CONTEXT.md y PROJECT_STATUS.md del proyecto al instalar este documento. No se realizó una nueva prueba del juego.
- Una idea pendiente no autoriza a implementarla. Trabajar solo en la tarea solicitada.

Se usan casillas Markdown estándar; para estados intermedios se añade texto en lugar de `[~]`.

## Visión y alcance

Plataformas de acción lateral 2D en GameMaker/GML, con pixel art retro, humor chileno y una paloma urbana armada. Referencia jugable: control preciso, etapas temáticas y jefes con patrones, al estilo de Mega Man. El jugador recorre zonas, supera obstáculos y enemigos, encuentra armas y derrota al jefe para avanzar.

La primera meta propuesta es **«Santiago se fue al demonio»**, una demo de 3–5 minutos: recorrido corto, pistola, Completazo, dos enemigos, checkpoint antes del Completo Demoníaco, victoria y opción de volver a jugar. La campaña completa iría de norte a sur; Santiago se desarrolla primero.

- [ ] Idea VIS-01 — Historia: el Rey Chupacabras despierta y una energía corrompe animales, vehículos y comida; la paloma sigue el rastro hacia el extremo sur.
- [ ] Idea VIS-02 — Motivación cómica: la paloma solo quiere comer tranquila, pero ahora la comida la persigue. Contar la historia con una introducción breve, encuentros y detalles del escenario.
- [ ] Idea VIS-03 — Accesorios de la protagonista: mochila, pecho inflado, expresión desafiante y armas desproporcionadas; decisión artística pendiente.

Pudú y quique se mencionaron como alternativas iniciales de protagonista. Se conserva la paloma que ya se creó; no hay compromiso de implementar personajes alternativos.

## Movimiento

- [x] MOV-01 — Movimiento horizontal de `obj_player`. Confirmado por el usuario: «solo me puedo mover en x» y luego «paloma salta se mueve».
- [x] MOV-02 — Salto con Espacio desde el suelo. La confirmación posterior del usuario cierra la antigua duda sobre si el salto funcionaba.
- [x] MOV-03 — Gravedad y aterrizaje sobre el suelo del prototipo con `obj_solid`, según el avance confirmado en la conversación.
- [ ] Por validar MOV-04 — Orientación izquierda/derecha implementada y confirmada por Francisco según PROJECT_STATUS.md; falta validar conservación al detenerse y giro junto a bloques.
- [ ] Por validar MOV-05 — Colisiones contra paredes, techos y esquinas; girar junto a bloques sin desplazamientos ni atascos. No dar por probados estos casos por haber validado el suelo.
- [ ] Por validar MOV-06 — Aleteo repetido: cada nueva pulsación de Espacio en el aire da un pequeño impulso ascendente, sin exigir aterrizar entre aleteos.
- [ ] Por validar MOV-07 — Planeo: al dejar de pulsar, descender lentamente con gravedad aérea y velocidad máxima de caída; nunca quedar suspendido indefinidamente.
- [ ] Por validar MOV-08 — Al aterrizar, reiniciar el estado aéreo; el siguiente Espacio vuelve a iniciar un salto normal.
- [ ] Por validar MOV-09 — Exponer parámetros fáciles de ajustar: impulso de aleteo, gravedad aérea y descenso máximo; pequeño cooldown opcional.
- [ ] Pendiente MOV-10 — Reaparición en el punto inicial al caer fuera del escenario.
- [ ] Idea MOV-11 — Ajustar sensación de control: velocidad, altura del salto, frenado y respuesta al aterrizar.

Regla deseada del vuelo: pulsaciones individuales, no ascenso continuo por mantener Espacio. El aleteo repetido sustituye la idea inicial de un doble salto tradicional. Hasta introducir stamina, la duración máxima del vuelo todavía no estará limitada por energía.

## Animación

- [ ] Por validar ANI-13 — Oficinista base East y ataque de cinco frames conectados. Golpe sincronizado con el cuarto frame observado, recuperación y reflejo horizontal; origen ajustado en ejecución. Compilación y prueba visual pendientes.

- [ ] Por validar ANI-12 — Disparo conectado a `spr_player_shoot_pixellab`: cinco frames presentes en disco, origen ajustado en ejecución y lanzamiento en el tercero. Se conserva reflejo horizontal; posición fina del completo, compilación y prueba jugable pendientes.

- [ ] Por validar ANI-11 — Sprites PixelLab conectados para suelo y vuelo, reflejo horizontal existente conservado. Ocho frames de vuelo a 10 FPS; orígenes ajustados en ejecución. Pendientes compilación, alineación visual y giro en ambos sentidos. Ataque mantiene el sprite anterior; base importada con alas abiertas.

- [x] ANI-01 — Sprite base `spr_player` disponible y utilizado por la paloma.
- [x] ANI-02 — `spr_player_jump` creado y animación aérea visible. Confirmación del usuario: «ya veo la animacion».
- [x] ANI-03 — Cambio a `spr_player_jump` en el aire y regreso a `spr_player` al aterrizar, confirmado en el intercambio final sobre animación.
- [x] ANI-04 — Máscara de colisión de `obj_player` fijada a `spr_player`, independiente del sprite aéreo. Confirmación explícita del usuario.
- [ ] Por validar ANI-05 — Ajustar velocidad de la animación aérea. Se sugirieron 10 FPS y 6–8 FPS si resulta rápida; no son valores finales confirmados.
- [ ] Por validar ANI-06 — Mantener animación aérea y orientación durante todos los aleteos y el planeo futuros.
- [ ] Idea ANI-07 — Separar despegue, subida, punto más alto y caída; pose de aterrizaje opcional.
- [ ] Idea ANI-08 — Animaciones de reposo, caminar, disparar, recibir daño y morir.

Usar el mismo personaje, paleta, escala y origen entre estados. Priorizar una vista lateral y reflejarla para la otra dirección; sprites separados solo si la asimetría del diseño lo justifica. Los nombres de estados propuestos no prueban que esos recursos existan.

## Combate y armas

Decisión vigente (2026-10-03): el primer ataque será comida lanzada desde el pico. Sustituye la prioridad inicial de pistola y bazuca con munición ilimitada; las armas listadas más abajo quedan como catálogo futuro. La animación lleva la cabeza hacia atrás y luego hacia delante; el completo será un objeto separado.

- [x] ANI-09 — Usuario creó `spr_player_shoot` con cuatro frames; recurso registrado y origen (16, 32) comprobados en disco.
- [x] ANI-10 — Animación de ataque con Z implementada; Francisco confirma «quedo listo» después de probarla. Confirmación general, sin dar por cerradas pruebas específicas de vuelo o colisiones.
- [x] COM-13 — Recoger un completo, llevarlo en el pico y lanzarlo con Z: Francisco confirmó el ciclo jugando y añadió más completos. Daño a enemigos pendiente; no se infieren pruebas exhaustivas de colisión o caducidad.
- [ ] Idea COM-14 — Registrar basureros para encontrar comida; medio completo inflige la mitad del daño de uno entero.
- [ ] Idea COM-15 — Robar completos enteros de puestos o carritos; interacción y posibles consecuencias pendientes de diseño.

- [ ] Pendiente COM-01 — Pistola: proyectil recto y rápido, disparado hacia donde mira la paloma.
- [ ] Pendiente COM-02 — Blanco quieto con vida: recibir impactos, destruirse y eliminar proyectiles al impactar o cuando corresponda.
- [ ] Por validar COM-03 — Vida y daño del jugador y del oficinista implementados. Paloma con 3 de vida, invulnerabilidad breve y reinicio de room al morir; zombi desaparece con 2 completos. Balance provisional, pendiente de compilación y prueba jugable.
- [ ] Pendiente COM-04 — Recoger armas y alternar entre dos armas equipadas con un botón; ataque con un botón común.
- [ ] Pendiente COM-05 — Completazo: bazuca de completos, proyectil más lento, mayor intervalo entre disparos y explosión de área útil contra grupos.
- [ ] Idea COM-06 — Metralleta: muchos disparos de poco daño para mantener presión.
- [ ] Idea COM-07 — Espada: golpe cercano de arco amplio y daño alto a cambio de acercarse.
- [ ] Idea COM-08 — Sopaipillera: discos que rebotan para atacar desde otros ángulos.
- [ ] Idea COM-09 — Empanada explosiva: trayectoria en arco y explosión posterior para superar obstáculos.
- [ ] Idea COM-10 — Probar munición ilimitada para pistola y Completazo en la demo; evaluar munición o recargas para el juego completo después de jugarla.
- [ ] Idea COM-11 — Compartir configuración sencilla de armas: daño, velocidad del proyectil, intervalo y aspecto visual; añadir comportamientos especiales gradualmente.
- [ ] Pendiente COM-12 — Pausa con Escape; las teclas de ataque y cambio de arma siguen por definir.

## Stamina y viento

- [ ] Idea STA-01 — Barra de stamina que represente el cansancio de la paloma.
- [ ] Idea STA-02 — Consumir energía gradualmente por tiempo volando y con cada aleteo; aletear cuesta más que planear.
- [ ] Idea STA-03 — Al agotarse, impedir ganar altura; conservar desplazamiento horizontal y planeo descendente.
- [ ] Idea STA-04 — Recuperar energía al descansar en el suelo. Ritmo y demora por definir.
- [ ] Idea STA-05 — A mayor altura, especialmente cerca del tope del mapa, aumentar el consumo por viento.
- [ ] Idea STA-06 — Viento capaz de desplazar, frenar o impedir avanzar a la paloma.
- [ ] Idea STA-07 — Ajustar intensidad del viento, umbrales de altura y costes de energía mediante pruebas. No hay fórmulas ni valores acordados.

Stamina y viento son reglas futuras. El primer encargo de aleteo excluía expresamente su implementación, la barra, sonidos y nuevos sprites.

## Niveles, cámara y progresión

- [x] NIV-01 — Prototipo en `Room1`, con paloma y suelo; el juego compila y abre según confirmación del usuario.
- [ ] Pendiente NIV-02 — Ajustar encuadre, escala y cámara para distinguir cómodamente personaje y plataformas.
- [ ] Pendiente NIV-03 — Construir la demo de Santiago de 3–5 minutos y comprobar recorrido completo.
- [ ] Pendiente NIV-04 — Inicio en plaza o calle tranquila: caminar, saltar un obstáculo bajo y disparar a un blanco.
- [ ] Pendiente NIV-05 — Introducir micro poseída y luego bolsa flotante para practicar amenazas a diferentes alturas.
- [ ] Pendiente NIV-06 — Recoger el Completazo junto a un puesto abandonado y encontrar una situación que enseñe su daño de área.
- [ ] Pendiente NIV-07 — Checkpoint antes del jefe; arena en una fuente de soda corrompida.
- [ ] Pendiente NIV-08 — Pantalla de victoria y posibilidad de volver a jugar.
- [ ] Idea NIV-09 — Campaña de norte a sur con niveles hechos a mano y apertura de la siguiente etapa al vencer al jefe.
- [ ] Idea NIV-10 — Norte / mina maldita: desierto, túneles y maquinaria abandonada; aprovechar y esquivar maquinaria y rocas.
- [ ] Idea NIV-11 — Valparaíso / cerros embrujados: escaleras, techos y ascensores; ganar altura entre plataformas móviles y evitar objetos que ruedan cuesta abajo.
- [ ] Idea NIV-12 — Santiago / hora punta infernal: centro, feria, paraderos y fuente de soda; anticipar el cruce de vehículos.
- [ ] Idea NIV-13 — Centro-sur / campo torcido: caminos rurales, molinos y galpones; mecanismos y obstáculos móviles.
- [ ] Idea NIV-14 — Chiloé / noche del Caleuche: palafitos, bosque y cubierta fantasmal; caminos sobre agua y espacios cerrados.
- [ ] Idea NIV-15 — Extremo sur / guarida: estepa, cavernas y estructuras corrompidas; combinar lo aprendido durante la campaña.

## Enemigos y peligros

Decisión vigente: el primer enemigo de Santiago será el oficinista zombi; la micro pasa a una etapa posterior.

- [ ] Por validar ENE-09 — Oficinista zombi implementado con patrulla, aviso amarillo, golpe frontal rojo y recuperación. Sprite provisional estático; animación de maletín pendiente. Vida de 2 y daño por completo de 1. Falta compilar y probar jugando.
- [ ] Idea ENE-10 — Vendedor de completos neutral que persigue con escoba si le roban comida; interacción y consecuencias por concretar.

- [ ] Pendiente ENE-01 — Micro poseída de la demo: bocina de aviso, preparación y avance terrestre; saltarla o destruirla.
- [ ] Pendiente ENE-02 — Bolsa embrujada de la demo: flotar por un recorrido corto y predecible.
- [ ] Idea ENE-03 — Santiago: otros vehículos demoníacos que embisten.
- [ ] Idea ENE-04 — Norte: lagartos de sal, carros mineros poseídos y rocas que caen.
- [ ] Idea ENE-05 — Valparaíso: gaviotas piratas y objetos rodantes.
- [ ] Idea ENE-06 — Centro-sur: espantapájaros, herramientas animadas y tractor embrujado.
- [ ] Idea ENE-07 — Chiloé: criaturas de pantano y tripulantes espectrales.
- [ ] Idea ENE-08 — Extremo sur: chupacabras menores y variantes de enemigos anteriores.

## Bosses

- [ ] Pendiente BOS-01 — Completo Demoníaco, jefe de Santiago: completo grande con cara, patas pequeñas y movimientos exagerados; se levanta del mostrador.
- [ ] Pendiente BOS-02 — Primer combate completo con un único ataque, pausas para dañarlo y victoria; ampliar después.
- [ ] Idea BOS-03 — Kétchup a presión: se infla, apunta y dispara un proyectil bajo que se puede saltar.
- [ ] Idea BOS-04 — Embestida italiana: se inclina, pausa y cruza la arena; el jugador reconoce el aviso y salta.
- [ ] Idea BOS-05 — Lluvia de mayo: marcar zonas del suelo antes de que caigan gotas grandes, dejando espacios seguros.
- [ ] Idea BOS-06 — Patrones inicialmente en orden fijo, con señales claras y pausas entre ataques para aprender el combate.
- [ ] Idea BOS-07 — Alicanto Corrompido, jefe de la mina del norte.
- [ ] Idea BOS-08 — El Ascensor Maldito, jefe de Valparaíso.
- [ ] Idea BOS-09 — El Espantapájaros Mayor, jefe del centro-sur.
- [ ] Idea BOS-10 — Basilisco reinterpretado para el juego, jefe propuesto de Chiloé.
- [ ] Idea BOS-11 — Rey Chupacabras / jefe demonio chupacabras, jefe final de la campaña en el extremo sur.

Estas criaturas y ubicaciones son propuestas del universo ficticio del juego; salvo el Completo Demoníaco, no se detallaron patrones de ataque.

## Arte, sonido y presentación

- [x] ART-01 — Primer diseño de paloma dibujado a mano por el usuario y utilizado como base del prototipo.
- [x] ART-02 — Bloque provisional de suelo `spr_ground` utilizado en el escenario.
- [ ] Idea ART-03 — Mantener pixel art retro, siluetas legibles, paleta limitada, fondo transparente en sprites y humor visual durante el juego.
- [ ] Por validar ART-04 — Escala final: se propuso personaje de 32×32, imagen de juego de 320×180 y tiles de 16×16; el bloque provisional se planteó de 32×32. No confundir propuestas con configuración comprobada.
- [ ] Idea ART-05 — Dibujar cuerpo y arma por separado para reutilizar animaciones y ajustar el punto de sujeción de cada arma.
- [ ] Pendiente ART-06 — Crear arte para proyectil, primer enemigo, segunda arma y jefe a medida que se implementen sus mecánicas.
- [ ] Idea ART-07 — Sustituir bloques provisionales por tiles de calle, cemento o tierra; añadir fachadas, carteles y fondos con identidad local después de validar el recorrido.
- [ ] Idea ART-08 — Enemigos pequeños de escala cercana a la paloma; jefe mayor, dejando espacio para esquivarlo.
- [ ] Idea ART-09 — Sonidos, señales de ataque, reacciones visuales y ajuste final de ritmo y presentación.
- [ ] Idea ART-10 — Producir nuevas poses mediante duplicación y edición manual de alas, patas y cuerpo; conservar identidad entre frames.

Herramientas exploradas: editor de GameMaker y PixelLab; Piskel y LibreSprite como alternativas manuales. También se mencionaron Spritesheets.ai y Sloyd para explorar generación. Ninguna herramienta ni suscripción es requisito: se priorizó seguir a mano ante el coste de generar más imágenes.

## Flujo de trabajo con agentes

- [x] AGE-01 — Contexto e instrucciones iniciales entregados en la conversación: `GAME_CONTEXT.md`, `PROJECT_STATUS.md`, `AGENTS.md`, `CLAUDE.md` y material de apoyo. Esto acredita la entrega, no su instalación local.
- [ ] Por validar AGE-02 — Comprobar que esos documentos están en la raíz del proyecto y corresponden al estado más reciente.
- [ ] Por validar AGE-03 — Comprobar instalación y carga de los subagentes propuestos: `gm-investigador`, `gm-programador` y `gm-revisor`. Se describió un paquete, pero su funcionamiento local quedó pendiente.
- [x] AGE-04 — Backlog incorporado a la raíz del proyecto el 2026-10-03.
- [ ] Pendiente AGE-07 — Referenciar este backlog desde las instrucciones de Codex y Claude.
- [ ] Idea AGE-05 — Guardar hitos jugables con Git; no hay confirmación en la conversación de repositorio ni commits.
- [ ] Idea AGE-06 — Evaluar OpenSpec al desarrollar una funcionalidad que necesite requisitos, escenarios, criterios de aceptación y tareas. Por ahora se acordó documentación Markdown sencilla.

### Reglas compartidas para Codex y Claude

1. Leer las instrucciones del proyecto, `GAME_CONTEXT.md`, este archivo y `PROJECT_STATUS.md`; contrastar con los recursos reales antes de editar.
2. Este archivo concentra diseño y estado por funcionalidad. `GAME_CONTEXT.md` conserva la visión y `PROJECT_STATUS.md` el avance de la sesión, evidencias y próximo paso. Evitar listas contradictorias.
3. Ante contradicciones, conservar la evidencia, señalar qué falta comprobar y actualizar el estado con la confirmación más reciente. El salto ya fue confirmado: no volver a tratarlo como fallo pendiente sin evidencia nueva.
4. El usuario diseña/importa sprites, crea objetos y eventos, construye rooms y prueba el juego. El agente implementa la programación GML autorizada y explica cómo ajustarla.
5. Trabajar paso a paso, con una mecánica concreta por encargo. No reemplazar arte ni modificar rooms o metadatos `.yy`/`.yyp` fuera del alcance autorizado. Si hace falta un recurso, indicar cuál debe prepararse.
6. Inspeccionar `Create` y `Step` reales antes de proponer cambios; conservar movimiento, colisiones y recursos existentes con modificaciones mínimas.
7. Guardar el proyecto antes de la edición externa y evitar cambios simultáneos sobre el mismo recurso. Al volver a GameMaker, revisar los cambios pendientes antes de recargar desde disco.
8. Si se usan subagentes: investigador y revisor leen; programador implementa; principal coordina y actualiza documentación. Un solo escritor por vez. No afirmar delegaciones que no ocurrieron; se puede trabajar con un único agente.
9. Al terminar, informar archivos/eventos modificados, variables ajustables y prueba manual corta. Registrar por separado revisión, compilación y prueba jugable.
10. Marcar `[x]` solo con evidencia de cierre. Si hay código sin prueba, usar `[ ] Por validar` y describir lo pendiente. No avanzar automáticamente al siguiente hito.

## Próximo paso registrado

Actualización de prioridad: animación con Z (ANI-10) confirmada por Francisco. Probar ahora recogida y lanzamiento de un completo (COM-13), implementados en los eventos existentes. Aleteo/planeo sigue pendiente de validación. El orden anterior se conserva a continuación como antecedente.

Probar el aleteo/planeo ya implementado (`MOV-06` a `MOV-09`, `ANI-06`; PB-002A en PROJECT_STATUS.md). El registro local informa revisión estática y compilación Windows exitosa el 2026-10-03; falta prueba jugable de Francisco. Parámetros documentados: `flap_force = 3.0`, `flap_max_rise_speed = 9.0`, `glide_gravity = 0.12` y `glide_max_fall_speed = 2.2`. Después retomar reaparición, encuadre, pistola/blanco y primer enemigo. Este orden orienta el trabajo y no autoriza cambios por sí mismo.

Prueba de cierre del aleteo: caminar → saltar → pulsar varias veces para ganar altura → soltar y descender → aterrizar → repetir; comprobar orientación, animación y colisiones. Stamina y viento se abordan en tareas posteriores.

## Registro breve de cierres

| Fecha | Elementos | Evidencia |
| --- | --- | --- |
| 2026-10-03 | MOV-01 a MOV-03, NIV-01 | El usuario confirma que compila, abre, se mueve, salta y tiene suelo. |
| 2026-10-03 | ANI-01 a ANI-04, ART-01 y ART-02 | Creación y uso de recursos descritos; usuario confirma máscara y animación visible. |
| 2026-10-03 | AGE-01 | La conversación registra entrega del paquete documental; instalación y carga pendientes. |

Para nuevos cierres, añadir una fila con la prueba concreta y quién la confirmó. Si una función deja de cumplirla, reabrir su casilla y registrar el motivo.
