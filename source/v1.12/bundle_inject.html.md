---
title: bundle inject
description: Add the named gem(s), with version requirements, to the resolved Gemfile
---

## bundle inject

Add the named gem(s), with version requirements, to the resolved Gemfile

    $ bundle inject [GEM] [VERSION]

When injecting a gem, it adds it to both your Gemfile and Gemfile.lock if
it doesn't yet exist in them. Example below:

    $ bundle install

    $ bundle inject 'rack' '> 0'
    # Injects rack gem greater than version 0 in your Gemfile and Gemfile.lock
