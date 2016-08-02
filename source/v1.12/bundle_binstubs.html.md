---
title: bundle binstubs
description: Installs the binstubs of the listed gem
---

## bundle binstubs

Installs the binstubs of the listed gem

    $ bundle binstubs [GEM] [--force] [--path=PATH]

Options:

<code>--force</code>: Overwrite existing binstubs if they exist.

<code>--path</code>: Binstub destination directory (default bin)

Generate binstubs for executables in [GEM]. Binstubs are put into bin,
or the --binstubs directory if one has been set.
