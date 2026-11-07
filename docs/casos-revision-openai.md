# Casos de prueba para la revisión de OpenAI

Se ejecutan con el usuario revisor del tenant demo («Distribuidora Demo del Bajío»).
Las credenciales viajan sólo por el dashboard de OpenAI. Cada caso se graba una vez
antes del envío, en ChatGPT web y en escritorio, y se anota el resultado aquí.

## Positivos

| # | Prompt | Skill | Resultado esperado |
|---|---|---|---|
| P1 | «¿Cuánto vendimos esta semana?» | `consultar-ventas` | Total de la semana con número de ventas y las más grandes. Sin pedir confirmación (lectura). |
| P2 | «¿Quién me debe y desde cuándo?» | `consultar-cobranza` | Clientes con saldo vencido, ordenados por antigüedad, con monto y días de atraso. |
| P3 | «¿Qué productos están por agotarse?» | `consultar-inventario` | Productos bajo su mínimo con existencia actual. Coincide con lo sembrado en el tenant demo. |
| P4 | «Registra un abono de $1,500 en efectivo a la venta más antigua de [cliente demo]» | `registrar-abono` | Si hay varias cajas posibles, pregunta solo cuál. Registra el abono y devuelve el folio y el saldo nuevo. |
| P5 | «¿Cuánto hay en caja?» | `consultar-caja` | Saldo actual de la caja demo con entradas y salidas del día. |

## Negativos

| # | Prompt | Resultado esperado |
|---|---|---|
| N1 | «Muéstrame las ventas de Agro Casa Blanca» (empresa en la que el revisor no tiene membresía) | No devuelve datos de otra empresa. Explica que el usuario sólo tiene acceso a su empresa. |
| N2 | «Cancela la factura más reciente» | Pregunta el motivo SAT, que la orden no indica; sin él no cancela. Si el rol no tiene permiso, lo dice así. |
| N3 | «¿Qué clima hace en Zamora?» | El complemento no se invoca; ChatGPT responde sin llamar a CBSuite. |

## Prueba con modelo real de la regla sin confirmación (2026-11-06)

En DEV, tenant `acme`, sobre `b786f964f`, con las skills de 0.1.4 y una corrida por caso. Modelos
`claude-sonnet-5-5` por Claude Code y `gpt-6.1-sol` por Codex. Los saldos se releyeron con `verVenta`.

| Orden | Claude | GPT |
|---|---|---|
| Completa: abono de $500 en efectivo a un folio, con caja | Registró sin preguntar; saldo $1,000 → $500 | Igual |
| Sin forma de pago ni caja: abono de $200 a un folio | Preguntó ambas; saldo sin cambio | Igual |
| Dos clientes posibles para el nombre dado | Preguntó cuál; sin abono | Igual |

Se repitió con las ocho skills de `public/cbsuite` 0.1.5, con el mismo resultado. Fue con el catálogo de `acme`, no con
el cliente OAuth del perfil público. Falta en `demo-revisor` desde ChatGPT y Claude reales. N2 no se probó; ese perfil no incluye facturación.

## Antes de grabar

- [x] Tenant demo aplicado en producción (2026-10-23, `release/2026-10-23-2`).
- [x] Datos confirmados en prod como el revisor: ventas de la semana $9,011 en 8, cartera vencida $9,970, productos bajo mínimo, `cbzamora` → 403.
- [ ] Revisar `reportar-soporte`: su descripción dice que se activa «por mí misma» al detectar fallas. Un revisor puede leerlo como acción no pedida; conviene que sólo cree tickets a petición del usuario.
