---
name: venta-completa
description: "Registrar una venta de punta a punta en el ERP: contado, crédito, Pago mañana o apartado, con cliente, partidas, precio por volumen y entrega (acción de escritura). Triggers: 'véndele 10 sacos a Juan a crédito', 'haz una venta de mostrador', 'apártale el equipo a María con $500', 'entrégale lo que falta del apartado'."
---

# Skill: Venta completa

> Llama cada herramienta directo por su nombre. Si no aparece en tu lista, búscala con `buscarHerramientas`: al encontrarla ya puedes llamarla directo. Usa `ejecutarHerramienta` sólo si la llamada directa no está disponible. Nunca digas que una herramienta no existe sin buscarla.

Las reglas de cada herramienta están en su descripción; esta skill sólo da el orden. Una orden explícita y completa se ejecuta; pregunta sólo lo que falte.

## Flujo

1. **Cliente**: `buscarClientes`. Mostrador anónimo = el «Público General» de esta empresa. Si es nominativo y no existe, `crearCliente`.
2. **Vendedor**: `buscarVendedores`, si la empresa lo pide.
3. **Productos**: `buscarProductos` (precio de lista y existencia).
4. **Precio por cantidad**: `calcularPrecioSegunCantidad` por cada renglón.
5. **Modalidad**, según lo que dijo el usuario:
   - **Contado**: cobros en `pagosJson`, cada uno con su `cajaId` de `listarCajasCaptura`.
   - **Crédito**: antes, `verificarCreditoCliente`; decide con `puedeComprarACredito` y, si es false, explica `motivoBloqueo`.
   - **Pago mañana**: `tipo` CREDITO con `creditoDiaSiguiente=true`, sólo para cliente nominativo sin línea de crédito.
   - **Apartado**: `crearApartado` (no `crearVenta`), con anticipo, forma y `cajaId`.
6. **Crear**: `crearVenta` y guarda `id` y `folio`.
7. **Entregas** (apartados y entrega diferida): `listarMercanciaPendienteEntrega` → `registrarEntregaVenta`. Para liquidar y entregar todo el apartado en un acto: `convertirApartadoEnVenta`.
8. **Releer**: `verVenta` con el folio; reporta total, saldo, estatus y lo entregado.

## Cambios a una venta existente

- Renglones uno por uno: `agregarArticuloVenta`, `editarArticuloVenta`, `eliminarArticuloVenta` (con el `id` del renglón que da `verVenta`).
- Cabecera: `editarVenta` (no cambia el tipo).
- De contado a crédito: sólo `convertirVentaACredito`. Es irreversible; confírmalo antes.

## Después

- Cobros a crédito o apartado: skill **cobro-y-abonos**.
- Factura: skill **facturar-y-rep**.
- `listarApartados` dice «Saldada» por el dinero, no por la entrega: lo pendiente de entregar está en `listarMercanciaPendienteEntrega`.
