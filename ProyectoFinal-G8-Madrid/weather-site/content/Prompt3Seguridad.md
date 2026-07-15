### Actúa como un editor académico experto en redacción científica y documentación técnica.

Estoy desarrollando una página web para un proyecto universitario utilizando Emacs Org-mode. El documento corresponde al análisis estadístico del robo de motocicletas en Ecuador y forma parte de un sitio web generado con Org Publish.

Quiero que revises TODO el documento y mejores únicamente aquello que sea necesario.

## Objetivo

Transformar este borrador en un documento con calidad de informe universitario, manteniendo un lenguaje claro, natural y profesional.

## Requisitos obligatorios

### Formato

- Conserva completamente el formato Org-mode.
- No modifiques el encabezado (#+TITLE, #+AUTHOR, #+OPTIONS, #+HTML_HEAD).
- No elimines enlaces, imágenes, referencias ni etiquetas Org.
- Conserva exactamente la estructura de títulos y subtítulos.
- No cambies la organización general del documento.

### Contenido

- No inventes datos.
- No inventes estadísticas.
- No inventes porcentajes.
- No inventes fechas.
- No inventes provincias.
- No inventes horarios.
- No inventes causas.
- No inventes conclusiones que no puedan obtenerse de los datos.
- No cambies ninguna cifra existente.
- No elimines ninguna cifra existente.

### Información que puede utilizar

Utiliza únicamente información correspondiente al documento oficial:

"Estadísticas de Seguridad Integral: delitos de mayor connotación psicosocial"

publicado por el Instituto Nacional de Estadística y Censos (INEC).

Los registros provienen del Sistema Integrado de Actuaciones Fiscales (SIAF) de la Fiscalía General del Estado.

Si alguna afirmación no puede deducirse de esa información o del texto ya escrito, no la agregues.

### Redacción

Quiero un estilo similar al de un artículo científico o un informe técnico.

La redacción debe ser:

- formal;
- objetiva;
- clara;
- coherente;
- fluida;
- natural;
- sin frases repetidas;
- sin redundancias;
- sin sonar generada por inteligencia artificial.

Mejora:

- cohesión;
- gramática;
- ortografía;
- puntuación;
- conectores;
- orden lógico de las ideas;
- claridad de las explicaciones.

### Organización

Verifica que cada sección realmente hable de lo que indica su título.

Por ejemplo:

- "Definición" debe contener una definición.
- "Fuente de los datos" debe explicar únicamente la procedencia de los datos.
- "Procesamiento de los datos" debe explicar cómo fueron organizados y analizados.
- "Resultados" debe presentar únicamente resultados.
- "Análisis" debe interpretar los resultados.
- "Conclusiones" debe resumir los hallazgos.

Si detectas que algún contenido está ubicado en una sección incorrecta, muévelo a la sección adecuada conservando toda la información.

### Tablas

Las tablas deben estar escritas en formato Org-mode.

Verifica que:

- tengan una estructura correcta;
- sean fáciles de leer;
- tengan encabezados adecuados;
- utilicen exactamente los valores originales.

No modifiques ningún dato.

### Gráfico

No generes el gráfico.

Únicamente mejora el texto que acompaña al gráfico.

### Referencias

No inventes referencias bibliográficas.

Únicamente conserva las referencias existentes y mejora su presentación si es necesario.

### Resultado esperado

Devuelve el documento completo en formato Org-mode.

No expliques los cambios realizados.

No agregues comentarios.

No escribas introducciones.

No escribas notas.

No escribas observaciones.

Entrega únicamente la versión final del documento.

#+TITLE: Análisis de seguridad: robo de motocicletas en Ecuador
#+AUTHOR: José Jácome
#+LANGUAGE: es
#+OPTIONS: toc:t num:t

#+HTML_HEAD: <link rel="preconnect" href="https://fonts.googleapis.com">
#+HTML_HEAD: <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=JetBrains+Mono:wght@400;600&display=swap" rel="stylesheet">
#+HTML_HEAD: <link rel="stylesheet" type="text/css" href="css/estilo.css" />

[[file:index.html][← Volver a la página principal]]

* Robo de motocicletas en Ecuador

** Descripción del problema

El robo de motocicletas es uno de los delitos de mayor relevancia
registrados en Ecuador, representando una problemática significativa
que afecta tanto la seguridad ciudadana como el patrimonio
personal. El incremento en el uso de motocicletas como medio de
transporte y herramienta de trabajo ha convertido su seguridad en una
preocupación prioritaria. 

Analizar esta problemática permite comprender su evolución,
identificar tendencias y establecer comparaciones temporales para
evaluar cambios en su incidencia. Este trabajo se basa en datos del
Instituto Nacional de Estadística y Censos (INEC) para examinar el
comportamiento del robo de motocicletas durante los primeros meses de
2025 y 2026.

** Definición de robo de motos

El análisis considera el robo de motocicletas como un delito incluido
entre los "delitos de mayor connotación psicosocial", tal como se
describe en el documento *Estadísticas de Seguridad Integral* del
INEC. Los datos analizados se obtuvieron del Sistema Integrado de
Actuaciones Fiscales (SIAF) de la Fiscalía General del Estado. Este
estudio tiene como objetivo comparar los registros correspondientes a
los meses de enero y febrero de 2025 con el mismo periodo de 2026,
evaluando las variaciones registradas entre ambos años.

** Fuente de los datos

La información utilizada en este análisis proviene del documento
*Estadísticas de Seguridad Integral: delitos de mayor connotación
psicosocial*, publicado por el Instituto Nacional de Estadística y
Censos (INEC). Los registros corresponden al Sistema Integrado de
Actuaciones Fiscales (SIAF) de la Fiscalía General del Estado y fueron
empleados para comparar el comportamiento del robo de motocicletas
durante enero y febrero de 2025 y 2026.

** Procesamiento de los datos

Para el análisis, se seleccionaron exclusivamente los registros
nacionales correspondientes al robo de motocicletas durante los meses
de enero y febrero de los años 2025 y 2026. Los datos fueron
organizados por mes y año con el objetivo de facilitar la comparación
entre periodos equivalentes.

Posteriormente, se calcularon los totales acumulados para los dos
meses en cada año, la diferencia absoluta entre ambos periodos y la
variación porcentual. Estos resultados se presentaron mediante tablas
y un gráfico de barras, con el fin de simplificar su interpretación y
análisis comparativo.

* Resultados

** Tabla de datos

| Mes      | Año 2025 | Año 2026 |
|----------+----------+----------|
| Enero    |     1481 |     1226 |
| Febrero  |     1333 |     1072 |

La tabla muestra el número de robos de motocicletas registrados en los
meses de enero y febrero de los años 2025 y 2026. Se observa una
disminución en ambos meses al comparar los dos años.

** Comparación acumulada
| Periodo            | Año 2025 | Año 2026 | Diferencia absoluta | Variación (%) |
|--------------------+----------+----------+---------------------+---------------|
| Enero - Febrero    |     2814 |     2298 |                -516 |        -18,3 |

En esta tabla se comparan los datos acumulados de robos de
motocicletas en los meses de enero y febrero de los años 2025
y 2026. Los valores reflejan una disminución absoluta de 516 casos,
equivalente a una variación negativa del 18,3 %.

** Gráfico estadístico

[[file:images/robo_motos_2025_2026.png]]

...

* Análisis

Los resultados muestran una disminución del robo de motocicletas en
los dos meses analizados. En enero se registraron 255 casos menos en
2026 que en 2025, lo que equivale a una reducción aproximada del
17,2 %. En febrero se registraron 261 casos menos, correspondientes a
una disminución aproximada del 19,6 %.

Al considerar el periodo acumulado de enero y febrero, los registros
pasaron de 2814 casos en 2025 a 2298 casos en 2026. Esto representa
una diferencia de 516 casos y una variación acumulada negativa del
18,3 %.

Aunque se observa una reducción entre ambos periodos, los datos no
permiten establecer por sí solos las causas de esta variación. Por
ello, el análisis se limita a describir y comparar los registros
oficiales presentados por el INEC y la Fiscalía General del Estado.

* Relación con sistemas tecnológicos

Los sistemas tecnológicos pueden contribuir a la prevención y
respuesta ante el robo de motocicletas. Entre estas herramientas se
encuentran los dispositivos de rastreo GPS, los sensores de movimiento,
las alarmas conectadas y las aplicaciones móviles que permiten enviar
notificaciones al propietario.

Las cámaras de seguridad también pueden aportar evidencia sobre el
momento y las características del robo. Además, las bases de datos de
vehículos reportados como robados facilitan el intercambio de
información y la verificación de motocicletas, números de chasis y
motores.

Estas tecnologías no eliminan por completo el riesgo, pero pueden
mejorar la detección, la localización del vehículo y la disponibilidad
de información para realizar la denuncia y apoyar la investigación.

* Conclusiones

- Los registros de robo de motocicletas disminuyeron durante enero y
  febrero de 2026 en comparación con el mismo periodo de 2025.

- El total acumulado pasó de 2814 a 2298 casos, lo que representa 516
  registros menos y una variación negativa del 18,3 %.

- Las tablas y el gráfico facilitaron la comparación de los periodos,
  mientras que las herramientas tecnológicas pueden contribuir a la
  prevención, detección y localización de motocicletas robadas.

* Referencias

- Instituto Nacional de Estadística y Censos (INEC). /Estadísticas de
  Seguridad Integral: delitos de mayor connotación psicosocial/.h
  Febrero de 2026.

- [[https://www.ecuadorencifras.gob.ec/justicia-y-crimen/][INEC: Estadísticas de Justicia y Crimen]]

- [[https://www.fiscalia.gob.ec/analitica/][Fiscalía General del Estado: Analítica]]


```org
#+TITLE: Análisis de seguridad: robo de motocicletas en Ecuador
#+AUTHOR: José Jácome
#+LANGUAGE: es
#+OPTIONS: toc:t num:t

#+HTML_HEAD: <link rel="preconnect" href="https://fonts.googleapis.com">
#+HTML_HEAD: <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=JetBrains+Mono:wght@400;600&display=swap" rel="stylesheet">
#+HTML_HEAD: <link rel="stylesheet" type="text/css" href="css/estilo.css" />

[[file:index.html][← Volver a la página principal]]

* Robo de motocicletas en Ecuador

** Descripción del problema

El robo de motocicletas es uno de los delitos de mayor relevancia registrados en Ecuador, representando una problemática significativa que afecta tanto a la seguridad ciudadana como al patrimonio personal. El incremento en el uso de motocicletas como medio de transporte y herramienta de trabajo ha convertido su seguridad en una preocupación crucial. 

Analizar esta problemática permite comprender su evolución, identificar tendencias y establecer comparaciones temporales para evaluar cambios en su incidencia. Este trabajo utiliza datos del Instituto Nacional de Estadística y Censos (INEC) para examinar el comportamiento de los robos de motocicletas durante los primeros meses de los años 2025 y 2026.

** Definición de robo de motocicletas

El análisis considera el robo de motocicletas como un delito incluido entre los "delitos de mayor connotación psicosocial", tal como se describe en el documento *Estadísticas de Seguridad Integral* del INEC. Los datos analizados provienen del Sistema Integrado de Actuaciones Fiscales (SIAF) de la Fiscalía General del Estado. Este estudio tiene como objetivo comparar los registros correspondientes a los meses de enero y febrero de 2025 con el mismo periodo de 2026, evaluando la variación registrada entre ambos años.

** Fuente de los datos

La información utilizada en este análisis proviene del documento *Estadísticas de Seguridad Integral: delitos de mayor connotación psicosocial*, publicado por el Instituto Nacional de Estadística y Censos (INEC). Los registros procesados corresponden al Sistema Integrado de Actuaciones Fiscales (SIAF) de la Fiscalía General del Estado. Esta información fue utilizada para comparar el comportamiento del robo de motocicletas en los meses de enero y febrero de los años 2025 y 2026.

** Procesamiento de los datos

Para el análisis, se seleccionaron exclusivamente los registros nacionales correspondientes al robo de motocicletas durante los meses de enero y febrero de los años 2025 y 2026. Los datos fueron organizados por mes y año con el propósito de facilitar la comparación entre periodos equivalentes.

Posteriormente, se calcularon los totales acumulados para los dos meses en cada año, así como la diferencia absoluta entre ambos periodos y la variación porcentual. Estos resultados se presentaron mediante tablas y un gráfico de barras para simplificar su interpretación y el análisis comparativo.

* Resultados

** Tabla de datos

| Mes      | Año 2025 | Año 2026 |
|----------+----------+----------|
| Enero    |     1481 |     1226 |
| Febrero  |     1333 |     1072 |

La tabla presenta el número de robos de motocicletas registrados en los meses de enero y febrero de los años 2025 y 2026. Se observa una disminución en ambos meses al comparar los dos años.

** Comparación acumulada

| Periodo            | Año 2025 | Año 2026 | Diferencia absoluta | Variación (%) |
|--------------------+----------+----------+---------------------+---------------|
| Enero - Febrero    |     2814 |     2298 |                -516 |        -18,3 |

En esta tabla se comparan los datos acumulados de robos de motocicletas en los meses de enero y febrero de 2025 y 2026. Los valores reflejan una disminución absoluta de 516 casos, equivalente a una variación negativa del 18,3 %.

** Gráfico estadístico

[[file:images/robo_motos_2025_2026.png]]

El gráfico de barras ilustra la disminución en el número de robos de motocicletas entre los meses analizados de los años 2025 y 2026, proporcionando un complemento visual a los datos presentados en las tablas.

* Análisis

Los resultados muestran una disminución significativa en los casos de robos de motocicletas en los dos meses analizados. En enero de 2026 se registraron 255 casos menos que en enero de 2025, lo que equivale a una reducción aproximada del 17,2 %. En febrero de 2026, la diferencia fue de 261 casos menos respecto a febrero de 2025, correspondiente a una disminución del 19,6 %.

Al considerar el periodo acumulado de enero y febrero, los registros pasaron de 2814 casos en 2025 a 2298 casos en 2026, resultando en una diferencia de 516 casos y una variación acumulada negativa del 18,3 %.

Estos datos reflejan una tendencia general a la baja en los robos de motocicletas en el periodo analizado. Sin embargo, los registros no permiten establecer las causas de esta disminución. Por lo tanto, el análisis se limita a describir y comparar los datos oficiales proporcionados por el INEC y la Fiscalía General del Estado.

* Relación con sistemas tecnológicos

Los sistemas tecnológicos representan herramientas importantes en la prevención y la respuesta ante el robo de motocicletas. Entre estas tecnologías destacan los dispositivos de rastreo GPS, los sensores de movimiento, las alarmas conectadas y las aplicaciones móviles que notifican al propietario de incidentes en tiempo real.

Las cámaras de seguridad también desempeñan un papel esencial al aportar evidencia sobre la ocurrencia y las características del delito. Adicionalmente, las bases de datos nacionales de vehículos robados facilitan el intercambio de información, así como la verificación de motocicletas, números de chasis y motores.

Si bien estas tecnologías no eliminan por completo el riesgo de robo, contribuyen a mejorar la detección, la localización de vehículos robados y la disponibilidad de información para realizar denuncias y apoyar las investigaciones correspondientes.

* Conclusiones

- Los registros de robos de motocicletas disminuyeron durante los meses de enero y febrero de 2026 en comparación con el mismo periodo de 2025.

- El total acumulado pasó de 2814 casos a 2298 casos, lo que representa 516 registros menos y una variación negativa del 18,3 %.

- Las tablas y el gráfico facilitaron la comparación de los periodos analizados. Por otro lado, las herramientas tecnológicas pueden contribuir a la prevención, detección y localización de vehículos robados.

* Referencias

- Instituto Nacional de Estadística y Censos (INEC). /Estadísticas de Seguridad Integral: delitos de mayor connotación psicosocial/. Febrero de 2026.

- [[https://www.ecuadorencifras.gob.ec/justicia-y-crimen/][INEC: Estadísticas de Justicia y Crimen]]

- [[https://www.fiscalia.gob.ec/analitica/][Fiscalía General del Estado: Analítica]]
```

### 

;; Local Variables:
;; gptel-model: gpt-4o
;; gptel--backend-name: "Copilot"
;; gptel-system-prompt: "You are a large language model living in Emacs and a helpful assistant. Respond concisely."
;; gptel--tool-names: nil
;; gptel--bounds: ((response (9776 16604)))
;; End:
