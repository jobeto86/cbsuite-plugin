---
name: ajuste-inventario
description: "Diagnosticar y corregir una existencia que no cuadra con lo físico, dar de baja merma y registrar el conteo (acción de escritura). Triggers: 'el sistema dice 12 y en bodega hay 9', 'no me deja vender y sí hay producto', 'se rompieron 3 cajas, dalas de baja', '¿qué conviene contar hoy?'."
---

# Skill: Ajuste de inventario

> Llama cada herramienta directo por su nombre. Si no aparece en tu lista, búscala con `buscarHerramientas`: al encontrarla ya puedes llamarla directo. Usa `ejecutarHerramienta` sólo si la llamada directa no está disponible. Nunca digas que una herramienta no existe sin buscarla.

Las reglas de cada herramienta están en su descripción; esta skill sólo da el orden. Una orden explícita y completa se ejecuta; si la causa no está clara, decide con la evidencia del diagnóstico y repórtala al cerrar.

## Flujo

1. **Producto**: `buscarProductos`; quédate con su ID interno.
2. **Foto**: `verProducto` (existencia, comprometido, disponible).
3. **Clasifica la queja**:
   - «No me deja vender y sí hay»: casi siempre es comprometido por apartados (`listarApartadosSinRespaldoStock`, `listarApartados`). No es un ajuste: no crees entradas para liberar stock.
   - «El sistema dice X y hay Y»: sigue al paso 4.
   - Servicios no tienen existencia: no se diagnostican.
4. **Diagnostica** y detente al tener la causa: `cuadreProducto` → `historialInventario` (con fechas y `tipo`; pagina). `diagnosticarInventario` sólo para ver los últimos movimientos con su stock.
5. **Corrige según la causa**:
   - Error de captura: corrige el documento origen con su herramienta (compra, venta, consigna, o `editarArticuloEntradaInventario` / `editarArticuloSalidaInventario`). Si es anterior a la última verificación, el kárdex está sellado: compensa con un documento de hoy.
   - Merma con causa (rotura, caducidad, robo) o consumo interno: `crearSalidaInventario` con `MERMA` o `CONSUMO` y el motivo en `observaciones`.
   - Sobrante con origen conocido que no es compra: `crearEntradaInventario` `ENTRADA_GENERICA` con motivo.
   - Diferencia sin causa: ni entrada ni salida; va directo al conteo.
6. **Cuenta al final**: `registrarVerificacionInventario` con lo contado, antes de más ventas o entregas del producto.
7. **Releer**: `verProducto` y `cuadreProducto`; reporta existencia final, tipo de ajuste y folio del documento.

## Conteo cíclico

Si piden qué contar: `obtenerRecomendacionesConteo` y cuenta primero los de score más alto.

Liberar o cancelar un apartado mueve dinero del cliente, no inventario: sólo si el usuario lo decide.
