# Perfil público CBSuite 0.1.4

`cbsuite/` es la fuente del ZIP portátil para el catálogo público de OpenAI.
El paquete privado en `plugins/cbsuite/` conserva su alcance.

Este perfil incluye ventas, consultas de clientes, inventario, compras, caja y
cobranza, con confirmación antes de las escrituras. Excluye facturación fiscal,
identificadores oficiales y archivos. Sus ocho skills usan operaciones MCP
individuales, sin descubrimiento ni ejecutor genérico.

`mcp.json` usa un cliente OAuth público dedicado, sin secreto, con PKCE. El
servidor debe incluir su ID en `CBSUITE_MCP_PUBLIC_CLIENT_IDS` antes de reconectar
el borrador. No activar el paquete contra un servidor que aún entregue el perfil
privado a este cliente.

Para empaquetar, comprimir el contenido de `cbsuite/` dejando `plugin.json` y
`mcp.json` en la raíz. El ZIP no lleva credenciales de revisión. Estas se guardan
en Bitwarden y se proporcionan únicamente en el formulario del portal.

La carga de un borrador no equivale al envío a revisión ni a publicación.
Después del despliegue certificado: reconectar OAuth, verificar herramientas y
empresa de prueba, ejecutar casos de revisión, repetir el escáner y comprobar
los datos del revisor antes del envío.
