# What's New in v2.6

The [Bundler 2.6 announcement](/blog/2024/12/19/bundler-v2-6.html)
includes context and a more detailed explanation of the changes in this version.
This is a summary of the biggest changes. As always, a detailed list of every change is provided in
[the changelog](https://github.com/rubygems/rubygems/blob/3.6/bundler/CHANGELOG.md).

## Lockfile checksums

Bundler 2.6 can now record the checksum of every gem in the lockfile, to make
sure no malicious changes are ever introduced to a locked gem.

## Other notable changes

* Better support for switching between different versions of Ruby.
* Better handling of git dependencies in application caches.
* More careful redaction of gem server credentials in logs and `bundle config` output.
* Better `bundle exec` behaviour on Windows.
* Better documentation of commands and CLI flags.

<a href="https://github.com/rubygems/rubygems/blob/3.6/bundler/CHANGELOG.md" class="btn btn-primary">Full 2.6 changelog</a>
