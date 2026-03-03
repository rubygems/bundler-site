Dir.glob(File.expand_path("../lib/config/*.rb", __FILE__), &method(:require))
require_relative "lib/versions"

config[:versions] = VERSIONS
config[:latest_version] = config[:versions].last

activate :syntax
activate :i18n
activate :search do |search|
  search.resources = ["index.html", "#{config[:latest_version]}/", "changelog.html", "compatibility.html", "conduct.html"]

  search.index_path = "search/lunr-index.json"

  search.fields = {
    title: {boost: 100, store: true, required: true},
    content: {boost: 50},
    url: {index: false, store: true},
    description: {index: false, store: true},
  }
end

set :layout, :base

set :images_dir, "images"

set :markdown_engine, :kramdown

# Markdown extentions
set :markdown,
    input: "GFM",
    autolink: true,
    fenced_code_blocks: true,
    footnotes: true,
    gh_codeblock: true,
    highlight: true,
    no_intra_emphasis: true,
    quote: true,
    smartypants: true,
    strikethrough: true,
    superscript: true,
    tables: true,
    hard_wrap: false

# Webpack
activate :external_pipeline,
         name: :webpack,
         command: build? ? "npm run build" : "npm run start",
         source: ".tmp/dist",
         latency: 1

# Make documentation for the latest version available at the top level, too.
# Any pages with names that conflict with files already at the top level will be skipped.
Dir.glob("./source/#{config[:latest_version]}/*.haml").each do |file_path|
  file_path = file_path.sub(/\.haml$/, "")

  page_path = file_path.sub(/^\.\/source\//, "")
  proxy_path = file_path["./source/#{config[:latest_version]}/".length..-1]

  proxy proxy_path, page_path unless file_exist?(proxy_path)
end
# Same for localizable
Dir.glob("./source/localizable/#{config[:latest_version]}/**/*").select{ |f| File.file?(f) }.each do |file_path|
  matched = file_path.match(/(localizable\/v\d+.\d+\/(.*)\.(.{2})\.html)/)
  next unless matched

  page_path = matched[1]
  proxy_path = "#{matched[2]}.html"
  country = matched[3]

  next if file_exist?(proxy_path)

  proxy "#{country}/#{proxy_path}", page_path, locale: country.to_sym
  proxy proxy_path, page_path, locale: :en if country == "en"
end

# Redirect old pages in this repo to manpages (see https://github.com/rubygems/bundler-site/issues/723)
%w[help binstubs check clean console init inject install open outdated plugin show version viz].each do |command|
  redirect "bundle_#{command}.html", to: "man/bundle-#{command}.1.html"
end

# Redirect meaningless pages proxied for 6 years to the original pages
# https://github.com/rubygems/bundler-site/issues/807
config[:versions].each do |version|
  Dir.glob("./source/#{version}/man/**/*").select{ |f| File.file?(f) }.each do |file_path|
    file_path = file_path[0..-5]
    page_path = file_path.sub(/^\.\/source/, "")

    man_page_name_matched = file_path.match(/man\/(.*)\.html$/)
    next unless man_page_name_matched

    man_page_name = man_page_name_matched[1].gsub(/\.\d+$/, "").gsub("-", "_")
    man_page_name = "gemfile_man" if man_page_name == "gemfile"

    redirect "#{version}/#{man_page_name}.html", to: page_path unless man_page_exists?(man_page_name, version)
  end
end

%w[1.12 1.13 1.14 1.15].each do |version|
  # Redirect old pages in this repo to manpages (see https://github.com/rubygems/bundler-site/issues/723)
  %w[help binstubs check clean console init inject install open outdated show version viz].each do |command|
    redirect "v#{version}/bundle_#{command}.html", to: "v1.15/man/bundle-#{command}.1.html"
  end

  # /v:ver/docs.html is now the center of versioned docs
  redirect "v#{version}/index.html", to: "v#{version}/docs.html"
end

%w[1.16 1.17 2.0 2.1 2.2 2.3].each do |version|
  # Redirect old pages in this repo to manpages (see https://github.com/rubygems/bundler-site/issues/723)
  %w[help binstubs check clean console init inject install open outdated plugin show version viz].each do |command|
    next if %w[plugin].include?(command) && version < "2.3"
    redirect "v#{version}/bundle_#{command}.html", to: "v#{version}/man/bundle-#{command}.1.html"
  end

  # /v:ver/docs.html is now the center of versioned docs
  redirect "v#{version}/index.html", to: "v#{version}/docs.html"
end

redirect "sponsors.html", to: "https://rubygems.org/pages/sponsors" # Backwards compatibility

page "/changelog.html", layout: :two_column_layout
page "/conduct.html", layout: :two_column_layout
page "/compatibility.html", layout: :two_column_layout
page "/whats_new.html", layout: :two_column_layout
page /\/v(\d+.\d+)\/(?!bundle_|commands|docs|man)(.*)/, layout: :two_column_layout
page /\/v(.*)\/man\/(.*)/, layout: :two_column_layout
page /man\/(.*)/, layout: :two_column_layout
page /\/doc\/(.*)/, layout: :two_column_layout # Imported from rubygems/bundler

page "/sitemap.xml", layout: false

redirect "issues.html", to: "https://github.com/rubygems/rubygems/issues/new?labels=Bundler&template=bundler-related-issue.md" # Backwards compatibility
redirect "commands.html", to: "man/bundle.1.html" # Backwards compatibility
redirect "older_versions.html", to: "whats_new.html" # Backwards compatibility
redirect "team.html", to: "contributors.html" # https://github.com/rubygems/bundler-site/issues/842

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
