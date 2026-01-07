# What's New in v4.0

## Key New Features

**Custom lockfile support**

The new `bundle install --lockfile` option and `lockfile` method in Gemfile allow managing multiple lockfiles for different environments.

**Go extension support**

`bundle gem --ext=go` generates gems with Go native extensions, expanding beyond Ruby and Rust.

**JSON output for bundle list**

`bundle list --format=json` provides machine-readable dependency output.

## Performance Improvements

* Parallel git operations for faster resolution of git-sourced gems.
* Fewer network roundtrips via adjusted `API_REQUEST_LIMIT`.

## Major Breaking Changes

**New enabled defaults**

* `cache_all` - Caches all gems including git gems by default.
* `lockfile_checksums` - Checksums are now included in the lockfile by default.

**Removed commands and flags**

* `bundle viz` and `bundle inject` commands removed.
* `bundle install --binstubs` now raises an error.
* `bundle show --outdated` now raises an error.
* `bundle remove --install` now raises an error.
* `--rubocop` flag to `bundle gem` removed.
* `--local-git` flag to `bundle plugin install` removed.
* All "remembered CLI flags" removed.

**Removed features**

* Multiple global sources in Gemfile/lockfile no longer supported.
* `allow_offline_install` setting removed.
* `deployment`, `capistrano`, `vlad` entrypoints removed.
* Various deprecated `Bundler.*` helper methods removed.

**Lockfile changes**

* Triple spacing fix for cleaner lockfile formatting.
* Patchlevel hidden from lockfile.

## Security

* Vendored URI bumped to 1.0.4.

**Notable Enhancements**

* Better "did you mean" gem suggestions using `DidYouMean::SpellChecker`.
* Improved Windows loading support.
* Better error messages for gemspec/path source conflicts.
* Checksums now work for gems on private servers.

<a href="https://github.com/rubygems/rubygems/blob/4.0/bundler/CHANGELOG.md" class="btn btn-primary">Full 4.0 changelog</a>
