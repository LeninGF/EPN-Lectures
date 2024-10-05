# README

## Problema con ELPA
En caso de no poder actualizar los paquetes del init.el para la
configuración de Emacs desde GNU realizar:

1. Desactivar temporalmente el checking de paquetes:

	M-x set-variable RET package-check-signature RET nil RET

2. Instalar el keyring

	M-x package-install RET gnu-elpa-keyring-update RET

3. Sugiero refrescar paquetes

	M-x package-refresh-contents
	
4. Rehabilitar el checking de paquetes

	M-x set-variable RET package-check-signature RET allow-unsigned RET

## Instalación de Paquetes Ortográficos

