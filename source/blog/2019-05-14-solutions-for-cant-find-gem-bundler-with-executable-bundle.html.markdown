---
title: "Solutions for 'Cant find gem bundler (>= 0.a) with executable bundle'"
date: 2019-05-14
tags:
author: Colby Swandale
category: release
---

TL;DR: `run gem update --system`.

## What is this bug?

Some versions of RubyGems try to use the exact version of Bundler listed in your Gemfile.lock anytime you run the bundle command. If you are using one of those versions of RubyGems, but do not have that exact version of Bundler installed, you will run into this error:

```
Can't find gem bundler (>= 0.a) with executable bundle (Gem::GemNotFoundException)
```

This error is saying (in a very particular way) that RubyGems was unable to find the exact version of Bundler that is in your Gemfile.lock.

This is a bug, and RubyGems should be willing to use the version of Bundler that you have installed. The bug is fixed in RubyGems 2.7.10 or 3.0.0 and above, which you can install by running `gem update --system`.

If you want to know more about how this happened, keep reading!

## Why does this bug exist?

Starting in RubyGems 2.7, the RubyGems and Bundler teams worked together to add a feature for the future: a Bundler version switcher. The intention was that later on when Bundler 2 eventually came out, RubyGems would be able to automatically run Bundler 1 or Bundler 2 on a per-application basis. It did this by reading the Gemfile.lock and using the version of Bundler listed in the `BUNDLED WITH` section.

After more discussion and experimentation, before Bundler 2 actually shipped, the Bunder team decided that this was too magical and too surprising.

Unfortunately, the code in RubyGems that looked for an exact version of the Bundler gem based on `BUNDLED WITH` was already out there. We didn't realize it in advance, but that code causes this error anytime the `BUNDLED WITH` version is even slightly different from the exact Bundler gem you have installed. (For example, you might have only Bundler 2.0.3, while `BUNDLED WITH` calls for 2.0.2. In that case, RubyGems will unfortunately raise this error.)

## What are the possible solutions?

There are a few options, depending on what you are able to update to newer versions.

## Update RubyGems

The easiest way is to update to the latest RubyGems (2.7.10 and 3.0.4) or higher. You can do that by running `gem update --system`.

## Update Ruby

Ruby 2.6.3 includes a version of RubyGems with the fix for this issue.

## Install the exact Bundler

If updating Ruby or RubyGems is not an available option, you install the exact version of Bundler that RubyGems is looking for by running:

```
$ gem install bundler -v "$(grep -A 1 "BUNDLED WITH" Gemfile.lock | tail -n 1)"
```

Once you've installed the exact version that RubyGems will try to load, future bundle commands should work.

## I'm still having this problem after trying everything else

Oh no! We'd like to help you figure it out. Head over to the GitHub issue tracker and open a new issue, and we'll do what we can to help.

---

— Colby and the Bundler team
