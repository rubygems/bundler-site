---
title: What's New in v1.5
date: 2014/01/01
draft: false
author: André Arko
author_url: http://arko.net
category: release
---

Some re-write of the previous changelog to something a little more conversational. Perhaps listing a couple [high level](#) [new features](#) and explaining in a little greater detail the direction we're heading with [this feature](#). Then ending on a cheeky joke finished with a hat tip towards [v1.6](#).

##### [Changelog](https://github.com/bundler/bundler/blob/1-5-stable/CHANGELOG.md) | [Rubygems](https://rubygems.org/gems/bundler/versions/1.6.0.pre.1) | [Etc...](https://github.com/bundler/bundler/blob/1-5-stable/CHANGELOG.md)

### [Parallel Install](/bundle_install.html#jobs)

The `--jobs` option (`-j` for short) installs gems in parallel. For example, `bundle install -j4` will use 4 workers. We've seen speedups of 40-60% on fresh bundle installs. To always install in parallel, run `bundle config --global jobs 4` or set `BUNDLE_JOBS`.

### [Source Mirrors](/bundle_config.html#gem-source-mirrors)

Bundler now supports the ability to use a gem mirror in a Gemfile locally by using bundle config. 

```
bundle config mirror.https://rubygems.org https://localgems.lan
```

### [Ruby Directive](/gemfile_ruby.html#patchlevel)

The ruby DSL now takes a `:patchlevel` option for locking to specific patchlevels of ruby like `ruby '2.0.0', :patchlevel => '247'`

### [Outdated `--strict`](/bundle_outdated.html#strict)

`bundle outdated --strict` displays outdated gems that match the dependency requirements.

### [Retry](/bundle_install.html#retry)

bundle install now retries failed downloads. You can adjust the number of retries with the `--retry` option.

### Also included:

- many smaller performance improvements to make resolving and installing faster
- cyclic dependency detection, to avoid infinite loops
- multiple arguments to the bundle binstubs command
- a bundler command in case you typo bundle
- uses RUBYLIB for better compatibility with Windows