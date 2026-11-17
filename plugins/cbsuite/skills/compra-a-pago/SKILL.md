---
name: compra-a-pago
description: "Registrar una compra a proveedor de punta a punta: proveedor, renglones con impuestos, recepción, anticipos, pagos, bonificaciones y estado de cuenta (acción de escritura). Triggers: 'captura la compra de Fulano', 'págale la factura al proveedor', 'aplica el anticipo a la compra', 'dale un anticipo de $X a [proveedor]'."
---

# Skill: Compra a pago

> Llama cada herramienta directo por su nombre. Si no aparece en tu lista, búscala con `buscarHerramientas`: al encontrarla ya puedes llamarla directo. Usa `ejecutarHerramienta` sólo si la llamada directa no está disponible. Nunca digas que una herramienta no existe sin buscarla.

Las reglas de cada herramienta están en su descripción; esta skill sólo da el orden.

## Flujo

1. **Proveedor**: `buscarProveedores`; sólo si no existe, `crearProveedor` (el ERP no rechaza duplicados).
2. **Compra**, en una sola llamada: `crearCompra` con `proveedorId` y `lineasJson`. Nace como remisión.
   - Mercancía y gasto van en el mismo folio: renglón con `productoId` entra al kárdex; renglón libre (`descripcion`) es servicio o gasto. No hagas dos compras para separarlos.
   - Si paga al capturar: `abonoInicialMonto`, `abonoInicialFormaPago` y `abonoInicialCajaId`.
   - Con el XML del proveedor: `crearCompraDesdeXml`, o `vincularCfdiCompra` sobre una compra ya capturada.
3. **Impuestos**: un solo impuesto va en el renglón; IVA + IEPS con `configurarImpuestosLineaCompra`. Revisa con `verImpuestosCompra`.
4. **Recepción**: entra al crear, salvo `recepcionDiferida=true`; entonces `registrarRecepcionCompra` por renglón con el pendiente de `verCompra`.
5. **Pago posterior**: `registrarAbonoCompra` con `cajaId` de `listarCajasCaptura`.
6. **Anticipo** (dinero que sale sin compra destino): `crearAnticipoCompra`; luego `listarAnticiposCompra` → `aplicarAnticipoCompra` (simula sin `confirmed=true`). Desaplicar: `desaplicarAnticipoCompra` con el `aplicacionId` de `verAnticipoCompra`.
7. **Releer**: `verCompra`; reporta folio, saldo y pagos. `estadoCuentaProveedor` sólo si piden la cuenta.

## Correcciones y ajustes

- Renglones: `agregarLineaCompra`, `editarLineaCompra`, `eliminarLineaCompra`. Cabecera: `editarCompra`.
- Factura recibida después: `vincularCfdiCompra`; varios XML: `sugerirCompraParaXml` por cada uno y confirma antes de vincular. Estado SAT: `estadoFiscalCompra`.
- Proveedor extranjero: comprobante con `subirDocumento` + `vincularComprobanteExtranjero`; importación con `registrarPedimento`.
- Descuento del proveedor sin devolver mercancía: `registrarBonificacionCompra`.
- Devolución física: `crearDevolucionCompra` y su saldo con `compensarDevolucionCompra`.
- `COMPENSACION` no es forma de pago: usa bonificación, compensación de devolución o anticipo, según el caso.
