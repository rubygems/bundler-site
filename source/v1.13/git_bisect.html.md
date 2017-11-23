---
title: How to git bisect in projects using Bundler
---

## How to git bisect in projects using Bundler

A few things that may not be obvious are needed for `git bisect` to work
in a project that uses Bundler.

1. The `Gemfile.lock` needs to be in the git repo, so that each commit
will load the same dependencies every time.
1. Each step during the bisect needs to run `bundle install` first, so
that the correct dependencies are installed and available to be loaded.
1. After determining if the commit is good or bad, each step needs to
`git reset`. If `bundle install` or running the test can cause changes
on the file system, which would prevent `git checkout` of the next commit
to test if they are not reset.

Here's a minimal example script that runs the rake task `spec`:

~~~ bash
#!/usr/bin/env bash
bundle install
bin/rake spec
status=$?
git reset --hard HEAD
exit $status
~~~

See also the discussion at [bundler/bundler#3726](https://github.com/bundler/bundler/issues/3726).