# Plugin CBSuite · Alcance y operaciones

Línea base del paquete al 7 de noviembre de 2026. Las skills guían al asistente para consultar u operar el ERP mediante el MCP de CBSuite. El ERP conserva los datos, permisos y reglas de negocio.

| ID | Comportamiento y criterio de aceptación |
| --- | --- |
| PLG-01 | En el perfil público, una consulta de ventas, clientes, compras, caja, inventario o cobranza usa el MCP. El resultado se limita a los datos devueltos y cualquier total incompleto se identifica como parcial. |
| PLG-02 | En el perfil público, con una empresa solicitada fuera de las membresías de la cuenta, el asistente no devuelve datos de esa empresa ni recurre a otro conector. Las operaciones usan el `tenantSlug` de la empresa resuelta con el MCP. |
| PLG-03 | En una orden explícita de registrar un pago ya realizado, con venta inequívoca, monto dentro del saldo, forma de pago y caja compatible, el asistente registra el abono sin pedir una segunda confirmación. Si falta un dato, hay ambigüedad o el monto supera el saldo, aclara antes de escribir. |
| PLG-04 | Si el registro de abono devuelve un error o timeout en el perfil público, se comprueba si se registró antes de reintentarlo. Sólo se comunica éxito cuando lo respalda la respuesta del ERP o la verificación posterior. |
| PLG-05 | El paquete público contiene ocho skills y opera con herramientas MCP individuales. Ante facturación fiscal, archivos o soporte por ticket, informa el límite del perfil y deriva al ERP web o a la página de soporte según corresponda. |
| PLG-06 | El paquete privado incluye la skill `reportar-soporte`. Si el asistente detecta una falla por su cuenta, ofrece reportarla y sólo crea el ticket tras la autorización de la persona. |
| PLG-07 | En el ZIP público, `plugin.json` y `mcp.json` quedan en la raíz. La configuración usa el cliente público OAuth con PKCE y el paquete carece de secretos o credenciales de revisión. |
| PLG-08 | En el perfil público, una orden completa de compra comercial registra una remisión en el ERP sin pedir clasificación fiscal. Si la persona solicita registrarla como facturada, el asistente explica que debe vincular el XML del proveedor en CBSuite web. No solicita uso de CFDI ni archivos y no crea una remisión salvo orden expresa. |
| PLG-09 | Una orden explícita de guardar seguimiento de cobranza usa el cliente, tipo y resultado operativo, con promesa de pago si aplica. El seguimiento queda en el ERP y no genera mensajes ni llamadas al cliente. |
| PLG-10 | El paquete privado incluye la skill `cargar-catalogo`: interpreta la fuente de la persona, cruza duplicados antes de dar de alta porque el ERP no los rechaza, y usa `crearProducto`, una sola `crearEntradaInventario` y `crearCliente`. Si el plan contiene suposiciones, espera el sí de la persona; un fallo de alta se comprueba antes de reintentarlo. |

Fuentes y verificación. Revisar el [perfil público](../public/README.md), las [skills privadas](../plugins/cbsuite/skills/) y los [casos de revisión](casos-revision-openai.md). Para las pruebas de aceptación del perfil público, usar el cliente OAuth público y datos de prueba. La solicitud de cancelar una factura debe terminar informando el límite del perfil.
