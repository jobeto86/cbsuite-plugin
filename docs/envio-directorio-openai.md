# Envío de CBSuite al directorio público de OpenAI

Estado al 2026-10-23. Spec rector: `cbsuite-erp/docs/specs/conector-chatgpt.spec.md`
(CUR-351, meta de envío 2026-11-13). Requisitos tomados de guías de terceros: la
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
- [x] 480 de 482 tools declaran `readOnlyHint` / `destructiveHint` / `openWorldHint`.
- [x] Escrituras fiscales con vista previa y `confirmed=true` del lado del servidor.

## Le toca a Roberto

- [ ] **Organización verificada** en OpenAI Platform a nombre de CB Inteligencia
      (persona o empresa). Sin verificar, rechazan.
- [ ] **Datos del responsable** para el aviso de privacidad: razón social, domicilio,
      RFC y correo ARCO (Anexo A del spec).
- [ ] **Revisión de abogado** del aviso y los términos del Anexo A.
- [ ] **Autorizar publicar en `cbinteligencia.com`** las páginas de privacidad,
      términos y soporte. Hoy `/privacidad`, `/terminos` y `/soporte` no existen:
      el sitio responde la portada.
- [ ] **Autorizar el token de dominio en producción**: servir el texto exacto que dé
      OpenAI en `https://cbsuite.cbinteligencia.com/.well-known/openai-apps-challenge`
      (hoy 404).
- [ ] **Decidir la superficie de producción**: con la bandera B4 apagada (prod), el
      token de ChatGPT recibe el perfil curado `chatgpt-v1` y quedan fuera tools que
      usan las skills (abajo). Encenderla en prod o ajustar las skills es decisión tuya.
- [ ] **Grabar el video demo** y hacer el envío (Plugins → Upload new or existing plugin).

## Le toca a Marvin (cuando lo anterior se destrabe)

- [ ] Tenant demo con datos sintéticos y usuario revisor sin 2FA, membresía sólo ahí
      (spec §4, fecha 2026-11-10). Credenciales por el dashboard, nunca en el repo.
- [ ] 5 casos positivos y 3 negativos, con prompts y resultado esperado.
- [ ] Capturas (ancho por confirmar: 706 px) y notas de versión.
- [ ] Publicar las páginas legales y el token una vez autorizados.
- [ ] Anotar las 2 tools sin hints.

## Skills contra el perfil curado `chatgpt-v1`

Con B4 apagada, estas skills llaman tools que el perfil no incluye y fallarían ante
el revisor:

| Skill | Tools fuera del perfil |
|---|---|
| `reportar-soporte` | `crearTicket`, `verTicket`, `listarTickets`, `actualizarTicketEstado`, `buscarEmpleados`, `listarUsuarios` |
| `consultar-cobranza` | `identificarOportunidadesContacto`, `registrarInteraccionCobranza` |
| `consultar-caja` | `verificarCaja` |
| `consultar-inventario` | `historialInventario` |
| `consultar-clientes` | `resumenEstrategicoCliente` |

Con B4 encendida (núcleo + `buscarHerramientas` / `ejecutarHerramienta`) todas
alcanzan su tool, filtrada por RBAC.
