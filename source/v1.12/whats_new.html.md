# What's New in v1.12

### New index format

Bundler now fetches gem metadata using [the new index format](https://andre.arko.net/2014/03/28/the-new-rubygems-index-format/) speeding up `install` significantly.
In addition to the speed increases provided by the format itself, we’re also serving the new index directly from the Fastly CDN.
That means Bundler will be able to talk to a server located nearby, no matter where you are in the world.
We expect that to make a huge difference, especially in Oceania and Africa. 🎉

### Outdated by version significance

It is now possible to run `bundle outdated` with the flags `--major`, `--minor`, and `--patch`.
Using those flags, you can limit Bundler to only show you new versions that are both allowed by your `Gemfile` and also meet the criteria of only changing the major, minor, or patch version of the gem.
You can combine them to get only minor and patch updates, or even only major and patch updates (but I have no idea why you would want to do that)

### Ruby version locking

It is now possible to use regular gem version requirements, like `ruby "~> 2.3"`, in your `Gemfile`.
Bundler will save your exact Ruby version (e.g. "2.3.1") into your `Gemfile.lock`.
You can update the ruby version by running `bundle update --ruby`, and that will update the lock
to match your current version of Ruby the same way Bundler currently updates gem versions.
Bundler 1.12 also includes:

- running `bundle exec` now about 0.25 seconds faster
- support for Ruby 2.4
- support for RubyGems 2.6.3
- support for frozen string literals
- many, many, many bugfixes

<a href="https://github.com/rubygems/bundler/blob/1-12-stable/CHANGELOG.md" class="btn btn-primary">Full 1.12 changelog</a>
