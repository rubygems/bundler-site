# What's New in v2.4

The [Bundler 2.4 announcement](/blog/2022/12/22/bundler-v2-4.html)
includes context and a more detailed explanation of the changes in this version. This is a summary of the biggest changes. As always, a detailed list of every change is provided in
[the changelog](https://github.com/rubygems/rubygems/blob/3.4/bundler/CHANGELOG.md).

### A new PubGrub based resolver

Bundler now uses [pub_grub](https://github.com/jhawthorn/pub_grub) under the
hood to resolve versions. The most advance algorithm to approach the version
solving problem! 💪

### Generate gems with Rust extensions

`bundle gem` now supports Rust! Pass the `--ext=rust` flag to generate a gem
with a Rust extension.

### Faster git sources in Gemfile

Git sources in Gemfile now work faster and use less disk space.

### Old Ruby and RubyGems no longer supported

Support for Ruby 2.3, 2.4, and 2.5, and RubyGems 2.5, 2.6, and 2.7 has been dropped.

### No more auto-sudo

Bundler no longer tries to use `sudo` to upgrade privileges under any circumstances.

### Other improvements

Bundler 2.4 also includes other improvements like a new `--pre` flag
to `bundle lock` and `bundle update` to explicitly opt-in to prereleases.

<a href="https://github.com/rubygems/rubygems/blob/3.4/bundler/CHANGELOG.md" class="btn btn-primary">Full 2.4 changelog</a>
