# What's New in v2.0

The [Bundler 2.0 announcement](/blog/2019/01/03/announcing-bundler-2.html)
includes context and a more detailed explanation of the changes in this version. This is a summary of the biggest changes. As always, a detailed list of every change is provided in
[the changelog](https://github.com/rubygems/bundler/blob/2-0-stable/CHANGELOG.md).

### Breaking changes

This release focuses on removing offical support of versions of Ruby and RubyGems that have reached their end of life, with a few other small breaking changes.

- Removed support for Ruby < 2.3
- Remove support for RubyGems < 3.0.0
- Changed the `github: "some/repo"`  gem source to use the `https` schema by default
- Errors/warnings will now print to `STDERR`
- Bundler now auto-switches between version 1 and 2 based on the Lockfile
