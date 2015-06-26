## bundle install

> Makes sure all the dependencies in your `Gemfile` are available to your application.

~~~
$ bundle install [--clean] [--deployment] [--frozen]
                 [--full-index] [--gemfile=FILE] [--local] [--no-cache]
                 [--no-prune] [--path=PATH] [--quiet] [--shebang=STRING]
                 [--standalone[=GROUP [GROUP...]] [--system]
                 [--without=GROUP[ GROUP...]] [--retry=NUMBER]
                 [--trust-policy=SECURITYLEVEL]
~~~

**Options:**

`--clean`: Runs bundle clean automatically after install.

`--deployment`: Install using defaults tuned for deployment environments.

`--force`: Force download every gem, even if the required versions are available locally.

`--frozen`: Do not allow the `Gemfile.lock` to be updated after this install.

`--full-index`: Use the rubygems modern index instead of the API endpoint.

`--gemfile`: Use the specified gemfile instead of the default `Gemfile`

`--jobs`: Install gems using parallel workers.

`--local`: Do not attempt to fetch gems remotely and use the gem cache instead.

`--no-cache`: Don't update the existing gem cache.

`--no-prune`: Don't remove stale gems from the cache.

`--path`: Specify a different path than the system default `($BUNDLE_PATH or $GEM_HOME)`.
Bundler will remember this value for future installs on this machine.

`--quiet`: Only output warnings and errors.

`--retry`: Retry network and git requests that have failed.

`--shebang`: Specify a different shebang executable name than the default (usually 'ruby').

`--standalone`: Make a bundle that can work without the Bundler runtime.

`--system`: Install to the system location `($BUNDLE_PATH or $GEM_HOME)` even if
the bundle was previously installed somewhere else for this application.

`--trust-policy`: Sets level of security when dealing with signed gems. Accepts
'LowSecurity', 'MediumSecurity' and 'HighSecurity' as values.

`--without`: Exclude gems that are part of the specified named group.

<aside class="notes" markdown="1">
**Note:** Gems will be installed to your default system location for
gems. If your system gems are stored in a root-owned location (such as in
Mac OSX), bundle will ask for your root password to install them there.

While installing gems, Bundler will check `vendor/cache` and the
your system's gems. If a gem isn't cached or installed, Bundler will try to
install it from the sources you have declared in your `Gemfile`.
</aside>

The `--system` option is the default. Pass it to switch back
after using the `--path` option as described below.

Install your dependencies, even gems that are already installed to your system
gems, to a location other than your system's gem repository. In this case,
install them to `vendor/bundle`.

~~~
$ bundle install --path vendor/bundle
~~~

Further `bundle` commands or calls to `Bundler.setup` or
`Bundler.require` will remember this location.

[Learn more: Bundler.setup](./bundler_setup.html)

[Bundler.require](./groups.html)

Install all dependencies except those in groups that are explicitly excluded.

~~~
$ bundle install --without development test`
~~~

[Learn more: Groups](./groups.html)

Install all dependencies on to a production server. Do **not** use this flag on
a development machine.

~~~
$ bundle install --deployment
~~~

The `--deployment` flag activates a number of deployment-friendly conventions:

- Isolate all gems into `vendor/bundle`
- Require an up-to-date `Gemfile.lock`
- If `bundle package` was run, do not fetch gems from rubygems.org. Instead,
only use gems in the checked in `vendor/cache`.

[Learn More: Deploying](./deploying.html)

Install gems in parallel by starting the number of workers specified.

~~~
$ bundle install --jobs 4
~~~

Retry failed network or git requests.

~~~
$ bundle install --retry 3
~~~
