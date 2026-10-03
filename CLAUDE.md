@AGENTS.md

# Adaptación para Claude Code

`AGENTS.md` contiene las reglas compartidas del proyecto. No mantengas una segunda versión divergente aquí.

Lee `GAME_CONTEXT.md` y `PROJECT_STATUS.md` antes de trabajar. Para la instalación y los prompts, consulta `docs/FLUJO_IA.md`.

Las definiciones de subagentes de este proyecto están en `.claude/agents/`:
`gm-investigador`, `gm-programador` y `gm-revisor`.

Verifica que estén disponibles antes de delegar. Son opcionales. El principal mantiene una sola tarea activa, pasa el contexto necesario a cada rol y consolida la respuesta y la actualización del estado.

Solo `gm-programador` tiene herramientas de edición en las definiciones incluidas. No amplíes sus herramientas o permisos para resolver un bloqueo sin consultarlo. La compilación y los comandos del entorno quedan coordinados por el agente principal.

No editar al mismo tiempo desde el principal y desde un subagente. No sustituir sprites ni crear recursos del editor sin la autorización específica indicada en `AGENTS.md`.
