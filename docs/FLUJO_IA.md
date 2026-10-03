# Flujo de trabajo — GameMaker + Codex / Claude Code

## 1. El ciclo de desarrollo

**Francisco prepara recursos → el agente programa una tarea → Francisco prueba → se registra el resultado.**

Ejemplo futuro: para disparar, el agente indicará qué sprite y objeto de proyectil necesita. Francisco los creará y confirmará sus nombres. Entonces el agente programará el disparo y explicará cómo probarlo. No crear el sistema de armas completo cuando solo se pidió un proyectil.

Para cada sesión:

1. Elegir una tarea de `PROJECT_STATUS.md`.
2. Guardar en GameMaker. Evitar editar los mismos archivos desde dos herramientas simultáneamente.
3. Abrir la carpeta que contiene `PlumaBrava.yyp` y leer las instrucciones.
4. Revisar los archivos reales y acordar el cambio pequeño que corresponda.
5. Implementar, revisar y ejecutar una compilación real cuando sea posible.
6. Abrir/recargar el proyecto, jugar la prueba y comunicar el resultado.
7. Actualizar estado y dejar la siguiente acción.

Para cambios externos, la opción `Reload` de GameMaker toma los archivos del disco; `Save` puede sobrescribirlos con lo que conserva el editor. Resolver cualquier trabajo sin guardar antes de elegir [R6].

## 2. Archivos de instrucciones y subagentes

Son cosas distintas.

**Codex:** `AGENTS.md` contiene instrucciones del proyecto. La documentación también define agentes personalizados mediante archivos TOML en `.codex/agents/`, con `name`, `description` y `developer_instructions` [R1, R2].

**Claude Code:** este paquete usa `CLAUDE.md` con `@AGENTS.md` para compartir las reglas. Sus subagentes se describen en `.claude/agents/` mediante Markdown con encabezado YAML [R3, R4].

No se modifican modelos, configuración global ni políticas de aprobación. Los archivos de Codex para investigación y revisión solicitan `sandbox_mode = "read-only"`; el programador hereda la configuración del principal. Los lectores de Claude reciben herramientas de lectura, y el programador recibe además edición. Estas reglas no sustituyen los permisos efectivos de la sesión.

### Comprobar la carga

Después de copiar el paquete, abre una sesión nueva en la raíz del proyecto y pregunta:

```text
¿Qué instrucciones del proyecto cargaste y qué agentes personalizados puedes
invocar realmente? Comprueba si están disponibles gm-investigador,
gm-programador y gm-revisor. No modifiques nada.
```

La lista de nombres escrita en un Markdown no demuestra que los agentes estén cargados. La confirmación útil es que la herramienta los reconozca y pueda delegar. Si no lo hace, continuar con el principal y revisar la compatibilidad antes de cambiar configuración.

No se ofrece una orden universal de activación porque no se ha inspeccionado la versión de Codex o Claude Code instalada en este equipo. El flujo básico no depende de los subagentes.

## 3. Tres roles y nada más

| Rol | Cuándo aporta valor | Resultado |
| --- | --- | --- |
| `gm-investigador` | Hay un comportamiento dudoso o no se conoce el código relevante. | Archivos, evidencia, hipótesis y prueba mínima. |
| `gm-programador` | Existe una tarea aprobada y se conocen los archivos que puede editar. | Diff pequeño y explicación del cambio. |
| `gm-revisor` | Ya terminó la implementación y conviene una segunda revisión. | Posibles regresiones y checklist de prueba. |

El principal integra el resultado y actualiza `PROJECT_STATUS.md`. No hay un agente artista: el arte y los recursos del editor los controla Francisco.

El uso habitual es secuencial. Para una corrección trivial, el principal puede hacer todo. No forzar tres delegaciones para cambiar una constante.

## 4. Prompt de diagnóstico inicial

```text
Lee AGENTS.md, GAME_CONTEXT.md y PROJECT_STATUS.md.

Contrasta el registro con el proyecto real y revisa PB-002.
Ya confirmé compilación, arranque y movimiento horizontal. No confirmé
que Espacio funcione ni que haya probado el salto correctamente.

Inspecciona obj_player, sus eventos Crear/Paso y los recursos relevantes
para colisionar con obj_solid. No cambies nada todavía.

Usa gm-investigador si está disponible; de lo contrario haz la revisión
con el agente principal. Distingue datos observados de hipótesis.

Dime qué debo probar en GameMaker y cuál sería el cambio mínimo si falla.
No agregues armas, animaciones, cámara ni objetos.
```

## 5. Prompt para implementar la tarea revisada

Usar después de revisar la propuesta y confirmar que no falta preparar un recurso:

```text
Implementa el cambio mínimo propuesto para PB-002.

Puedes editar únicamente los archivos GML existentes que identificaste
para esta tarea. Conserva el movimiento horizontal y los recursos visuales.
No cambies .yy, .yyp, rooms, sprites ni configuración del entorno.

Si necesitas un evento o recurso nuevo, detente y dime qué debo crear.
Si descubres que el salto ya funciona, no lo reescribas por preferencia.

Puedes usar gm-programador como único escritor y, cuando termine,
gm-revisor para revisar el resultado. No delegues si no aporta valor.

Verifica lo que puedas realmente, separando revisión, compilación y
prueba jugable. Indícame qué probar en GameMaker.

Actualiza PROJECT_STATUS.md sin marcar como verificadas pruebas que aún
no realizamos. Detente al terminar esta tarea.
```

## 6. Plantilla para pedir cualquier nueva mecánica

```text
Tarea:
Comportamiento que busco:
Recursos que ya creé y sus nombres:
Qué debe pasar al probarlo:
Qué no debe cambiar:

Lee las instrucciones y el estado. Trabaja solo en esta tarea.
Si falta un recurso, indícame cómo prepararlo antes de programar.
```

Ejemplo para un paso posterior:

```text
Tarea: PB-003, orientación de la paloma.
Quiero que mire a la izquierda al caminar a la izquierda y a la derecha
al caminar a la derecha. Al detenerse debe conservar la última dirección.
Ya existen obj_player y spr_player; no tengo una animación nueva.
No cambies mi sprite ni alteres el salto o las colisiones.
Revisa primero si ya está implementado y si el origen/máscara permiten
hacerlo sin desplazamientos extraños.
```

## 7. Cómo comunicar una prueba o un error

Para pruebas manuales:

```text
Tarea que probé:
Qué hice (teclas, lugar y condición):
Qué esperaba:
Qué ocurrió:
¿Hay mensaje de error?:
Captura o log, si existe:
```

Para una falla de compilación, compartir desde el primer mensaje útil del log, no solo el resumen `FAILED`. La ventana de errores es una fuente adicional, no la única. Antes de pedir logs completos, retirar tokens, credenciales o datos privados que no ayuden a investigar.

El agente debe conservar lo que funciona y distinguir una falla nueva de la incidencia ya resuelta del primer arranque.

## 8. Cierre de una sesión

El agente principal anota en `PROJECT_STATUS.md` la tarea, archivos, evidencia, estado y siguiente acción. No cambia `GAME_CONTEXT.md` salvo que se haya tomado una decisión de diseño. No duplica el historial en `AGENTS.md` o `CLAUDE.md`.

La comprobación de un artefacto de código y una prueba jugable son distintas. Si Francisco aún debe probar, el estado debe decirlo.

## 9. Referencias técnicas

Consultadas el 2026-10-03. Se usan para los formatos de configuración y las precauciones del editor; el diseño del juego y el estado inicial provienen de la conversación de Francisco.

Los siguientes enlaces están en texto para poder consultarlos desde el editor. Algunas direcciones oficiales pueden redirigir a una ubicación nueva.

```text
[R1] OpenAI — Custom instructions with AGENTS.md
https://developers.openai.com/codex/guides/agents-md

[R2] OpenAI — Subagents / Custom agents
https://developers.openai.com/codex/subagents

[R3] Claude Code — How Claude remembers your project
https://code.claude.com/docs/en/memory

[R4] Claude Code — Create custom subagents
https://code.claude.com/docs/en/sub-agents

[R5] GameMaker — Project Format
https://manual.gamemaker.io/lts/en/Additional_Information/Project_Format.htm

[R6] GameMaker — The File Watcher
https://manual.gamemaker.io/lts/en/IDE_Tools/The_File_Watcher.htm
```
