---
title: bundle config
---

## bundle config

> Retrieve or set a configuration value.

~~~
$ bundle config [NAME [VALUE]] [--local] [--global] [--delete]
~~~

**Options:**

`--local`: Get/set local configuration.

`--global`: Get/set global configuration.

`--delete`: Delete `NAME` value.

Retrieves or sets a configuration value. If only parameter is provided, retrieve
the value. If two parameters are provided, replace the existing value with the
newly provided one.

By default, setting a configuration value sets it for all projects on the
machine.

If a global setting is superseded by local configuration, this command will show
the current value, as well as any superseded values and where they were
specified.

Get your bundle configuration.

~~~
$ bundle config
~~~


**Note:** Executing `bundle config` with no parameters will
print a list of all bundler configuration for the current bundle, and where
that configuration was set.
{:.notes}

Get your bundle configuration for the `NAME` variable:

~~~
$ bundle config NAME
~~~

**Note:** `bundle config NAME` print the value of that
configuration setting for `NAME`, and  where it was set. It will
print both local and global configuration.
{.notes}

Set your bundle configuration for `NAME` variable to `VALUE`.

~~~
$ bundle config NAME VALUE
~~~


**Note:** This will set `NAME` to `VALUE` for all
bundles executed as the current user (i.e. global setting). The configuration
will be stored in  `~/.bundle/config`. If `NAME` already
is set, `NAME` will be overridden and the user will be warned.
{.notes}

Set your bundle global/user configuration for `NAME` variable to `VALUE`.

~~~
$ bundle config --global NAME VALUE
~~~


Works the same as the previous command.
{.notes}

Set your bundle local configuration for `NAME` variable to `VALUE`.

~~~
$ bundle config --local NAME VALUE
~~~

Works the same as the two command above but for the local application. The
configuration will be stored in `app/.bundle/config`.

Delete the configuration for `NAME` in both local and global sources.

~~~
$ bundle config --delete NAME
~~~

This will delete the configuration for the `NAME` variable in both local and
global sources. Not compatible with `--global` or `--local` flag.

## Build options

You can use `bundle config` to give bundler the flags to pass to the gem
installer every time bundler tries to install a particular gem.

A very common example, the `mysql` gem, requires Snow Leopard users to pass
configuration flags to `gem install` to specify where to find the `mysql_config`
executable.

~~~
$ gem install mysql -- --with-mysql-config=/usr/local/mysql/bin/mysql_config
~~~

Since the specific location of that executable can change from machine to
machine, you can specify these flags on a per-machine basis.

~~~
$ bundle config build.mysql --with-mysql-config=/usr/local/mysql/bin/mysql_config
~~~

After running this command, every time bundler needs to install the `mysql` gem,
it will pass along the flags you specified.

## Configuration keys

Configuration keys in bundler have two forms: the canonical form and the
environment variable form.

For instance, passing the `--without` flag to `bundle install` prevents Bundler
from installing certain groups specified in the `Gemfile`. Bundler persists this
value in `app/.bundle/config` so that calls to `Bundler.setup` do not try to
find gems from the `Gemfile` that you didn't install. Additionally, subsequent
calls to `bundle install` remember this setting and skip those groups.

The canonical form of this configuration is `"without"`. To convert the
canonical form to the environment variable form, capitalize it, and prepend
`BUNDLE_`. The environment variable form of `"without"` is `BUNDLE_WITHOUT`.

## List of available keys

The following is a list of all configuration keys and their purpose. You can
learn more about their operation in `bundle install`.

`auto_install` (`1`): Setting `auto_install config` to 1 or any other truth
value will enable automatic installing of gems instead of raising an error. This
behavior applies to the following commands: `show`, `binstubs`, `outdated`,
`exec`, `open`, `console`, `license`, `clean`.

`path` (`BUNDLE_PATH`): The location on disk to install gems. Defaults to
`$GEM_HOME` in development and `vendor/bundle` when `--deployment` is used.

`frozen` (`BUNDLE_FROZEN`): Disallow changes to the `Gemfile`. Defaults to
`true` when `--deployment` is used.

`without` (`BUNDLE_WITHOUT`): A `:`-separated list of groups whose gems bundler
should not install.

`bin` (`BUNDLE_BIN`): Install executables from gems in the bundle to the
specified directory. Defaults to `false`.

`gemfile` (`BUNDLE_GEMFILE`): The name of the file that bundler should use as
the `Gemfile`. This location of this file also sets the root of the project,
which is used to resolve relative paths in the `Gemfile`, among other things.
By default, bundler will search up from the current working directory until it
finds a `Gemfile`.

`ssl_ca_cert` (`BUNDLE_SSL_CA_CERT`): Path to a designated CA certificate file
or folder containing multiple certificates for trusted CAs in PEM format.

`ssl_client_cert` (`BUNDLE_SSL_CLIENT_CERT`): Path to a designated file
containing a X.509 client certificate and key in PEM format.

`cache_path` (`BUNDLE_CACHE_PATH`): The directory that bundler will place cached
gems in when running `bundle package` and that bundler will look in when
installing with the `--deployment` option.

`disable_multisource` (`BUNDLE_DISABLE_MULTISOURCE`): When set, Gemfiles
containing multiple sources will produce an error instead of a warning. Use
`bundle config --delete disable_multisource` to unset.

In general, you should set these settings per-application by using the
applicable flag to the `bundle install` or `bundle package` command.

You can set them globally either via environment variables or `bundle config`,
whichever is preferable for your setup. If you use both, environment variables
will take preference over global settings.

## Local git repositories

Bundler also allows you to work against a git repository locally instead of
using the remote version. This can be achieved by setting up a local override:

~~~
$ bundle config local.GEM_NAME /path/to/local/git/repository
~~~

For example, in order to use a local Rack repository, a developer could call:

~~~
$ bundle config local.rack ~/Work/git/rack
~~~

Now instead of checking out the remote git repository, the local override will
be used. Similar to a path source, every time the local git repository change,
changes will be automatically picked up by Bundler. This means a commit in the
local git repo will update the revision in the `Gemfile.lock` to the local git
repo revision. This requires the same attention as git submodules. Before
pushing to the remote, you need to ensure the local override was pushed,
otherwise you may point to a commit that only exists in your local machine.

Bundler does many checks to ensure a developer won't work with invalid
references. Particularly, we force a developer to specify a branch in the
`Gemfile` in order to use this feature. If the branch specified in the `Gemfile`
and the current branch in the local git repository do not match, Bundler will
abort. This ensures that a developer is always working against the correct
branches, and prevents accidental locking to a different branch.

Finally, Bundler also ensures that the current revision in the `Gemfile.lock`
exists in the local git repository. By doing this, Bundler forces you to fetch
the latest changes in the remotes.

## Gem Source Mirrors

If your environment contains a local mirror of the rubygems.org server, use the
`mirror.URL` configuration option to supply the URL of the mirror. At that point,
Bundler will download gems and gemspecs from that mirror instead of the source listed in the `Gemfile`.

~~~
$ bundle config mirror.https://rubygems.org https://localgems.lan
~~~
