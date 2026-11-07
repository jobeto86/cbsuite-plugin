---
name: consultar-compras
description: "Consultar compras y estados de cuenta de proveedores o registrar remisiones en CBSuite."
---

# Consultar compras

Usa `listarCompras`, `verCompra`, `buscarProveedores` y `estadoCuentaProveedor`. Resuelve primero el proveedor y las fechas requeridas. Presenta folios comerciales, importes y saldos disponibles.

Si el usuario pide crear una compra, usa `crearCompra` cuando tengas proveedor, productos, cantidades e importes. Para un pago ya efectuado usa `registrarAbonoCompra` con compra, monto, forma de pago y la caja de `listarCajasCaptura`. Pregunta sólo si falta un dato o la orden es ambigua. No ejecutes transferencias ni solicites datos bancarios sensibles.

En el perfil público, `crearCompra` registra una remisión. Una orden de compra comercial completa se puede ejecutar sin preguntar por clasificación fiscal. Si la persona pide registrar la compra como facturada o vincular su factura, indícale que debe vincular el XML del proveedor en CBSuite web. Sólo registra una remisión en ese caso si la persona la pide expresamente. Omite `esFacturada` y `usoCFDI`; la clasificación se deriva del XML vinculado en el ERP. No solicites RFC, identificaciones, XML ni PDF.

## Reglas del perfil público

- Confirma la empresa con `listarMisMembresias` y `tenantActual`; usa su `tenantSlug` en las operaciones.
- Usa únicamente las herramientas individuales expuestas y sus esquemas actuales. Si falta una, explica la limitación de esta conexión; no intentes acceder por un ejecutor genérico, HTTP alternativo u otro conector.
- No solicites ni transmitas RFC, CURP, NSS, identificaciones oficiales, archivos, contraseñas, datos completos de tarjetas o cuentas bancarias. Para funciones fiscales y expedientes, indica que esta versión pública no las incluye y que se gestionan en el ERP web.
- Presenta sólo datos devueltos; omite campos no disponibles. Recorre la paginación antes de afirmar totales completos; si no, indica que son parciales.
- Una orden explícita y completa se ejecuta; pregunta sólo si falta un dato o es ambigua. No inventes que una escritura tuvo éxito: verifica la respuesta.

