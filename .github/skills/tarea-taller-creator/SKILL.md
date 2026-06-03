---
name: tarea-taller-creator
description: "Crea y modifica archivos de tareas (individuales) y talleres (grupales) en formato Emacs Org-mode para cursos universitarios. Úsalo cuando necesites crear una nueva tarea o taller, adaptar un taller existente a versión individual, ajustar la longitud de una actividad, o traducir entre formatos."
argument-hint: "Describe el tema, el tipo (tarea/taller), el curso, y si es creación nueva o modificación de un archivo existente."
---

# Creador/Modificador de Tareas y Talleres en Org-mode

Ayuda a *crear* o *modificar* archivos `.org` para entregas académicas,
siguiendo las convenciones de nomenclatura y estructura del curso.

---

## 1. Convención de Nomenclatura

| Tipo      | Propósito                     | Longitud    | Archivo                         | Trabajo    |
|-----------|-------------------------------|-------------|---------------------------------|------------|
| **Tarea** | Ejercicio individual, corto   | 1–3 secciones | `Tarea-<Titulo>.org`          | Individual |
| **Taller**| Actividad grupal, más extensa | 3+ secciones | `Taller-<Titulo>.org`         | Grupal (2–4) |

- `<Titulo>`: PascalCase o con guiones, ej: `Tarea-SistemasNumeracion.org`
- Guardar en la carpeta del curso correspondiente (`Talleres/` o `Tareas/`)

---

## 2. Estructura del Archivo `.org`

### Encabezado Org-mode

```org
#+options: ':nil *:t -:t ::t <:t H:3 \n:nil ^:t arch:headline
#+options: author:t broken-links:nil c:nil creator:nil
#+options: d:(not "LOGBOOK") date:t e:t email:nil expand-links:t f:t
#+options: inline:t num:t p:nil pri:nil prop:nil stat:t tags:t
#+options: tasks:t tex:t timestamp:t title:t toc:t todo:t |:t
#+title: <Tipo: Tarea/Taller> de <Título Descriptivo>
#+date: <YYYY-MM-DD>
#+author: <Para Tarea: "[Nombre]" / Para Taller: "[Nombres del grupo]">
#+email: <email del profesor>
#+language: Español
#+select_tags: export
#+exclude_tags: noexport
#+creator: Emacs 27.1 (Org mode 9.7.5)
```

### Configuración LaTeX (para exportación a PDF)

```org
#+latex_class: article
#+latex_compiler: pdflatex
#+latex_header: \usepackage{fancyhdr}
#+latex_header: \usepackage[top=25mm, left=25mm, right=25mm]{geometry}
#+latex_header: \usepackage{longtable}
#+LATEX_HEADER: \usepackage{tabularx}
#+LATEX_HEADER: \usepackage{longtable}
```

### Membrete institucional (si aplica)

```org
#+begin_export latex
\fancyhead[C]{\includegraphics[scale=0.05]{../images/logoEPN.jpg}\\
ESCUELA POLITECNICA NACIONAL\\FACULTAD DE INGENIERIA DE SISTEMAS\\
ARQUITECTURA DE COMPUTADORES}
\thispagestyle{fancy}
#+end_export
```

---

## 3. Secciones para Tarea (individual)

```org
* Objetivos de Aprendizaje
- <objetivo 1>
- <objetivo 2>

* Instrucciones
1. <instrucción 1>
2. <instrucción 2>

* <Actividad 1>
<enunciado>

#+begin_src <lenguaje> :exports both :results verbatim
  <código o espacio>
#+end_src

#+RESULTS:

* Verificación de Entregables [0%]:
- [ ] <ítem 1>
- [ ] <ítem 2>
```

---

## 4. Secciones para Taller (grupal)

```org
* Objetivos
- <objetivo 1>
- <objetivo 2>

* Instrucciones Generales
  Este taller se realiza en *grupos*. ...

* <Parte A. Nombre>
** <Sub-actividad>
   <enunciado>
   #+begin_src <lenguaje> :exports both :results verbatim
   #+end_src

* Equipo de Trabajo
|-----------------+-------------------------+-------------|
| Nombre          | email                   | Rol         |
|-----------------+-------------------------+-------------|
| <Nombre>        | <email>                 | líder       |
| <Nombre>        | <email>                 | colaborador |
|-----------------+-------------------------+-------------|

* Rúbrica de evaluación
| Criterio                     | Puntaje máximo |
|------------------------------+----------------|
| <Criterio>                   |             30 |
| TOTAL                        |            100 |

* Verificación de Entregables [0%]:
- [ ] <ítem 1>
- [ ] Revisión de ortografía con ~ispell-buffer~
- [ ] Generación de PDF ~M-x org-latex-export-to-pdf~
- [ ] Subir al aula virtual ~.org~ y ~.pdf~

** Problemas con la Tarea/logísticos:
- Tarea $X_1$ no pudo completarse debido a
```

---

## 5. Reglas de Adaptación

Al *modificar* un archivo existente:
0. **Antes de modificar, crear una rama de Git.** Ejecutar:
   ```bash
   git checkout -b fix/<descripcion-breve-del-cambio>
   ```
   Usar prefijo `fix/` para correcciones o `update/` para adaptaciones (ej: `fix/tarea-ortografia`, `update/taller-a-individual`).
1. Leer el original primero.
2. Preguntar: ¿cambiar tipo? ¿agregar/quitar secciones? ¿ajustar integrantes?
3. Preservar estilo, configuración LaTeX y membrete.
4. Renombrar según convención si cambia el tipo.

Al *crear* desde cero:
1. Preguntar: ¿tarea o taller? ¿curso? ¿tema? ¿número de actividades? ¿fecha?
2. Usar la plantilla correspondiente (secciones 3 o 4).
3. Dejar placeholders claros.
