---
title: "Solutions for 'Cant find gem bundler (>= 0.a) with executable bundle'"
tags:
author: Colby Swandale
category: release
---

TL;DR: run

```
$ gem install bundler -v "$(grep -A 1 "BUNDLED WITH" Gemfile.lock | tail -n 1)"
```

## What is this error?

Some versions of RubyGems try to use the exact version of Bundler listed in your Gemfile.lock anytime you run the bundle command. If you are using one of those versions of RubyGems, but do not have that exact version of Bundler installed, you will run into this error:

```
Can't find gem bundler (>= 0.a) with executable bundle (Gem::GemNotFoundException)
```

This error is saying (in a very particular way) that RubyGems was unable to find the exact version of Bundler that is in your Gemfile.lock.

This is a bug, and future Bundler & RubyGems versions will automatically install and use the exact version of Bundler your application needs to run.

## What are the possible solutions?

There are a few options, depending on what you are able to update to newer versions.

## Install the exact Bundler

The only version of Bundler 100% guaranteed to work with a given `Gemfile.lock` file is the Bundler version that generated it. So the most reliable way to fix this error is to install that exact Bundler version.

This will be the default behavior of `bundle install` in the future, but for now you can get that result with:

```
$ gem install bundler -v "$(grep -A 1 "BUNDLED WITH" Gemfile.lock | tail -n 1)"
```

## Update RubyGems

More recent RubyGems versions are less strict and as long as the major Bundler version in the `BUNDLED WITH` section of your `Gemfile.lock` file matches the major Bundler version you are running, it won't generate an error.

You can try updating RubyGems by running `gem update --system`, but note that if the Ruby you're running is provided by an OS package, this most likely won't work since the RubyGems update should come from another OS package.

## Update Ruby

Similarly to the previous solution, Ruby 2.6.3 includes a version of RubyGems that's less strict, so upgrading Ruby will automatically upgrade RubyGems and should fix the issue too.

---

— Colby and the Bundler team
