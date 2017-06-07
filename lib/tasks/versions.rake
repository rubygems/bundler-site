VERSIONS = Dir.chdir("source") { Dir.glob("v*").sort_by{|x| [x.size, x] } }.freeze

desc "Print the Bundler versions the site documents"
task :versions do
  puts VERSIONS.join(' ')
end

namespace :versions do
  desc "Prepare a new version"
  task :create do
    last = VERSIONS.last
    succ = VERSIONS.last.succ
    puts "Latest version is #{last}. Creating version #{succ}..."
    cp_r "source/#{last}", "source/#{succ}"
    cp_r "source/localizable/#{last}", "source/localizable/#{succ}"
    sh "middleman article 'Bundler #{succ}'"
  end
end