---
title: Bundler Compatibility
---

## Bundler compatibility with Ruby

#### Ruby 2.0

Requires Bundler 1.3 or greater.

#### Ruby 1.9

Requires Bundler 1.0.10 or greater. Ruby **1.9.1** is not supported.

Bundler **1.0** requires a minimum Ruby version of **1.8.7**.


## Bundler compatibility with RubyGems

#### RubyGems 2.2
1. Requires at least Bundler 1.3.0.
2. Installing gems with C extensions using sudo requires Bundler 1.6.1 or higher.

#### RubyGems 2.0

1. Requires at least Bundler version 1.3.0.
2. Users of RubyGems 2.0.2 and Bundler 1.3.0-1.3.3 may encounter exceptions while running install or update, and should upgrade either Bundler or RubyGems to a newer version.

#### RubyGems 1.8

1. Requires Bundler version 1.0.14.

2. Users with RubyGems 1.8.0-1.8.2 may encounter exceptions running `rake`.
They should use `bundle exec rake` instead.

#### RubyGems 1.6 and 1.7

1. Requires Bundler version 1.0.11.

#### RubyGems 1.5

Requires Bundler version 1.0.10.

#### RubyGems 1.3 and 1.4.

1. Requires Bundler version 1.0.
On RubyGems 1.3, Bundler may be unable to find prerelease gems cached via the `bundle pack` command.

Bundler **1.0** requires a minimum RubyGems version of **1.3.6**.
