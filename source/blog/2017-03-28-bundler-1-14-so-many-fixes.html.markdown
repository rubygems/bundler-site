---
title: "Bundler 1.14: So many fixes"
date: 2017-03-28 07:15 UTC
tags:
author: André Arko
author_url: https://github.com/indirect
category: release
---

# What’s new in Bundler 1.14?

We somehow missed writing up an announcement when Bundler 1.14 was initially released, but several people kindly pointed out the problem. Just 48 days late, here’s what’s new in Bundler 1.14! In this feature release, we added several small features, and fixed a giant pile of bugs.

### Conservative updates

Building on the previous [fine controls for the update command](http://bundler.io/v1.13/whats_new.html#fine-controls-for-the-update-command), the illustrious [@chrismo](https://github.com/chrismo) worked his way through many gnarly possible usage combinations to implement the `update --conservative` flag. Using the conservative flag allows `bundle update GEM` to update the version of GEM, but prevents Bundler from updating the versions of any of the gems that GEM depends on. For a more in-depth discussion of why this is useful, check out the  [discussion of overlapping dependencies](http://bundler.io/v1.14/man/bundle-update.1.html#OVERLAPPING-DEPENDENCIES) in the [`update` command man page](http://bundler.io/v1.14/man/bundle-update.1.html).

### Checksum validation

As part of the [compact index format](https://andre.arko.net/2014/03/28/the-new-rubygems-index-format/) provided by RubyGems.org, Bundler now has access to checksums for every .gem file. Starting with version 1.14, Bundler actively validates those checksums against downloaded .gem files before installing them. Hooray! 🎉

### Improved platform support

Courtesy of some intensive work by @segiddins, Bundler is getting better at handling applications that will be run on more than one platform, like both Unix and Windows. To start with, Bundler will now print a warning if your Gemfile includes any gems that will never be installed due to a `platform` block. For gems that need to be compiled even though the author has uploaded a binary gem, the `force_ruby_platform` config setting has you covered. Lastly, the new config setting `specific_platform` tells Bundler to consider platforms during dependency resolution. This setting should significantly improve things for users installing a single bundle on more than one platform. We expect the `specific_platform` setting to become the default behavior in Bundler 2.0.

### Improved required Ruby versions

Building on the support for Ruby and RubyGems version that was added in 1.13, Bundler 1.14 improves resolver error messages. If any gem conflicts with your Ruby or RubyGems version, the error message will now show both the conflicting dependencies and the chain of parent dependencies that led to the conflict.

### Various improvements

In addition to those larger additions, we made some smaller tweaks with the aim of smoothing and improving the overall experience of using Bundler:

- Installing gems using `sudo` will now always prompt for a password, even if the sudo password is cached from an earlier command
- The Gemfile method `platform` now supports Ruby 2.5, allowing arguments like `:ruby_25` or `:mri_25`.
- The “lockfile is missing dependencies” error (triggered by certain old lock files that were missing information) is no longer fatal. We now print instructions on how to repair the Gemfile, and install using one thread.
- Running `require "bundler"` is now about five times faster than it used to be.
- Bundler now works when run by users without a home directory.
- The output from `bundle env` is now preformatted as Markdown for pasting into a GitHub issue.
- After Bundler 2.0 is (eventually) released, Bundler 1.14 and greater will be able to automatically switch to Bundler 2.0+ for apps that need it.

We also fixed over 60 separate bugs, and you can read about every single one of them [in the Bundler 1.14 changelog](https://github.com/rubygems/bundler/blob/1-14-stable/CHANGELOG.md).

### How To Upgrade

Run `gem install bundler` to upgrade to the newest version of Bundler.
