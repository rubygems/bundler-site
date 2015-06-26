## bundle update

> Update the current environment.

~~~
$ bundle update [GEM] [--full-index] [--group=GROUP] [--jobs=NUMBER] [--local]
                      [--quiet] [--source=SOURCE]
~~~

**Options:**

`--full-index`: Use the rubygems modern index instead of the API endpoint

`--group`: Update one or more gem groups

`--jobs`: Specify the number of jobs to run in parallel

`--local`: Do not attempt to fetch gems remotely and use the gem cache instead

`--quiet`: Only output warnings and errors.

`--source`: Update a specific source (and all gems associated with it)

Update the gems specified (all gems, if none are specified), ignoring the previously
installed gems specified in the `Gemfile.lock`. In general, you should use
`bundle install` to install the same exact gems and versions across machines.


You would use `bundle update` to explicitly update the version of a gem.

Update the current environment.

~~~
$ bundle update
~~~

If you run `bundle update` with no parameters, bundler will ignore any
previously installed gems and resolve all dependencies again based on the latest
versions of all gems available in the sources.

Update a specific source (and all gems associated with it)

~~~
$ bundle update --source=SOURCE
~~~

The name of a `:git` or `:path` source used in the `Gemfile`. For instance, with
a `:git` source of `http://github.com/rails/rails.git`, you would call `bundle update --source rails`.

### Update all gems

If you run `bundle update` with no parameters, bundler will ignore any previously
installed gems and resolve all dependencies again based on the latest versions
of all gems available in the sources.

Consider the following `Gemfile`:

~~~ ruby
source 'https://rubygems.org'
gem 'rails', '3.0.0.rc'
gem 'nokogiri'
~~~

When you run `bundle install` the first time, bundler will resolve all of the
dependencies, all the way down, and install what you need:

~~~
Fetching source index for https://rubygems.org/
Installing rake (0.8.7)
Installing abstract (1.0.0)
Installing activesupport (3.0.0.rc)
Installing builder (2.1.2)
Installing i18n (0.4.1)
Installing activemodel (3.0.0.rc)
Installing erubis (2.6.6)
Installing rack (1.2.1)
Installing rack-mount (0.6.9)
Installing rack-test (0.5.4)
Installing tzinfo (0.3.22)
Installing actionpack (3.0.0.rc)
Installing mime-types (1.16)
Installing polyglot (0.3.1)
Installing treetop (1.4.8)
Installing mail (2.2.5)
Installing actionmailer (3.0.0.rc)
Installing arel (0.4.0)
Installing activerecord (3.0.0.rc)
Installing activeresource (3.0.0.rc)
Installing bundler (1.0.0.rc.3)
Installing nokogiri (1.4.3.1) with native extensions
Installing thor (0.14.0)
Installing railties (3.0.0.rc)
Installing rails (3.0.0.rc)

Your bundle is complete! Use `bundle show [gemname]` to see where a bundled gem
is installed.
~~~

As you can see, even though you have just two gems in the `Gemfile`, your
application actually needs 25 different gems in order to run. Bundler remembers
the exact versions it installed in `Gemfile.lock`. The next time you run
`bundle install`, bundler skips the dependency resolution and installs the same
gems as it installed last time.

After checking in the `Gemfile.lock` into version control and cloning it on
another machine, running `bundle install` will _still_ install the gems that you
installed last time. You don't need to worry that a new release of `erubis` or
`mail` changes the gems you use.

However, from time to time, you might want to update the gems you are using to
the newest versions that still match the gems in your `Gemfile`.

To do this, run `bundle update`, which will ignore the `Gemfile.lock`, and
resolve all the dependencies again. Keep in mind that this process can result in
a significantly different set of the 25 gems, based on the requirements of new
gems that the gem authors released since the last time you ran `bundle update`.

### Update a list of gems.

Sometimes, you want to update a single gem in the `Gemfile`, and leave the rest
of the gems that you specified locked to the versions in the `Gemfile.lock`.

For instance, in the scenario above, imagine that `nokogiri` releases version
`1.4.4`, and you want to update it _without_ updating Rails and all of its
dependencies. To do this, run:

~~~
bundle update nokogiri
~~~

Bundler will update `nokogiri` and any of its dependencies, but leave alone Rails and its dependencies.

### Overlapping dependencies

Sometimes, multiple gems declared in your `Gemfile` are satisfied by the same
second-level dependency. For instance, consider the case of `thin` and `rack-perftools-profiler`.

~~~ ruby
source 'https://rubygems.org'

gem 'thin'
gem 'rack-perftools-profiler'
~~~

The `thin` gem depends on `rack >= 1.0`, while `rack-perftools-profiler` depends on `rack ~> 1.0`.
If you run bundle install, you get:

~~~
Fetching source index for https://rubygems.org/
Installing daemons (1.1.0)
Installing eventmachine (0.12.10) with native extensions
Installing open4 (1.0.1)
Installing perftools.rb (0.4.7) with native extensions
Installing rack (1.2.1)
Installing rack-perftools_profiler (0.0.2)
Installing thin (1.2.7) with native extensions
Using bundler (1.0.0.rc.3)
~~~

In this case, the two gems have their own set of dependencies, but they share
`rack` in common. If you run `bundle update thin`, bundler will update
`daemons`, `eventmachine` and `rack`, which are dependencies of `thin`, but not
`open4` or `perftools.rb`, which are dependencies of `rack-perftools_profiler`.
Note that `bundle update thin` will update `rack` even though it's _also_ a
dependency of `rack-perftools_profiler`.

In short, when you update a gem using `bundle update`, bundler will update all
dependencies of that gem, including those that are also dependencies of another gem.

In this scenario, updating the `thin` version manually in the `Gemfile`, and
then running `bundle install` will only update `daemons` and `eventmachine`, but not`rack`.

For more information, see the  `CONSERVATIVE UPDATING`section of `bundle install`.
