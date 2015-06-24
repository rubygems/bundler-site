---
layout: layout
---

<!-- # The Best Way to Manage Your Application's Dependencies.


Bundler provides a consistent environment for Ruby projects by tracking
and installing the exact version of gems that are needed.

Bundler is an exit from dependency hell, and ensures that the gems
you need are present in development, staging, and production. -->


## Getting Started

Getting started with bundler is easy! Open a terminal window and run this command:

~~~
$ gem install bundler
~~~

Specify your dependencies in a Gemfile in your project's root:

~~~ ruby
source 'https://rubygems.org'
gem 'nokogiri'
gem 'rack', '~>1.1'
gem 'rspec', :require => 'spec'
~~~

[Learn More: Gemfiles](/doc/gemfile)

Install all of the required gems from your specified sources:

~~~
$ bundle install
$ git add Gemfile Gemfile.lock
~~~

[Learn More: bundle install](/doc/bundle_install)


The second command adds the Gemfile and Gemfile.lock to your repository.
This ensures that other developers on your app, as well as your deployment
environment, will all use the same third-party code that you are using now.
{:.alert .alert-info}

Inside your app, load up the bundled environment:

~~~ ruby
require 'rubygems'
require 'bundler/setup'

# require your gems as usual
require 'nokogiri'
~~~

[Learn More: Bundler.setup](/doc/bundler_setup)

Run an executable that comes with a gem in your bundle:

~~~
$ bundle exec rspec spec/models
~~~

In some cases, running executables without `bundle exec`
may work, if the executable happens to be installed in your system
and does not pull in any gems that conflict with your bundle.
However, this is unreliable and is the source of considerable pain.
Even if it looks like it works, it may not work in the future or
on another machine.
{:.alert .alert-info}


Finally, if you want a way to get a shortcut to gems in your bundle:

~~~
$ bundle install --binstubs
$ bin/rspec spec/models
~~~

The executables installed into <code>bin</code> are scoped to the bundle, and will always work.
{:.alert .alert-info}

[Learn More: Executables](./man/bundle-exec.1)


<!-- ## Use Bundler with

.btn.btn-default.btn-block
  = link_to 'Rails 3', '/doc/rails3.html'
.btn.btn-default.btn-block
  = link_to 'Rails 2.3', '/doc/rails23.html'
.btn.btn-default.btn-block
  = link_to 'Sinatra', '/doc/sinatra.html'
.btn.btn-default.btn-block
  = link_to 'RubyGems', '/doc/rubygems.html'
.btn.btn-default.btn-block
  = link_to 'RubyMotion', '/doc/rubymotion.html'

%h2#get-involved Get involved

%p
  Bundler has a lot of contributors and users, and they all talk to each other
  quite a bit. If you have questions, try #{link_to 'the IRC channel', 'http://webchat.freenode.net/?channels=bundler'}
  or #{link_to 'mailing list', 'http://groups.google.com/group/ruby-bundler'}.
  If you're interested in contributing to the project (no programming skills needed),
  read #{link_to 'the contributing guide', 'https://github.com/bundler/bundler/blob/master/DEVELOPMENT.md'}.
  While participating in the Bundler project, please keep the #{link_to 'code of conduct', '/conduct.html'}
  in mind, and be inclusive and friendly towards everyone. If you have sponsorship
  or security questions, please contact the core team directly.

.buttons
  = link_to 'Code of Conduct', '/conduct.html'
  = link_to '#bundler on IRC', 'http://webchat.freenode.net/?channels=bundler'
  = link_to 'Mailing list', 'http://groups.google.com/group/ruby-bundler'
  = link_to 'Contributing', 'https://github.com/bundler/bundler/blob/master/DEVELOPMENT.md'
  = link_to 'Email core team', 'mailto:team@bundler.io' -->
