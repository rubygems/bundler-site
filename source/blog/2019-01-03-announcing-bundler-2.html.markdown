---
title: "Announcing Bundler 2.0"
tags:
author: Colby Swandale
category: release
---

The Bundler team is excited to announce the release of Bundler 2.0 🎉!

This release focuses on removing offical support of versions of Ruby and RubyGems that have reached their end of life, with a few other small breaking changes.

The following is the full list of changes to Bundler 2:

* Removed support for Ruby \< 2.3
* Removed support for RubyGems \< 3.0.0
* Changed the `github: 'some/repo'` gem source to use the  `https` schema by default
* Errors/warnings will now print to `STDERR`
* Bundler now auto-switches between version 1 and 2 based on the Lockfile

### Update

We've posted an update on the [release of Bundler 2](/blog/2019/01/04/an-update-on-the-bundler-2-release.html)

### What is version autoswitching?

Version autoswitching means that Bundler will automatically run the correct 1.x or 2.x version based on your lockfile. This means you can have both Bundler 1.17.3 and Bundler 2.0.0 installed at the same time, and each application will use the version saved in your lockfile when you run `bundle install`. Every existing application should continue to work using Bundler 1, even after you have installed Bundler 2 (or even Bundler 3 or 4, later on).

### Installing Bundler 2

Bundler 2 requires RubyGems 3.0, so install that first by running:

	$ gem update --system

Then, install Bundler 2 by running:

	$ gem install bundler

### Why does Bundler depend on RubyGems 3.0?

To make Bundler's user experience when it auto-switches between versions as smooth as possible, Bundler depends on particular features in RubyGems that were publicly introduced in RubyGems v3.0.

RubyGems is able to be upgraded to newest release using the `gem update --system` command. See [RubyGems Guides](https://guides.rubygems.org/command-reference/#gem-update) for more information.

### Upgrading existing applications to use Bundler 2

Bundler will never automatically upgrade an application to Bundler 2 without your explicit permission. If you are ready to upgrade an existing application to use Bundler 2, you can run this command and then commit your lockfile:

	$ bundle update --bundler

### Upgrading new applications to use Bundler 2

If you have Bundler 2 installed, new applications will use Bundler 2 automatically. After you run `bundle install`, you can check the lockfile to see which version of Bundler your application will use.

### Can I use Bundler 2 on Heroku?

Yes you can! The Heroku team has said they plan to upgrade the official Ruby buildpack to Bundler 2, but it will take some time. They have a zillion users, so that totally makes sense.

In the meantime, you can use our [buildpack](https://github.com/bundler/heroku-buildpack-bundler2), which is exactly the same as Heroku’s but with Bundler 2.

Note: Support for the Bundler 2 buildpack is limited. You are welcome to report issues at the [bundler/heroku-buildpack-bundler2](https://github.com/bundler/heroku-buildpack-bundler2) repository, but we can’t guarantee solutions.

### Major releases going forward

With the release of Bundler 2, the core team now kicks off a new release schedule for Bundler: we’re going to aim for one major version release per year, so we can drop support for older Ruby and RubyGems versions around the same time that the Ruby core team does. Being able to stop supporting Ruby 1.8.7 is a huge relief!

### More Information

If you have more questions, or want more information about Bundler 2, read our [detailed Bundler 2 guide](https://bundler.io/guides/bundler_2_upgrade.html) for the full scoop.

### I tried to upgrade but something is broken!

Oh no! Sorry about that. Please head over to our [troubleshooting guide](/doc/troubleshooting.html) and open a ticket so that we can try to fix your problem ASAP.

---- 

We hope you enjoy this release. Happy Bundling!

— Colby and the Bundler team
