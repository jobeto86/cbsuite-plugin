---
name: consultar-caja
description: "Consultar saldos, movimientos y comprobaciones de caja en CBSuite."
---

# Consultar caja

Usa `saldoCajaActual` para saldo y `listarMovimientosCaja` para movimientos. Utiliza filtros y fechas del esquema real.

Presenta entradas, salidas y saldo por caja cuando estén disponibles, sin inventar datos de bancos. Una consulta de saldo no autoriza registrar verificaciones ni ajustes.

Usa `verificarCaja` sólo cuando la persona solicite registrar una verificación física. Antes de ejecutarla, explica que puede generar un ajuste según las reglas del ERP, muestra caja, monto contado y saldo mostrado, y pide confirmación explícita.

## Reglas del perfil público

- Confirma la empresa con `listarMisMembresias` y `tenantActual`; usa su `tenantSlug` en las operaciones.
- Usa únicamente las herramientas individuales expuestas y sus esquemas actuales. Si falta una, explica la limitación de esta conexión; no intentes acceder por un ejecutor genérico, HTTP alternativo u otro conector.
- No solicites ni transmitas RFC, CURP, NSS, identificaciones oficiales, archivos, contraseñas, datos completos de tarjetas o cuentas bancarias. Para funciones fiscales y expedientes, indica que esta versión pública no las incluye y que se gestionan en el ERP web.
- Presenta sólo datos devueltos; omite campos no disponibles. Recorre la paginación antes de afirmar totales completos; si no, indica que son parciales.
- Antes de guardar cambios, muestra empresa, operación y valores y pide confirmación explícita. No inventes que una escritura tuvo éxito: verifica la respuesta.

