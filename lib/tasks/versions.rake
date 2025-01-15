require "date"
require "erb"
require "pathname"

require_relative "../versions"

desc "Print the Bundler versions the site documents"
task :versions do
  puts VERSIONS.join(" ")
end

namespace :versions do
  desc "Prepare a new minor version"
  task :create do
    last = VERSIONS.last
    succ = VERSIONS.last.succ
    puts "Latest version is #{last}. Creating version #{succ}..."
    last_root = "source/#{last}"
    succ_root = "source/#{succ}"
    cp_r last_root, succ_root
    puts "Creating empty What's New page..."
    render_whats_new(succ)
    puts "Creating announcement blog post..."
    sh "middleman article 'Bundler #{succ}'"
    puts "Updating latest version symlinks..."
    Dir.glob("#{succ_root}/man/*.html.erb") do |file|
      url = file.delete_prefix("#{succ_root}/")
      latest_man = "source/#{url}"
      FileUtils.ln_sf Pathname.new(file).relative_path_from(File.dirname(latest_man)), latest_man
    end
    puts "Updating whats_new symlink..."
    FileUtils.ln_sf Pathname.new("#{succ_root}/whats_new.html.md").relative_path_from("source"), "source/whats_new.html.md"
  end
end

def render_whats_new(full_version)
  version = full_version[1..-1]
  version_slug = version.tr(".", "-")
  rubygems_version = Gem::Version.new(version).segments.map.with_index {|segment, i| i == 0 ? segment + 1 : segment }.join(".")
  date_slug = Date.today.strftime("%Y/%m/%d")

  template = Pathname.new("../templates/whats_new.html.md.erb").expand_path(__dir__)
  renderer = ERB.new(template.read)
  whats_new = Pathname.new("../../source/#{full_version}/whats_new.html.md").expand_path(__dir__)
  File.write whats_new.to_s, renderer.result(binding)
end
