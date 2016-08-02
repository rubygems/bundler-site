---
title: bundle show
description: Shows all gems that are part of the bundle, or the path to a given gem
---

## bundle show

Shows all gems that are part of the bundle, or the path to a given gem

    $ bundle show [GEM] [--paths]

Options:

<code>--paths</code>: List the paths of all gems that are required by your Gemfile.

Show lists the names and versions of all gems that are required by your Gemfile.
Calling show with [GEM] will list the exact location of that gem on your machine.
