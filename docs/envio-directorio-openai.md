# Envío de CBSuite al directorio público de OpenAI

Estado al 2026-10-23. Spec rector: `cbsuite-erp/docs/specs/conector-chatgpt.spec.md`
(CUR-351). **Envío: 2026-11-03** (adelantado por Roberto); todo listo el 2026-10-31. Requisitos tomados de guías de terceros: la
documentación oficial de OpenAI respondió 403; se confirman en el dashboard.

## Paquete

- `dist/cbsuite-0.1.3.zip` (no versionado; se regenera abajo). 231 KB, 24 entradas
  (límites: 100 MB y 5,000). Contiene `.codex-plugin/plugin.json`, `.mcp.json`,
  `assets/logo.png` y las 9 skills. Sin secretos ni referencias a `.app.json`.
- El MCP va desde el primer envío: no se puede agregar después a un envío sólo de skills.

```bash
cd plugins/cbsuite && zip -qr -X ../../dist/cbsuite-$(jq -r .version .codex-plugin/plugin.json).zip .codex-plugin .mcp.json assets skills
```

## Listo

- [x] ZIP dentro de límites, manifiesto válido, logo de marca.
- [x] OAuth del MCP: discovery, DCR, RFC 9207 y callbacks de ChatGPT (CUR-144).
- [x] Las 486 tools declaran `readOnlyHint` / `destructiveHint` / `openWorldHint`.
- [x] Escrituras fiscales con vista previa y `confirmed=true` del lado del servidor.

## Le toca a Roberto

- [ ] **Organización verificada** en OpenAI Platform a nombre de CB Inteligencia
      (persona o empresa). Sin verificar, rechazan.
- [ ] **Datos del responsable** para el aviso de privacidad: razón social, domicilio,
      RFC y correo ARCO (Anexo A del spec).
- [ ] **Revisión de abogado** del aviso y los términos del Anexo A.
- [x] Páginas publicadas: `https://cbinteligencia.com/privacidad/`, `/terminos/` y `/soporte/`
      (responsable José Roberto Ramírez Aguilar; revisión de abogado pendiente por decisión de Roberto).
- [ ] **Autorizar el token de dominio en producción**: servir el texto exacto que dé
      OpenAI en `https://cbsuite.cbinteligencia.com/.well-known/openai-apps-challenge`
      (hoy 404).
- [x] **Superficie de producción**: B4 encendida en prod (verificado 2026-10-23,
      `release/2026-10-22`). ChatGPT recibe núcleo + descubrimiento; las skills alcanzan
      todas sus tools, filtradas por RBAC.
- [x] **Video demo grabado** (2026-10-23). Recorrido real desde chatgpt.com con `revisor.openai`:
      primera autorización con callback de ChatGPT en prod (12:35) y 5 tools en `demo-revisor`
      (perfil, membresías, ventas, cartera, productos críticos) sin errores.
- [ ] Hacer el envío (Plugins → Upload new or existing plugin) con `dist/cbsuite-0.1.3.zip`.

## Le toca a Marvin (cuando lo anterior se destrabe)

- [x] Tenant demo «Distribuidora Demo del Bajío» (`demo-revisor`) y usuario `revisor.openai`
      sembrados en prod el 2026-10-23 (`release/2026-10-23-2`), verificados por OAuth. Contraseña
      en `~/.marvin/state/cbsuite-demo-revisor-prod.env`; se entrega sólo por el dashboard.
- [ ] 5 casos positivos y 3 negativos, con prompts y resultado esperado.
- [ ] Capturas (ancho por confirmar: 706 px) y notas de versión.
- [ ] Publicar las páginas legales y el token una vez autorizados.
- [x] Hints: las 486 tools declaran `readOnlyHint` / `destructiveHint` / `openWorldHint` (verificado 2026-10-23).
- [x] Casos de prueba redactados: `docs/casos-revision-openai.md`.

## Skills contra el perfil curado `chatgpt-v1`

Histórico: con B4 apagada, estas skills llamarían tools que el perfil no incluye. Desde
el 2026-10-23 B4 está encendida en prod y las alcanzan vía `ejecutarHerramienta`:

| Skill | Tools fuera del perfil |
|---|---|
| `reportar-soporte` | `crearTicket`, `verTicket`, `listarTickets`, `actualizarTicketEstado`, `buscarEmpleados`, `listarUsuarios` |
| `consultar-cobranza` | `identificarOportunidadesContacto`, `registrarInteraccionCobranza` |
| `consultar-caja` | `verificarCaja` |
| `consultar-inventario` | `historialInventario` |
| `consultar-clientes` | `resumenEstrategicoCliente` |

Con B4 encendida (núcleo + `buscarHerramientas` / `ejecutarHerramienta`) todas
alcanzan su tool, filtrada por RBAC.
