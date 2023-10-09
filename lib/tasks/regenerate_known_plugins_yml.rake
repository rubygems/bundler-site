desc "Recreate data/known_plugins.yml from RubyGems.org data."
task :regenerate_known_plugins_yml do
  require "json"
  require "rubygems/package"
  require "rubygems/remote_fetcher"
  require "yaml"

  known_plugins = %w[
    bootboot
    extended_bundler-errors
  ]
  skipped_gems = %w[
    bundler-interactive source-does-not-exist yanked-all-but-last
    bundler-next
    bundler-security
    bundler-explain
    bundler-fast_git
  ]

  rubygems = Gem::Source.new("https://rubygems.org")
  known_plugins = rubygems.load_specs(:latest).filter_map do |name_tuple|
    next unless name_tuple.name.start_with?("bundler-") ||
                known_plugins.include?(name_tuple.name)
    next if skipped_gems.include?(name_tuple.name)

    spec = rubygems.fetch_spec(name_tuple)
    path = rubygems.download(spec, Gem.dir)
    gem = Gem::Package.new(path)
    # make sure it's actually a Bundler plugin
    next unless gem.contents.include?("plugins.rb")
    next unless spec.homepage
    next unless spec.summary

    {
      name: spec.name,
      summary: spec.summary,
      uri: spec.homepage
    }
  end

  File.write(File.expand_path("../../data/known_plugins.yml", __dir__), YAML.dump(known_plugins))
  puts "Saved #{known_plugins.size} plugins as data/known_plugins.yml"
  puts "Done."
end
