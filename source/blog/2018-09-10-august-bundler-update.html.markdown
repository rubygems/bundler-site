---
title: "August 2018 Bundler Update"
tags:
author: Stephanie Morillo
author_url: http://www.stephaniemorillo.co
---

Welcome to the August monthly update!

With the help of [@eanlain](https://github.com/eanlain), we shipped a new guide: [“How to use Bundler with Docker”](https://bundler.io/guides/bundler_docker_guide.html). We also dramatically improved error messages when version requirements conflict, shipped a playbook for adding or removing core team members, and fixed some issues handling gemspecs with non-ASCII characters. We also merged a fix that could cause Bundler to [fail when trying to install a gem that has had a version yanked recently](https://github.com/rubygems/bundler/pull/6675).

On top of that code work, we also added two new contributors to [the Bundler team](https://bundler.io/contributors.html)! Welcome to [Stephanie Morillo](https://www.twitter.com/radiomorillo) and [Grey Baker](https://twitter.com/greybaker).

Stephanie has helped create new Bundler docs (like the troubleshooting RubyGems and Bundler TLS/SSL issues guide), and update existing ones. She’s also responsible for updating the Bundler contributor guidelines and trying to make Bundler docs more accessible to new contributors. We're excited to have her on board, and looking forward to working with her more in the future.

Grey is the author of [Dependabot](https://dependabot.com), and has regularly contributed to [Molinillo](https://github.com/cocoapods/molinillo), the core resolver library that powers Bundler, RubyGems, and Cocoapods.

In total this month, Bundler gained 58 new commits, contributed by 10 authors. There were 334 additions and 54 deletions across 30 files.

Interested in contributing to Bundler? We always welcome contributions in the forms of triaging bugs, adding new features, writing docs, and engaging with the wider community. Visit the [Bundler Contributor Guidelines](https://github.com/rubygems/rubygems/blob/master/bundler/doc/contributing/README.md) on GitHub to get started. Don't have time to contribute, but want to support our work? Sign up as a member of [Ruby Together](https://rubytogether.org) to help fund our work to keep Bundler working for everyone.