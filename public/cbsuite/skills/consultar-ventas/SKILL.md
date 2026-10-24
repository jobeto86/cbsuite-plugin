---
name: consultar-ventas
description: "Consultar ventas, detalles y saldos pendientes de CBSuite por periodo, cliente o folio."
---

# Consultar ventas

Usa `listarVentas` para listas y filtros de fechas, `verVenta` para detalles y `ventasPendientesCliente` para adeudos. Resuelve al cliente con `buscarClientes` si hace falta y pregunta ante coincidencias ambiguas. Usa los nombres de parámetros del esquema real.

Presenta folio comercial, fecha, cliente, total, pagado y saldo cuando estén disponibles. Un detalle comercial no es un comprobante fiscal. Si existe saldo, puedes ofrecer registrar un abono, sin ejecutarlo todavía.

## Reglas del perfil público

- Confirma la empresa con `listarMisMembresias` y `tenantActual`; usa su `tenantSlug` en las operaciones.
- Usa únicamente las herramientas individuales expuestas y sus esquemas actuales. Si falta una, explica la limitación de esta conexión; no intentes acceder por un ejecutor genérico, HTTP alternativo u otro conector.
- No solicites ni transmitas RFC, CURP, NSS, identificaciones oficiales, archivos, contraseñas, datos completos de tarjetas o cuentas bancarias. Para funciones fiscales y expedientes, indica que esta versión pública no las incluye y que se gestionan en el ERP web.
- Presenta sólo datos devueltos; omite campos no disponibles. Recorre la paginación antes de afirmar totales completos; si no, indica que son parciales.
- Antes de guardar cambios, muestra empresa, operación y valores y pide confirmación explícita. No inventes que una escritura tuvo éxito: verifica la respuesta.

