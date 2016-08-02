---
title: bundle outdated
description: List installed gems with newer versions available
---

## bundle outdated

List installed gems with newer versions available

    $ bundle outdated [GEM] [--local] [--pre] [--source] [--strict]
    
Options:

<code>--local</code>: Do not attempt to fetch gems remotely and use the gem cache instead

<code>--pre</code>: Check for newer pre-release gems

<code>--source</code>: Check against a specific source

<code>--strict</code>: Display outdated gems that match the dependency requirements.

Outdated lists the names and versions of gems that have a newer version available
in the given source. Calling outdated with [GEM [GEM]] will only check for newer
versions of the given gems. By default, available prerelease gems will be ignored.
