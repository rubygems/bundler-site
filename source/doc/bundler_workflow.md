---
title: Bundler Workflow
---

## Bundler Workflow

### Recommended Workflow with Version Control

In general, when working with an application managed with bundler, you should use the following workflow:

After you create your `Gemfile` for the first time, run

~~~
$ bundle install
~~~

Check the resulting `Gemfile.lock` into version control.

~~~
$ git add Gemfile.lock
~~~
When checking out this repository on another development machine, run

~~~
$ bundle install
~~~

When checking out this repository on a deployment machine, run

~~~
$ bundle install --deployment
~~~

After changing the `Gemfile` to reflect a new or update dependency, run

~~~
$ bundle install
~~~

Make sure to check the updated `Gemfile.lock` into version control

~~~
$ git add Gemfile.lock
~~~

If `bundle install` reports a conflict, manually update the specific gems that you changed in the `Gemfile`

~~~
$ bundle update rails thin
~~~

If you want to update all the gems to the latest possible versions that
still match the gems listed in the `Gemfile`, run

~~~
$ bundle update
~~~

### A Thorough Bundler Workflow

Getting started with bundler is easy! Open a terminal window and run this command:

~~~
$ gem install bundler
~~~

- When you first create a Rails application, it already comes with a `Gemfile`.
For another kind of application (such as Sinatra), run:

~~~
$ bundle init
~~~

- The `bundle init` command creates a simple `Gemfile` which you can edit.

Specify your dependencies in the root of your application, called the `Gemfile`. It looks something like this:

~~~ ruby
source 'https://rubygems.org'
gem 'nokogiri'
gem 'rack', '~>1.1'
gem 'rspec', :require => 'spec'
~~~

<aside class="notes">
  <b>Note:</b> This `Gemfile` says a few things. First, it says that bundler should look for gems declared in the `Gemfile` at https://rubygems.org by default.
</aside>

**Learn More:** [Gemfiles](./gemfile.html)

After declaring your first set of dependencies, you tell bundler to go get them:

~~~
$ bundle    # bundle is a shortcut for bundle install
~~~

Bundler will connect to rubygems.org (and any other sources that you declared), and find a list of all of the required gems that meet the requirements you specified. Because all of the gems in your `Gemfile` have dependencies of their own (and some of those have their own dependencies), running `bundle install` on the `Gemfile` above will install quite a few gems.

~~~
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
~~~

If any of the needed gems are already installed, Bundler will use them. After installing
any needed gems to your system, bundler writes a snapshot of all of the gems and
versions that it installed to `Gemfile.lock`.

- If `bundle install` reports a conflict between your `Gemfile` and `Gemfile.lock`, run:

~~~
$ bundle update sinatra
~~~

- This will update just the `sinatra` gem, as well as any of its dependencies.

- To update all of the gems in your `Gemfile` to the latest possible versions, run:

~~~
$ bundle update
~~~

Whenever your `Gemfile.lock` changes, always check it in to version control.
It keeps a history of the exact versions of all third-party code that you used
to successfully run your application.

- The `git add Gemfile*` command adds the Gemfile and Gemfile.lock to your repository.
This ensures that other developers on your app, as well as your deployment environment,
will all use the same third-party code that you are using now.

**Learn More:** [bundle install](./bundle_install.html) | [bundle update](./bundle_update.html)

Inside your app, load up the bundled environment:

~~~ ruby
require 'rubygems'
require 'bundler/setup'

# require your gems as usual
require 'nokogiri'
~~~

**Learn More:** [Bundler.setup](./bundler_setup.html)

Run an executable that comes with a gem in your bundle:

~~~
$ bundle exec rspec spec/models
~~~

In some cases, running executables without `bundle exec` may work, if the executable
happens to be installed in your system and does not pull in any gems that conflict with your bundle.

However, this is unreliable and is the source of considerable pain. Even if it
looks like it works, it may not work in the future or on another machine.

Finally, if you want a way to get a shortcut to gems in your bundle:

~~~
$ bundle install --binstubs
$ bin/rspec spec/models
~~~
The executables installed into `bin` are scoped to the bundle, and will always work.

**Learn More:** [Executables](./man/bundle-exec.1.html)
