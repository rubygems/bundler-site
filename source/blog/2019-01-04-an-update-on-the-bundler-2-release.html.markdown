---
title: "An update on the Bundler 2 release"
tags:
author: Colby Swandale
category: release
---

Yesterday I released Bundler 2.0 that introduced a number of breaking changes. One of the those changes was setting Bundler to require RubyGems v3.0.0. After making the release, it has become clear that lots of our users are running into issues with Bundler 2 requiring a really new version of RubyGems.

We have been listening closely to feedback from users and have decided to relax the RubyGems requirement to v2.5.0 at minimum. We have released a new Bundler version, v2.0.1, that adjusts this requirement.

I apologise to our users for the disruption this has caused.

### Important Note

Bundler 2 introduced a new feature that will automatically switch between Bundler v1 and v2 based on the lockfile. This feature is enabled by RubyGems (only on versions 2.7.0+) which unfortunately has a bug when you run Bundler without the appropriate version installed. You may encounter an error message like:

    Can't find gem bundler (>= 0.a) with executable bundle (Gem::GemNotFoundException)

If you do, it can be fixed by installing the version of Bundler that is declared in the lockfile.

    $ cat Gemfile.lock | grep -A 1 "BUNDLED WITH"
    BUNDLED WITH
       1.17.3

    $ gem install bundler -v '1.17.3'

This bug was fixed in RubyGems 3.0.0 but backports are now being prepared for previous major versions of RubyGems. We'll let you know when they become available.

---

- Colby and the Bundler team
