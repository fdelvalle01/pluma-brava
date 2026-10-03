# AGENTS.md — Pluma Brava

## Propósito y lectura inicial

Ayuda a Francisco a desarrollar un plataformas 2D en GameMaker mediante cambios pequeños y comprensibles. Francisco controla el diseño y crea los recursos visuales y del editor; tú programas GML y verificas lo que puedas comprobar realmente.

Antes de actuar:

1. Lee `GAME_CONTEXT.md` para conocer la intención del juego.
2. Lee `PROJECT_STATUS.md` para conocer el avance y la siguiente tarea.
3. Inspecciona los archivos reales relevantes; el registro inicial procede de una conversación, no de una auditoría del repositorio.
4. Para delegar o retomar el flujo, consulta `docs/FLUJO_IA.md`.

Responde en español. Usa los nombres reales de recursos y eventos. El usuario está aprendiendo GameMaker: explica lo necesario del motor sin convertir cada respuesta en una lección extensa.

## Reparto de responsabilidades

| Responsable | Trabajo |
| --- | --- |
| Francisco | Dibujos, animaciones, sprites, creación de objetos, asignación visual, rooms, colocación de instancias, decisiones de diseño y pruebas jugando. |
| Agente principal | Entender la tarea, leer el proyecto, proponer el cambio, programar o delegar, integrar, verificar e informar. |
| Subagentes | Una tarea limitada de investigación, implementación o revisión, según su rol. |

Nunca sustituyas el arte del usuario para resolver un problema de programación. No crees ni coloques objetos o sprites automáticamente porque una idea aparezca en el diseño.

## Autorización y alcance

- Una petición de diagnosticar, revisar, explicar o planificar es de lectura: no editar archivos del proyecto.
- Una petición explícita de implementar una tarea autoriza el GML mínimo y la actualización de estado asociados a esa tarea. No pedir permiso para cada línea ni extender la autorización al resto del backlog.
- Por defecto, trabaja sobre eventos y scripts que ya existan y estén registrados. Si necesitas un recurso o evento nuevo, pide a Francisco que lo cree en GameMaker e indica nombre, tipo, objeto y evento exactos.
- Crear o registrar recursos desde fuera del IDE requiere autorización específica y un plan que preserve las referencias.
- Detente al terminar la tarea solicitada. No avances automáticamente al próximo hito.

## Archivos protegidos por defecto

No modificar sin acuerdo específico:

- `sprites/**`, imágenes, audio y otros recursos artísticos.
- `rooms/**`, posiciones de instancias, capas, tamaños y cámaras configuradas en recursos.
- `.yyp`, `.yy` y `.resource_order`, salvo el cambio mínimo autorizado para una tarea concreta de metadatos.
- Opciones del proyecto, versiones, plugins, permisos, configuración global, runtime o cachés.

Los archivos `.gml` dentro de recursos existentes son el área normal de implementación. Leer metadatos para diagnosticar está permitido; cambiarlos no es equivalente a editar un evento GML.

No renombrar, mover, eliminar ni regenerar recursos para uniformar su estilo. No normalizar todos los metadatos con un serializador de JSON. Los `.yy` usan un formato similar a JSON; un rechazo de un parser genérico no prueba por sí solo que el recurso sea inválido [R5]. Verifica las convenciones de la versión local antes de sugerir reparaciones.

## Protección del trabajo existente

- Si hay Git, revisa estado y diff antes de editar; distingue cambios previos del usuario. La existencia de `.gitignore` no garantiza un repositorio inicializado.
- No usar `reset --hard`, `clean`, restauraciones amplias, borrados recursivos o force-push para arreglar esta tarea.
- No descartar modificaciones ajenas, hacer commits ni publicar cambios sin que el usuario lo pida.
- Conserva la estructura y los finales de línea del proyecto. Haz diffs pequeños.
- No copiar rutas de logs antiguos ni asumir que los temporales de una compilación anterior siguen siendo válidos.

## Edición externa y GameMaker

Antes de editar, confirma que Francisco haya guardado sus cambios y no esté modificando simultáneamente el mismo recurso. Para esta fase se recomienda guardar y cerrar el proyecto durante la edición externa.

Si GameMaker detecta cambios externos, `Reload` carga el disco y `Save` sobrescribe el disco con el estado del IDE [R6]. Indica cómo evitar perder cambios: no elegir una opción a ciegas si hay trabajo sin guardar. Si ambos lados cambiaron, detenerse y comparar antes de continuar.

Al entregar, indica que abra o recargue el mismo `PlumaBrava.yyp` que se editó. No abrir una copia temporal distinta y presentarla como validación del proyecto principal.

## Estilo de implementación GML

- Primero lee Create, Step y los eventos relacionados. No sustituyas código real por un snippet de la conversación.
- Mantén identificadores existentes como `hsp`, `vsp` o `move_speed` salvo una razón concreta para cambiarlos.
- Inicializa el estado que necesita cada instancia antes de usarlo. Mantén parámetros ajustables en un lugar claro.
- Usa variables locales para cálculos temporales y comentarios breves para explicar decisiones.
- Evita estado global innecesario, dependencias nuevas y abstracciones sin uso actual.
- No incorporar Box2D o el sistema de física como solución automática: el prototipo parte de movimiento y colisiones controlados en GML.
- Para desplazamiento, revisa fracciones, límites de velocidad, máscaras, apoyo y casos de solapamiento. Los bucles de corrección deben tener progreso y no poder bloquear el juego.
- Si se voltea un sprite, comprueba que el origen y la máscara no produzcan un desplazamiento inesperado; no alteres el dibujo para ocultarlo.
- Una nueva API, comando de compilación o formato dudoso debe verificarse con la documentación oficial correspondiente y la versión instalada.
- No introducir ECS, frameworks de combate, inyección de dependencias o una arquitectura genérica para resolver una sola mecánica.

Estas son prioridades de revisión, no autorización para implementar todas esas mejoras de una vez.

## Recursos que debe preparar Francisco

Cuando falte algo, entrega una ficha corta y espera su creación:

```text
Recurso/evento necesario:
Nombre propuesto:
Dónde crearlo en GameMaker:
Sprite, origen o máscara requeridos (solo si aplican):
Qué debe colocar o asignar Francisco:
Cómo confirmar que quedó listo:
```

No inventes nombres de botones o rutas de menú de una versión que no has visto. Describe el recurso que se necesita y pide una captura solo si hace falta para ubicarlo.

## Flujo de una tarea

**Inspeccionar → plan breve → implementar dentro del alcance → revisar → compilar si es posible → prueba jugable → actualizar estado.**

Para errores, busca la primera evidencia útil y distingue síntoma de causa. Una pestaña de errores vacía no demuestra que el código o los recursos estén bien. No diagnostiques antivirus, permisos o runtime solo por una salida `-1`.

No reinstalar herramientas ni borrar cachés como primer paso. Si una prueba adicional puede distinguir dos causas, propón esa prueba antes de un cambio invasivo.

## Subagentes: opcionales y con un solo escritor

Roles disponibles cuando la herramienta los reconozca:

- `gm-investigador`: lectura de GML, recursos y evidencia; devuelve diagnóstico y archivos relevantes.
- `gm-programador`: implementa una única tarea GML autorizada sobre archivos asignados.
- `gm-revisor`: revisa el resultado y propone pruebas; no modifica archivos ni da por ejecutadas pruebas manuales.

El agente principal coordina y consolida. Usa un rol solo si aporta valor. Una tarea pequeña puede resolverse directamente.

Nunca haya dos escritores trabajando simultáneamente en el proyecto. Si delegas implementación, el principal espera y no edita esos archivos. La revisión del resultado empieza después de terminar la escritura. No ejecutar varias compilaciones a la vez.

Cada delegación incluye objetivo, archivos permitidos, restricciones, criterios de aceptación y evidencia disponible. Todos los roles deben leer este archivo y el estado pertinente. Los subagentes no delegan a otros agentes y no actualizan la bitácora; lo hace el principal.

Si la versión no admite subagentes o no reconoce estos nombres, dilo y ejecuta los mismos pasos secuencialmente. Nunca afirmes que se lanzó un subagente sin haberlo hecho.

## Verificación honesta

Distingue tres niveles:

1. **Revisión estática:** lectura del código y referencias. No equivale a compilar.
2. **Compilación:** ejecución real, comando/entorno y resultado observado. No equivale a jugar.
3. **Prueba jugable:** entradas y resultado observados, o confirmación explícita de Francisco.

Compila solo si tienes un procedimiento válido para este proyecto y permisos suficientes. Reutiliza un procedimiento confirmado o identifica el oficial compatible; no inventes comandos de Igor ni reutilices un `build.bff` temporal como receta permanente. Si no puedes compilar desde la sesión, informa la limitación y entrega pasos concretos para probar en el IDE.

Una prueba que crea salida o cachés no pertenece a una revisión estrictamente de solo lectura. Los subagentes lectores devuelven recomendaciones; el principal coordina la compilación cuando esté autorizada.

Antes de cerrar un cambio de movimiento, comprueba o deja pendientes: controles anteriores, salto desde el suelo, caída, aterrizaje, paredes, techo y ausencia de errores. No agregues una suite extensa de pruebas o infraestructura para este prototipo.

## Actualización y respuesta de cierre

El agente principal actualiza `PROJECT_STATUS.md` solo con hechos nuevos o decisiones del usuario. Usa `implementado_sin_verificar` cuando falte evidencia de funcionamiento. Mantén separado el futuro del estado real.

Entrega al usuario:

- Qué cambió y en qué archivos/eventos.
- Qué debe hacer en GameMaker y qué debería observar.
- Qué se verificó, qué falta y qué valores puede ajustar.
- Una sola próxima acción.

No inventar compilaciones, pruebas, archivos o recursos. No afirmar que se inspeccionó todo el repositorio cuando solo se leyeron algunos archivos.

## Referencias de mantenimiento

[R1–R6] están en `docs/FLUJO_IA.md`. Las reglas de alcance de este documento son decisiones del proyecto; las referencias respaldan los formatos y el comportamiento de las herramientas.
