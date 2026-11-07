---
name: consultar-cobranza
description: "Consultar cartera y guardar seguimientos de cobranza cuando la persona lo ordena."
---

# Consultar cobranza

Usa `estadoCartera` para antigüedad de saldos, `buscarClientes` para resolver al cliente, `ventasPendientesCliente` para adeudos y `listarInteraccionesCobranza` para seguimiento. No conviertas totales por antigüedad en una lista de clientes que no fue devuelta.

Para `registrarInteraccionCobranza`, recoge sólo cliente, tipo, resultado operativo y promesa de pago si aplica. Con esos datos, guarda; pregunta sólo si falta uno o la orden es ambigua. No mandes mensajes ni hagas llamadas al cliente. No añadas identificaciones o detalles sensibles en texto libre.

## Reglas del perfil público

- Confirma la empresa con `listarMisMembresias` y `tenantActual`; usa su `tenantSlug` en las operaciones.
- Usa únicamente las herramientas individuales expuestas y sus esquemas actuales. Si falta una, explica la limitación de esta conexión; no intentes acceder por un ejecutor genérico, HTTP alternativo u otro conector.
- No solicites ni transmitas RFC, CURP, NSS, identificaciones oficiales, archivos, contraseñas, datos completos de tarjetas o cuentas bancarias. Para funciones fiscales y expedientes, indica que esta versión pública no las incluye y que se gestionan en el ERP web.
- Presenta sólo datos devueltos; omite campos no disponibles. Recorre la paginación antes de afirmar totales completos; si no, indica que son parciales.
- Una orden explícita y completa se ejecuta; pregunta sólo si falta un dato o es ambigua. No inventes que una escritura tuvo éxito: verifica la respuesta.

