---
title: bundler/inline
---

## bundler/inline

Allows for declaring a Gemfile inline in a ruby script, optionally installing
any gems that aren't already installed on the user's system.

<aside class="notes">
  <p>
    <b>Note:</b> Every gem that is specified in this 'Gemfile' will be
    <code>require</code>'d, as if the user had manually called
    <code>Bundler.require</code>. To avoid a requested gem being automatically
    required, add the <code>require => false</code> option to the
    <code>gem</code> dependency declaration.
  </p>
</aside>

`install [Boolean]`: Whether gems that aren't already installed on the user's system should be installed. Defaults to `false`.

`gemfile [Proc]`: A block that is evaluated as a `Gemfile`.

## Using an inline Gemfile

To use a `Gemfile` inline in your script, first `require 'bundler/inline'`. Then in the `gemfile` block, declare your source and gems as you would in a normal `Gemfile`.

``` ruby
#!/usr/bin/env ruby

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'json', require: false
  gem 'nap', require: 'rest'
  gem 'cocoapods', '~> 0.34.1'
end

puts Pod::VERSION => "0.34.4"
```
