require "bundler/setup"

directory "vendor"
directory "vendor/bundler" => ["vendor"] do
  system "git clone git@github.com:bundler/bundler.git vendor/bundler"
  # Some users don't have private permissions
  if !File.exist?("vendor/bundler")
    system "git clone git://github.com/bundler/bundler.git vendor/bundler"
  end
end

task :update_vendor => ["vendor/bundler"] do
  Dir.chdir("vendor/bundler") { sh "git fetch" }
end

desc "Pull in the man pages for the specified gem versions."
task :man => [:update_vendor] do
  %w(v1.0 v1.1 v1.2 v1.3 v1.5 v1.6).each do |version|
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

  # Make man pages for the latest version available at the top level, too.
  cp_r "build/v1.5/man", "build/man"
end

desc "Pulls in ISSUES.md from the master branch."
task :issues => [:update_vendor] do

  Dir.chdir "vendor/bundler" do
    sh "git reset --hard HEAD"
    sh "git checkout origin/master"
    cp "ISSUES.md", "../../source/issues.md"
  end

end

desc "Build the static site"
task :build => [:issues] do
  sh "middleman build --clean"
end

desc "Release the current commit to bundler/bundler@gh-pages"
task :release => [:update_vendor, :build, :man, :issues] do
  commit = `git rev-parse HEAD`.chomp

  Dir.chdir "vendor/bundler" do
    sh "git reset --hard HEAD"
    sh "git checkout gh-pages"
    sh "git pull origin gh-pages"

    rm_rf FileList["*"]
    cp_r FileList["../../build/*"], "./"
    File.write("CNAME", "bundler.io")

    sh "git add -A ."
    sh "git commit -m 'bundler/bundler-site@#{commit}'"
    sh "git push origin gh-pages"
  end
end

# Allow Heroku deploys to build the site (for previewing)
namespace :assets do
  task :precompile => [:build, :man]
end
