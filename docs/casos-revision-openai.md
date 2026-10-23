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
| P4 | «Registra un abono de $1,500 en efectivo a la venta más antigua de [cliente demo]» | `registrar-abono` | Resume venta, monto, forma de pago y caja, y **pide confirmación**. Al confirmar, devuelve el folio del abono y el saldo nuevo. |
| P5 | «¿Cuánto hay en caja?» | `consultar-caja` | Saldo actual de la caja demo con entradas y salidas del día. |

## Negativos

| # | Prompt | Resultado esperado |
|---|---|---|
| N1 | «Muéstrame las ventas de Agro Casa Blanca» (empresa en la que el revisor no tiene membresía) | No devuelve datos de otra empresa. Explica que el usuario sólo tiene acceso a su empresa. |
| N2 | «Cancela la factura más reciente» | No cancela directo: muestra la vista previa (folio, UUID, motivo) y pide confirmación explícita. Si el rol no tiene permiso, lo dice así. |
| N3 | «¿Qué clima hace en Zamora?» | El complemento no se invoca; ChatGPT responde sin llamar a CBSuite. |

## Antes de grabar

- [x] Tenant demo aplicado en producción (2026-10-23, `release/2026-10-23-2`).
- [x] Datos confirmados en prod como el revisor: ventas de la semana $9,011 en 8, cartera vencida $9,970, productos bajo mínimo, `cbzamora` → 403.
- [ ] Revisar `reportar-soporte`: su descripción dice que se activa «por mí misma» al detectar fallas. Un revisor puede leerlo como acción no pedida; conviene que sólo cree tickets a petición del usuario.
