# Pluma Brava — contexto y trabajo con IA

**Punto de partida:** 3 de octubre de 2026.  
**Objetivo:** seguir construyendo el juego, con Francisco a cargo del arte y de los recursos en GameMaker, y Codex o Claude Code a cargo de la programación.

Este paquete contiene documentación e instrucciones. No incluye ni reemplaza el proyecto GameMaker, su código GML o sus imágenes. El estado inicial se reconstruyó a partir de la conversación y las capturas; todavía debe contrastarse con los archivos del proyecto.

## 1. Dónde colocar los archivos

Extrae el contenido del paquete **junto a `PlumaBrava.yyp`**, dentro de la carpeta del proyecto. No lo importes desde el navegador de activos de GameMaker.

La ruta local mostrada durante el desarrollo fue `E:\games_development\PlumaBrava`. Comprueba que sea la carpeta del proyecto que estás abriendo actualmente.

```text
PlumaBrava/
├── PlumaBrava.yyp              ← ya existe; no viene en este paquete
├── objects/                   ← recursos existentes
├── rooms/                     ← recursos existentes
├── sprites/                   ← tus dibujos existentes
├── EMPEZAR_AQUI.md
├── GAME_CONTEXT.md
├── PROJECT_STATUS.md
├── AGENTS.md
├── CLAUDE.md
├── docs/
│   └── FLUJO_IA.md
├── .codex/
│   └── agents/
│       ├── gm-investigador.toml
│       ├── gm-programador.toml
│       └── gm-revisor.toml
└── .claude/
    └── agents/
        ├── gm-investigador.md
        ├── gm-programador.md
        └── gm-revisor.md
```

Si ya tienes un archivo con el mismo nombre, revisa y combina su contenido antes de reemplazarlo. Las carpetas que comienzan con punto también forman parte del paquete. No se incluye configuración global, credenciales ni un cambio de permisos.

## 2. Para qué sirve cada archivo

| Archivo | Uso |
| --- | --- |
| `GAME_CONTEXT.md` | Idea del juego, protagonista, armas, mundo y alcance de la primera demo. |
| `PROJECT_STATUS.md` | Qué está confirmado, qué falta y cuál es la próxima tarea. Es el registro que se actualiza al avanzar. |
| `AGENTS.md` | Reglas compartidas para los asistentes: qué pueden programar, qué debes crear tú y cómo verificar cambios. |
| `CLAUDE.md` | Entrada para Claude Code; importa `AGENTS.md` para compartir las mismas reglas. |
| `docs/FLUJO_IA.md` | Forma de trabajar, uso de subagentes y prompts reutilizables. |
| `.codex/agents/` y `.claude/agents/` | Definiciones de los tres roles para las herramientas que admitan esos formatos. |

Para empezar con un solo agente bastan `AGENTS.md`, `GAME_CONTEXT.md` y `PROJECT_STATUS.md`. `CLAUDE.md` adapta las instrucciones a Claude Code. Los subagentes son opcionales: no necesitas utilizarlos todos en cada tarea.

## 3. Primera sesión

Guarda el proyecto en GameMaker y abre su carpeta en VS Code. Inicia una nueva conversación con Codex o Claude Code desde esa carpeta y pega:

```text
Lee AGENTS.md, GAME_CONTEXT.md y PROJECT_STATUS.md.

Estamos retomando Pluma Brava. Yo dibujo los sprites, creo los objetos y
construyo las rooms en GameMaker. Tú me ayudas con el GML, en pasos pequeños.

Primero contrasta el estado documentado con los archivos reales.
El juego ya compiló y abrió, y confirmé movimiento horizontal.
El salto con Espacio todavía NO está verificado; no des por hecho que falta.

Trabajemos únicamente en PB-002: revisar movimiento, gravedad, salto y
colisiones de obj_player contra obj_solid.

Usa gm-investigador si está disponible. Si no, haz esa revisión tú mismo
y aclara que no hubo una delegación real.

Por ahora no modifiques archivos. Dime qué encontraste, qué debo probar
y cuál sería el cambio mínimo si hay un problema.
```

Después de la revisión puedes autorizar la implementación de esa tarea. Hay un prompt para hacerlo en `docs/FLUJO_IA.md`.

## 4. El acuerdo de trabajo

**Tú creas y diseñas → el agente programa una mecánica → tú pruebas en GameMaker → se registra el resultado.**

Un cambio puede estar escrito o compilar y seguir pendiente de comprobar jugando. No se marcará el salto como terminado hasta tener evidencia de esa prueba.

## 5. Subagentes y compatibilidad

`AGENTS.md` y `CLAUDE.md` dan instrucciones; no son, por sí solos, un sistema que cree subagentes. Las definiciones adicionales usan los formatos documentados de cada herramienta. Hay que confirmar que la versión instalada las cargue antes de usarlas.

No se han probado estas definiciones dentro de tu instalación. El paquete fue comprobado como archivos de texto, TOML y encabezados YAML. Si una herramienta no reconoce un rol, continúa con el agente principal siguiendo las mismas reglas, sin alterar permisos ni instalar componentes automáticamente.

Consulta el flujo y las referencias oficiales en `docs/FLUJO_IA.md`.
