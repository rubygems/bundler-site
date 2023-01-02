# What's New in v1.13

The [Bundler 1.13 announcement](/blog/2016/09/08/bundler-1-13.html)
includes context and a more detailed explanation of the changes in this version. This is a summary of the biggest changes. As always, a detailed list of every change is provided in
[the changelog](https://github.com/rubygems/bundler/blob/1-13-stable/CHANGELOG.md).

### New `doctor` command

Add the `doctor` command for automated troubleshooting. So far, it can automatically detect gems that have been compiled against libraries that no longer exist, and compile them again to fix them.
(Thanks [@mistydemeo](https://github.com/mistydemeo)!)

### Support for `required_ruby_version`

Gems that declare a `required_ruby_version` will now resolve correctly as long as your Gemfile contains a `ruby` declaration.
If a gem cannot be resolved because of your Ruby version, the error will correctly indicate that your Ruby version conflicts with your other gem version requirements.

### Manage locked platforms

In the past, the only way to resolve your Gemfile on a new platform (like `java` or `mswin`) was to run `bundle install` on that platform.
We've added explicit options to the `lock` command to allow managing platforms.
Platforms can be added using `bundle lock --add-platform NAME`, and platforms can be removed using `bundle lock --remove-platform NAME`.

### Fine controls for the `update` command

The `update` command now has several options to enable users to fine-tune exactly what it is that they will get,
using the new flags `--major`, `--minor`, `--patch`, and `--strict`.
It was also recently pointed out to us that running `update` could even result in some locked gems being changed to an older version!
We can’t change the default behavior to avoid that until version 2.0, but for now we’ve added a config setting.
To prevent the `update` command from ever “upgrading” you to an older version, run `bundle config only_update_to_newer_versions true`.

### Experimental plugin system

The plugin system also supports "source" plugins, which means it should be possible to use gems from Subversion, Mercurial, S3, or anything else you can think of.
In addition to source plugins, we've started adding new "lifecycle" hooks.
That means plugins will be able to hook in and run their own code before, during, or after the install or update process.

### Experimental Bundler version locking

automatically trampoline to the bundler version locked in the lockfile, only updating to the running version on `bundle update --bundler` (@segiddins)
Bundler 1.13 also includes:

- Support for RubyGems 2.6.4
- Automatic gem installation for `bundler/inline`
- Dramatic resolver optimizations
- Better load-based `exec` command
- Support for setting "mirror" servers by hostname
- Automatic retrying for gem downloads

<a href="https://github.com/rubygems/bundler/blob/1-13-stable/CHANGELOG.md" class="btn btn-primary">Full 1.13 changelog</a>
