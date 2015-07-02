---
title: Version 1.10 released
date: 2015-06-24 05:36 UTC
tags:
author: André Arko
author_url: http://arko.net
category: release
---

Bundler 1.10 is out! In fact, Bundler 1.10.5 is out today, so we thought it was high time to let everyone know about it. 

This release comes with a bunch of new features: the `lock` command, support for inline gemfiles in scripts, the ability to disable post-install messages, optional groups, conditional gem installation, dramatically improved `outdated` output, and the option to force installed gems to be downloaded and installed again.

[日本語訳 / Japanese translation](http://qiita.com/jnchito/items/a9907114bc56af67d0b0)

### New features

First up, the new `lock` command. Running `bundle lock` will resolve the Gemfile and write a Gemfile.lock, but will not download or install any gems.

Next, for single-file scripts that still depend on gems, a `gemfile` method is provided by `require "bundler/inline"`. This method will not generate a lock, so be careful what gem versions you allow! Check out the [inline docs](https://github.com/bundler/bundler/blob/master/lib/bundler/inline.rb) for details and examples.

Are you tired of being told to HTTParty hard? This option's for you. Run `bundle config ignore_messages.httparty true` to silence HTTParty for good, or run `bundle config ignore_messages true` to turn off all messages forever.

Who needs a jetpack future when you can have optional groups? The long-requested ability to create groups of gems that are not installed by default is finally here. Mark a group as optional using `group :name, optional: true do`, and then opt in to installing an optional group with `bundle install --with name`.

At the same time as adding the long-awaited optional groups, we added groups that can be installed (or not) completely automatically! Provide a lambda or proc to determine if gems in the `install_if` group should be installed, and they will be. Or not. For an example, check out the [Gemfile](/v1.10/man/gemfile.5.html#INSTALL_IF-install_if-) documentation. The idea for this feature came entirely from discussions with [Ruby Together members](https://rubytogether.org/members). If you'd like to see more features like this one, or even suggest some of your own, [join Ruby Together today](https://rubytogether.org/join).

That's not all! There are several more smaller changes, including better support for gems with native extensions on RubyGems 2.2. Check out the full [1.10 changelog](https://github.com/bundler/bundler/blob/1-10-stable/CHANGELOG.md) for the entire list.

### BUNDLED WITH

This release also contains a change that has been somewhat controversial: Bundler 1.10 will add the Bundler version to the `Gemfile.lock`.

While the intended workflow involves only one lock change per Bundler version, the results in real life have been very frustrating. The _extremely_ short explanation is that the problem will disappear once the entire team (rather than only part of the team) upgrades to Bundler 1.9.10 or higher.

Here's the long explanation: Bundler 1.10 adds the BUNDLED WITH section to the lock, while Bundler 1.9 removes it. When a team includes some developers on 1.9 or older, and some developers on 1.10 or higher, it's easy to end up in a situation with commits changing the lock back and forth. The simplest way to stop that problem is to upgrade to 1.10 by running `gem install bundler`. When Bundler 1.10 or higher sees a BUNDLED WITH section, it will leave it in the file.

This change turned out to be a lot more problematic than we were expecting because of the way Spring works. Knowing what I know now, I would have rolled out this change completely differently to reduce this problem, but it's too late for that now. :/ We designed the change to only activate when you run an "install" command, like `bundle install` or `bundle update`. If you just use `bundle exec`, the lock does not change. We didn't count on Spring, which runs `bundle install --local` all the time in the background without notifying users. To stop that from happening, we've released a version of Bundler (1.10.4) that works around Spring.

The last issue is that some developers refuse to upgrade from 1.9 to 1.10, for whatever reason, keeping the problem alive. To address that, we're releasing a final update to 1.9 later today that will simply ignore the BUNDLED WITH section, rather than deleting it.

The reason that we made the change is pretty straightforward: It has been a long-term source of bug reports that users are often on a version of Bundler so old it won't work for a project, but they have no way to tell. We've wanted to fix this by tracking the Bunder version in the lock file since right after 1.0.0 came out. Unfortunately, there was a bug in the 1.0.x lock parser that meant we had to wait until 1.0 fell out of use. We also need to start tracking the Bundler version in the bundle now because we plan to release 2.0 (with big improvements, but breaking some backwards compatibility).

At this point in the explanation, several people have then asked if we could just track the minor version, without the bugfix version. What if it was just 1.10? Would that give most of the benefits without the git churn? Despite this, there are two factors that made us decide to stick with patch level.

First, and most importantly, as soon as everyone is on 1.10+, the churn completely disappears. Version 1.10.1 will not change a lock that says it was bundled with 1.10.3. The absolute worst case once everyone has upgraded to Bundler 1.9.10 or higher is a single commit per version of Bundler, followed by no git churn.

Second, Bundler patch level releases definitely fix bugs, and oftentimes those bugs are big enough to break `bundle install` for certain subsets of users. Only tracking minor version would be similar to only tracking the minor version of Rails—it’s not really feasible to say “oh, you can use any 4.2.x version of Rails”, because the x allows security holes, breaking bugs, and other problems.

So, in conclusion, the change was never intended to be this disruptive, we're doing what we can to reduce the impact, and the problem should be completely resolved by updating Bundler to 1.10 (or even the latest 1.9 release, if some of your team want to stay on 1.9).

Thanks for the feedback, everyone!
