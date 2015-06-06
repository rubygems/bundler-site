## bundle platform

Displays platform compatibility information.

``` bash
$ bundle platform [--ruby]
```

**Options:**

`--ruby`: Only display ruby related platform information.

When not passed any options, platform will display information from your `Gemfile`, `Gemfile.lock`, and Ruby VM about your platform. You'll see output like the following:

``` bash
$ bundle platform
Your platform is: x86_64-linux

Your app has gems that work on these platforms:
* ruby

Your Gemfile specifies a Ruby version requirement:
* ruby 1.9.3

Your current platform satisfies the Ruby version requirement.
```

When the `ruby` directive doesn't match the running Ruby VM, it will tell you what part does not.

``` bash
Your Ruby version is 1.9.3, but your Gemfile specified 1.8.7
```

When using the `--ruby` flag, it will just display the `ruby` directive information, so you don't have to parse it from the `Gemfile`.

``` bash
$ bundle platform --ruby
ruby 1.9.3 (jruby 1.6.7)
```

