# Pluma Brava — contexto del juego

> Documento de diseño inicial, creado el 2026-10-03 a partir de las decisiones e ideas de Francisco. Describe intención, no funcionalidades ya implementadas. El avance real está en `PROJECT_STATUS.md`.

## 1. La idea

### Diseño vigente al 2026-10-04

La fase actual es pulir una base jugable de la paloma en Santiago. Hay aleteo y planeo, carga con Espacio e impulso al soltar, disparo de completos con Z, picada aérea con Z sin comida y un golpe individual de ala con X. El salto desde suelo usa doble toque de Espacio. La abuelita anima al acercarse y los oficinistas persiguen y golpean; los detalles de implementación y validación están en PROJECT_STATUS.md.

El siguiente diseño de combate es un combo X-X-X: corte con un ala, corte contrario y remate giratorio que avanza atravesando enemigos pero se detiene ante paredes. El remate tendrá preparación dentro de su animación; mantener X para un golpe cargado independiente fue una propuesta anterior, no la prioridad acordada. El combo aún no está implementado.

Los futuros shurikens de pluma tendrán munición propia y gastarán una unidad al aparecer el proyectil. Los corazones representan salud; no se consumen al lanzar plumas. C, la cantidad inicial y el máximo de munición siguen como propuestas. El daño de picada y la curación con semillas siguen pendientes.

Francisco controla y retoca el arte; PixelLab ayuda con borradores, no garantiza poses ni continuidad del combo. El fondo de Santiago tiene un sprite importado, aún no asignado a Background en el archivo actual de Room1. Las secciones siguientes conservan el diseño inicial: ante diferencias, prevalece este resumen y el estado verificado en PROJECT_STATUS.md.

### Antecedente: ataque desde el pico

Primer enemigo elegido: oficinista zombi de Santiago. Patrulla, avisa y da un golpe frontal corto de maletín; la paloma lo esquiva saltando o lo derrota con completos. La micro se pospone. El prototipo usa el dibujo estático del usuario y colores de aviso/impacto hasta que prepare animaciones. Balance inicial para probar: dos completos derrotan al zombi y tres golpes recibidos reinician el escenario.

Francisco eligió recoger comida y lanzarla desde el pico como primer combate. La cabeza se echa hacia atrás para preparar el ataque y luego hacia delante para soltar el alimento. Z activa el ataque; Espacio conserva salto y aleteo. Primero se conecta solo la animación de cuatro frames, sin proyectiles ni inventario. Después vendrán recogida de completos y daño contra un blanco. Medio completo hará la mitad del daño de uno entero; basureros y carritos son ideas posteriores. La bazuca queda como arma especial futura. Esta decisión sustituye la prioridad anterior de pistola y bazuca con munición ilimitada para el primer prototipo; el catálogo y recorrido originales de abajo se conservan como propuestas a revisar.

**Una paloma armada recorre un Chile sobrenatural y absurdo, enfrentándose a animales monstruosos, vehículos poseídos y comida demoníaca.**

Plataformas de acción 2D con desplazamiento lateral, pixel art retro, niveles diseñados a mano y jefes con patrones. La inspiración de jugabilidad es el control y la progresión por etapas de juegos como Mega Man; el personaje, el arte y el universo deben tener identidad propia.

El nombre de trabajo es **Pluma Brava**. Es provisional; no se ha evaluado aquí su disponibilidad como marca.

## 2. Cómo se construirá

Francisco quiere aprender a utilizar GameMaker mientras desarrolla un juego propio.

- Francisco dirige el diseño, dibuja sprites, crea objetos y organiza escenarios en el editor.
- Codex o Claude Code inspeccionan y programan GML, explican los cambios y ayudan a depurar.
- Se avanza con una mecánica pequeña y comprobable a la vez.
- Primero se busca que jugar resulte entretenido; después se amplía y se pule.

No se está construyendo un motor genérico, un framework de videojuegos ni una plataforma de agentes. Los agentes son una ayuda para desarrollar este juego.

## 3. Pilares del diseño

**Control claro.** Caminar, saltar y atacar deben responder de manera predecible.

**Chile como escenario creativo.** Calles, ferias, desierto, cerros, bosque y lugares del sur inspiran escenarios y situaciones.

**Humor jugable.** Una bazuca de completos no es solamente una imagen distinta: debería ofrecer una forma de atacar diferente de una pistola.

**Combate legible.** Un enemigo anuncia su ataque con una pose, movimiento o señal. Lo absurdo no debe volver arbitraria la dificultad.

**Alcance pequeño.** La primera meta es una demo corta en Santiago, no toda la campaña.

## 4. Protagonista

La protagonista actual es una **paloma urbana** dibujada a mano por Francisco.

El primer sprite tiene un lienzo de 32 × 32 píxeles, una pose lateral mirando a la derecha, cuerpo gris, ala clara, contorno oscuro, ojo anaranjado y patas marrón/anaranjadas. Se utiliza como base del prototipo, sin exigir nuevas animaciones para probar el movimiento.

No reemplazar el dibujo por una imagen generada ni rediseñarlo sin que Francisco lo solicite. El personaje puede ganar accesorios y expresividad después.

### Movimiento propuesto

Camina y salta. En el aire, cada nueva pulsación de Espacio produce un aleteo; al dejar de aletear, desciende con una caída más lenta y limitada. Mantener Espacio no produce ascenso continuo. No es un doble salto tradicional ni vuelo permanente. Una futura estamina limitará los aleteos, pero aún no está implementada. La explicación cómica de que el arsenal pesa demasiado sigue siendo una propuesta narrativa.

| Acción | Propuesta inicial | Observación |
| --- | --- | --- |
| Caminar | Flechas izquierda y derecha | Movimiento horizontal confirmado por el usuario. |
| Saltar | Espacio desde el suelo | Funcionamiento confirmado por Francisco. |
| Aletear y planear | Nuevas pulsaciones de Espacio en el aire; descenso más lento al dejar de pulsar | Implementado en GML; pendiente de prueba jugable y ajuste de sensación. |
| Atacar | Z | Requiere llevar un completo: lo lanza desde el pico en el tercer frame. Implementado; pendiente de prueba jugable. Daño pendiente. |
| Cambiar arma | Una tecla por decidir | Se introduce al incorporar la segunda arma. |
| Pausar | Escape, como propuesta | No implementado ni confirmado. |

Se dispara hacia donde mira el personaje. No se contempla apuntar con el mouse para la primera demo.

## 5. Bucle de juego

**Explorar un tramo → superar obstáculos y enemigos → encontrar un arma → aprender su utilidad → derrotar al jefe → avanzar.**

Los niveles deben enseñar sus ideas gradualmente. Por ejemplo, tras encontrar el Completazo aparece una situación en la que su explosión permite alcanzar a enemigos agrupados.

## 6. Armas

Todo este catálogo es diseño pendiente, no un inventario de recursos existentes.

| Arma | Comportamiento propuesto | Alcance |
| --- | --- | --- |
| Pistola | Proyectil recto, rápido y preciso. | Primera arma a implementar. |
| Completazo | Bazuca que lanza un completo lento con explosión al impactar. | Segunda arma de la demo. |
| Metralleta | Disparos frecuentes de menor daño individual. | Futuro. |
| Espada | Ataque cercano con un arco de impacto. | Futuro. |
| Sopaipillera | Discos de sopaipilla que rebotan. | Futuro. |
| Empanada explosiva | Trayectoria curva y explosión retardada. | Futuro. |

La propuesta inicial es probar pistola y Completazo con munición ilimitada y tiempos entre disparos distintos. Francisco decidirá el balance al jugar. No crear todavía un sistema complejo de inventario, rarezas o mejoras.

## 7. Mundo y campaña futura

La campaña imaginada recorre Chile de norte a sur. El orden de construcción comienza por Santiago para probar primero el tono del juego.

| Zona propuesta | Ambiente | Ideas de enemigos y jefe |
| --- | --- | --- |
| Norte | Desierto, mina y maquinaria abandonada. | Lagartos de sal, carros poseídos y un Alicanto Corrompido. |
| Valparaíso | Cerros, escaleras, techos y ascensores. | Gaviotas piratas y el Ascensor Maldito. |
| Santiago | Centro, feria, paraderos y fuente de soda. | Micros y vehículos demoníacos; el Completo Demoníaco. |
| Centro-sur | Campo, molinos y galpones. | Espantapájaros y maquinaria embrujada. |
| Chiloé | Palafitos, bosque y barco fantasmal. | Criaturas y reinterpretaciones de leyendas como material creativo. |
| Extremo sur | Estepa y guarida consumida por la maldición. | Chupacabras menores y el Rey Chupacabras. |

Estas asociaciones son propuestas de ficción para el juego. No constituyen afirmaciones de distribución de fauna ni de origen histórico de las leyendas. No implementar ninguna zona automáticamente por aparecer en esta tabla.

### Historia provisional

El Rey Chupacabras despierta y una energía extraña empieza a corromper el país. La paloma solo quiere volver a comer tranquila, pero hasta la comida intenta atacarla. Sigue el rastro de la maldición hacia el sur.

Es una base opcional: no exige diálogos, cinemáticas ni sistema narrativo en el prototipo.

## 8. Primera demo: Santiago se fue al demonio

**Duración objetivo de una partida completa: aproximadamente 3–5 minutos.** No es una estimación del tiempo necesario para desarrollarla.

Contenido objetivo:

- Una paloma y un recorrido corto.
- Pistola y Completazo.
- Dos enemigos sencillos: micro poseída y bolsa embrujada, como propuestas.
- Reaparición y un punto de control antes del jefe.
- Completo Demoníaco, victoria y posibilidad de volver a jugar.

### Recorrido propuesto

1. Zona segura para caminar y saltar.
2. Primer enemigo terrestre con ataque anunciado.
3. Obstáculo o enemigo a otra altura.
4. Recogida del Completazo y espacio para probarlo.
5. Punto de control y arena del jefe.

### Jefe propuesto: Completo Demoníaco

Comenzar por un ataque, una pausa y una condición de derrota. Solo después agregar variedad.

- **Kétchup a presión:** anuncia y lanza un proyectil bajo.
- **Embestida italiana:** se prepara y atraviesa la arena.
- **Lluvia de mayo:** marca zonas antes de dejar caer proyectiles.

Todos son conceptos pendientes. No crear recursos, estados o código de jefe durante la tarea actual de movimiento.

## 9. Arte y presentación

El primer personaje y bloque de suelo usan sprites de 32 × 32. Esto no obliga a que todos los futuros recursos tengan ese tamaño.

Como propuesta futura de presentación se considera una imagen de juego de 320 × 180, con escalado entero, y piezas de escenario de 16 × 16 o 32 × 32. **No está confirmado que la room, cámara o ventana actuales usen esas medidas.** Revisar el proyecto y acordar el encuadre antes de cambiarlo.

Mantener una silueta clara, colores limitados y fondo transparente en los sprites que lo necesiten. Las animaciones iniciales pueden tener pocos cuadros. La separación visual entre cuerpo y arma es una idea para evaluar cuando se implemente el combate, no una estructura que deba prepararse ahora.

## 10. Fuera del alcance inicial

Sin multijugador, cuentas, backend, base de datos, mundo abierto, generación procedural, árbol de habilidades, tienda, mods ni soporte multiplataforma completo. Sin plugins o librerías nuevas salvo necesidad concreta y autorización.

No introducir arquitectura empresarial, un CLI propio ni un sistema de orquestación adicional como requisito para programar la paloma.

## 11. Decisiones que siguen abiertas

El nombre final, personalidad y accesorios; animaciones; teclas de combate; resolución y cámara; salud y dificultad; balance de armas; historia definitiva y orden de escenarios después de Santiago.

Cuando una de estas decisiones se tome, registrar la decisión sin presentar las demás propuestas como aprobadas. El agente puede sugerir opciones, pero Francisco decide.
