---
title: "An Update on Bundler 2.0"
tags:
author: Colby Swandale & André Arko
category: release
---

For the past few years the Bundler core team has been working hard on a major release of Bundler. We've been solving problems that users have seen since Bundler 1.0 first came out, but weren't able to release without breaking changes. At the same time, we've spent a lot of time thinking about how to release a new major version with as little breakage and as few surprises as possible. We've come up with a system that allows everyone to use multiple major versions of Bundler at the same time, and we think that system will make future breaking changes much easier to handle.

However, this post isn't about that system. This post is about a new plan for Bundler releases, dropping support for old Rubies, and how long we will support old Rubies and RubyGems in the future. Every version of Bundler in existence fully supports Ruby 1.8.6+ and RubyGems 1.3.6+. Maintaining that support is a burden not just on the Bundler team, but has become a blocker for the ruby-core team to accept Bundler into Ruby itself. The ruby-core team only has the resources to maintain three minor versions at a time: the current release, the previous release, and security patches for the next oldest release.

To refocus the efforts of the Bundler team on useful work, and make it easier to integrate Bundler into Ruby itself, we are adopting a similar support policy to Ruby: each year, we plan to release a new version of Bundler that drops support for any Ruby that is no longer supported. We plan to issue bugfixes as needed for each previous major version of Bundler, and if security patches are needed we will try to issue releases for the previous two major versions.

With that in mind, today we are announcing a new Bundler 2.0.0 release. It should not break anyone's workflows, and only contains changes that are "breaking" in a very strict and technical sense of the word. This is an exhaustive list of the changes from Bundler 1.17 to Bundler 2.0:

- Dropped support for end of lifed Ruby versions 1.8.7 through 2.2
- Dropped support for end of lifed RubyGems versions 1.3.6 through 2.5
- Moved error messages from STDOUT to STDERR

To be extremely clear: **all applications and Gemfiles that currently work with Bundler 1 will continue to work with Bundler 2**. You will not be able to upgrade to Bundler 2 if you are using an older version of Ruby or RubyGems that has been end-of-lifed and is no longer supported. We will support Bundler 1.17 with bugfixes for about one year, and stop supporting Bundler 1.17 when we release Bundler 3.

In future releases of Bundler, we hope to schedule future breaking changes with a one-year deprecation warning period, while listening to user feedback and doing everything that we can to keep existing applications from breaking. Keep an eye on [@bundlerio](https://twitter.com/bundlerio) or [the Bundler blog](https://bundler.io/blog) to hear more about the future of Bundler as we figure things out.

As always, if you have problems or feedback, we want to hear from you! Head over to the [Bundler issue tracker](https://github.com/rubygems/rubygems/issues) and let us know.
