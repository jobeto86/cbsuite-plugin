# CBSuite (0.1.6)

Conecta tu cuenta de **CBSuite ERP** para consultar y operar ventas, facturación, clientes, inventario, compras, saldos de caja, cobranza y reportes en lenguaje natural.

## Alcance

- **ERP completo según tus permisos**: el servidor MCP expone el núcleo operativo y descubrimiento dinámico (`buscarHerramientas` / `ejecutarHerramienta`) limitado únicamente por las empresas (tenants), módulos activos y permisos RBAC asignados a tu cuenta de CBSuite.
- **Fuente única de guías**: los manuales operativos y reglas de negocio viven en el servidor MCP de CBSuite (recursos MCP y descripciones de herramientas); este paquete aporta el manifiesto, la conexión MCP y el skill mínimo de arranque (`ayuda`).

## Requisitos y autenticación

- Cuenta activa en **CBSuite** (`https://cbsuite.cbinteligencia.com`).
- Conexión MCP remota vía Streamable HTTP (`https://cbsuite.cbinteligencia.com/mcp`) con autenticación **OAuth 2.0** (`https://antigravity.google/oauth-callback`). El acceso queda limitado a las empresas (tenants) y permisos asignados a tu cuenta.

## Soporte y políticas

- Sitio web: https://cbinteligencia.com
- Soporte: https://cbinteligencia.com/soporte
- Privacidad: https://cbinteligencia.com/privacidad
- Términos: https://cbinteligencia.com/terminos
