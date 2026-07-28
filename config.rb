require_relative "lib/versions"

config[:versions] = VERSIONS
config[:latest_version] = config[:versions].last

activate :syntax

set :layout, :base

set :images_dir, "images"

# Webpack
activate :external_pipeline,
         name: :webpack,
         command: build? ? "npm run build" : "npm run start",
         source: ".tmp/dist",
         latency: 1

# The site is English-only now. Redirect the old localized top pages to the top page.
%w[es pl].each do |lang|
  redirect "#{lang}/index.html", to: "/"
end

# Redirect removed guide pages to https://guides.rubygems.org/
guides_target = "https://guides.rubygems.org/"

## /guides/creating_gem.html, /guides/using_bundler_in_applications.html (localizable guides, non-en)
%w[creating_gem using_bundler_in_applications].each do |filename|
  %w[es pl].each do |lang|
    redirect "#{lang}/guides/#{filename}.html", to: guides_target
  end
end

## Top-level pages that were previously redirected to guides/
%w[bundler_workflow gemfile_ruby rationale rubygems rubymotion].each do |filename|
  redirect "#{filename}.html", to: guides_target
end

## The Gemfile guide was replaced by the gemfile(5) reference on the guides site.
redirect "gemfile.html", to: "#{guides_target}gemfile/"

## /compatibility.html moved to the RubyGems guides
redirect "compatibility.html", to: "#{guides_target}bundler-compatibility/"

## /v1.12/rails23.html, /v1.12/rails3.html
%w[rails23 rails3].each do |filename|
  redirect "v1.12/#{filename}.html", to: guides_target
end

## Versioned guide redirects for v1.12-v1.14
%w[1.12 1.13 1.14].each do |version|
  %w[bundler_setup bundler_sharing deploying faq git git_bisect groups rails sinatra updating_gems].each do |filename|
    redirect "v#{version}/#{filename}.html", to: guides_target
  end
end

## Versioned localizable guide redirects for v1.12-v1.15
%w[1.12 1.13 1.14 1.15].each do |version|
  ["", "pl/"].each do |lang|
    redirect "#{lang}v#{version}/guides/creating_gem.html", to: guides_target
    redirect "#{lang}v#{version}/guides/using_bundler_in_applications.html", to: guides_target
  end
end

## v1.15 guides
%w[bundler_setup bundler_sharing deploying faq git git_bisect groups rails rubygems_tls_ssl_troubleshooting_guide sinatra updating_gems].each do |filename|
  redirect "v1.15/guides/#{filename}.html", to: guides_target
end
%w[bundler_setup bundler_sharing].each do |filename|
  redirect "es/v1.15/guides/#{filename}.html", to: guides_target
end

## Versioned guide redirects for v1.16-v2.3
%w[1.16 1.17 2.0 2.1 2.2 2.3].each do |version|
  %w[
    bundler_docker_guide bundler_in_a_single_file_ruby_script bundler_plugins
    bundler_setup bundler_sharing deploying faq git git_bisect groups rails
    rubygems_tls_ssl_troubleshooting_guide sinatra updating_gems
  ].each do |filename|
    redirect "v#{version}/guides/#{filename}.html", to: guides_target
  end

  %w[bundler_workflow gemfile_ruby rationale rubygems rubymotion].each do |filename|
    redirect "v#{version}/#{filename}.html", to: guides_target
  end
  redirect "v#{version}/gemfile.html", to: "#{guides_target}gemfile/"

  ["", "pl/"].each do |lang|
    redirect "#{lang}v#{version}/guides/creating_gem.html", to: guides_target
    redirect "#{lang}v#{version}/guides/using_bundler_in_applications.html", to: guides_target
  end
end

## v2.0-v2.3 bundler_2_upgrade
%w[2.0 2.1 2.2 2.3].each do |version|
  redirect "v#{version}/guides/bundler_2_upgrade.html", to: guides_target
end

## /doc/* pages were imported from the rubygems repo. The Bundler doc tree was merged into the
## RubyGems one, so each page is redirected to wherever its content lives now.
rubygems_repo = "https://github.com/ruby/rubygems/blob/HEAD/"
{
  "contributing/bug_triage" => "#{rubygems_repo}doc/ISSUE_TRIAGE.md",
  "contributing/community" => "#{guides_target}contributing/",
  "contributing/how_you_can_help" => "#{guides_target}contributing/",
  "contributing/readme" => "#{guides_target}contributing/",
  "debugging" => "#{rubygems_repo}doc/DEBUGGING.md",
  "development/debugging" => "#{rubygems_repo}doc/DEBUGGING.md",
  "development/new_features" => "#{rubygems_repo}doc/NEW_FEATURES.md",
  "development/pull_requests" => "#{rubygems_repo}doc/PULL_REQUESTS.md",
  "development/readme" => "#{rubygems_repo}doc/README.md",
  "development/setup" => "#{rubygems_repo}doc/GETTING_STARTED.md",
  "documentation" => "#{rubygems_repo}doc/DOCUMENTATION.md",
  "documentation/readme" => "#{rubygems_repo}doc/DOCUMENTATION.md",
  "documentation/vision" => "#{rubygems_repo}doc/DOCUMENTATION.md",
  "documentation/writing" => "#{rubygems_repo}doc/DOCUMENTATION.md",
  "getting_started" => "#{rubygems_repo}doc/GETTING_STARTED.md",
  "issue_triage" => "#{rubygems_repo}doc/ISSUE_TRIAGE.md",
  "new_features" => "#{rubygems_repo}doc/NEW_FEATURES.md",
  "playbooks/merging_a_pr" => "#{rubygems_repo}doc/PULL_REQUESTS.md",
  "playbooks/team_changes" => "#{rubygems_repo}doc/POLICIES.md",
  "policies" => "#{rubygems_repo}doc/POLICIES.md",
  "pull_requests" => "#{rubygems_repo}doc/PULL_REQUESTS.md",
  "readme" => "#{rubygems_repo}doc/README.md",
  "release" => "#{rubygems_repo}doc/RELEASE.md",
  "troubleshooting" => "#{rubygems_repo}doc/TROUBLESHOOTING.md",
  "upgrading" => "#{rubygems_repo}doc/UPGRADING.md",
}.each do |page, target|
  redirect "doc/#{page}.html", to: target
end

## The changelog and the code of conduct were imported from the rubygems repo, too.
redirect "changelog.html", to: "#{rubygems_repo}CHANGELOG-bundler.md"
redirect "conduct.html", to: "#{rubygems_repo}CODE_OF_CONDUCT.md"

## The about page was folded into this repo's README.
redirect "about.html", to: "https://github.com/rubygems/bundler-site#readme"

# The man pages moved to the command reference on the guides site. Every man page URL
# this site ever served (any version, the top-level mirror of the latest version, and
# the underscore aliases from https://github.com/rubygems/bundler-site/issues/723 and
# https://github.com/rubygems/bundler-site/issues/807) redirects to the guides page for
# that command. The guides document the latest Bundler only, so commands that were
# removed upstream point at their successor, or at the bundle(1) index for bundle viz.
command_reference = "#{guides_target}command-reference/"
man_pages = %w[
  bundle.1 bundle-add.1 bundle-binstubs.1 bundle-cache.1 bundle-check.1
  bundle-clean.1 bundle-config.1 bundle-console.1 bundle-doctor.1 bundle-env.1
  bundle-exec.1 bundle-fund.1 bundle-gem.1 bundle-help.1 bundle-info.1
  bundle-init.1 bundle-inject.1 bundle-install.1 bundle-issue.1 bundle-licenses.1
  bundle-list.1 bundle-lock.1 bundle-open.1 bundle-outdated.1 bundle-package.1
  bundle-platform.1 bundle-plugin.1 bundle-pristine.1 bundle-remove.1
  bundle-show.1 bundle-update.1 bundle-version.1 bundle-viz.1 gemfile.5
]
man_targets = {
  "gemfile.5" => "#{guides_target}gemfile/",
  "bundle-inject.1" => "#{command_reference}bundle-add/",
  "bundle-package.1" => "#{command_reference}bundle-cache/",
  "bundle-viz.1" => "#{command_reference}bundle/",
}

man_pages.each do |man_page|
  target = man_targets.fetch(man_page) { "#{command_reference}#{man_page.sub(/\.\d+$/, "")}/" }
  alias_name = man_page.sub(/\.\d+$/, "").tr("-", "_")
  alias_name = "gemfile_man" if alias_name == "gemfile"

  redirect "man/#{man_page}.html", to: target
  redirect "#{alias_name}.html", to: target unless alias_name == "bundle"

  config[:versions].each do |version|
    redirect "#{version}/man/#{man_page}.html", to: target
    redirect "#{version}/#{alias_name}.html", to: target
  end
end

# /docs.html and /v:ver/docs.html were the indexes of the man pages, and /v:ver/index.html
# redirected there. bundle(1) plays that role on the guides site.
redirect "docs.html", to: "#{command_reference}bundle/"
config[:versions].each do |version|
  redirect "#{version}/docs.html", to: "#{command_reference}bundle/"
  redirect "#{version}/index.html", to: "#{command_reference}bundle/"
end

redirect "sponsors.html", to: "https://rubygems.org/pages/sponsors" # Backwards compatibility

# The curated What's New pages were removed in favor of the GitHub releases page.
# Bundler tags exist in ruby/rubygems from bundler-v2.1.0 onwards only, so older
# versions can't be filtered there and point to the latest release instead.
releases_url = "https://github.com/ruby/rubygems/releases"
redirect "whats_new.html", to: "#{releases_url}/latest"
config[:versions].each do |version|
  target = if Gem::Version.new(version[1..-1]) >= Gem::Version.new("2.1")
    "#{releases_url}?q=tag%3Abundler-#{version}"
  else
    "#{releases_url}/latest"
  end
  redirect "#{version}/whats_new.html", to: target
end
page "/sitemap.xml", layout: false

redirect "issues.html", to: "https://github.com/ruby/rubygems/issues/new?labels=Bundler&template=bundler-related-issue.md" # Backwards compatibility
redirect "commands.html", to: "#{command_reference}bundle/" # Backwards compatibility
redirect "older_versions.html", to: "https://github.com/ruby/rubygems/releases/latest" # Backwards compatibility
redirect "team.html", to: "https://guides.rubygems.org/contributing" # https://github.com/rubygems/bundler-site/issues/842
redirect "contributors.html", to: "https://guides.rubygems.org/contributing"

# Backwards compatibility for year/month/day index
ymds = %w[
  2013/10/12 2013/12/07
  2014/07/16 2014/08/14 2014/08/15
  2015/03/19 2015/03/20 2015/03/21 2015/06/24 2015/12/12
  2016/04/28 2016/07/10 2016/09/08
  2017/03/28 2017/05/19 2017/10/31
  2018/01/08 2018/01/17 2018/03/09 2018/04/09 2018/05/07 2018/06/07 2018/07/12 2018/08/10 2018/09/10 2018/10/15 2018/10/25 2018/11/04 2018/11/05 2018/12/08
  2019/01/03 2019/01/04 2019/02/02 2019/03/12 2019/05/14
  2020/04/27 2020/12/09
  2021/02/15
  2022/01/23
]
## /blog/YYYY/MM/DD/
ymds.each do |ymd|
  redirect "blog/#{ymd}/index.html", to: "/blog/"
end
## /blog/YYYY/MM/
ymds.map { |ymd| ymd.sub(%r{/\d+$}, "") }.each do |ym|
  redirect "blog/#{ym}/index.html", to: "/blog/"
end
## /blog/YYYY/
ymds.map { |ymd| ymd.sub(%r{/\d+/\d+$}, "") }.each do |y|
  redirect "blog/#{y}/index.html", to: "/blog/"
end

configure :development do
  config[:css_dir] = ".tmp/dist"
  config[:js_dir] = ".tmp/dist"
end

configure :build do
  config[:css_dir] = ""
  config[:js_dir] = ""
end
