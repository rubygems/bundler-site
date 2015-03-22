---
title: The rumors of Bundler's death have been greatly exaggerated
date: 2013/12/07
draft: false
author: André Arko
author_url: http://arko.net
category: annoucement
---

So this week there was some excitement on [Github](#), [Hacker News](#), and [Ruby Weekly](#) about the news that Bundler will (eventually) be merged into RubyGems. Before that comment, which was a side point on a different topic, the idea of merging the two projects had not been announced or explained. As lead of the Bundler project, I'd like to explain the merger plan, such as it is, and the reasoning behind it.

The underlying motivation is simple: RubyGems and Bundler do a lot of the same things. Installing gems, downloading gems, resolving dependencies, and the like. It's a pretty long list of duplicated functionality. Since the RubyGems team now values many features that started in Bundler, they are also adding them, leading to even more duplicated functionality.

During RubyConf this year in Miami, the Bundler team (represented by Terence Lee and myself) and the RubyGems team (represented by Eric Hodel and Evan Phoenix) met to talk about the increasing duplication. In that meeting, we agreed it made sense to decrease the duplication by merging the RubyGems and Bundler projects into one codebase and one team. Eventually. One day.

But not yet! Because still there's a lot of stuff going on. Bundler and RubyGems already have separate feature road maps for the next 6 months, including things like parallel installation of gems and the new, more efficient index format that I talked about in my [talk at RubyConf](#). As a result of those plans, the merger work of combining code, tests, teams, and policies is not expected to be done for a year or even two years. At the earliest.

While we're talking about potential changes that are this big, I'd also like to make a point about what this means for Bundler. The Bundler team has taken great pains over the years so that Bundler can be stable, reliable, and dependable. We have also gone out of our way to conform strictly to semantic versioning. This has all been for a simple reason: trust. We want you to be able to trust Bundler. To keep that trust, we are willing to make changes much more slowly and cautiously than many other projects. While we all agree that reducing duplicate work is good, keeping Bundler trustworthy is an even higher priority than combining our work.

Even with the plan to eventually merge projects, Bundler will continue to adhere to semantic versioning. We will continue to run the exhaustive Bundler integration RSpec suite. We will continue working just as hard to make sure Bundler updates are reliable and useful to the entire Ruby community. While everyone involved agrees this merger seems good, it also involves a huge amount of work. At a minimum, we need a unified release process and a functional single codebase, but we haven't even started working on either of those yet!

In the meantime, we are enjoying higher cooperation than ever before between the RubyGems and Bundler projects. We are deliberately sharing both server-side and client-side code for the new index format. The RubyGems team has said they will begin using Bundler's integration tests along side their unit tests.

I'm excited about the idea of sharing work between both projects and eliminating duplicated code. We have a common goal of streamlining and simplifying the work of using gems for everyone in Ruby. Even though we aren't working on merging projects yet, keep an eye out for releases of both Bundler and RubyGems that showcase the work we are cooperating to do together.

And we will be happy to announce the merger once it has happened.
