---
name: consultar-clientes
description: "Buscar clientes y consultar su estado de cuenta, ventas pendientes y resumen comercial."
---

# Consultar clientes

Busca por nombre comercial con `buscarClientes`. Si hay varias coincidencias, pide seleccionar una antes de consultar su cuenta. Usa `estadoCuentaCliente`, `ventasPendientesCliente` y `resumenEstrategicoCliente` según la petición.

Muestra únicamente saldos y datos comerciales devueltos. No prometas evaluación de crédito ni creación o modificación de clientes: no están incluidas en este perfil.

## Reglas del perfil público

- Confirma la empresa con `listarMisMembresias` y `tenantActual`; usa su `tenantSlug` en las operaciones.
- Usa únicamente las herramientas individuales expuestas y sus esquemas actuales. Si falta una, explica la limitación de esta conexión; no intentes acceder por un ejecutor genérico, HTTP alternativo u otro conector.
- No solicites ni transmitas RFC, CURP, NSS, identificaciones oficiales, archivos, contraseñas, datos completos de tarjetas o cuentas bancarias. Para funciones fiscales y expedientes, indica que esta versión pública no las incluye y que se gestionan en el ERP web.
- Presenta sólo datos devueltos; omite campos no disponibles. Recorre la paginación antes de afirmar totales completos; si no, indica que son parciales.
- Antes de guardar cambios, muestra empresa, operación y valores y pide confirmación explícita. No inventes que una escritura tuvo éxito: verifica la respuesta.

