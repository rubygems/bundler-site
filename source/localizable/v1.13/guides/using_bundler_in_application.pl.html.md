---
title: Bundler w aplikacjach
---

# Bundler w aplikacjach

Ten poradnik został oryginalnie napisany przy użyciu Bundler-a v1.12. Jeśli używasz innej wersji wyniki mogą się nieznacznie różnić.
Aby sprawdzić, którą wersję Bundler-a posiadasz, uruchom `bundler -v`.

## Co w środku?

1. [Rozpoczęcie - instalacja Bundler-a i **bundle init**](#getting-started---installing-bundler-and-bundle-init)
1. [Edytowanie Gemfile'a](#editing-gemfile)
    1. [Sources](#sources)
    1. [Adding Gems](#adding-gems)
    1. [More About Gemfile Syntax](#more-about-gemfile-syntax)
1. [Installing Gems - **bundle install**](#installing-gems---bundle-install)
    1. [Development](#development)
    1. [Deployment](#deployment)
1. [Gemfile.lock](#gemfilelock)
1. [Executing Commands - **bundle exec**](#executing-commands---bundle-exec)
1. [Updating Gems - **bundle outdated** and **bundle update**](#updating-gems---bundle-outdated-and-bundle-update)
1. [Recommended Workflow](#recommended-workflow)

## Rozpoczęcie - instalacja Bundler-a i **bundle init**

**Niektóre framework-i posiadają wbudowaną obsługę Bundler-a, np. kiedy uruchomisz `rails new app`
Bundler zostanie automatycznie zainicjalizowany**

Po pierwsze, musimy zainstalować Bundler-a.
 
    $ gem install bundler
    
Powyższa komenda zaktualizuje Bundler-a, jeśli był wcześniej zainstalowany. Powinniśmy dostać coś takiego, jako wynik:

~~~ bash
$ gem install bundler
Successfully installed bundler-1.12.5
1 gem installed
~~~

Aby zainicjalizować Bundler-a ręcznie, wpiszmy poniższe komendy (`bundler_example` to nasz folder z aplikacją):

    $ mkdir bundler_example && cd bundler_example
    $ bundle init
    
Plik `Gemfile` powinien zostać automatycznie stworzony:

~~~ ruby
# frozen_string_literal: true
# A sample Gemfile
source "https://rubygems.org"

# gem "rails"
~~~

## Edytowanie Gemfile'a

### źródła gem-ów

Automatycznie wygenerowany `Gemfile` zawiera linijkę `source "https://rubygems.org"`.
Znaczy to tyle, że Bundler będzie szukał gem-ów na serwerze `https://rubygems.org`.
Jeśli chcesz użyć własnego serwera RubyGems lub innego, po prostu zmień ją:

~~~ ruby
source "https://your_ruby_gem_server.url"
~~~

***

Jeśli masz więcej źródeł dla gem-ów, możesz użyć bloku lub `:source`:

~~~ ruby
source "https://your_ruby_gem_server.url" do
  # gems
end

gem "my_gem", source: "https://your_2_ruby_gem_server.url"
~~~

Gem-y te będą uzyskiwane z dwóch różnych źródeł.

***

Czytaj więcej o `source` [tu](/man/gemfile.5.html#GLOBAL-SOURCES). 

### Dodawanie gem-ów

Dodajmy teraz kilka zależności do naszego projektu:

~~~ ruby
# frozen_string_literal: true
# A sample Gemfile
source "https://rubygems.org"

gem "rails"
~~~

Używając powyższego Gemfile-a po uruchomieniu `bundler install` zainstalowana zostanie najnowsza wersja
gem-u `rails`.

***

Co jeśli chcemy zainstalować wybraną wersję? Wystarczy ją wpisać po przecinku:

~~~ ruby
gem "rails", "3.0.0"
~~~

lub użyć poniższej składni:

~~~ ruby
gem "rails", "~> 4.0.0" # to jest to samo, co gem "rails", ">= 4.0.0", "< 4.1.0" 
gem "nokogiri", ">= 1.4.2"
~~~

***

Czytaj więcej o gem-ach w Gemfile-u [tu](/man/gemfile.5.html#GEMS).

### Więcej o Gemfile-ach

Czytaj więcej o Gemfile-ach [tu](/man/gemfile.5.html).

## Instalacja gem-ów - **bundle install**

### Development

By zainstalować gem-y do development-u, użyjemy po prostu `bundle install`.

Powinno dać nam to podobny wynik:

    Fetching gem metadata from https://rubygems.org/
    Fetching version metadata from https://rubygems.org/
    Fetching dependency metadata from https://rubygems.org/
    Resolving dependencies...
    Using mini_portile2 2.1.0
    Using pkg-config 1.1.7
    Using bundler 1.12.5
    Using nokogiri 1.6.8
    Bundle complete! 1 Gemfile dependency, 4 gems now installed.
    Use `bundle show [gemname]` to see where a bundled gem is installed.

Stworzy to także [plik `Gemfile.lock`](/man/bundle-install.1.html#THE-GEMFILE-LOCK):

    GEM
      remote: https://rubygems.org/
      specs:
        mini_portile2 (2.1.0)
        nokogiri (1.6.8)
          mini_portile2 (~> 2.1.0)
          pkg-config (~> 1.1.7)
        pkg-config (1.1.7)
    
    PLATFORMS
      ruby
    
    DEPENDENCIES
      nokogiri (>= 1.4.0)
    
    BUNDLED WITH
       1.12.5

Ten plik będzie omawiany w [następnym rozdziale](#gemfilelock).

### Deployment

Dla deployment-u powinniśmy użyć
[opcji `--deployment`](/man/bundle-install.1.html#DEPLOYMENT-MODE):

    $ bundle install --deployment
    
Zainstaluje nam to wszystkie zależności do folderu `./vendor/bundle`.

Jednakże, by uruchomić tą komendę, są pewne wymagania:

1. `Gemfile.lock` jest wymagany.
1. `Gemfile.lock` musi być aktualny.

***

Czytaj więcej o komendzie `bundle install` [tu](/man/bundle-install.1.html).

## Gemfile.lock

Bundler używa tego pliku, by zapisać nazwy i wersje wszystkich gem-ów.
Gwarantuje to, że zawsze będziemy używać tych samych bibliotek, nawet jeśli będziemy się przenosić pomiędzy maszynami.
Po zainstalowaniu gem-a po raz pierwszy, Bundler zablokuje jego wersją.
Aby go zaktualizować, musimy użyć: [`bundler update`](#updating-gems---bundle-outdated-and-bundle-update)
lub/i zmodyfikować jego wersję w `Gemfile`-u.

Ten plik jest tworzony/aktualizowany automatycznie, kiedy uruchamiasz niektóre komendy Bundler-a
(np. `bundle install` lub `bundle update`) i powinno się go dodać do systemu kontroli wersji.

Użyjemy `Gemfile.lock`-a z poprzedniego rozdziału jako przykład. 

    GEM
      remote: https://rubygems.org/
      specs:
        mini_portile2 (2.1.0)
        nokogiri (1.6.8)
          mini_portile2 (~> 2.1.0)
          pkg-config (~> 1.1.7)
        pkg-config (1.1.7)
    
    PLATFORMS
      ruby
    
    DEPENDENCIES
      nokogiri (>= 1.4.0)
    
    BUNDLED WITH
       1.12.5

Prześledźmy jego ważniejsze elementy:

* `GEM`
  * `remote` - źródło gem-ów
  * `specs` - zainstalowany gem-y (z wersją). Widzimy tu, że przykładowo `mini_portile2` jest 
  zależnością `nokogiri`, ponieważ jest poniżej i ma wcięcie.
* `PLATFORMS` - platforma, która została użyta w aplikacji ([zobacz więcej](/man/gemfile.5.html#PLATFORMS)).
* `DEPENDENCIES` - gem-y zdefiniowane w `Gemfile`-u.
* `BUNDLED WITH` - wersja Bundler-a, który ostatnim razem zmienił `Gemfile.lock`

## Wykonywanie komend - **bundle exec**

Popatrzmy najpierw na przykład:

    $ bundle exec rspec
    
    $ bundle exec rails s

Dzięki temu, komenda (w tym przypadku `rspec` i `rails s`) zostanie uruchomiona w aktualnym kontekście bundle-a, 
pozwalając dołączać i używać wszystkich gem-ów zdefiniowanych w `Gemfile`-u.

***

Czytaj więcej o komendzie `bundle exec` [tu](/man/bundle-exec.1.html).

## Aktualizowanie gem-ów - **bundle outdated** i **bundle update**

Now let's update some gems. With `bundle outdated` we can list installed gems with newer versions available:

    $ bundle outdated
    Fetching gem metadata from https://rubygems.org/
    Fetching version metadata from https://rubygems.org/
    Fetching dependency metadata from https://rubygems.org/
    Resolving dependencies.......
    
    Outdated gems included in the bundle:
      * nokogiri (newest 1.6.8, installed 1.6.7.2) in group "default"

You can also specify gems (`bundle outdated *gems`).

We've got `nokogiri` locked on version 1.6.7.2. How can we update it?
`bundle install` won't install newer version because it's locked in `Gemfile.lock` file.
We must use `bundle update`.

    $ bundle update
    Fetching git://github.com/middleman/middleman-syntax.git
    Fetching gem metadata from https://rubygems.org/
    Fetching version metadata from https://rubygems.org/
    Fetching dependency metadata from https://rubygems.org/
    Resolving dependencies.....
    Installing nokogiri 1.6.8 (was 1.6.7.2) with native extensions
    Using i18n 0.7.0
    
    ... (and more)
    
    Bundle updated!
    
Using `bundle update` without any argument will try to update every gem to newest available version
(restrained by `Gemfile`).

To update specific gems, use `bundle update *gems`

***

To learn more about `bundle outdated` command click [here](/bundle_outdated.html).

To learn more about `bundle update` command click [here](/man/bundle-update.1.html).

## Recommended Workflow

In general, when working with an application managed with bundler, you should use the following workflow:

* To init Bundler, run

~~~
$ bundle init
~~~

* After you create your `Gemfile` for the first time, run

~~~
$ bundle install
~~~

* Check the resulting `Gemfile.lock` into version control

~~~
$ git add Gemfile.lock
~~~
 
* When checking out this repository on another development machine, run
 
~~~
$ bundle install
~~~

* When checking out this repository on a deployment machine, run

~~~
$ bundle install --deployment
~~~

* After changing the `Gemfile` to reflect a new or update dependency, run

~~~
$ bundle install
~~~

* Make sure to check the updated Gemfile.lock into version control

~~~
$ git add Gemfile.lock
~~~

* If `bundle install` reports a conflict, manually update the specific gems that you changed in the `Gemfile`

~~~
$ bundle update rails thin
~~~

* If you want to update all the gems to the latest possible versions that still match the gems listed in the Gemfile(5), run

~~~
$ bundle update
~~~
