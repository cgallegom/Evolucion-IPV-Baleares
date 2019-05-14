clear all


* Enseña el directorio de trabajo actual
pwd
cd "C:\Users\Carlos\Downloads\TFG"

use IPV_General.dta, clear
* Ordenamos los datos como series temporales
tsset trimestre

** Raíces Unitarias
dfuller ipv, lags(1) trend

dfuller d.ipv, lags(1) trend

summ ipv, d
summ d.ipv, d

* añadir histograma????
histogram ipv

qnorm ipv
* añadir gráfico de probabilidad normal estandarizada?????(solo fila siguiente)*
pnorm ipv
tsline ipv

summ d.ipv, d

gen dipv=d.ipv

tsline dipv

** Vamos a crear variables binarias estacionales
gen q = quarter(dofq(trimestre))
gen d2 = (q==2)
gen d3= (q==3)
gen d4= (q==4)

* Regresión sobre las variables binarias estacionales
regress ipv d2 d3 d4
regress ipv d2 d3 d4, vce(r)

regress dipv d2 d3 d4, vce(robust)

* Modelos de estacionalidad
	** 1. Media Movil (4 Trimestres)
**tssmooth ma mm= ipv, window(4 1 4)
tssmooth ma mm= ipv, weights(1/5 <9> 5/1)
line ipv mm trimestre

** Generar error

gen ruido = ipv - mm

* Generar correlograma de los errores para verificar si hay autocorrelación

ac ruido
drop ruido
