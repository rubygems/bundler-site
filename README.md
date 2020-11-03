# bundler.io
bundler.io is intended to serve as a convenient source for documentation on the [bundler](https://github.com/rubygems/rubygems) gem.

The site bundler.io is a static site generated using [Middleman](http://middlemanapp.com/).

[Bundler's manual pages](https://github.com/rubygems/rubygems/tree/master/bundler/man) document much of its functionality and serve as an important part of the site. They are included via the **Rakefile**.

## Development Set Up

Begin by cloning the repository onto your location machine:

    git clone https://github.com/rubygems/bundler-site.git

Once complete prepare the dependencies by running:

    bundle install

### If you have trouble installing the `middleman-search` gem

`middleman-search` depends on the deprecated gem `therubyracer`, which depends
on an obsolete version of `libv8`. They can be difficult to install.

```
gem install libv8 -v '3.16.14.19' -- --with-system-v8
gem install therubyracer -v '0.12.3' --source 'https://rubygems.org/' -- --with-v8-dir=/usr/local/opt/v8@3.15
```

For further discussion, see https://gist.github.com/fernandoaleman/868b64cd60ab2d51ab24e7bf384da1ca

There is an open PR to fix `middleman-search`:
https://github.com/manastech/middleman-search/issues/18

## Basic Middleman Commands

Fetch latest documentation from bundler repo (should be done before running local development web server):

    rake man

Run a local development web server:

    bundle exec middleman server

This will start a local web server running at: *http://localhost:4567*. It will serve the site as it exists in **/source**.

To specify the host and/or port, add the -h, -p flag(s):

    bundle exec middleman -h 0.0.0.0 -p 8080

Note: the development server will automatically reload pages when they or there associated stylesheets are modified. This feature is enabled in **config.rb**.

Build the site:

    bundle exec middleman build

This will use the files in **/source** to generate a static site in **/build**.
