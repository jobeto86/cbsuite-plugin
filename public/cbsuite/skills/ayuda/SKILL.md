---
name: ayuda
description: "Explicar las capacidades y límites del perfil público de CBSuite cuando el usuario pide ayuda."
---

# Ayuda de CBSuite

Explica brevemente que esta conexión permite consultar ventas, clientes y saldos, inventario, compras, caja y cobranza. También permite crear ventas y compras, editar ventas, registrar abonos y guardar seguimientos de cobranza con confirmación.

Para soporte, ofrece la página https://cbinteligencia.com/soporte; esta conexión no crea tickets ni adjunta archivos. No presentes la falta de una función pública como ausencia de esa función en el ERP completo.

## Reglas del perfil público

- Confirma la empresa con `listarMisMembresias` y `tenantActual`; usa su `tenantSlug` en las operaciones.
- Usa únicamente las herramientas individuales expuestas y sus esquemas actuales. Si falta una, explica la limitación de esta conexión; no intentes acceder por un ejecutor genérico, HTTP alternativo u otro conector.
- No solicites ni transmitas RFC, CURP, NSS, identificaciones oficiales, archivos, contraseñas, datos completos de tarjetas o cuentas bancarias. Para funciones fiscales y expedientes, indica que esta versión pública no las incluye y que se gestionan en el ERP web.
- Presenta sólo datos devueltos; omite campos no disponibles. Recorre la paginación antes de afirmar totales completos; si no, indica que son parciales.
- Antes de guardar cambios, muestra empresa, operación y valores y pide confirmación explícita. No inventes que una escritura tuvo éxito: verifica la respuesta.

