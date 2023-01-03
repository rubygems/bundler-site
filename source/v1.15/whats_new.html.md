# What's New in v1.15

The [Bundler 1.15 announcement](/blog/2017/05/19/bundler-1-15-bundle-oh-so-fast.html)
includes context and a more detailed explanation of the changes in this version. This is a summary of the biggest changes. As always, a detailed list of every change is provided in
[the changelog](https://github.com/rubygems/bundler/blob/1-15-stable/CHANGELOG.md).

### Exec optimization

We've made `bundle exec` faster by reducing the impact of each additional gem in your application. In applications with hundreds of gems, this change made `exec` half a second (!) faster.

### `bundle issue`

The `issue` command provides troubleshooting help. If the problem persists, this command will help you open an issue in the Bundler issue tracker with all of the information that we need to help.

### `bundle add`

Finally, you can add gems to your Gemfile directly from the command line, without having to edit your Gemfile first. We've got plans to make this command even better, but this is a good start.

### `bundle pristine`

Just like the `gem pristine` command, the `bundle pristine` command wipes out any changes you have made to the gems installed locally, for testing or debugging reasons, and restores them to a freshly-installed state.
