---
title: Compartiendo su código
---
## Cómo paquetizar y compartir código usando un Gemfile
<a name="sharing"></a>

### Chequeando su código en su sistema de control de versiones
<a name="checking-your-code-into-version-control"></a>

Después de desarrollar su aplicación por un tiempo, chequee su código en su sistema de
control de versiones con el `Gemfile` y el `Gemfile.lock`.
Ahora, su repositorio tiene un registro de las versiones exactas de todas las gemas que usó la
última vez que usted sabe que la aplicación sirvió. Tenga en mente que mientras su `Gemfile`
lista solamente tres gemas (con diferente grados de rigor de versión), su aplicación
depende de muchas gemas cuando se considera todos los requisitos implícitos de todas las gemas
que dependen en unas de otras.

Esto es importante: **el `Gemfile.lock`** contiene su código y también código de terceros.
El**`Gemfile.lock`** hace que su aplicación sea un paquete singular
que asegura que su aplicación ejecutó con éxito la última vez que corrió el código.
Especificando versiones exáctas del código de terceros que uno depende de su
`Gemfile` no proveería la misma garantía, porque gemas usualmente declaran
un rango de versiones para sus dependencias.

La próxima vez que ejecuta `bundle install` en la misma máquina, bundler va a ver
que ya tiene todas las dependencias necesarias, y va a omitir el proceso de instalación.

No chequee el directorio `.bundle`, o ningunos de los archivos dentro de él.
Esos archivos son específicos para cada máquina, y se usan para persistir opciones de
instalación entre diferentes instancias de ejecutación del comando `bundle install`.

Si ha ejecutado `bundle pack`, las gemas (pero no las gemas de git) necesitadas
por su bundle van a estar descargadas en `vendor/cache`. Bundler puede correr sin
conectarse al internet (o al servidor RubyGems) si todas las gemas que necesita ya están presentes
en ese directorio y están chequeadas en su sistema de control de versiones.

### Compartiendo su aplicación con otros desarrolladores
<a name="sharing-your-application-with-other-developers"></a>

Cuando otros desarrolladores (o usted mismo en otra máquina) chequean su código,
va a venir con las versiones exáctas de todo el código de terceros que su aplicación
usó en la máquina que usó más reciéntemente para desarrollar (en el `Gemfile.lock`).
Cuando <em>otros</em> ejecuten `bundle install`, bundler va a encontrar el
`Gemfile.lock` y va a omitir el paso de resolver dependencias.

En otras palabras, no va a adivinar cuales versiones de las dependencias debería
instalar. En los ejemplos que hemos usado, aunque `rack-cache` declara una
dependencia en `rack >= 0.4`, sabemos que definitivamente trabaja con `rack
1.5.2`. Aunque Rack lanzaría `rack 1.5.3`, bundler va a siempre instalar
`1.5.2`, la version exácta de la gema que sabemos que funciona. Esto
alivia una gran parte de la carga de mantenimiento de desarrolladores de aplicación, porque
todas las máquinas siempre ejecutarán el mismo código de terceros.
