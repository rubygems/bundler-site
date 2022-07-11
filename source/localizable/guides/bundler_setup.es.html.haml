---
title: Usando Bundler con Ruby
---

.container.guide
  %h2 Cómo usar Bundler con Ruby

  .contents
    .bullet
      .description
        Configure la ruta de carga para que todas las dependencias en
        su Gemfile puedan ser requerídas
    :code
      # lang: ruby
      require 'rubygems'
      require 'bundler/setup'
      require 'nokogiri'

    .bullet
      .description
        Agregue solamente gemas de grupos específicos
        a la ruta de carga. Si quiere usar las gemas en el grupo
        por defecto, inclúyalo
      :code
        # lang: ruby
        require 'rubygems'
        require 'bundler'
        Bundler.setup(:default, :ci)
        require 'nokogiri'
      = link_to 'Aprende más: Grupos', './groups.html', class: 'btn btn-primary'

    %h2 Compatibilidad

    .contents
      .bullet
        .description
          Tanto Ruby 2.0 como Rubygems 2.0 requieren Bundler 1.13 o superior. Si tiene dudas sobre la compatibilidad entre Bundler y su sistema, por favor chequee la lista de compatibilidad.
        = link_to 'Aprende más: Compatibilidad', '/compatibility.html', class: 'btn btn-primary'

      %h2#setting-up-your-application-to-use-bundler
        Configurando su aplicación para usar Bundler

      .bullet
        .description
          Bundler asegura que Ruby pueda encontrar todas las gemas en el <code>Gemfile</code>
          (y todas sus dependencias). Si su aplicación es una aplicación Rails,
          ya contiene el código necesario para invocar a Bundler.

      .bullet
        .description
          Para otro tipo de aplicación (como una aplicación Sinatra), necesitará
          configurar Bundler antes de intentar requerir otras gemas. Al principio del primer archivo
          que su aplicación carga (para Sinatra, el archivo que contiene <code>require 'sinatra'</code>),
          ponga el código siguiente:

        :code
          # lang: ruby
          require 'rubygems'
          require 'bundler/setup'

      .bullet
        .description
          Esto automáticamente lee su <code>Gemfile</code>, y hace que todas
          las gemas en él estén disponibles para Ruby (en terminos
          técnicos, pone las gemas en "la ruta de carga"). Puede pensarlo
          como una manera de agregar superpoderes extra a <code>require 'rubygems'</code>.

      .bullet
        .description
          Ahora que su código está disponible para Ruby, puede requerir
          las gemas que necesite. Por ejemplo, puede usar el código <code>require 'sinatra'</code>.
          Si tiene muchas dependencias, puede que prefiera requerir todas las gemas
          en su <code>Gemfile</code>. Para hacer esto, ponga el código
          siguiente inmediatamente después de <code>require 'bundler/setup'</code>:

        :code
          # lang: ruby
          Bundler.require(:default)
        Para nuestro Gemfile de ejemplo, esta línea es lo mismo que:

        :code
          # lang: ruby
          require 'rails'
          require 'rack-cache'
          require 'nokogiri'
      .bullet
        .description
          Quizá haya observado que la manera correcta de requerir
          la gema <code>rack-cache</code> es <code>require 'rack/cache'</code>,
          no <code>require 'rack-cache'</code>. Para decirle a bundler que use
          <code>require 'rack/cache'</code>, especifíquelo en su Gemfile de la
          siguiente manera:

        :code
          # lang: ruby
          source 'https://rubygems.org'

          gem 'rails', '5.0.0'
          gem 'rack-cache', require: 'rack/cache'
          gem 'nokogiri', '~> 1.4.2'
      .bullet
        .description
          Para un <code>Gemfile</code> tan pequeño, aconsejamos no usar
          <code>Bundler.require</code>, sino requerir las gemas manualmente
          (especialmente por el hecho que se necesita <code>:require</code> en
          el <code>Gemfile</code>). Para los <code>Gemfile</code>s mucho más grandes,
          usar <code>Bundler.require</code> permite a uno no tener que repetir
          muchos de los mismos requisitos.
