# Arquitectura de Computadores — ICCD332

Profesor: M.Sc. Lenin G. Falconí  
Facultad de Ingeniería de Sistemas — Escuela Politécnica Nacional

Este repositorio contiene el material de la asignatura **Arquitectura de Computadores (ICCD332)**. Los
archivos están escritos en **Org-mode** (Emacs) y exportados a PDF. También se incluyen cuadernos de
Jupyter para laboratorios prácticos.

---

## Estructura del curso

Todo el material está dentro de [`iccd332ArqComp-2024-B/`](iccd332ArqComp-2024-B/).

### Diapositivas de clase

Cada tema tiene su archivo `.org` (fuente editable en Emacs) y su `.pdf` (versión lista para leer):

| # | Tema | Archivos |
|---|------|----------|
| S1 | Sistemas de Numeración | `S1-SistemasNumeracion.org`, `.pdf` |
| S2 | Aritmética Digital | `S2-AritmeticaDigital.org`, `.pdf` |
| S3 | Instrucciones del Computador | `S3-InstruccionesComputador.org`, `.pdf` |
| S4 | Circuitos Digitales | `S4-CircuitosDigitales.org`, `.pdf` |
| S5 | Computador Digital y Rendimiento | `S5-ComputadorDigitalRendimiento.org`, `.pdf` |
| S6 | Máquina de Von Neumann | `S6-MaquinaVonNeuman.org`, `.pdf` |
| S8 | Buses del Sistema | `S8-Buses-del-Sistema.org`, `.pdf` |
| S8–S9 | Buses y Memoria (integrado) | `S8-S9-Buses-y-Memoria.org`, `.pdf` |
| S9 | Memoria del Sistema | `S9-Memoria-del-Sistema.org`, `.pdf` |
| S10 | Memoria Externa del Sistema | `S10-Memoria-Externa-del-Sistema.org`, `.pdf` |
| S11 | Sistema de Entrada/Salida | `S11-SistemaES.org` |
| S12 | Soporte del Sistema Operativo | `S12-Soporte-SO.org` |
| S13 | Arquitectura ARM | `S13-ARM.org`, `.pdf` |
| S17 | Sistemas Operativos | `S17-SistemasOperativos.org`, `.pdf` |

Adicionalmente hay versiones en HTML de algunas clases (archivos `AulaVirtual-S*.html`) y una
presentación de bienvenida (`Welcome.org`, `.pdf`).

### Notebooks Jupyter (`Notebooks/`)

| Notebook | Contenido |
|----------|-----------|
| `LabS1-IntroPython.ipynb` | Introducción a Python para el curso |
| `CityTemperatureAnalysis.ipynb` | Análisis de datos de temperatura |
| `FashionMnistNN.ipynb` | Red neuronal para clasificación de imágenes (Fashion MNIST) |

### Talleres (`Talleres/`)

| Taller | Archivo |
|--------|---------|
| Configuración del entorno de trabajo | `Taller-ConfiguracionEntorno.org`, `.pdf` |
| Python + Emacs | `Taller-Python-Emacs.org`, `.pdf` |
| Hardware básico | `Taller-HardwareBasico.org`, `.pdf` |
| Instruction Set Architecture (IAS) | `TallerIAS.org`, `.pdf` |
| Comandos de Emacs | `TallerComandosEmacs.org` |
| Comandos de Linux | `TallerComandosLinux.org` |
| Disco Duro | `TallerDiscoDuro.org` |
| Scripts en Python | `TallerScriptPython.org`, `.pdf` |
| Ubuntu (boot) | `TallerUbuntuBoot.org`, `.pdf` |
| Representación de enteros con signo | `Taller-Representacion-Enteros-Signo.ipynb` |
| Coding en Jupyter | `Taller-CodingJupyter.ipynb` |

### Tareas (`Tareas/`)

| Tarea | Archivo |
|-------|---------|
| Escribir en Emacs | `TareaS0-EscribirEnEmacs.org` |
| Sistemas de Numeración | `TareaS1-SistemasNumeracion.org` |
| Configuración del entorno | `TareaS1-ConfiguracionEntorno-20240515.ipynb` |
| IEEE 754 | `TareaS2-RepresentacionIEEE754.ipynb` |
| Álgebra de Boole | `TareaS3-AlgebraBoole.org`, `.pdf` |
| Álgebra de Boole + Circuitos | `TareaS3S4-AlgebraCircuitosBool.org`, `.pdf` |
| Circuitos Digitales | `TareaS4-CircuitosDigitales.org`, `.pdf` |
| Ejercicios — Aritmética Digital | `Tarea-Ejercicios-Capitulo9-AritmeticaDigital.org`, `.pdf` |

### Tutoriales (`Tutoriales/`)

| Tutorial | Carpeta / Archivo |
|----------|-------------------|
| Assembler (ejemplos `.s`) | `Assembler/` |
| Presentaciones Beamer con Emacs | `Beamer-Emacs/tutorialBeamer.org`, `.pdf` |
| Configuración Java, Python y Emacs | `ConfiguracionJavaPythonEmacs/` |
| Crear sitio web con Org-mode | `Org-Website/Org-Website.org`, `.pdf` |
| Intro a Pandas y Numpy | `IntroPandasNumpy.ipynb` |

### Simulaciones (`Simulaciones/`)

Archivos Simulink (`.slx`) para circuitos digitales:

| Simulación | Archivo |
|------------|---------|
| Compuerta NOT | `Not_Gate_Simulation.slx` |
| XOR con NAND | `XorGateNand.slx` |
| XOR con NAND (variante) | `XorNand.slx` |
| Latch | `LatchM1.slx` |

### Proyectos (`Proyectos/`)

| Documento | Archivo |
|-----------|---------|
| Especificación del proyecto final | `proyecto-final.org` |
| Preguntas frecuentes | `QA-proyecto.org`, `.html` |
| Ejemplo: CityWeather | `CityWeather/` |

### Hacks (`Hacks/`)

Tips, trucos y notas útiles para el curso: `Hacks.org`.

### Formato de Tareas (`FormatoTareas/`)

Plantillas para que el alumno prepare sus entregas:

| Plantilla | Archivo |
|-----------|---------|
| Tareas | `TemplateTareas.org`, `.pdf` |
| Presentaciones | `TemplatePresentacion.org`, `.pdf` |
| Notas de clase | `TemplateNotasClase.org` |

### Configuración de Emacs (`configEmacs/`)

El archivo `init.el` contiene la configuración de Emacs usada durante el curso. Está versionado
con **git tags** para poder volver a cualquier versión anterior (ver sección siguiente).

---

## Cambiar entre versiones de `init.el`

El archivo `configEmacs/init.el` tiene cinco versiones identificadas con tags:

| Tag | Rol | Descripción |
|-----|-----|-------------|
| `v0.1.0` | — | Primera versión funcional (Oct 2024) |
| `v0.2.0` | — | Expansión significativa (Jun 2025) |
| `v0.3.0` | — | Configuración ampliada (Jun 2025) |
| `v1.0.0` | **Estable** | Versión probada: deeper-blue, elpy básico, ein (Nov 2025) |
| `v1.1.0` | **Última** | Doom themes, emacs-jupyter, org-present, ox-reveal, latexmk (Jun 2025) |

Si querés seguridad usá `v1.0.0`. Si querés las mejoras más recientes, usá `v1.1.0`.

**Ver el historial completo:**
```bash
git log --oneline --decorate -- iccd332ArqComp-2024-B/configEmacs/init.el
```

**Ver el contenido de una versión sin modificar nada:**
```bash
git show v1.1.0:iccd332ArqComp-2024-B/configEmacs/init.el
```

**Usar la versión más reciente** (reemplaza tu `init.el` actual):
```bash
git checkout v1.1.0 -- iccd332ArqComp-2024-B/configEmacs/init.el
```

**Volver a la versión estable:**
```bash
git checkout v1.0.0 -- iccd332ArqComp-2024-B/configEmacs/init.el
```

**Comparar dos versiones:**
```bash
git diff v1.0.0 v1.1.0 -- iccd332ArqComp-2024-B/configEmacs/init.el
```

---

## Formato de archivos

| Extensión | Descripción |
|-----------|-------------|
| `.org` | Fuente en Org-mode — editable en Emacs, contiene las diapositivas y notas |
| `.pdf` | Versión exportada lista para leer |
| `.tex` | Exportación intermedia a LaTeX |
| `.ipynb` | Cuaderno de Jupyter — ejecutable con Python |
| `.slx` | Simulación de Simulink (MATLAB) |
| `.html` | Versión web de algunas clases |

---

## Flujo de trabajo sugerido

1. Clonar el repositorio:
   ```bash
   git clone <url-del-repo>
   ```
2. Copiar el `init.el` a tu configuración de Emacs:
   ```bash
   cp iccd332ArqComp-2024-B/configEmacs/init.el ~/.emacs.d/init.el
   ```
3. Abrir cualquier `.org` en Emacs y exportar con `C-c C-e l p` (LaTeX → PDF).
4. Para los notebooks, usar Jupyter Lab o VS Code.
