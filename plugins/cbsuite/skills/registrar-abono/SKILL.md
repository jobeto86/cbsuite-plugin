---
name: registrar-abono
description: "Registrar un abono/pago de cliente a una venta en el ERP: valida monto y ejecuta la orden explicita y completa; pregunta solo si falta un dato o es ambigua (accion de escritura). Triggers: 'registra un pago de [cliente]', 'abono de $[X]', 'le pago [cliente]'."
---

# Skill: Registrar Abono

> Si una herramienta que nombra esta skill no aparece en tu lista, búscala con `buscarHerramientas` y ejecútala con `ejecutarHerramienta`; nunca digas que no existe sin buscarla.

**Trigger**: "registra un pago de [cliente]", "abono de $[X] a la venta [folio]",
"[cliente] pagó $[X]", "registra el pago"

---

## Qué hace

Registra un abono (pago) a una venta en el ERP.
Afecta caja y saldo. Si la orden trae venta, monto, forma de pago y caja sin ambigüedad, se ejecuta; si falta algo, pregunta solo eso.

## Flujo

### 1. Recopilar datos necesarios

Necesitas obligatoriamente:
- **Cliente** o **folio de venta** — ¿a qué venta va el pago?
- **Monto** — ¿cuánto pagó?
- **Forma de pago** — efectivo / transferencia / tarjeta / cheque
- **Caja** — ¿a qué caja entra? Toma las opciones de `listarCajasCaptura` (activa, compatible con la forma de pago); si hay una sola, úsala, pero pasa siempre su `cajaId`.

Si falta alguno, preguntar antes de continuar.

### 2. Verificar la venta

- Tool: `verVenta` para confirmar saldo pendiente
- Si el monto supera el saldo: informar y preguntar si quiere abonar el saldo exacto

### 3. Preguntar solo si hace falta

Pregunta antes de ejecutar únicamente si falta un dato, hay varias ventas posibles o el monto supera el saldo. Di lo que ya tienes y pide lo que falta.

### 4. Ejecutar

- Tool: `registrarAbonoVenta` con `ventaId`, `monto`, `formaPago`, `cajaId` (obligatorio) y `referencia` si hay folio de transferencia o cheque

### 5. Confirmar resultado

```
✅ Abono registrado.

Venta:     [folio]
Abono:     $X,XXX ([forma de pago])
Saldo anterior: $X,XXX
Saldo actual:   $X,XXX
[Estado: Saldada / Pendiente $X,XXX]
```

## Errores comunes

| Error | Qué decir |
|-------|-----------|
| Monto > saldo | "El monto ($X) supera el saldo ($Y). ¿Registramos $Y para saldar la venta?" |
| Caja no disponible | "La caja [X] no está disponible. Las opciones son: [lista]. ¿Cuál usamos?" |
| Venta ya saldada | "Esta venta ya está saldada desde [fecha]. ¿Quieres buscar otra?" |
| Sin permiso | "No tengo permiso para registrar abonos. Contacta a tu administrador." |
