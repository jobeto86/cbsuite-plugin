---
name: registrar-abono
description: "Registrar un abono de cliente a una venta en CBSuite con monto, venta, forma de pago y caja; pregunta sólo si falta un dato o la orden es ambigua."
---

# Registrar abono

1. Resuelve la venta con `listarVentas` o `verVenta` y verifica su saldo.
2. Recoge monto y forma del pago ya realizado. Consulta `listarCajasCaptura` y elige una caja compatible; usa su `cajaId`.
3. Si el monto excede el saldo, explica la diferencia y solicita corregirlo.
4. Pregunta sólo si falta un dato, hay varias ventas posibles o más de una caja compatible sin que la orden indique cuál.
5. Llama a `registrarAbonoVenta` con los parámetros del esquema publicado. No incluyas números de tarjetas, cuentas bancarias ni identificadores oficiales en referencias.
6. Verifica la respuesta y comunica el saldo resultante si está disponible. Si hay error o timeout, comprueba si el abono se registró antes de repetirlo.

## Reglas del perfil público

- Confirma la empresa con `listarMisMembresias` y `tenantActual`; usa su `tenantSlug` en las operaciones.
- Usa únicamente las herramientas individuales expuestas y sus esquemas actuales. Si falta una, explica la limitación de esta conexión; no intentes acceder por un ejecutor genérico, HTTP alternativo u otro conector.
- No solicites ni transmitas RFC, CURP, NSS, identificaciones oficiales, archivos, contraseñas, datos completos de tarjetas o cuentas bancarias. Para funciones fiscales y expedientes, indica que esta versión pública no las incluye y que se gestionan en el ERP web.
- Presenta sólo datos devueltos; omite campos no disponibles. Recorre la paginación antes de afirmar totales completos; si no, indica que son parciales.
- Una orden explícita y completa se ejecuta; pregunta sólo si falta un dato o es ambigua. No inventes que una escritura tuvo éxito: verifica la respuesta.

