# CBSuite (Perfil Público 0.1.5)

Conecta tu cuenta de **CBSuite ERP** para consultar ventas, clientes, inventario, compras, saldos de caja y cobranza, así como registrar operaciones comerciales y abonos en lenguaje natural.

## Alcance

- **Incluido**: ventas, clientes, inventario, compras, caja, cobranza y registro de abonos ya realizados/recibidos (`ayuda`, `consultar-ventas`, `consultar-clientes`, `consultar-cobranza`, `consultar-inventario`, `consultar-compras`, `consultar-caja`, `registrar-abono`).
- **Excluido en este perfil público**: facturación fiscal (CFDI/RFC), identificaciones oficiales y carga o descarga de archivos.
- **Pagos**: el plugin registra abonos y compras en el ERP; no ejecuta transferencias bancarias ni cargos a tarjetas.

## Requisitos y autenticación

- Cuenta activa en **CBSuite** (`https://cbsuite.cbinteligencia.com`).
- Conexión MCP remota vía Streamable HTTP (`https://cbsuite.cbinteligencia.com/mcp`) con autenticación **OAuth 2.0**. El acceso queda limitado a las empresas (tenants) y permisos asignados a tu cuenta.

## Soporte y políticas

- Sitio web: https://cbinteligencia.com
- Soporte: https://cbinteligencia.com/soporte
- Privacidad: https://cbinteligencia.com/privacidad
- Términos: https://cbinteligencia.com/terminos
