---
title: "Making gem development a little better"
date: 2017-09-13 15:01 UTC
tags:
author: Hiren Mistry
author_url: http://github.com/hmistry
category: release
---

You may have experienced this before: you're excited about a gem, and want to contribute to its development. You clone the gem repo and run `bundle install` only to see the horror of installation issues or a failing test suite. What to do? Do you debug this unsure of how deep the rabbit hole goes, or perhaps leave it for another day as you're short on time?

Recently [David Rodriguez](https://github.com/deivid-rodriguez) brought up the issue and explained one way to prevent this: by having gem repositories lock versions of gem dependencies like we do in app development. The team listened to his proposal and reconsidered the original motivation behind not locking versions of gem dependencies, the impact to gem developers, and whether those reasons were still valid today.

Starting with Bundler 1.16, the default for a new gem template created by Bundler no longer adds `Gemfile.lock` to `.gitignore`, thereby allowing the lock file to be committed into the Git repository. Locking the versions of gem dependencies lets gem developers install a known working setup across different systems for development and save time by not having to debug broken installations. With a little CI configuration, gems can still be tested against new version dependencies (see the recommended CI flow below). We believe gem developers and the OSS community can benefit more by reducing hurdles for contributors. Some gem authors like Rails and Devise have been checking in the lock file into Git for some time now.

The change only applies to new gems created using Bundler by running `bundle gem` to create a new gem skeleton. Bundler will not change the lock file's presence in `.gitignore` for existing gems.

We'd like to thank David for bringing this issue to our attention and implementing the changes to Bundler!

### Recommended CI Flow
Gem authors who check in `Gemfile.lock` into the Git repository and use CI platforms for testing their gems can add the following step in their CI script so it can test different versions of the gem dependencies:

* Delete the `Gemfile.lock` file before the CI installs the dependencies using `bundle install`.

Here is an example to configure TravisCI (`travis.yml`):

~~~ ruby
before_install: "rm ${BUNDLE_GEMFILE}.lock"
~~~

