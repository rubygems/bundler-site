Dir.glob("lib/tasks/**/*.rake").each { |r| load r }

desc "Build the static site"
task build: [:man] do
  sh "middleman build --clean --verbose"
end