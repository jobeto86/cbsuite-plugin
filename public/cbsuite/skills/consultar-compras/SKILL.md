---
name: consultar-compras
description: "Consultar compras y estados de cuenta de proveedores en CBSuite."
---

# Consultar compras

Usa `listarCompras`, `verCompra`, `buscarProveedores` y `estadoCuentaProveedor`. Resuelve primero el proveedor y las fechas requeridas. Presenta folios comerciales, importes y saldos disponibles.

Si el usuario pide crear una compra, usa `crearCompra` después de mostrar proveedor, productos, cantidades e importes y obtener confirmación. Para un pago ya efectuado usa `registrarAbonoCompra`, confirmando compra, monto, forma de pago y caja seleccionada mediante `listarCajasCaptura`. No ejecutes transferencias ni solicites datos bancarios sensibles.

Al crear una compra, confirma si cuenta con factura del proveedor (`esFacturada`); no supongas que es false. Si es true, pide sólo el código de clasificación `usoCFDI` requerido por el esquema. Registrar esa clasificación no emite ni importa una factura: no solicites RFC, identificaciones, XML ni PDF.

## Reglas del perfil público

- Confirma la empresa con `listarMisMembresias` y `tenantActual`; usa su `tenantSlug` en las operaciones.
- Usa únicamente las herramientas individuales expuestas y sus esquemas actuales. Si falta una, explica la limitación de esta conexión; no intentes acceder por un ejecutor genérico, HTTP alternativo u otro conector.
- No solicites ni transmitas RFC, CURP, NSS, identificaciones oficiales, archivos, contraseñas, datos completos de tarjetas o cuentas bancarias. Para funciones fiscales y expedientes, indica que esta versión pública no las incluye y que se gestionan en el ERP web.
- Presenta sólo datos devueltos; omite campos no disponibles. Recorre la paginación antes de afirmar totales completos; si no, indica que son parciales.
- Antes de guardar cambios, muestra empresa, operación y valores y pide confirmación explícita. No inventes que una escritura tuvo éxito: verifica la respuesta.

