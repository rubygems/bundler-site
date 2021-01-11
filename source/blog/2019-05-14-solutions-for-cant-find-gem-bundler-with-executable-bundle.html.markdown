---
title: "Solutions for 'Cant find gem bundler (>= 0.a) with executable bundle'"
date: 2019-05-14
tags:
author: Colby Swandale
category: release
---

TL;DR: run `gem update --system`.

## What is this error?

Some versions of RubyGems try to use the exact version of Bundler listed in your Gemfile.lock anytime you run the bundle command. If you are using one of those versions of RubyGems, but do not have that exact version of Bundler installed, you will run into this error:

```
Can't find gem bundler (>= 0.a) with executable bundle (Gem::GemNotFoundException)
```

This error is saying (in a very particular way) that RubyGems was unable to find the exact version of Bundler that is in your Gemfile.lock.

This is a bug, and future Bundler & RubyGems versions will automatically install and use the exact version of Bundler your application needs to run.

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
