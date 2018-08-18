---
title: How to use Bundler with Docker
---

# How to use Bundler with Docker

## Introduction 

If you have tried to bundle an application in Docker with Bundler v1.16 or earlier, you may run into issues with explicitly setting `GEM_HOME`, `BUNDLE_BIN`, `BUNDLE_PATH`, and with adding the `BUNDLE_BIN` to the `PATH` in your Dockerfile similar to this:

```
ENV GEM_HOME="/usr/local/bundle"
ENV BUNDLE_PATH="$GEM_HOME"
ENV BUNDLE_BIN="$GEM_HOME/bin"
ENV PATH="$BUNDLE_BIN:$PATH"
```

This is due to Docker treating Bundler binstubs as if they were RubyGems binstubs, which results in Bundler first creating RubyGems binstubs at `$BUNDLE_PATH/bin` and then overwriting those generic binstubs with application-locked Bundler binstubs (available in Bundler v1.16). 

## How to fix the issue

First, unset `BUNDLE_PATH` and `BUNDLE_BIN`, and change the `PATH` to use `$GEM_HOME/bin` in your Dockerfile:

```
ENV GEM_HOME="/usr/local/bundle"
ENV PATH $GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH
```

This will create the original generic RubyGems binstubs in `$GEM_HOME/bin`. (You will still be able to use gem commands like rake directly if there's only one version of the gem installed.) 

If more than one version of a gem is installed, or if you want to use the application/Gemfile-specified version of a gem, run `bundle exec <gem name>`.