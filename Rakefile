Dir.glob("lib/tasks/**/*.rake").each { |r| load r }

desc "Build the static site"
task :build => [:repo_pages, :man] do
  sh "middleman build --clean"
end

namespace :assets do
  task :precompile => [:repo_pages, :man]
end
