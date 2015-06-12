---
title: bundle binstubs
---

## bundle binstubs

> Installs the binstubs of the listed gem.

```
$ bundle binstubs [GEM] [--force] [--path=PATH]
```

**Options:**

`--force`: Overwrite existing binstubs if they exist.

`--path`: Binstub destination directory (default bin)

Generate binstubs for executables in [GEM]. Binstubs are put into bin, or the
`--binstubs` directory if one has been set.
