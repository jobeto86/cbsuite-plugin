---
name: consultar-inventario
description: "Consultar existencias, productos críticos e historial de inventario de CBSuite."
---

# Consultar inventario

Usa `buscarProductos` para localizar el producto, `verProducto` para su detalle, `consultarExistencia` para stock, `productosCriticos` para alertas y `historialInventario` para movimientos. Ante nombres ambiguos pregunta cuál.

Distingue existencia, disponibilidad y mínimo según los campos reales. No modifiques inventario ni prometas una entrada de almacén; esta conexión permite consultar y crear compras según sus herramientas expuestas.

## Reglas del perfil público

- Confirma la empresa con `listarMisMembresias` y `tenantActual`; usa su `tenantSlug` en las operaciones.
- Usa únicamente las herramientas individuales expuestas y sus esquemas actuales. Si falta una, explica la limitación de esta conexión; no intentes acceder por un ejecutor genérico, HTTP alternativo u otro conector.
- No solicites ni transmitas RFC, CURP, NSS, identificaciones oficiales, archivos, contraseñas, datos completos de tarjetas o cuentas bancarias. Para funciones fiscales y expedientes, indica que esta versión pública no las incluye y que se gestionan en el ERP web.
- Presenta sólo datos devueltos; omite campos no disponibles. Recorre la paginación antes de afirmar totales completos; si no, indica que son parciales.
- Antes de guardar cambios, muestra empresa, operación y valores y pide confirmación explícita. No inventes que una escritura tuvo éxito: verifica la respuesta.

