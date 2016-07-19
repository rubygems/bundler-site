Dir.glob("lib/tasks/**/*.rake").each { |r| load r }

desc "Build the static site"
task :build => [:repo_pages, :man] do
  sh "middleman build --clean"
end

# Heroku runs assets:precompile during deploys
namespace :assets do
  task :precompile => [:repo_pages, :man] do
    sh "middleman build --environment build"
  end
end
