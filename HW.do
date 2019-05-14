clear all
set more off

* Enseña el directorio de trabajo actual
pwd
cd "C:\Users\Carlos\Downloads\TFG"

use IPV_General.dta, clear
* Ordenamos los datos como series temporales
tsset trimestre

summ ipv, d
summ d.ipv, d

	** 2. HW
tssmooth hwinters suavexp= ipv,  iterate(50) replace
line ipv suavexp trimestre


** Generar error

gen ruido = ipv - suavexp

* Generar correlograma de los errores para verificar si hay autocorrelación

ac ruido

drop ruido

	** 4. Holt-Winters Con Estacionalidad
set more off
	tssmooth shwinters shw= ipv, iterate(50) additive replace
line ipv shw trimestre

** Generar error

gen ruido = ipv - shw

* Generar correlograma de los errores para verificar si hay autocorrelación

ac ruido

drop ruido

** 4. Holt-Winters Con Estacionalidad (Multiplicativo)
set more off
	tssmooth shwinters shw_m= ipv, iterate(50) replace
line ipv shw_m trimestre

** Generar error

gen ruido = ipv - shw_m

* Generar correlograma de los errores para verificar si hay autocorrelación

ac ruido

drop ruido
