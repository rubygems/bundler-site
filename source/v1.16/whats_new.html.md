# What's New in v1.16

The [Bundler 1.16 announcement](/blog/2017/10/31/bundler-1-16.html)
includes context and a more detailed explanation of the changes in this version. This is a summary of the biggest changes. As always, a detailed list of every change is provided in
[the changelog](https://github.com/rubygems/bundler/blob/1-16-stable/CHANGELOG.md).

### Resolver improvements

By replacing the heuristic-focused “swapping” algorithm with one that can consider groups of gems at once, Grey Baker managed to eliminate many bugs around dependency resolution, all while making resolution faster than ever before.

### Resolver improvements

We've managed to reduce the number of times a Gemfile needs to be `eval`ed when running `bundle install`.
Additionally, running `bundle install` when no installation needs to be done is several times faster, bringing it within a few hundred milliseconds of `bundle check`.
Bundler 1.16 also includes:

- `bundle pristine` will now allow passing a list of gems to pristine
- gemfiles are evaluated one fewer time when running `bundle install`
- More than 20 other bugfixes

<a href="https://github.com/rubygems/bundler/blob/1-16-stable/CHANGELOG.md" class="btn btn-primary">Full 1.16 changelog</a>
