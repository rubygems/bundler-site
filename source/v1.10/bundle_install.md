## bundle install

Makes sure all the dependencies in your `Gemfile` are available to your application.

```
$ bundle install [--binstubs=PATH] [--clean] [--deployment] [--frozen]
                 [--full-index] [--gemfile=FILE] [--local] [--no-cache]
                 [--no-prune] [--path=PATH] [--quiet] [--shebang=STRING]
                 [--standalone[=GROUP [GROUP...]] [--system]
                 [--without=GROUP[ GROUP...]] [--retry=NUMBER]
                 [--trust-policy=SECURITYLEVEL]
```

**Options:**

`--binstubs`: Generate binstubs for bundled gems to `./bin`.

`--clean`: Runs bundle clean automatically after install.

`--deployment`: Install using defaults tuned for deployment environments.
 
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

`--system`: Install to the system location `($BUNDLE_PATH or $GEM_HOME)` even if the
bundle was previously installed somewhere else for this application.

`--trust-policy`: Sets level of security when dealing with signed gems. Accepts
'LowSecurity', 'MediumSecurity' and 'HighSecurity' as values.

`--without`: Exclude gems that are part of the specified named group.

<aside class="notes">
  <p>
    <b>Note:</b> Gems will be installed to your default system location for gems. If your system 
    gems are stored in a root-owned location (such as in Mac OSX), bundle will ask 
    for your root password to install them there.
  </p>
  <p>
    While installing gems, Bundler will check <code>vendor/cache</code> and then your system's
    gems. If a gem isn't cached or installed, Bundler will try to install it from the
    sources you have declared in your <code>Gemfile</code>.
  </p>
  <p>
    The <code>--system</code> option is the default. Pass it to switch back after using the 
    <code>--path</code> option as described below.
  </p>
</aside>


Install your dependencies, even gems that are already installed to your system 
gems, to a location other than your system's gem repository. In this case, install
them to `vendor/bundle`.

``` shell
$ bundle install --path vendor/bundle
```

<aside class="notes">
  Further <code>bundle</code> commands or calls to <code>Bundler.setup</code> or <code>Bundler.require</code> will remember this location.
</aside>

**Learn more:** [Bundler.setup](./bundler_setup.html) | [Bundler.require](./groups.html)

Install all dependencies except those in groups that are explicitly excluded.

``` shell
$ bundle install --without development test`
```

**Learn more:** [Groups](./groups.html)

Install all dependencies on to a production server. Do **not** use this flag on 
a development machine.

``` shell
$ bundle install --deployment
```

The `--deployment` flag activates a number of deployment-friendly conventions:

- Isolate all gems into `vendor/bundle`
- Require an up-to-date `Gemfile.lock`
- If `bundle package` was run, do not fetch gems from rubygems.org. Instead, only use gems in the checked in `vendor/cache`.

**Learn More:** [Deploying](./deploying.html)

Install gems in parallel by starting the number of workers specified.

``` shell
$ bundle install --jobs 4
```

Retry failed network or git requests.

``` shell
$ bundle install --retry 3
```

