---
name: cobro-y-abonos
description: "Cobrar a un cliente en el ERP: ubicar ventas con saldo, registrar uno o varios abonos, corregirlos o eliminarlos, bonificar y anotar promesas de pago (acción de escritura). Triggers: 'registra un pago de [cliente]', 'abono de $[X]', 'Ferretería López pagó 15 mil por transferencia', 'el abono de ayer se capturó mal', 'el cliente promete pagar el viernes'."
---

# Skill: Cobro y abonos

> Llama cada herramienta directo por su nombre. Si no aparece en tu lista, búscala con `buscarHerramientas`: al encontrarla ya puedes llamarla directo. Usa `ejecutarHerramienta` sólo si la llamada directa no está disponible. Nunca digas que una herramienta no existe sin buscarla.

Las reglas de cada herramienta están en su descripción; esta skill sólo da el orden. Si la orden trae cliente o venta, monto, forma de pago y caja sin ambigüedad, se registra sin pedir otra confirmación; si falta algo, pregunta sólo eso.

## Registrar un cobro

1. **Cliente**: `buscarClientes` (no recorras `listarClientesCobranza` para encontrar a uno).
2. **Ventas con saldo**: `ventasPendientesCliente`. Si piden lo vencido, `resumenFinancieroCliente`.
3. **Reparto**: si el pago cubre varias ventas y el usuario no dio folios y montos, propón el reparto en un solo resumen (folio, monto, forma, caja).
4. **Caja**: `listarCajasCaptura`; pasa siempre el `cajaId`, aunque haya una sola.
5. **Abono**: `registrarAbonoVenta` por venta; guarda `abonoId` y saldo.
6. **Releer**: `verVenta` de cada venta afectada; reporta folio y saldo final.
7. **REP**: si la venta tiene `facturasVinculadas` y el cobro aparece en `listarPagosPendientesRep`, avisa que toca REP (a más tardar el día 5 del mes siguiente) y sigue la skill **facturar-y-rep**.
8. Comprobante, si lo piden: `imprimirAbonoVenta`.

Sobrepago sin otra venta pendiente: no lo fuerces ni lo registres como recibo de ingreso; informa el excedente.

Si el registro devuelve error o se pierde la respuesta, comprueba con `verVenta` si quedó antes de reintentar, con la misma `operacionClave`.

## Corregir o eliminar un abono

- El `abonoId` sale del registro, de `listarPagosPendientesRep` o de `listarMovimientosCaja` (concepto COBRO_VENTA).
- Corregir: `editarAbonoVenta`. Eliminar: `eliminarAbonoVenta` (vista previa; con la orden explícita, `confirmed=true`).
- Contado ya saldado: `corregirPagosVenta`, primero `dryRun=true`.
- Caja verificada o REP timbrado: el ERP lo rechaza; no cambies la fecha para esquivarlo, informa al usuario.

## Bonificación y seguimiento

- Descuento sobre una venta hecha: `registrarBonificacionVenta` (no toca caja). Revisar o revertir: `listarBonificacionesVenta`, `editarBonificacionVenta`, `eliminarBonificacionVenta`.
- Sin pago o con promesa: `registrarInteraccionCobranza`. Queda en el ERP; no manda mensajes ni llama al cliente.
