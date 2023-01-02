---
title: "Making gem development a little better"
date: 2018-01-17 15:01 UTC
tags:
author: Hiren Mistry
author_url: https://github.com/hmistry
category: release
---

You may have experienced this before: you're excited about a gem, and want to contribute to its development. You clone the gem repo and run `bundle install` only to see the horror of installation issues or a failing test suite. What to do? Do you debug this unsure of how deep the rabbit hole goes, or perhaps leave it for another day as you're short on time?

Recently [David Rodriguez](https://github.com/deivid-rodriguez) brought up the issue and explained one way to prevent this: by having gem repositories lock versions of gem dependencies like we do in app development. The team listened to his proposal and reconsidered the original motivation behind not locking versions of gem dependencies, the impact to gem developers, and whether those reasons were still valid today.

Starting with Bundler 1.16, the default for a new gem template created by Bundler no longer adds `Gemfile.lock` to `.gitignore`, thereby allowing the lock file to be committed into the Git repository. Locking the versions of gem dependencies lets gem developers install a known working setup across different systems for development and save time by not having to debug broken installations. With a little CI configuration, gems can still be tested against new version dependencies (see CI recommendations below). We believe gem developers and the OSS community can benefit more by reducing hurdles for contributors. Some gem authors like Rails and Devise have been checking in the lock file into Git for some time now.

The change only applies to new gems created using Bundler by running `bundle gem` to create a new gem skeleton. Bundler will not change the lock file's presence in `.gitignore` for existing gems.

We'd like to thank David for bringing this issue to our attention and implementing the changes to Bundler!

### CI recommendations

There are (at least) two ways to ensure the gem is still tested against the latest versions of dependencies in the CI, even after the `Gemfile.lock` is checked in to the gem repo.

#### Option 1: Delete the lockfile when testing

One way is to delete the lockfile before running the test suite. This will test the build against the latest version of the gem dependencies, giving you a preview of what your users will experience when they install the gem. The easiest way to do this is to add one line to `travis.yml`:

~~~ ruby
before_install: "rm Gemfile.lock"
~~~

This means the CI only runs with the latest dependencies, and so the results may not match what gem developers see on their local machines. You can work around this problem by running the tests twice or setting up a Travis build matrix, to see test results for both, with and without a lockfile.

#### Option 2: Let a bot handle it

The easiest way to make sure new versions are tested with the gem is to ask a friendly bot to update the `Gemfile.lock` and open a PR anytime one of the dependencies release a new version. Friendly bot options include [Dependabot](https://dependabot.com) (by Bundler contributor [@greysteil](https://github.com/greysteil)), [Depfu](https://depfu.com), and others. Having a separate PR for every version bump makes it easy to tell which gems and versions caused failures, if any. They also make it easy to update a version in the lockfile, secure in the knowledge that the tests have already passed with the new version.
