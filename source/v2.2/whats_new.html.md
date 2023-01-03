# What's New in v2.2

The [Bundler 2.2 announcement](/blog/2020/12/09/bundler-v2-2.html)
includes context and a more detailed explanation of the changes in this version. This is a summary of the biggest changes. As always, a detailed list of every change is provided in
[the changelog](https://github.com/rubygems/rubygems/blob/3.2/bundler/CHANGELOG.md).

### Multiplatform support

We have improved our multiplatform support to better choose platform
specific gems when appropriate but properly fallback to the ruby
alternative as well.

We have improved support for Windows, and Jruby too.

### Bundle fund command

We have shipped a `bundle fund` command to helps you discovered gems that you depend on that need funding.

### A bunch of other improvements

Bundler 2.2 also includes many other improvements, such as many additions
to the `bundle gem` command, better integration inside ruby-core as a
default gem, and dozens of bug fixes

<a href="https://github.com/rubygems/rubygems/blob/3.2/bundler/CHANGELOG.md" class="btn btn-primary">Full 2.2 changelog</a>
