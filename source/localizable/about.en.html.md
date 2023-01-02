---
title: About this site
layout: two_column_layout
---

# About this Web site

## Source code

[https://github.com/rubygems/bundler-site](https://github.com/rubygems/bundler-site)

## Architecture

Middleman 4.4 is the core system of this Web site.
A half of source code is located in `./source`,
but the other half is located in [rubygems/rubygems/tree/master/bundler/lib/bundler/man"](https://github.com/rubygems/rubygems/tree/master/bundler/lib/bundler/man),
which would be retrieved by executing `bundle exec rake man`.

When the source code is merged to the default branch `master` on GitHub,
[Deploy job on GitHub Actions](https://github.com/rubygems/bundler-site/blob/HEAD/.github/workflows/deploy.yml)
would automatically build source (HTML, JS, CSS and font) and push them to GitHub Pages.
Deploy status can be followed in
[github-pages Deployment history](https://github.com/rubygems/bundler-site/deployments/activity_log?environment=github-pages).
Custom domain is used to host `bundler.io` (see also
[Managing a custom domain for your GitHub Pages site](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site#configuring-a-subdomain)).

As seen above, you might sometimes take care about the difference in
deploy methods between review apps and production. Unlike production
mentioned above, review apps of this Web site rely on Heroku architecture,
which run as middleman server.

## Localization

While
[internationalization system was introduced in 2016](/blog/2016/07/10/bundler-1-13-and-redesigned-bundler-io.html),
multilingualization is still ongoing.
We welcome multilingualize more guides and other documentations.
To get started, move some files existing in `/source`
or create a file to `/source/localizable`
to multiligualize
files.

## Becoming a maintainer of this Web site (namely `rubygems/bundler-site`)

If you want to be an official maintainer, start by helping out.

As a first step, we welcome you to create a few of pull requests to improve
the Web site to [the repo](https://github.com/rubygems/bundler-site/pulls).
Also new feature improvement proposals are welcome.
