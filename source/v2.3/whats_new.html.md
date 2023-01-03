# What's New in v2.3

The [Bundler 2.3 announcement](/blog/2022/01/23/bundler-v2-3.html)
includes context and a more detailed explanation of the changes in this version. This is a summary of the biggest changes. As always, a detailed list of every change is provided in
[the changelog](https://github.com/rubygems/rubygems/blob/3.3/bundler/CHANGELOG.md).

### Bundler Version Locking

Bundler is now able to lock itself! The Bundler version used to
create `Gemfile.lock` will be used for all future runs of
`bundle install`. Upgrade Bundler for your app by running
`bundle update --bundler`. (Requires RubyGems 3.3 or
higher.)

### Other improvements

Bundler 2.3 also includes other improvements like enhancements
`bundle gem` or `bundle add`, and deprecation
messages to make dropping support for old rubies in the future
smoother.

<a href="https://github.com/rubygems/rubygems/blob/3.3/bundler/CHANGELOG.md" class="btn btn-primary">Full 2.3 changelog</a>
