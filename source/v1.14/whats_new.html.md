# What's New in v1.14

The [Bundler 1.14 announcement](/blog/2017/03/28/bundler-1-14-so-many-fixes.html)
includes context and a more detailed explanation of the changes in this version. This is a summary of the biggest changes. As always, a detailed list of every change is provided in
[the changelog](https://github.com/rubygems/bundler/blob/1-14-stable/CHANGELOG.md).

### Conservative updates

The conservative flag allows `bundle update --conservative GEM` to update the version of GEM,
but prevents Bundler from updating the versions of any of the gems that GEM depends on,
similar to changing a gem's version number in the Gemfile and then running `bundle install`.

### Checksum validation

As part of the compact index format provided by RubyGems.org, Bundler now has access to checksums for every .gem file.
Starting with version 1.14, Bundler actively validates those checksums against downloaded .gem files before installing them. Hooray! 🎉

### Improved platform support

The `force_ruby_platform` and `specific_platform` settings tell Bundler to always compile gems and to consider platforms during dependency resolution, respectively.
These options can significantly improve things for users installing a single bundle on more than one platform.

### Required Ruby and RubyGems conflict messages

If any gem conflicts with your Ruby or RubyGems version, the error message will now show both the conflicting dependencies and the chain of parent dependencies that led to the conflict.
Bundler 1.14 also includes:

- Installing gems using `sudo` will now always prompt for a password, even if the sudo password is cached from an earlier command
- The Gemfile method `platform` now supports Ruby 2.5, allowing arguments like `:ruby_25` or `:mri_25`.
- The “lockfile is missing dependencies” error (triggered by certain old lock files that were missing information) is no longer fatal. We now print instructions on how to repair the Gemfile, and install using one thread.
- Running `require "bundler"` is now about five times faster than it used to be.
- Bundler now works when run by users without a home directory.
- The output from `bundle env` is now preformatted as Markdown for pasting into a GitHub issue.
- After Bundler 2.0 is (eventually) released, Bundler 1.14 and greater will be able to automatically switch to Bundler 2.0+ for apps that need it.

<a href="https://github.com/rubygems/bundler/blob/1-14-stable/CHANGELOG.md" class="btn btn-primary">Full 1.14 changelog</a>
