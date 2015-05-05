---
title: Hello, Bundler 1.9!
date: 2015-03-21 00:00 UTC
author: Samuel Giddins
author_url: http://segiddins.me
category: release
---

A mere month and a half after the release of Bundler 1.8, we're happy to announce our next act: Bundler 1.9.

While the [CHANGELOG](https://github.com/bundler/bundler/blob/v1.9.0/CHANGELOG.md#190-2015-03-20) for this version might seem rather short (and light on big new features), there is one cool thing to talk about: [Molinillo](https://github.com/CocoaPods/Molinillo). Molinillo is a new dependency resolution algorithm developed for [CocoaPods](http://cocoapods.org) -- the Cocoa dependency manager. Now, Bundler shares its dependency resolver -- one of the most integral parts of a dependency manager -- with CocoaPods, with the core logic being independently documented and tested. Molinillo was developed thanks to a [generous grant from Stripe](https://stripe.com/blog/stripe-open-source-retreat) for the express purpose of being a generic dependency resolution algorithm that was sharable across different code bases -- specifically CocoaPods and Bundler (and possibly even [RubyGems](https://github.com/rubygems/rubygems/pull/1189))!

#### Dependencies in Bundler?

Having dependencies inside Bundler itself is a bit crazy: Bundler is a dependency manager _for_ gems, written in Ruby. How could it use gems itself? Well, it can't _really_. But we can cheat a bit by shipping Molinillo's source files inside the `bundler` gem. This has its own challenge -- what if a gem (such as CocoaPods), requires a different version of `molinillo` (or `thor`, which is likewise vendored in Bundler)? The solution is to prefix the top-level namespace constant in the vendored gem with Bundler's own namespace. The upshot of this song-and-dance is that Bundler can share open source libraries just like every other gem!

#### Updating

To install the last release of Bundler you can run:

```
$ [sudo] gem install bundler
```

For all the details, don’t miss the Changelog!
