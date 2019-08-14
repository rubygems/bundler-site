
# Bundler Metrics

Recently, a metric collection and reporting system for Bundler [has been introduced](https://github.com/bundler/bundler/pull/7298).

Let's start with a TL;DR - **No personally identifying information is collected** (aside from your **hashed** remote git repo).
The data is reported **only to the rubygems.org servers**.

We collect this information for various reasons, such as:

- Making decisions about future deprecations and feature additions
- Building a public dashboard of the Ruby ecosystem
and more!

We care about your privacy and would never compromise it.
Read on to learn about the information we collect and how to opt out of metric collection.

## What information we collect

### For all commands used

Command used
Options if specified
Time taken to perform the command
Timestamp

### For install/outdated/package/update/pristine

The prior, and-
A randomized hex ID
Remote git repository (hashed)
git version
rvm version
rbenv version
chruby version
Host system details
Ruby version
Bundler version
Rubygems version
Ruby engine
CI’s
Extra user agent strings
Gemfile gem count
Actually installed gem count
git gem count
Path gem count
Gem source count
List of gem sources (hashed)
Gem download time
Gem installation time
Gemfile resolve time
Name and version of the gem that failed to install, if such exists.

### How to opt out of metric collection

Using `bundle config set disable_metrics true` sets the setting in the Bundler global config file.
if `disable_metrics` is set to true in the config, no metric related operation will be done.

You can opt back in by using `bundle config set disable_metrics false`.

If `disable_metrics` is not set in the global config file, Bundler will behave as if `disable_metrics` is set to `false`.
