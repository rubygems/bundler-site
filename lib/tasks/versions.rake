VERSIONS = Dir.chdir("source") { Dir.glob("v*").sort_by{|x| [x.size, x] } }.freeze

desc "Print the Bundler versions the site documents"
task :versions do
  puts VERSIONS.join(' ')
end
