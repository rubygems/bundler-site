---
title: "Announcing Bundler 1.17.0"
tags:
author: Colby Swandale
category: release
---

The Bundler team is excited to announce Bundler v1.17.0, our next feature-packed release! Most of the changes in this release are the result of the work from our wonderful contributors whom we would like to thank. ❤️

Here are a few features we want to highlight:

### Remove gems from the CLI

We've added a new command called `remove` that allows you to remove gems from the command line. Here's a quick example:

~~~ruby
# Gemfile
source 'https://rubygems.org'

gem 'rake'
gem 'json'
~~~

We can now remove a gem using `bundle remove`:

~~~bash
$ bundle remove json
Removing gems from Gemfile
json was removed.
~~~

Bundler will then remove the `json` gem from the Gemfile. There also is an  `--install` option that will run `bundle install` after the gem has been removed.

Thanks to [agrim123 (Agrim Mittal)](https://github.com/agrim123) for developing this feature.

### New command options

We've added a few options that extend existing features and improve the overall user experience:

* Add `--optimistic` and `--strict` options to `bundle add`  that will add a version constraint to new gems
* Add `--gemfile` option to  `bundle exec`
* Add `--skip-install` option to `bundle add`  to skip running `bundle install` when adding a new gem
* Add `--only-explicit` option to `bundle outdated` to only show outdated gems that are listed directly in the Gemfile

### New plugin events

We've added new events into Bundler for plugins. Libraries are now able to perform an action before and after each gem is installed.

We are excited to see plugins take advantage of these events, and enhance the user experience on top of Bundler.

Thanks to [jules2689 (Julian Nadeau)](https://github.com/jules2689) for working on this!

### Bundler home, plugin, cache and config environment variables

Users have been asking for a feature that will allow them to specify a location for Bundler to place any files/folders that it creates or downloads, but until now Bundler has been hardcoded to place all of its files into `~/.bundle`.  To solve this issue, we've added some environment variables that (optionally) let you tell Bundler exactly where to put its files.

To change the directory where Bundler will store all user-level files (which is `~/.bundle` by default), set `BUNDLE_USER_HOME`. To change the directory where Bundler caches downloaded gems and gem metadata (which is `~/.bundle/cache` by default), set `BUNDLE_USER_CACHE`. To change the location of the user-level configuration file (which is `~/.bundle/config` by default), set `BUNDLE_USER_CONFIG`. Finally, to set the location that Bundler will look for plugin files (which is `~/.bundle/plugins` by default), set `BUNDLE_USER_PLUGIN`. To see a more detailed description of the change and the reasons behind it, check out [the awesome pull request from @gwerbin](https://github.com/rubygems/bundler/pull/6024).

### And a whole lot more!

There is a lot more that we've added into this release. For a more detailed list of changes, check out the [CHANGELOG](https://github.com/rubygems/bundler/tree/1-17-stable/CHANGELOG.md).

## Upgrading from Bundler 1.16

Run `gem install bundler`  to upgrade to the newest release of Bundler.

- - - -

We hope you enjoy this release. Happy Bundling!
