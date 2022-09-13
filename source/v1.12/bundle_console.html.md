---
title: bundle console
description: Start an interactive Ruby console session in the context of the current bundle
---

# bundle console

Start an interactive Ruby console session in the context of the current bundle

    $ bundle console [GROUP]

<code>bundle console</code> uses irb by default. Alternatives like Pry and Ripl can be used with bundle console by adjusting the <code>console</code> Bundler setting. Also make sure that <code>pry</code> or <code>ripl</code> is in your Gemfile.

    $ bundle config console pry
    $ bundle console
    [1] pry(main)>
