---
name: facturar-y-rep
description: "Facturar una o varias ventas con CFDI 4.0 (PUE o PPD), timbrar sin duplicar y emitir el complemento de pago (REP) de cada cobro posterior (acción de escritura fiscal). Triggers: 'factúrame la venta RV15360', 'timbra la factura de estas remisiones', 'haz el REP del pago de la B-12591'."
---

# Skill: Facturar y REP

> Llama cada herramienta directo por su nombre. Si no aparece en tu lista, búscala con `buscarHerramientas`: al encontrarla ya puedes llamarla directo. Usa `ejecutarHerramienta` sólo si la llamada directa no está disponible. Nunca digas que una herramienta no existe sin buscarla.

Las reglas de cada herramienta están en su descripción; esta skill sólo da el orden. Timbrar y cancelar son actos ante el SAT: antes de `timbrarCfdi` muestra folio, receptor, RFC, método, forma y total; si cuadran con lo pedido, timbra; si no, pregunta.

## Factura

1. **Preparación**, una vez por conversación: `consultarPreparacionFacturacion`.
2. **Ventas**: `verVenta` por cada folio; toma su `id` y revisa `facturasVinculadas`.
3. **Receptor**: `buscarRazonSocial`; si no existe, `crearRazonSocial`; si está mal, `editarRazonSocial`.
4. **Método**: PUE o PPD según cuándo se cobra (lo explica `crearBorradorFactura`).
5. **Borrador**: `crearBorradorFactura` con `ventaIds`, `razonSocialId` y `esPue`. Lee el `warning`. Factura libre sin ventas: conceptos con `agregarConceptoBorradorFactura`.
6. **Forma de pago** de un PUE distinta de efectivo: corrígela antes de timbrar con `editarBorradorFactura`.
7. **Timbrar**: `timbrarCfdi`. Si falla o se pierde la respuesta: `consultarOperacionTimbrado` → `recuperarTimbrado`.
8. **Releer**: `verFactura`; reporta folio y UUID.

Sin PAC activo: timbrada por fuera, con el XML en la Documentación del borrador, va por `timbrarFacturaManualDesdeDocumentacion`.

## Complemento de pago (sólo PPD)

1. **Cobros sin REP**: `listarPagosPendientesRep`.
2. **Borrador existente**: `listarComplementosPago` (RFC del receptor, estado BORRADOR) y `verComplementoPago`; si ya hay uno para ese cobro, reúsalo.
3. **Borrador nuevo**: `crearBorradorComplementoPago` con la fecha y la forma del cobro. Un REP cubre varias facturas sólo del mismo receptor.
4. **Timbrar**: `timbrarComplementoPago`; si falla, `recuperarTimbradoComplemento`.

Un PUE nunca lleva REP: no lo uses para corregir un PUE.

## Corregir o cancelar

- **Sustituir por error en la venta**, en este orden: `desvincularVentaFactura` → corregir la venta → crear y timbrar la sustituta → `cancelarCfdi` de la original con motivo 01 y el UUID de la sustituta. No canceles primero.
- Cancelar (`cancelarCfdi`, `cancelarComplementoPago`) es irreversible: muestra la vista previa y ejecuta con `confirmed=true` sólo con la orden explícita.
- Notas de crédito por bonificación: `crearBorradorNotaCreditoBonificacion`; por devolución: `crearBorradorNotaCredito`.
