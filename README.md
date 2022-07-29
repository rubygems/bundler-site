# bundler.io

[![Middleman deploy](https://github.com/rubygems/bundler-site/actions/workflows/deploy.yml/badge.svg)](https://github.com/rubygems/bundler-site/deployments/activity_log?environment=github-pages)

bundler.io is intended to serve as a convenient source for documentation on the [bundler](https://github.com/rubygems/rubygems) gem.

The site bundler.io is a static site generated using [Middleman](http://middlemanapp.com/).

[Bundler's manual pages](https://github.com/rubygems/rubygems/tree/master/bundler/lib/bundler/man) document much of its functionality and serve as an important part of the site. They are included via the **Rakefile**.

## Development Set Up

Begin by cloning the repository onto your location machine:

    git clone https://github.com/rubygems/bundler-site.git

Once complete prepare the dependencies by running:

    bundle install
    npm install

Or you can prepare a development environment on Gitpod cloud from the below link:

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/rubygems/bundler-site)

## Basic Middleman Commands

Fetch latest documentation from bundler repo (should be done before running local development web server):

    bundle exec rake man

Run a local development web server:

    bundle exec middleman server

This will start a local web server running at: *http://localhost:4567*. It will serve the site as it exists in **/source**.

To specify the host and/or port, add the --bind-address, -p flag(s):

    bundle exec middleman --bind-address 0.0.0.0 -p 8080

Note: the development server will automatically reload pages when they or there associated stylesheets are modified. This feature is enabled in **config.rb**.

Build the site:

    bundle exec middleman build

This will use the files in **/source** to generate a static site in **/build**.
