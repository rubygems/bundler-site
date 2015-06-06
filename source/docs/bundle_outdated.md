## bundle outdated

List installed gems with newer versions available.

``` bash
$ bundle outdated [GEM] [--local] [--pre] [--source] [--strict]
```

**Options:**

`--local`: Do not attempt to fetch gems remotely and use the gem cache instead.

`--pre`: Check for newer pre-release gems.

`--source`: Check against a specific source.

`--strict`: Display outdated gems that match the dependency requirements.

`outdated` lists the names and versions of gems that have a newer version available
in the given source. Calling outdated with [GEM [GEM]] will only check for newer
versions of the given gems. By default, available prerelease gems will be ignored.

