# biank-plugin

Plugin de Biank para arnés comercial: ChatGPT Work para el cliente final y, del
mismo fuente, Claude y Codex. El producto son las skills; los datos y las
acciones vienen del MCP de CBSuite (TSK-479).

## Estructura

El repo es un marketplace de complementos de ChatGPT (Personalizar →
Complementos → Agregar marketplace → `jobeto86/biank-plugin`).

- `.agents/plugins/marketplace.json` — catálogo con el complemento `cbsuite`.
- `plugins/cbsuite/.codex-plugin/plugin.json` — manifiesto.
- `plugins/cbsuite/skills/<nombre>/SKILL.md` — una skill por carpeta, formato
  Agent Skills (frontmatter `name` + `description`).
- `plugins/cbsuite/.mcp.json` — MCP remoto de CBSuite para Codex.
- `plugins/cbsuite/.app.json` (pendiente) — liga al conector de CBSuite en
  ChatGPT; es lo que usan Chat y Work. Requiere el custom connector de CUR-351
  creado en el workspace para obtener su `connector_…`.

## Reglas del paquete

- Sin scripts locales: lo que necesite ejecutar algo es una tool del MCP.
- Sin memoria propia: la memoria personal es del arnés; la memoria OKF es un
  MCP opcional, opt-in por usuario, y el plugin base no depende de él.
- El conocimiento de la empresa vive en CBSuite (wiki de procesos, fichas) y
  en el Drive de la empresa, no en este repo.
- Toda escritura que mueva dinero o saldos pide confirmación explícita.

## Origen

Migración inicial desde `jobeto86/biank` `packages/agent/skills` (`2552e54`).
Quedaron fuera las skills propias de Biank Desktop: `actualizarme`,
`conectar-cbsuite`, `conectar-google`, `diagnostico`, `operaciones-whatsapp`.

## Pendiente

- `organizar-drive`: guía para organizar y compartir el Drive de la empresa
  (sustituye a `gestion-manuales`).
- `revision-semanal` y `buscar-archivo`: dependían de memoria y scripts
  locales; decidir si se rehacen sobre MCP o se descartan.
- Protocolo `receipt_capture` (captura de comprobantes) como skill.
- `.app.json` con el id del conector de CBSuite (ver Estructura).
- Empaquetado para Claude.
