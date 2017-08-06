---
title: "Bundler 1.15: Bundle Oh So Fast"
date: 2017-05-19 12:00 UTC
tags:
author: Samuel Giddins
author_url: http://segiddins.me
category: release
---

# What’s new in Bundler 1.15?

Hot on the heels of the many small fixes in Bundler 1.14, we're pushing out 1.15. The list of changes is much shorter, but we think you're going to love it all the same, since this time around we've focused on making Bundler a whole heck of a lot faster.

### Speed

Due to [Julian Nadeau](https://github.com/jules2689)'s prompting, we've made loading up Bundler fast. Up to a half a second faster than before, on every `bundle exec`, `require "bundler/setup"`, `Bundler.setup`, and `Bundler.require`. This is going to save developers a lot of time, given how often we tend to run things!

The mere act of initializing a Gemfile has been sped up by turning array lookups into hash table accesses, making expensive comparisons lazy, and generally avoiding object allocation.

We also now only validate git gems when they are first downloaded & installed, meaning projects with many git gems won't be validating each and every one of them over and over again.

Finally, we've managed to avoid evaluating the full `.gemspec` of all the gems that are being loaded when running on RubyGems 2.5 and above. Taking advantage of a feature called stub specifications, Bundler is able to grab all of the information it needs from the first two lines of a serialized gemspec file, without evaluating the rest. This represents a massive time savings for very large Gemfiles.

### New Commands

We've added 4 new commands that have been on our wish list for a long time.

#### `bundle info`

This command prints out basic information about the given gem, and is intended to replace `bundle show` once Bundler 2 rolls around.

#### `bundle issue`

Have you ever been frustrated by a Bundler issue that wasn't a crash? Have you found it difficult to figure out what information to put in a new GitHub issue? Well, no more! `bundle issue` will gather all of the information present in the error template, on demand.

#### `bundle add`

Bundler has long included the `bundle inject` command, which has been a source of some confusion. `inject` has always been intended to serve as plumbing for other tooling, doing a whole bunch of verification along with adding a new `gem` line to the Gemfile. Due to popular demand, we've extracted that latter part out into the `bundle add` command, making it easier than ever to automate adding dependencies to your Gemfile.

#### `bundle pristine`

Have you ever accidentally edited an installed gem's files and wished you had a way to undo that? Mirroring the `gem pristine` command, Bundler now supports `bundle pristine`, restoring all of the gems in your Gemfile to pristine condition.

### More Man Pages

Documentation improvements are amongst my favorite contributions, and [Liz Abinate](https://github.com/feministy) came through big for us this release. We now have man pages for every single Bundler command. This means that bundler.io will _also_ have documentation for all of the Bundler commands. We hope to do a better job of keeping our documentation up-to-date in the future, and this release is a great starting point for that effort.

### Various improvements

In addition to those larger additions, we made some smaller tweaks with the aim of smoothing and improving the overall experience of using Bundler:

- `bundle update` will now print gems whose versions are regressing in yellow.
- `bundle inject` has gained `--source` and `--group` options.
- `bundle config` has a `--parseable` option, suitable for use in scripts.
- Resolver version conflicts will only list relevant dependencies.
- When installing a gem fails, Bundler will print out the reason why that gem was being installed in the first place.
- Bundler will let you know when a new version of itself is available. How meta.
- `bundle update` works a lot better now when only unlocking a single gem.

We also fixed over 20 separate bugs, and you can read about every single one of them [in the Bundler 1.15 changelog](https://github.com/bundler/bundler/blob/1-15-stable/CHANGELOG.md).

### How To Upgrade

Run `gem install bundler` to upgrade to the newest version of Bundler.
