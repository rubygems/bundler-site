## What is Bundler?

Bundler provides a consistent environment for Ruby projects by tracking
and installing the exact gems and versions that are needed.


Bundler is an exit from dependency hell, and ensures that the gems
you need are present in development, staging, and production.
Starting work on a project is as simple as <code>bundle install</code>.


<a href="/whats_new.html" class="btn btn-primary">What's new in Bundler</a>
<a href="/rationale.html" class="btn btn-primary">Why Bundler exists</a>

## Getting Started

Getting started with bundler is easy! Open a terminal window and run this command:

    $ gem install bundler

Specify your dependencies in a Gemfile in your project's root:

~~~ ruby
source 'https://rubygems.org'
gem 'nokogiri'
gem 'rack', '~>1.1'
gem 'rspec', :require => 'spec'
~~~

<a href="/gemfile.html" class="btn btn-primary">Learn More: Gemfiles</a>

Install all of the required gems from your specified sources:

    $ bundle install
    $ git add Gemfile Gemfile.lock

<a href="/bundle_install.html" class="btn btn-primary">Learn More: bundle install</a>

The second command adds the Gemfile and Gemfile.lock to your repository. This ensures
that other developers on your app, as well as your deployment environment, will all use
the same third-party code that you are using now.

Inside your app, load up the bundled environment:

~~~ ruby
require 'rubygems'
require 'bundler/setup'

# require your gems as usual
require 'nokogiri'
~~~

<a href="/bundler_setup.html" class="btn btn-primary">Learn More: Bundler.setup</a>

Run an executable that comes with a gem in your bundle:

    $ bundle exec rspec spec/models

In some cases, running executables without <code>bundle exec</code>
may work, if the executable happens to be installed in your system
and does not pull in any gems that conflict with your bundle.

However, this is unreliable and is the source of considerable pain.
Even if it looks like it works, it may not work in the future or
on another machine.

Finally, if you want a way to get a shortcut to gems in your bundle:

    $ bundle install --binstubs
    $ bin/rspec spec/models

The executables installed into <code>bin</code> are scoped to the
bundle, and will always work.

<a href="/man/bundle-exec.1.html" class="btn btn-primary">Learn More: Executables</a>

## Create a rubygem with Bundler

Bundler is also an easy way to create new gems. Just like you might create a standard Rails project using <code>rails new</code>, you can create a standard gem project with <code>bundle gem</code>.

Create a new gem with a README, .gemspec, Rakefile, directory structure, and all the basic boilerplate you need to describe, test, and publish a gem:

    $ bundle gem my_gem
    Creating gem 'my_gem'...
          create  my_gem/Gemfile
          create  my_gem/.gitignore
          create  my_gem/lib/my_gem.rb
          create  my_gem/lib/my_gem/version.rb
          create  my_gem/my_gem.gemspec
          create  my_gem/Rakefile
          create  my_gem/README.md
          create  my_gem/bin/console
          create  my_gem/bin/setup
          create  my_gem/CODE_OF_CONDUCT.md
          create  my_gem/LICENSE.txt
          create  my_gem/.travis.yml
          create  my_gem/test/test_helper.rb
          create  my_gem/test/my_gem_test.rb
    Initializing git repo in ./my_gem

<a href="/man/bundle-gem.1.html" class="btn btn-primary">Learn More: bundle gem</a>

## Use Bundler with

<a href="/rails3.html" class="btn btn-primary">Rails 3</a>
<a href="/rails23.html" class="btn btn-primary">Rails 2.3</a>
<a href="/sinatra.html" class="btn btn-primary">Sinatra</a>
<a href="/rubygems.html" class="btn btn-primary">RubyGems</a>
<a href="/rubymotion.html" class="btn btn-primary">RubyMotion</a>

## Get involved

Bundler has a lot of contributors and users, and they all talk to each other quite a bit. If you have questions, try joining <a href="http://slack.bundler.io/">the Slack channel</a> or our <a href="http://groups.google.com/group/ruby-bundler">mailing list</a>. If you're interested in contributing to the project (no programming skills needed), read <a href="https://github.com/bundler/bundler/blob/master/CONTRIBUTING.md">the contributing guide</a> or <a href="https://github.com/bundler/bundler/tree/master/doc/development">the development guide</a>. While participating in the Bundler project, please keep the <a href="/conduct.html">code of conduct</a> in mind, and be inclusive and friendly towards everyone. If you have sponsorship or security questions, please contact the core team directly.

<a href="/conduct.html" class="btn btn-primary">Code of Conduct</a>
<a href="http://webchat.freenode.net/?channels=bundler" class="btn btn-primary">#bundler on IRC</a>
<a href="http://groups.google.com/group/ruby-bundler" class="btn btn-primary">Mailing list</a>
<a href="https://github.com/bundler/bundler/blob/master/CONTRIBUTING.md" class="btn btn-primary">Contributing</a>
<a href="mailto:team@bundler.io" class="btn btn-primary">Email core team</a>
