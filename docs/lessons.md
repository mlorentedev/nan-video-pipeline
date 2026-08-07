---
id: "nan-video-pipeline-lessons"
type: lesson
status: active
tags: [nan-video-pipeline, lessons]
created: "2026-06-09"
owner: manu
---

# nan-video-pipeline: Lessons Learned

> Post-mortems, gotchas, and patterns discovered during development.

## Lessons

### [2026-06-09] Un modelo de visión que "describe" una URL de imagen puede estar alucinando desde el nombre del fichero
**Context:** Tarea C del pipeline NaN: seleccionar la mejor imagen por escena pasándole candidatas a un modelo de visión (mimo-v2.5) vía markdown inline `![image](url)`. El tester anterior dio por bueno que "mimo ve la imagen" porque la descripción coincidía.
**Problem:** mimo-v2.5 en el cluster NaN devolvía descripciones plausibles para URLs públicas, pero en realidad NO descargaba la imagen: la inventaba leyendo el nombre del fichero (p.ej. `Vesuvius_1826.jpg` → "pintura del Vesubio"). El falso positivo se sostenía porque los nombres de Wikimedia son auto-descriptivos. Además el texto salía en `reasoning_content`, dejando `content` vacío con max_tokens bajos.
**Solution:** Test decisivo de URL MENTIROSA: pasar una URL inexistente cuyo nombre de fichero miente sobre el contenido (`.../a-photo-of-a-red-apple.jpg`) y pedir descripción. Si el modelo "describe la manzana", está leyendo el nombre, no los píxeles. Confirmado: mimo no fetchea URLs. Vía real: embeber los bytes como base64 data URI en formato array OpenAI; y usar modelos que sí ven (gemma4, qwen3.6), no mimo. Verificar visión con imagen sin pista en el nombre (base64, no URL).
**Tags:** `#vision` `#llm` `#nan-cluster` `#testing` `#hallucination` `#verification`
