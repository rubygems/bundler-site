# bundle package

Locks and then caches the gems into `./vendor/cache`.

``` bash
$ bundle package [--all] [--all-platforms] [--gemfile=GEMFILE] [--no-prune]
                 [--path=PATH] [--quiet]
```

**Options:**

`--all`: package `:git`, `:path`, and `.gem` dependencies. Once used, the `--all` 
option will be remembered.

`--all-platforms`: package dependencies for all known platforms, not only the one that `bundle package` is run on. This option will be remembered in your local Bundler configuration.

`--gemfile`: Use the specified gemfile instead of Gemfile.

`--no-install`: Don't actually install the gems, just package.

`--no-prune`: Don't remove stale gems from the cache.

`--path`: Specify a different path than the system default.

`--quiet`: Only output warnings and errors.

The package command will copy the `.gem` files for your gems in the bundle into 
`./vendor/cache`. Afterward, when you run `bundle install`, Bundler will use the 
gems in the cache in preference to the ones on rubygems.org.

Additionally, if you then check that directory into your source control repository, 
others who check out your source will be able to install the bundle without having 
to download any additional gems.

Lock and cache gems from RubyGems into `./vendor/cache`.

``` bash
$ bundle package
```

<aside class="notes">
  <p>
    <b>Note:</b> By default, if you simply run `bundle install` after running `bundle package`, Bundler will still connect to rubygems.org to check whether a platform-specific gem exists for any of the gems in `vendor/cache`.
  </p>
  <p>
    This behavior can be avoided by instead running `bundle install --local`. Note that this requires you to have the correctly platformed version for all of your gems already cached. The easiest way to achieve this is to run `bundle package` on an identical machine and then check in those vendored gems.
  </p>
  <p>
    Lock and cache gems from RubyGems into `./vendor/cache`, and don't remove any stale gems from the existing cache.
  </p>
</aside>

``` shell
$ bundle package --no-prune
```

Lock and cache all gems into `./vendor/cache`, including `:git`, `:path`, and `.gem` dependencies.

``` shell
$ bundle package --all
```

<aside class="notes">
  Once used, the <code>--all</code> option will be remembered.
  
  <p>
    This will be the default on Bundler 2.0.
  </p>
</aside>
