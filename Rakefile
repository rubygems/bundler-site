Dir.glob("lib/tasks/**/*.rake").each { |r| load r }

desc "Build the static site"
task build: ["contributors:update", :repo_pages, :man] do
  sh "middleman build --clean --verbose"
end

# Heroku runs assets:precompile during deploys
namespace :assets do
  task precompile: :build
end
