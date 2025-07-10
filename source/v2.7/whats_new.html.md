# What's New in v2.7

The [Bundler 2.7 announcement](/blog/2025/07/17/bundler-v2-7.html)
includes context and a more detailed explanation of the changes in this version.
This is a summary of the biggest changes. As always, a detailed list of every change is provided in
[the changelog](https://github.com/rubygems/rubygems/blob/3.7/bundler/CHANGELOG.md).

## A new setting to simulate the next major version (Bundler 4)

With Bundler 2.7, you can configure `bundle config simulate_version 4` and get
all future Bundler 4 defaults enabled by default. Please do use this setting and
contribute to Bundler 4 by leaving us feedback.

## Other notable changes

* Improved and more configurable gem generator.
* Better network error handling.
* More resiliency in presence of incorrect lockfiles, or locally installed gemspecs with incorrect dependencies.
* Improved support for default gems like `rdoc` or `irb`.
* Improved auto-switch and auto-restart mechanism based on locked version of Bundler.
* Better git source unlocking.

<a href="https://github.com/rubygems/rubygems/blob/3.7/bundler/CHANGELOG.md" class="btn btn-primary">Full 2.7 changelog</a>
