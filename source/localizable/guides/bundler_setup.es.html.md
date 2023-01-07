---
title: Usando Bundler con Ruby
---
## Cómo usar Bundler con Ruby

Configure la ruta de carga para que todas las dependencias en
su Gemfile puedan ser requerídas

~~~ruby
require 'bundler/setup'
require 'nokogiri'
~~~

Agregue solamente gemas de grupos específicos
a la ruta de carga. Si quiere usar las gemas en el grupo
por defecto, inclúyalo

~~~ruby
require 'bundler'
Bundler.setup(:default, :ci)
require 'nokogiri'
~~~

<a href="./groups.html" class="btn btn-primary">Aprende más: Grupos</a>

## Compatibilidad

Tanto Ruby 2.0 como Rubygems 2.0 requieren Bundler 1.13 o superior. Si tiene dudas sobre la compatibilidad entre Bundler y su sistema, por favor chequee la lista de compatibilidad.

<a href="/compatibility.html" class="btn btn-primary">Aprende más: Compatibilidad</a>

## Configurando su aplicación para usar Bundler
<a name="setting-up-your-application-to-use-bundler"></a>

Bundler asegura que Ruby pueda encontrar todas las gemas en el `Gemfile`
(y todas sus dependencias). Si su aplicación es una aplicación Rails,
ya contiene el código necesario para invocar a Bundler.
Para otro tipo de aplicación (como una aplicación Sinatra), necesitará
configurar Bundler antes de intentar requerir otras gemas. Al principio del primer archivo
que su aplicación carga (para Sinatra, el archivo que contiene `require 'sinatra'`),
ponga el código siguiente:

~~~ruby
require 'bundler/setup'
~~~

Esto automáticamente lee su `Gemfile`, y hace que todas
las gemas en él estén disponibles para Ruby (en terminos
técnicos, pone las gemas en "la ruta de carga").

Ahora que su código está disponible para Ruby, puede requerir
las gemas que necesite. Por ejemplo, puede usar el código `require 'sinatra'`.
Si tiene muchas dependencias, puede que prefiera requerir todas las gemas
en su `Gemfile`. Para hacer esto, ponga el código
siguiente inmediatamente después de `require 'bundler/setup'`:

~~~ruby
Bundler.require(:default)
~~~

１Para nuestro Gemfile de ejemplo, esta línea es lo mismo que:

~~~ruby
require 'rails'
require 'rack-cache'
require 'nokogiri'
~~~

Quizá haya observado que la manera correcta de requerir
la gema `rack-cache` es `require 'rack/cache'`,
no `require 'rack-cache'`. Para decirle a bundler que use
`require 'rack/cache'`, especifíquelo en su Gemfile de la
siguiente manera:

~~~ruby
source 'https://rubygems.org'

gem 'rails', '5.0.0'
gem 'rack-cache', require: 'rack/cache'
gem 'nokogiri', '~> 1.4.2'
~~~

Para un `Gemfile` tan pequeño, aconsejamos no usar
`Bundler.require`, sino requerir las gemas manualmente
(especialmente por el hecho que se necesita `:require` en
el `Gemfile`). Para los `Gemfile`s mucho más grandes,
usar `Bundler.require` permite a uno no tener que repetir
muchos de los mismos requisitos.
