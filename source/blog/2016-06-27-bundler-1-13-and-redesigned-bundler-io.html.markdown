---
title: Bundler 1.13 and Redesigned bundler.io
date: 2016-06-27 21:44 UTC
tags:
author: xxxx
author_url: xxxx
category: release
---

## Bundler v1.13

## Redesigned **bundler.io**

Most visible change is completely redesigned page with new styles and graphics. Now it’s responsive and adjusted also for mobile devices using [Bootstrap framework](http://getbootstrap.com/).

The [Docs page](/docs.html) allows you to choose between guide, command reference or versions' changelog. After choosing one of commands (e.g. [bundle install](/v1.13/man/bundle-install.1.html)), there
is a new sidebar, making navigation between other commands and versions easier.

There are also two new guides: [`Using Bundler In Application`](/guides/using_bundler_in_application.html) written by Jakub ([@kruczjak](https://github.com/kruczjak)) and [`Developing a RubyGem using
Bundler`](/guides/using_bundler_in_application.html) by Ryan ([@radar](https://github.com/radar)).

More improvements:

* Man pages from Bundler repository instead of hand-written commands pages (where possible)
* Commit to master branch in [bundler-site repository](https://github.com/bundler/bundler-site) causes auto-deploy of the newest page version (via Travis)
* Middleman updated to latest version
* Added anchor links in guides and commands docs for faster navigation
* [WIP] Started work on translations

Many thanks to Amy ([@sailorhg](https://github.com/sailorhg)), Andre ([@indirect](https://github.com/indirect)) and Samuel ([@segiddins](https://github.com/segiddins)). Without their help, it wouldn't be
possible.

Enjoy :D

~ Jakub ([@kruczjak](https://github.com/kruczjak))
