desc "Recreate data/known_plugins.yml from RubyGems.org data. " \
  "Look for gems with bundler- prefix names, and get their information, " \
  "skipping invalid gems. Run with RUBYOPT=-W1 enabled to see diagnostic " \
  "output about data not found. Uses curl, grep."
task :regenerate_known_plugins_yml do
  require "yaml"

  names_content = `curl --silent https://index.rubygems.org/names | grep '^bundler-'`
  all_plugin_names = names_content.lines.map(&:chomp)

  skipped_gem_names = %w[
    bundler-add functionality-exists-in-bundler-now
    bundler-auto-update
    bundler-bootstrap empty
    bundler-budit not-authoritative
    bundler-changelog empty
    bundler-fastupdate
    bundler-fu
    bundler-gem-hg
    bundler-geminabox
    bundler-gem_version_tasks
    bundler-github functionality-exists-in-bundler-now
    bundler-bouncer
    bundler-interactive source-does-not-exist yanked-all-but-last
    bundler-maglev-
    bundler-next
    bundler-norelease
    bundler-pgs
    bundler-prehistoric
    bundler-sass
    bundler-turbo
    bundler-updater
  ]
  not_plugins = %w[
    bundler-audit
    bundler-audited_update
    bundler-audit-ng
    bundler-advise
    bundler-bower
    bundler-commentator
    bundler-dependencies
    bundler-diff
    bundler-fixture
    bundler-grep
    bundler-gtags
    bundler-leak
    bundler-native-gems
    bundler-organization_audit
    bundler-patch
    bundler-reorganizer
    bundler-security
    bundler-squash
    bundler-stats
    bundler-update_stdout
    bundler-talks
    bundler-unload
    bundler-verbose
  ]
  # Suspected:
  # bundler-fastupdate
  plugin_names = all_plugin_names - skipped_gem_names - not_plugins

  # https://guides.rubygems.org/rubygems-org-api/#gem-methods
  # /api/v1/gems/[GEM NAME].(json|yaml)
  # Example: https://rubygems.org/api/v1/gems/rails.json
  plugins = plugin_names.map do |gem_name|
    json_string = `curl --silent https://rubygems.org/api/v1/gems/#{gem_name}.json`
    next "<#{gem_name.inspect} is unknown by the API>" if json_string == "This rubygem could not be found."

    gem_info = JSON.parse(json_string)

    uri = if gem_info["homepage_uri"].to_s == ""
      gem_info["project_uri"]
    else
      gem_info["homepage_uri"]
    end

    {
      name: gem_name,
      uri: uri
    }
  end
  # RUBYOPT=-W1 will display this diagnostic output
  warn plugins.reject { |e| e.is_a?(Hash) }.inspect

  valid_plugins = plugins.select { |e| e.is_a?(Hash) }

  File.write(File.expand_path("../../data/known_plugins.yml", __dir__), YAML.dump(valid_plugins))
  puts "Saved #{valid_plugins.size} plugins as data/known_plugins.yml"
  puts "Done."
end
