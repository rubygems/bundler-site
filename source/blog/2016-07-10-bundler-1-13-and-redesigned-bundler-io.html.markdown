---
title: A New Bundler Website
date: 2016-07-10 21:44 UTC
tags:
author: Jakub Kruczek
author_url: https://github.com/kruczjak
category: release
---

Announcing... the new Bundler website! As part of Google Summer of Code 2016, Bundler has a new, prettier, and better website. The most visible changes are a completely new design and color scheme. In addition, the entire site is now responsive and easy to read on mobile devices using the [Bootstrap framework](http://getbootstrap.com/).

The [new Docs page](/docs.html) provides a table of contents for the entire site, allowing you to choose between guides, command reference pages, and changelogs for each version. On each command page (e.g. [bundle install](/man/bundle-install.1.html)), there
is a new sidebar, allowing navigation not just between commands but also to previous versions of the same command.

There are also two new guides to go with the new website: [Using Bundler In Applications](/guides/using_bundler_in_applications.html) written by [me](https://github.com/kruczjak), and [Developing a RubyGem using Bundler](/guides/using_bundler_in_applications.html) by Ryan Bigg ([@radar](https://github.com/radar)).

The new site also includes some more improvements:

* Command pages are now built from the Bundler repository instead of hand-written (where possible)
* Commits to the master branch of [bundler-site](https://github.com/rubygems/bundler-site) are now auto-deployed (via Travis)
* Middleman has been updated to latest version
* Every header in the guides and commands pages now has anchor links for navigation and reference
* The site now supports multiple translations (although no translations have been completed yet)

Many thanks to Amy ([@sailorhg](https://github.com/sailorhg)), André ([@indirect](https://github.com/indirect)) and Samuel ([@segiddins](https://github.com/segiddins)). Without their help, it wouldn't have been
possible.

Enjoy :D

~ Jakub ([@kruczjak](https://github.com/kruczjak))
