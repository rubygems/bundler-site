---
title: "January and February Bundler Update"
tags:
author: Stephanie Morillo
---

Welcome to the December 2018 monthly update!

In January, we awarded our [first three-month long project grant](https://rubytogether.org/projects) to David Rodriguez for his work on Bundler and RubyGems. Here’s his first update:

Hello everyone!

This is my first progress report about my collaboration with Ruby Together to improve Bundler’s release process and deprecation management. I feel really proud that I’ve been given this opportunity, and I will do my best to improve the core of the Ruby ecosystem!

I have focused on several things these first two weeks:

I stabilized the builds of both Bundler and RubyGems, by fixing skipped tests and flaky failures to get both CIs consistently green. This should make subsequent improvements easier. In RubyGems, I landed several bug fixes in the install and update commands. With the release of Bundler 2 supporting only RubyGems 3.0, the basic command, “gem install rails”, started failing. We reverted the RubyGems 3.0 requirement in Bundler 2.0.1 to workaround this, but I intend to make `gem install` properly fallback to installing an older version when the `required_rubygems_version` requirement of the latest version is not satisfied. However, I decided to initially focus on some misc bug fixes in the install and update commands, to familiarize with the RubyGems code base and to be able to tackle this improvement with more confidence in the upcoming weeks. Big kudos to RubyGems contributor @MSP-Greg for providing the initial work for some of these fixes!

In Bundler, I started moving forward a new approach for deprecations, which will be enabled by default in the next release. We have a lot of improvements in Bundler’s master, but we haven’t released them for a long time, because they imply breaking changes. By starting to display deprecations for these changes, we’ll be closer to actually being able to release them. I also started addressing some issues surfaced by the Bundler 2 release, specifically about being too picky about the Bundler version a specific application should run. Currently, Bundler will raise if the version in the BUNDLED WITH section of the lock file doesn’t match the running version. We feel it’s premature to do this now, so I’m looking into downgrading this to a warning for the time being. I also coordinated with @colby-swandale the merge of Bundler 2 back into master, which hasn’t yet happened since the Bundler 2 release.

Finally, I’ve dedicated a fair amount of time to review the integration of Bundler into ruby-core since the 2.6 release, and the “gemification” of the standard library. Thanks to @hsbt, this is now a reality, but it comes with its own set of difficulties. I’ve been studying these difficulties and creating some fixes and workarounds for them. I plan to keep working on making this transition as smooth as possible for everyone.

I really hope my work is appreciated by the community and I expect to deliver better and bigger improvements in the upcoming weeks!

Best regards,
David

_This is a combined update for January and February, so here is David’s second update as well:_

Hello everyone!

This is my second report about my collaboration with Rubytogether to improve bundler's release process and deprecation management. They were a couple of exciting weeks, because I now feel I'm closer to being ready to release some of the work I've been doing.

The following is a non extensive list of the stuff I've been focusing on:

* I continued the work on bundler's deprecations. I reviewed each deprecation and made sure the messages are actionable, they show up when they should, and they have passing specs. In particular, I made a plan for the deprecation of the changes that are most likely to be controversial and require special care. For example, I proposed to deprecate sticky options, and custom gemfile sources (such as :github, :gist, or :bitbucket), in a smoother process that should be more friendly to our users because it happens in several steps across multiple major versions. Finally, I made sure that we use non-deprecated features in our own specs, in order to set a good example :)
* In addition to deprecations, I also finished the work that I mentioned in [the previous report]() about only reporting warnings and not hard errors when we find a mismatch between the running bundler version and the version the Gemfile was created with. I hope to release these changes in both rubygems and bundler soon.
* I also continued to improve the integration of bundler into ruby-core. I proposed to [eliminate the `git` dependency from bundler's gemspec](https://github.com/rubygems/bundler/pull/6985) (which has caused problems with the integration), and raised [an issue](https://bugs.ruby-lang.org/issues/15610) with ruby-core about where the default copies of bundler & rubygems should live, and how they should get updated. I'm in touch with hsbt and we plan to discuss the future of this integration some time in the near future.
* Finally, I've been working on making our specs "docker friendly", and making bundler testable under bare docker images of ruby and rvm. My understanding is that this should make it much easier to reproduce CI failures (or user reported bugs), and to detect version manager specific regressions (or ruby-core integration bugs). Besides that, testing on top of custom docker images is something provided built-in by Azure pipelines, so it's a good opportunity to try it.

As I mentioned in the previous report, I'm very glad to be working on bundler during these weeks. Any suggestions or feedback you may have, feel free to share them through Github, Slack or whatever means you like!

See you again soon,
David

In January and February, Bundler gained 110 new commits, contributed by 11 authors. There were 1,401 additions and 1,503 deletions across 849 files.

---

Interested in contributing to Bundler? We always welcome contributions in the forms of triaging bugs, adding new features, writing docs, and engaging with the wider community. Visit the [Bundler Contributor Guidelines](https://github.com/rubygems/rubygems/blob/master/bundler/doc/contributing/README.md) on GitHub to get started. Don’t have time to contribute, but want to support our work? Sign up as a member of [Ruby Together](https://rubytogether.org/) to help fund our work to keep Bundler working for everyone.
