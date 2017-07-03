require 'date'
require 'erb'
require 'pathname'

VERSIONS = Dir.chdir("source") { Dir.glob("v*").sort_by{|x| [x.size, x] } }.freeze

desc "Print the Bundler versions the site documents"
task :versions do
  puts VERSIONS.join(' ')
end

namespace :versions do
  desc "Prepare a new minor version"
  task :create do
    last = VERSIONS.last
    succ = VERSIONS.last.succ
    puts "Latest version is #{last}. Creating version #{succ}..."
    cp_r "source/#{last}", "source/#{succ}"
    cp_r "source/localizable/#{last}", "source/localizable/#{succ}"
    puts "Creating empty What's New page..."
    render_whats_new(succ)
    puts "Creating announcement blog post..."
    sh "middleman article 'Bundler #{succ}'"
  end
end

def render_whats_new(full_version)
  version = full_version[1..-1]
  version_slug = version.tr('.', '-')
  date_slug = Date.today.strftime('%Y/%m/%d')

  template = Pathname.new("../templates/whats_new.html.haml.erb").expand_path(__dir__)
  renderer = ERB.new(template.read)
  whats_new = Pathname.new("../../source/#{full_version}/whats_new.html.haml").expand_path(__dir__)
  File.write whats_new.to_s, renderer.result(binding)
end
