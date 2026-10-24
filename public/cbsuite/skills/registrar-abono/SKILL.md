---
name: registrar-abono
description: "Registrar un abono de cliente a una venta en CBSuite después de confirmar monto, venta y caja."
---

# Registrar abono

1. Resuelve la venta con `listarVentas` o `verVenta` y verifica su saldo.
2. Recoge monto y forma del pago ya realizado. Consulta `listarCajasCaptura` y elige una caja compatible; usa su `cajaId`.
3. Si el monto excede el saldo, explica la diferencia y solicita corregirlo.
4. Muestra empresa, venta, cliente, monto, forma y caja. Solicita confirmación explícita.
5. Sólo tras confirmación llama a `registrarAbonoVenta` con los parámetros del esquema publicado. No incluyas números de tarjetas, cuentas bancarias ni identificadores oficiales en referencias.
6. Verifica la respuesta y comunica el saldo resultante si está disponible. Si hay error o timeout, comprueba si el abono se registró antes de repetirlo.

## Reglas del perfil público

- Confirma la empresa con `listarMisMembresias` y `tenantActual`; usa su `tenantSlug` en las operaciones.
- Usa únicamente las herramientas individuales expuestas y sus esquemas actuales. Si falta una, explica la limitación de esta conexión; no intentes acceder por un ejecutor genérico, HTTP alternativo u otro conector.
- No solicites ni transmitas RFC, CURP, NSS, identificaciones oficiales, archivos, contraseñas, datos completos de tarjetas o cuentas bancarias. Para funciones fiscales y expedientes, indica que esta versión pública no las incluye y que se gestionan en el ERP web.
- Presenta sólo datos devueltos; omite campos no disponibles. Recorre la paginación antes de afirmar totales completos; si no, indica que son parciales.
- Antes de guardar cambios, muestra empresa, operación y valores y pide confirmación explícita. No inventes que una escritura tuvo éxito: verifica la respuesta.

