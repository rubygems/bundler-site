---
title: Version 1.11 released
date: 2015-12-12 19:00 UTC
tags:
author: Samuel Giddins
author_url: http://segiddins.me
category: release
---

Bundler 1.11 is here! Six and a half months after the last big release, we're
finally ready to ship 1.11.

I know it's been a while, but there's a pretty good reason for that. Over the
summer, the team was busy supervising _four_ Google Summer of Code students:

 - We made a significant amount of progress on the new compact gem index, which
   ought to ship in 1.12 in the near future.
 - We improved the Bundler website and online documentation.
 - We've created a solid base for Bundler 2.0.
 - We prototyped a new plugin system.

In addition, the Bundler Core team has spent a lot of time focusing on the
development experience of bundler itself. The bundler codebase is over five
years old, and contains code from over 400 contributors. That can make it
rather daunting to start contributing, and also makes it hard to ensure that
all of the code in bundler is up to the same standards (and is fit to last for
the next five years!). In order to make things more consistent, we've
introduced RuboCop (and thus a style guide), we've instituted a build bot to
ensure that `master` is never failing, and have decided to subject 100% of the
new code introduced to code review. This is a big step forward, and lets me
confidently say that this will be our best release yet!

That out of the way, what's actually in this long-awaited release?

### New features

First up, we've combed through a few years worth of bundler issues, and have
improved the error messaging for every single one of them. Our goal is to never
show an exception with a backtrace, and instead present a friendly and helpful
error message when things go awry -- and we're now pretty close to that.

The dependency resolver has also seen a few updates. Continuing the theme of
improved errors, version conflicts will now do a better job of reporting what
versions of every gem have been activated, making it even easier to figure out
the best way to resolve said conflict. Additionally, resolution has been sped up
by over 25x in pathological cases. That's a pretty nice win.

Finally, we've laid the groundwork for resolving gems based on the current
version of Ruby.  Once the new index is rolled out, Bundler will make sure to
choose gems whose `required_ruby_version` matches the Ruby you are running on.

### Bugfixes

The real meat of this release comes in the bugfix section, however. Across
almost four hundred commits, we've squashed upwards of fifty unique bugs.
Meaning this version of bundler should be the fastest, most stable version we've
ever released.

### What's Next

As I mentioned earlier, this long gap between releases doesn't mean we're
slowing down development -- quite the opposite, in fact! We're actively working
on bundler 1.12 and 2.0 _at this very moment_, and are incredibly exited to get
the new index into people's hands as fast as we possibly can.

#### Updating

To install the last release of Bundler, you can run:

```
$ [sudo] gem install bundler
```

For all the details, don’t miss the
[Changelog](https://github.com/bundler/bundler/blob/v1.11.0/CHANGELOG.md#1110-2015-12-12)!
