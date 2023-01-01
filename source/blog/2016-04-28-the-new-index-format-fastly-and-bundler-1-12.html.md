---
title: The new index format, Fastly, and Bundler 1.12
date: 2016-04-28 23:00 UTC
tags:
author: André Arko
author_url: https://arko.net
category: release
---

A new version of Bundler has arrived! With 1.12, we’re shipping one huge change and several smaller changes—the short version is that Bundler is getting faster and more capable.

## The new index format

The biggest change landing in this release is [the fabled new index format](https://andre.arko.net/2014/03/28/the-new-rubygems-index-format/), which has been in development for over two years. It has required significant work on Bundler and the Bundler API webapp, but it also lays the foundation for years of speed, stability, and security. In addition to the speed increases provided by the format itself, we’re also serving the new index directly from the Fastly CDN. That means Bundler will be able to talk to a server located nearby, no matter where you are in the world. We expect that to make a huge difference, especially in Oceania and Africa. 🎉

## `exec` performance

On top of the new index, we also made specific improvements to the performance of `bundle exec`. It now avoids running `Kernel.exec` if possible, and only evaluates the `Gemfile` one time, instead of twice. Added together, these changes should speed up any `bundle exec` command by around 0.25 seconds!

## `outdated` by version size

Another new feature is the ability to run `bundle outdated` with the flags `--major`, `--minor`, and `--patch`. Using those flags, you can limit Bundler to only show you new versions that are both allowed by your `Gemfile` and also meet the criteria of only changing the major, minor, or patch version of the gem. You can combine them to get only minor and patch updates, or even only major and patch updates (but I have no idea why you would want to do that).

## Ruby versions

Our final big feature is support for locking Ruby versions! That means that you can put `ruby "~> 2.3"` in your `Gemfile`, and Bundler will save your exact Ruby version (say, 2.3.1) into your `Gemfile.lock`. You can update the ruby version by running `bundle update --ruby`, and that will update the lock to match your current version of Ruby the same way Bundler currently updates gem versions.

Minor changes include adding support for Ruby 2.4, RubyGems 2.6.3, and support for the Ruby 2.3 feature of freezing all string literals.

## Changelog

We added a bunch of other small tweaks, features, and bugfixes, so be sure to check out [the changelog](https://github.com/rubygems/rubygems/blob/master/bundler/CHANGELOG.md) for the entire list!

## Updating

To get the newest version of Bundler, run `gem install bundler`. If you have any issues, please check out our [issues guide](https://github.com/rubygems/rubygems/issues/new?labels=Bundler&template=bundler-related-issue.md) and let us know!
