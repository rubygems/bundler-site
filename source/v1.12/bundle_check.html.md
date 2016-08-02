---
title: bundle check
description: Checks if the dependencies listed in Gemfile are satisfied by currently installed gems
---

## bundle check

Checks if the dependencies listed in Gemfile are satisfied by currently installed gems

    $ bundle check [--dry-run] [--gemfile=FILE] [--path=PATH]

Options:

<code>--dry-run</code>: Locks the Gemfile.

<code>--gemfile</code>: Use the specified gemfile instead of Gemfile.

<code>--path</code>: Specify a different path than the system default
($BUNDLE_PATH or $GEM_HOME). Bundler will remember this value for future
installs on this machine.

Check searches the local machine for each of the gems requested in the Gemfile. If
all gems are found, Bundler prints a success message and exits with a status of 0.
If not, the first missing gem is listed and Bundler exits status 1.
