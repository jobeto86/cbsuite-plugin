---
name: redactar-manual-y-puesto
description: "Redactar, actualizar o estructurar manuales de puesto (el qué) y manuales de procesos o políticas de la empresa en la wiki de CBSuite (el cómo), siguiendo el estándar de CBSuite (acción de escritura). Triggers: 'redacta el manual del puesto de...', 'ayúdame a documentar el proceso de...', 'escribe la política de...', 'actualiza el puesto de...', 'crea un artículo en la wiki', 'limpia este manual de puesto'."
---

# Skill: Redactar manuales y puestos

> Llama cada herramienta directo por su nombre. Si no aparece en tu lista, búscala con `buscarHerramientas`: al encontrarla ya puedes llamarla directo. Usa `ejecutarHerramienta` sólo si la llamada directa no está disponible. Nunca digas que una herramienta no existe sin buscarla.

Una orden explícita y completa se ejecuta; pregunta sólo lo que falte. Antes de escribir o reemplazar un puesto o artículo existente en CBSuite, muestra el borrador al administrador si hay supuestos o datos por confirmar.

---

## Frontera: qué va dónde

| Qué documentas | Dónde vive | Regla |
|---|---|---|
| **Puesto (el qué)** | RRHH › Puestos (`crearPuesto` / `editarPuesto`), visible en **Mi perfil** | Define misión, responsabilidades, límites de decisión, coordinación e indicadores. Enlaza procesos; no los copia. |
| **Manuales de la empresa (el cómo propio)** | Ayuda › Manuales de la empresa (`crearArticuloWiki` / `editarArticuloWiki`) | Procedimientos, políticas y referencias propias de la empresa. Enlaza el Manual de CBSuite en vez de copiar pantallas del ERP. |
| **Manual de CBSuite (el cómo del ERP)** | Fijo en Ayuda | No se reescribe en los manuales de la empresa; sólo se referencia. |

---

## 1. Plantilla de manual de puesto (sólo el qué)

Consulta primero `buscarPuestos` para evitar duplicados o ver el contenido actual.

- **Misión**: va en el campo `descripcion` del puesto, en una o dos frases.
- **Contenido del manual (`contenidoManual`)**, en este orden:
  1. **Responsabilidades**: lista corta, una por renglón, empezando con verbo.
  2. **Decisiones**: tabla con columnas `Decisión | ¿La tomas tú? | Si no, ¿quién?`.
  3. **Reporta a y se coordina con**: siempre por puesto (nunca por nombre de persona) y para qué.
  4. **Cómo se mide**: de 3 a 5 indicadores observables.
  5. **Procesos en los que participa**: enlaces a artículos de Manuales de la empresa con formato `/documentacion/wikia?open={referencia}` (consulta `listarArticulosWiki` para obtener las referencias reales).

**Lo que NO entra en el puesto:**
- Pasos de pantalla del ERP ni procedimientos paso a paso (van en Ayuda y aquí sólo se enlazan).
- Nombres propios de personas ni responsabilidades individuales de un empleado concreto.
- Cabeceras técnicas YAML (`---`).
- Repetir el título del puesto o su misión (la pantalla ya los muestra).

---

## 2. Manuales de la empresa (wiki en Markdown)

Antes de redactar, consulta `listarArticulosWiki` y `buscarProcesoWiki` para no duplicar contenido ni inventar referencias.

- **Un artículo, un tipo**:
  - **Procedimiento**: ficha breve (para qué, responsable por puesto, cuándo aplica, prerrequisitos), pasos numerados (una acción por paso con qué se debe ver y qué hacer si algo falla) y cierre «Terminado cuando».
  - **Política o criterio**: ficha breve, la regla clara, excepciones con quién las autoriza y qué hacer ante incumplimiento.
  - **Referencia**: ficha breve y tabla o lista directa de consulta rápida.
- **Reglas obligatorias**:
  - Responsables siempre **por puesto**, nunca por nombre propio.
  - **Nada confidencial**: no incluyas sueldos, márgenes, costos internos, contraseñas ni datos personales de clientes o empleados (la wiki puede consultarla cualquier empleado vía Biank).
  - **Nada inventado**: si un monto, plazo o responsable no lo confirmó la empresa, márcalo explícitamente como `pendiente de validar` y pregúntalo antes de publicarlo como definitivo.
  - Si el artículo lleva imágenes o respaldos propios, súbelos con `subirDocumento`.

---

## 3. Verificación al publicar

1. Si actualizas un puesto o artículo existente, guarda/muestra qué cambia y aplica con `editarPuesto` o `editarArticuloWiki` (o `crearPuesto` / `crearArticuloWiki` si es nuevo).
2. Para manuales de la empresa, valida con `buscarProcesoWiki` usando una pregunta real del equipo que el artículo aparece y responde correctamente.
