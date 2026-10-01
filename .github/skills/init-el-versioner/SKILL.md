---
name: init-el-versioner
description: "Versiona el archivo iccd332ArqComp-2024-B/configEmacs/init.el siguiendo la convención del repositorio EPN-Lectures: revisa los cambios, propone el número de versión (vX.Y.Z), crea el commit 'init.el: vX.Y.Z — …' y el tag anotado vX.Y.Z, y actualiza README.md para reflejar la versión más reciente. Usar cuando el usuario pida versionar, commitear, etiquetar, hacer release o subir de versión el init.el de Emacs, o actualizar la tabla de versiones del README."
argument-hint: "Describe opcionalmente los cambios del init.el (o el número de versión si ya lo conoces)."
---

# Init.el Versioner

Automatiza el versionado de la configuración de Emacs (`init.el`) del repositorio EPN-Lectures, siguiendo exactamente la convención usada para las versiones `v0.1.0` … `v1.2.0`.

## Cuándo usarla

- El usuario pide "versionar init.el", "commitear el init.el", "nueva versión del init.el", "etiquetar init.el", "release del init.el" o similar.
- Hay cambios sin commitear en `iccd332ArqComp-2024-B/configEmacs/init.el`.
- El usuario pide actualizar la tabla de versiones de `README.md`.

## Reglas fijas (convención del repo)

- **Repo root**: detectarlo siempre con `git rev-parse --show-toplevel`; no asumir la ruta.
- **Archivo versionado**: `iccd332ArqComp-2024-B/configEmacs/init.el`
- **README a actualizar**: `README.md` (raíz del repo)
- **Mensaje de commit**: `init.el: vX.Y.Z — <resumen breve de cambios>`
- **Tag**: anotado, apuntando al commit del init.el:
  `git tag -a vX.Y.Z <hash> -m "Versión con <resumen>"`
- **NUNCA hacer `git push`**. El usuario sube manualmente (decisión explícita del usuario).
- **NUNCA versionar archivos untracked**: solo `git add <ruta-del-init.el>` (y luego `README.md` en su commit separado). Prohibido `git add -A` o `git add .`.
- **Commits separados**: uno para `init.el` y otro para `README.md`. El tag apunta solo al commit de `init.el`.

## Procedimiento

### Paso 0 — Ubicar el repo

```bash
git rev-parse --show-toplevel
```

Usar ese directorio como `<repo>` en todos los comandos (`git -C <repo> ...`).

### Paso 1 — Verificar cambios en init.el

```bash
git -C <repo> status --short -- iccd332ArqComp-2024-B/configEmacs/init.el
git -C <repo> diff -- iccd332ArqComp-2024-B/configEmacs/init.el
```

- Si no hay cambios: informar "init.el no tiene cambios sin commitear" y detenerse.
- Leer el diff completo y resumir los cambios en una frase breve (servirá para el mensaje de commit y para el tag).

### Paso 2 — Determinar la versión actual y proponer la nueva

```bash
git -C <repo> tag -l 'v*' | sort -V | tail -n 1
```

- Analizar el diff y proponer el incremento:
  - **patch** (v1.2.0 → v1.2.1): correcciones, comentarios, ajustes pequeños.
  - **minor** (v1.2.0 → v1.3.0): funcionalidad nueva (paquetes, backends, modos).
  - **major** (v1.2.0 → v2.0.0): cambios incompatibles o reescritura total.
- Preguntar al usuario con `AskUserQuestion` mostrando: número propuesto, tipo de incremento y resumen de cambios. El usuario puede corregir el número o el resumen.
- Verificar que el tag no exista ya: `git -C <repo> tag -l 'vX.Y.Z'`. Si existe, pedir otro número.

### Paso 3 — Commit del init.el

```bash
git -C <repo> add iccd332ArqComp-2024-B/configEmacs/init.el
git -C <repo> diff --cached --stat   # verificar: solo init.el en staging
git -C <repo> commit -m "init.el: vX.Y.Z — <resumen>"
```

- Si `git diff --cached --stat` muestra otros archivos, deshacer con `git -C <repo> reset` y repetir el add solo del init.el.

### Paso 4 — Crear el tag anotado

```bash
git -C <repo> tag -a vX.Y.Z HEAD -m "Versión con <resumen>"
git -C <repo> show vX.Y.Z --no-patch --format='%H %s'   # verificar que apunta al commit correcto
```

### Paso 5 — Actualizar README.md

Leer `README.md` y, en la sección "Cambiar entre versiones de `init.el`":

1. **Conteo**: en la frase "El archivo `configEmacs/init.el` tiene N versiones identificadas con tags:", incrementar N según las filas reales de la tabla (si se agrega una fila, N = filas totales nuevas).
2. **Tabla de versiones**:
   - La fila que tiene `**Última**` pasa a rol `—`.
   - Agregar al final de la tabla: `| \`vX.Y.Z\` | **Última** | <descripción breve> |`
3. **Frase de recomendación**: actualizar "Si querés las mejoras más recientes, usá \`vX.Y.Z\`." con el nuevo tag.
4. **Comandos de ejemplo**: actualizar al nuevo tag solo los ejemplos que muestran la "versión más reciente":
   - `git show vX.Y.Z:iccd332ArqComp-2024-B/configEmacs/init.el`
   - `git checkout vX.Y.Z -- iccd332ArqComp-2024-B/configEmacs/init.el`
   - `git diff v1.0.0 vX.Y.Z -- iccd332ArqComp-2024-B/configEmacs/init.el` (mantener `v1.0.0` como versión estable salvo que el usuario indique lo contrario)
5. No tocar el resto del README.

### Paso 6 — Commit del README (separado)

```bash
git -C <repo> status --short -- README.md   # revisar si ya había cambios previos en README
git -C <repo> add README.md
git -C <repo> commit -m "README: registra versión vX.Y.Z de init.el"
```

- Si `README.md` ya tenía cambios no relacionados antes de empezar, avisar al usuario y preguntar antes de incluirlos en el commit.

### Paso 7 — Resumen final

Mostrar:

```bash
git -C <repo> log --oneline -3
git -C <repo> tag -l 'v*' | sort -V | tail -n 3
git -C <repo> status --short | head -n 20
```

E indicar que todo quedó **local**. Recordar al usuario que el push lo hace él manualmente:

```bash
git -C <repo> push
git -C <repo> push origin vX.Y.Z
```

## Ejemplo (sesión real v1.2.0)

1. `git tag -l 'v*' | sort -V | tail -n 1` → `v1.1.0`.
2. El diff mostraba: comentarios bilingües EN/ES, gptel con Copilot activo, rutas de usuario genéricas, temas Doom comentados.
3. Propuesta: incremento **minor** → `v1.2.0`; mensaje: "comentarios bilingües EN/ES, gptel con backend Copilot, rutas de usuario genéricas".
4. `git commit -m "init.el: v1.2.0 — comentarios bilingües EN/ES, gptel con backend Copilot, rutas de usuario genéricas"`
5. `git tag -a v1.2.0 HEAD -m "Versión con comentarios bilingües EN/ES, gptel Copilot y rutas genéricas"`
6. README: "cinco versiones" → "seis versiones"; fila `v1.2.0` con `**Última**`; ejemplos actualizados a `v1.2.0`.
7. Commit del README separado: `README: registra versión v1.2.0 de init.el`.

## Errores comunes

- `git show vX.Y.Z:...` falla con "no existe el objeto": el tag no fue creado. Verificar con `git tag -l 'v*'`.
- Tag duplicado: Git no permite recrearlo. Pedir al usuario otro número (o `git tag -d vX.Y.Z` solo si es local y el usuario lo confirma).
- `git add .` / `git add -A` metería los cientos de archivos untracked del repo: prohibido.
- Push automático: prohibido por decisión del usuario.
