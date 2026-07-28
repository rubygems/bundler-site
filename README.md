# bundler.io

[![Middleman deploy](https://github.com/rubygems/bundler-site/actions/workflows/deploy.yml/badge.svg)](https://github.com/rubygems/bundler-site/deployments/activity_log?environment=github-pages)

bundler.io is intended to serve as a convenient source for documentation on the [bundler](https://github.com/ruby/rubygems) gem.

The site bundler.io is a static site generated using [Middleman](http://middlemanapp.com/).

Bundler's manual pages moved to the [command reference on the RubyGems guides](https://guides.rubygems.org/command-reference/bundle/); this site redirects the old man page URLs there.

## Development Set Up

Begin by cloning the repository onto your local machine:

    git clone https://github.com/rubygems/bundler-site.git

Once complete prepare the dependencies by running:

    bundle install

## Basic Middleman Commands

Run a local development web server:

    bundle exec middleman server

This will start a local web server running at: *http://localhost:4567*. It will serve the site as it exists in **/source**.

To specify the host and/or port, add the --bind-address, -p flag(s):

    bundle exec middleman --bind-address 0.0.0.0 -p 8080

Note: the development server will automatically reload pages when they or their associated stylesheets are modified. This feature is enabled in **config.rb**.

Build the site:

    bundle exec middleman build

This will use the files in **/source** to generate a static site in **/build**.

## Deployment

When a pull request is merged into the `main` branch, the [deploy workflow](https://github.com/rubygems/bundler-site/blob/HEAD/.github/workflows/deploy.yml) on GitHub Actions builds the site and pushes it to GitHub Pages. Deploy status can be followed in [the workflow history](https://github.com/rubygems/bundler-site/actions/workflows/deploy.yml). The site is served at bundler.io using a [custom domain](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site).
