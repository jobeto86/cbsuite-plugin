---
name: cargar-catalogo
description: "Cargar a CBSuite el catálogo inicial de productos, existencias y clientes desde lo que tenga la persona (Excel tal cual, lista de precios, PDF, foto o XML de compras): interpreta, cruza duplicados, muestra el plan y da de alta con la ficha completa (acción de escritura). Triggers: 'carga mi catálogo', 'sube estos productos', 'importa mi lista de precios', 'dalos de alta', 'pásale mis clientes a CBSuite', 'inventario inicial'."
---

# Skill: Cargar catálogo

> Si una herramienta que nombra esta skill no aparece en tu lista, búscala con `buscarHerramientas` y ejecútala con `ejecutarHerramienta`; nunca digas que no existe sin buscarla.

**Trigger**: "carga mi catálogo", "sube estos productos", "importa mi lista de precios",
"da de alta mis clientes", "mete mi inventario inicial"

---

## Qué hace

Convierte lo que la persona ya tiene en productos, una sola entrada de almacén «Inventario inicial» y clientes.
Tú interpretas el archivo; CBSuite valida cada alta. Es una carga de una sola vez: no hay herramienta masiva y no la necesitas.

Si la persona no usa un agente, el camino equivalente, más simple, es el botón «Importar CSV» de Productos y de Clientes, con su plantilla.

## Reglas que no se negocian

- **Nunca inventes un dato fiscal, un precio ni una existencia.** Lo que no venga en la fuente se pregunta o se deja como pendiente visible.
- **CBSuite no rechaza duplicados** en `crearProducto` ni en `crearCliente`: el cruce del paso 3 es lo único que los evita.
- **Ante un error o timeout en un alta, comprueba con `buscarProductos` o `buscarClientes` si se creó antes de reintentar.**
- **Números como números** (`35.5`, no `"35.5"`), salvo `articulosJson`, que es un texto con JSON.

## Flujo

### 1. Confirmar empresa y leer la fuente

- Si la cuenta tiene varias empresas, confirma en cuál se carga (`tenantActual`, `listarMisMembresias`).
- Lee el archivo completo y mapea sus columnas a: nombre, tipo, precio, impuestos, clave SAT, unidad SAT, categoría, a granel, existencia, stock mínimo, contenido.
- Si hay XML de compras, úsalos para tomar descripción, clave SAT, unidad e impuestos, que ahí vienen correctos.

### 2. Normalizar cada renglón

| Campo | Regla |
|---|---|
| `tipo` | `MERCANCIA` o `SERVICIO`. Un servicio no lleva existencia. |
| `precio` | Precio de venta **con impuestos incluidos**. Si la lista dice «más IVA», calcula el precio final, redondea a 2 decimales y dilo en el plan. Un costo de compra no es un precio: si no sabes cuál columna es, pregunta. |
| Impuestos | Un solo impuesto: `tipoImpuesto` (`IVA`, `IEPS`, `EXENTO`) y `tasaImpuesto`. Sin datos, el alta asume IVA 16: nunca lo dejes pasar sin decirlo, porque varios alimentos y agroquímicos van a tasa 0. |
| IVA + IEPS | Usa `impuestos`, sin mezclarlo con `tipoImpuesto` ni `tasaImpuesto`: `[{"tipo":"IEPS","factor":"TASA","tasa":8,"base":"COMERCIAL","retencion":false},{"tipo":"IVA","factor":"TASA","tasa":16,"base":"COMERCIAL_MAS_IEPS","retencion":false}]` |
| A granel | `esDivisible: true` si se vende fraccionado. Sólo esos aceptan cantidades con decimales. |
| Claves SAT | `claveSatCodigo` y `claveUnidadSatCodigo` son obligatorias y deben existir en el catálogo de la empresa. |

**Claves SAT.** Consulta `listarClavesProductoSat` y `listarClavesUnidadSat`. Una clave real que falte se agrega con `crearClaveProductoSat` o `crearClaveUnidadSat` (`clave`, `descripcion`). Si no conoces la clave real de un producto, no la adivines: usa la clave comodín de la empresa (`SINCLAVE`, `SUNIT` si existen) y lístalo como pendiente, porque habrá que corregirlo antes de facturarlo.

### 3. Cruzar duplicados

- **Dentro del archivo**: mismo nombre sin distinguir mayúsculas, acentos ni espacios repetidos.
- **Productos contra CBSuite**: `buscarProductos` con `busqueda` = nombre e `incluirInactivos: true`. Devuelve coincidencias parciales: compara el nombre completo normalizado.
- **Clientes contra CBSuite**: `buscarClientes` por nombre y, si viene, por razón social. Busca por nombre o contacto: no encuentra por RFC ni lo devuelve, así que un cliente ya registrado con el mismo RFC y otro nombre no se detecta. Si la fuente trae RFC, dilo en el plan.
- Un duplicado no se da de alta ni se actualiza. Se reporta.

### 4. Mostrar el plan

```
Plan de carga — [empresa]

Productos nuevos:   [N] ([M] con existencia)
Clientes nuevos:    [N]
Ya existen (omitir): [N]
No se pueden cargar: [N] — [motivo]

Lo que supuse o calculé:
- [renglones y qué se asumió: IVA, precio con IVA, granel, clave comodín]

[tabla: nombre · tipo · precio · impuestos · clave · unidad · existencia]
```

Con catálogos largos muestra los primeros 15 y todas las excepciones.

Si la persona ya pidió cargar y el plan no tiene dudas ni suposiciones, ejecuta. Si interpretaste o supusiste algo, espera su sí a ese plan: una sola vez para toda la carga, no por renglón.

### 5. Dar de alta

- `crearProducto` uno por uno, en el orden del plan, con la ficha completa. Guarda el `id` que devuelve cada alta.
- Si un renglón falla, anota el motivo y sigue con el siguiente.
- `categoriaNombre`: pásalo sólo si la categoría ya existe. Si no existe, el alta se rechaza; y como busca por coincidencia parcial, un nombre corto puede caer en otra. Sin categoría, el producto va a la primera de la empresa.
- En cargas largas, informa el avance cada 50 renglones.
- `crearCliente`: `nombre` obligatorio. Con `rfc` también son obligatorios `nombreFiscal`, `regimenFiscalReceptor`, `usoCfdiDefault` y `codigoPostalFiscal`; si faltan, da de alta al cliente sin datos fiscales y lístalo como pendiente.

### 6. Registrar la existencia inicial

Una sola entrada de almacén para todo:

- Tool: `crearEntradaInventario` con `tipo: "ENTRADA_GENERICA"`, `observaciones: "Inventario inicial (carga con agente)"` y `articulosJson: "[{\"productoId\":279,\"cantidad\":12}]"`.
- Sólo renglones `MERCANCIA` con cantidad mayor a cero, dados de alta en el paso 5. Nunca servicios, aunque la herramienta los acepte.
- Revisa antes de enviarla: **una sola cantidad inválida rechaza la entrada completa** (decimales en un producto que no es a granel).
- Si falla, corrige y reintenta **sólo la entrada**; los productos ya existen. Si fue timeout, revisa `listarEntradasInventario` antes de crear otra.

### 7. Reportar

```
✅ Carga terminada — [empresa]

Productos creados:  [N] de [total]
Inventario inicial: [folio EA] · [N] productos
Clientes creados:   [N] de [total]
Omitidos por duplicado: [lista]
Rechazados: [renglón — motivo]

Pendientes:
- Clave SAT por corregir antes de facturar: [lista]
- Clientes sin datos fiscales: [lista]
- Categorías y marcas por asignar: [lista]
```

## Lo que esta carga no hace

| Dato | Qué decir |
|------|-----------|
| Costo de compra | "Esta carga no captura costos." No prometas cargarlos. |
| Categorías y marcas nuevas | "Por agente no las puedo crear. Créalas en Inventario y las asigno, o usa la plantilla CSV, que sí las crea." |
| Actualizar productos que ya existen | "Esta carga sólo da de alta. Dime cuáles quieres cambiar y los editamos aparte." |

## Errores comunes

| Error | Qué decir |
|-------|-----------|
| Clave SAT no encontrada | Agrégala (paso 2) si es real; si no, usa la comodín y márcala pendiente. |
| Categoría no encontrada | Quita la categoría de ese renglón y lístala como pendiente. |
| Producto no fraccionable | "[Producto] no se vende a granel y traía [cantidad]. ¿Cuál es la cantidad entera, o lo marcamos a granel?" |
| Sin permiso | "Tu usuario no tiene permiso para [crear productos / registrar entradas / crear clientes]. Pídelo a tu administrador." |
