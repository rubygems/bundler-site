---
title: Using Bundler with RubyMotion
---

## Using Bundler with RubyMotion

If you don't have a RubyMotion app yet, generate one.

``` bash
$ motion create myapp
$ cd myapp
```

You'll need to create a Gemfile. Here we're using bubblewrap.

``` ruby
gem 'bubble-wrap'
```

Then, set up your Rakefile to require your bundled gems at compile time.
Add this to the top of the file, right beneath the line `require 'motion/project'`

``` ruby
require 'bundler'

Bundler.require
```

Next, install your dependencies:

``` bash
$ bundle install
```

Now you can just compile your app as normal.

``` bash
$ bundle exec rake

