## Recommended Workflow with Version Control

In general, when working with an application managed with bundler, you
should use the following workflow:

After you create your <code>Gemfile</code> for the first time, run

    $ bundle install

Check the resulting <code>Gemfile.lock</code> into version control

    $ git add Gemfile.lock

When checking out this repository on another development machine, run

    $ bundle install

When checking out this repository on a deployment machine, run

    $ bundle install --deployment

After changing the <code>Gemfile</code> to reflect a new or update
dependency, run

    $ bundle install

Make sure to check the updated <code>Gemfile.lock</code> into version
control

    $ git add Gemfile.lock

If <code>bundle install</code> reports a conflict, manually update the
specific gems that you changed in the <code>Gemfile</code>

    $ bundle update rails thin

If you want to update all the gems to the latest possible versions that
still match the gems listed in the <code>Gemfile</code>, run

    $ bundle update

## A Thorough Bundler Workflow

Getting started with bundler is easy! Open a terminal window and run this command:

    $ gem install bundler
    
* When you first create a Rails application, it already comes with a
<code>Gemfile</code>.  For another kind of application (such as Sinatra), run:

        $ bundle init

    * The <code>bundle init</code> command creates a simple <code>Gemfile</code> which you
      can edit.

Specify your dependencies in the root of your application, called the <code>Gemfile</code>.
It looks something like this:

~~~ ruby
source 'https://rubygems.org'
gem 'nokogiri'
gem 'rack', '~>1.1'
gem 'rspec', :require => 'spec'
~~~

This <code>Gemfile</code> says a few things. First, it says that bundler should
look for gems declared in the <code>Gemfile</code> at <code>https://rubygems.org</code> by default.

<a href="/gemfile.html" class="btn btn-primary">Learn More: Gemfiles</a>

After declaring your first set of dependencies, you tell bundler to go get them:

    $ bundle install    # <code>bundle</code> is a shortcut for <code>bundle install</code>

Bundler will connect to <code>rubygems.org</code> (and any other sources that you declared),
and find a list of all of the required gems that meet the requirements you specified.
Because all of the gems in your <code>Gemfile</code> have dependencies of their own
(and some of those have their own dependencies), running <code>bundle install</code> on the
<code>Gemfile</code> above will install quite a few gems.

    $ bundle install
    Fetching gem metadata from https://rubygems.org/
    Resolving dependencies...
    Using rake (0.8.7)
    Using abstract (1.0.0)
    Installing activesupport (3.0.0.rc)
    Using builder (2.1.2)
    Using i18n (0.4.1)
    Installing activemodel (3.0.0.rc)
    Using erubis (2.6.6)
    Using rack (1.2.1)
    Installing rack-mount (0.6.9)
    Using rack-test (0.5.4)
    Using tzinfo (0.3.22)
    Installing actionpack (3.0.0.rc)
    Using mime-types (1.16)
    Using polyglot (0.3.1)
    Using treetop (1.4.8)
    Using mail (2.2.5)
    Installing actionmailer (3.0.0.rc)
    Using arel (0.4.0)
    Installing activerecord (3.0.0.rc)
    Installing activeresource (3.0.0.rc)
    Using bundler (1.0.0.rc.3)
    Installing nokogiri (1.4.3.1) with native extensions
    Installing rack-cache (0.5.2)
    Installing thor (0.14.0)
    Installing railties (3.0.0.rc)
    Installing rails (3.0.0.rc)
    Your bundle is complete! Use `bundle show [gemname]` to see where a bundled gem is installed.

If any of the needed gems are already installed, Bundler will use them. After installing
any needed gems to your system, bundler writes a snapshot of all of the gems and
versions that it installed to <code>Gemfile.lock</code>.

* If <code>bundle install</code> reports a conflict between your <code>Gemfile</code> and
<code>Gemfile.lock</code>, run:

        $ bundle update sinatra

* This will update just the Sinatra gem, as well as any of its dependencies.

* To update all of the gems in your <code>Gemfile</code> to the latest possible versions, run:

        $ bundle update

* Whenever your <code>Gemfile.lock</code> changes, always check it in to version control.
It keeps a history of the exact versions of all third-party code that you used to successfully
run your application.

* The <code>git add Gemfile*</code> command adds the Gemfile and Gemfile.lock to your repository. This ensures that
other developers on your app, as well as your deployment environment, will all use the same
third-party code that you are using now.

<a href="/bundle_install.html" class="btn btn-primary">Learn More: bundle install</a>
<a href="/bundle_update.html" class="btn btn-primary">Learn More: bundle update</a>

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
