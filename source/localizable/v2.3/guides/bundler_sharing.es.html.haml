---
title: Compartiendo su código
---
.container.guide
  %h2#sharing
    Cómo paquetizar y compartir código usando un Gemfile
  .contents
    .bullet
      .description
        %h3#checking-your-code-into-version-control
          Chequeando su código en su sistema de control de versiones

        %p
          Después de desarrollar su aplicación por un tiempo, chequee su código en su sistema de
          control de versiones con el <code>Gemfile</code> y el <code>Gemfile.lock</code>.
          Ahora, su repositorio tiene un registro de las versiones exactas de todas las gemas que usó la
          última vez que usted sabe que la aplicación sirvió. Tenga en mente que mientras su <code>Gemfile</code>
          lista solamente tres gemas (con diferente grados de rigor de versión), su aplicación
          depende de muchas gemas cuando se considera todos los requisitos implícitos de todas las gemas
          que dependen en unas de otras.
      %p.description
        Esto es importante: <strong>el <code>Gemfile.lock</code></strong> contiene su código y también código de terceros.
        El<strong><code>Gemfile.lock</code></strong> hace que su aplicación sea un paquete singular
        que asegura que su aplicación ejecutó con éxito la última vez que corrió el código.
        Especificando versiones exáctas del código de terceros que uno depende de su
        <code>Gemfile</code> no proveería la misma garantía, porque gemas usualmente declaran
        un rango de versiones para sus dependencias.

      %p.description
        La próxima vez que ejecuta <code>bundle install</code> en la misma máquina, bundler va a ver
        que ya tiene todas las dependencias necesarias, y va a omitir el proceso de instalación.
      %p.description
        No chequee el directorio <code>.bundle</code>, o ningunos de los archivos dentro de él.
        Esos archivos son específicos para cada máquina, y se usan para persistir opciones de
        instalación entre diferentes instancias de ejecutación del comando <code>bundle install</code>.
      %p.description
        Si ha ejecutado <code>bundle pack</code>, las gemas (pero no las gemas de git) necesitadas
        por su bundle van a estar descargadas en <code>vendor/cache</code>. Bundler puede correr sin
        conectarse al internet (o al servidor RubyGems) si todas las gemas que necesita ya están presentes
        en ese directorio y están chequeadas en su sistema de control de versiones.


    .bullet
      %h3#sharing-your-application-with-other-developers
        Compartiendo su aplicación con otros desarrolladores

      %p.description
        Cuando otros desarrolladores (o usted mismo en otra máquina) chequean su código,
        va a venir con las versiones exáctas de todo el código de terceros que su aplicación
        usó en la máquina que usó más reciéntemente para desarrollar (en el <code>Gemfile.lock</code>).
        Cuando <em>otros</em> ejecuten <code>bundle install</code>, bundler va a encontrar el
        <code>Gemfile.lock</code> y va a omitir el paso de resolver dependencias.

      %p.description
        En otras palabras, no va a adivinar cuales versiones de las dependencias debería
        instalar. En los ejemplos que hemos usado, aunque <code>rack-cache</code> declara una
        dependencia en <code>rack >= 0.4</code>, sabemos que definitivamente trabaja con <code>rack
        1.5.2</code>. Aunque Rack lanzaría <code>rack 1.5.3</code>, bundler va a siempre instalar
        <code>1.5.2</code>, la version exácta de la gema que sabemos que funciona. Esto
        alivia una gran parte de la carga de mantenimiento de desarrolladores de aplicación, porque
        todas las máquinas siempre ejecutarán el mismo código de terceros.
