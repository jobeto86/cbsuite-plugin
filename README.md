# biank-plugin

Plugin de Biank para arnés comercial: ChatGPT Work para el cliente final y, del
mismo fuente, Claude y Codex. El producto son las skills; los datos y las
acciones vienen del MCP de CBSuite (TSK-479).

## Estructura

- `skills/<nombre>/SKILL.md` — una skill por carpeta, formato Agent Skills
  (frontmatter `name` + `description`).

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
- Manifiestos de empaquetado por arnés (ChatGPT Work, Claude, Codex).
