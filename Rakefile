require "bundler/setup"

directory "vendor"
directory "vendor/bundler" => ["vendor"] do
  system "git clone git@github.com:carlhuda/bundler.git vendor/bundler"
  # Some users don't have private permissions
  if !File.exist?("vendor/bundler")
    system "git clone git://github.com/carlhuda/bundler.git vendor/bundler"
  end
end

task :update_vendor => ["vendor/bundler"] do
  Dir.chdir("vendor/bundler") { sh "git fetch" }
end

desc "Pull in the man pages for the specified gem versions."
task :man => [:update_vendor] do
  %w(v1.0 v1.1 v1.2 v1.3).each do |version|
    branch = (version[1..-1].split('.') + %w(stable)).join('-')

    mkdir_p "build/#{version}/man"

    Dir.chdir "vendor/bundler" do
      sh "git reset --hard HEAD"
      sh "git checkout origin/#{branch}"
      sh "ronn -5 man/*.ronn"
      cp(FileList["man/*.html"], "../../build/#{version}/man")
      sh "git clean -fd"
    end

  end
end

desc "Build the static site"
task :build do
  sh "middleman build --clean"
end

desc "Release the current commit to carlhuda/bundler@gh-pages"
task :release => [:update_vendor, :build, :man] do
  commit = `git rev-parse HEAD`.chomp

  Dir.chdir "vendor/bundler" do
    sh "git reset --hard HEAD"
    sh "git checkout gh-pages"
    rm_rf FileList["*"]
    cp_r FileList["../../build/*"], "./"
    File.write("CNAME", "gembundler.com")

    sh "git add -A ."
    sh "git commit -m 'carlhuda/bundler-site-middleman@#{commit}'"
    sh "git push origin gh-pages"
  end
end

# Allow Heroku deploys to build the site (for previewing)
namespace :assets do
  task :precompile => [:build, :man]
end
