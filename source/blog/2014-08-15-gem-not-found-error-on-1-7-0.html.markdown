---
title: Gem not found error on 1.7.0
date: 2014-08-15 17:02 UTC
author: André Arko
author_url: "http://arko.net"
category: announcement
---
After the release of Bundler 1.7.0 yesterday, we discovered a bug that can cause Bundler to report that a gem was not found, even though that gem is available from one of the relevant sources. We're understand the problem, and we're working on a fix as fast as we can. In the meantime, it's possible to work completely around the problem by adding the `--full-index` option when you run `bundle install`. I fully recognize that it sucks to have a regression in a security update, and I'm sorry that this happened. I can't guarantee something like this well never happen again, but we're adding tests to prevent this particular bug from recurring.

Sorry it's broken; we're working on fixing it. In the meantime, please work around the issue with `bundle install --full-index`.
