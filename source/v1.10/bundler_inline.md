---
title: bundler/inline
---

## bundler/inline

> Allows for declaring a Gemfile inline in a ruby script, optionally installing
any gems that aren't already installed on the user's system.

<aside class="notes" markdown="1">
**Note:** Every gem that is specified in this 'Gemfile' will be
`require`'d, as if the user had manually called
`Bundler.require`. To avoid a requested gem being automatically
required, add the `require => false` option to the
`gem` dependency declaration.
</aside>

`install [Boolean]`: Whether gems that aren't already installed on the user's
system should be installed. Defaults to `false`.

`gemfile [Proc]`: A block that is evaluated as a `Gemfile`.

### Using an inline Gemfile

To use a `Gemfile` inline in your script, first `require 'bundler/inline'`.
Then in the `gemfile` block, declare your source and gems as you would in a
normal `Gemfile`.

~~~ ruby
#!/usr/bin/env ruby

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'json', require: false
  gem 'nap', require: 'rest'
  gem 'cocoapods', '~> 0.34.1'
end

puts Pod::VERSION => "0.34.4"
~~~
