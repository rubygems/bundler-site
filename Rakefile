require "bundler/setup"

directory "vendor"
directory "vendor/bundler" => ["vendor"] do
  system "git clone https://github.com/bundler/bundler.git vendor/bundler"
end

task :update_vendor => ["vendor/bundler"] do
  Dir.chdir("vendor/bundler") { sh "git fetch" }
end

VERSIONS = %w(v1.0 v1.1 v1.2 v1.3 v1.5 v1.6 v1.7 v1.8 v1.9 v1.10 v1.11).freeze
desc "Print the Bundler versions the site documents"
task :versions do
  puts VERSIONS.join(' ')
end

desc "Pull in the man pages for the specified gem versions."
task :man => [:update_vendor] do
  VERSIONS.each do |version|
    branch = (version[1..-1].split('.') + %w(stable)).join('-')

    rm_rf "source/#{version}/man"
    mkdir_p "source/#{version}/man"

    Dir.chdir "vendor/bundler" do
      sh "git reset --hard HEAD"
      sh "git checkout origin/#{branch}"
      sh "ronn -5 man/*.ronn"
      cp(FileList["man/*.html"], "../../source/#{version}/man")
      sh "git clean -fd"
    end
  end

  # Make man pages for the latest version available at the top level, too.
  rm_rf "source/man"
  cp_r "source/#{VERSIONS.last}/man", "source"
end

desc "Pulls in pages maintained in the bundler repo."
task :repo_pages => [:update_vendor] do
  Dir.chdir "vendor/bundler" do
    sh "git reset --hard HEAD"
    sh "git checkout origin/master"
    cp "ISSUES.md", "../../source/issues.md"
    cp "CODE_OF_CONDUCT.md", "../../source/conduct.md"
  end
end

directory "vendor/bundler.github.io" => ["vendor"] do
  system "git clone https://github.com/bundler/bundler.github.io.git vendor/bundler.github.io"
end

task :update_site => ["vendor/bundler.github.io"] do
  Dir.chdir "vendor/bundler.github.io" do
    sh "git checkout master"
    sh "git reset --hard HEAD"
    sh "git pull origin master"
  end
end

desc "Build the static site"
task :build => [:repo_pages, :man] do
  sh "middleman build --clean"
end

desc "Release the current commit to bundler/bundler.github.io"
task :release => [:build, :update_site] do
  commit = `git rev-parse HEAD`.chomp

  Dir.chdir "vendor/bundler.github.io" do
    rm_rf FileList["*"]
    cp_r FileList["../../build/*"], "./"
    File.write("CNAME", "bundler.io")

    sh "git add -A ."
    sh "git commit -m 'bundler/bundler-site@#{commit}'"

    Bundler.with_clean_env do
      sh "git push origin master"
    end
  end

  Bundler.with_clean_env do
    sh "git push origin master"
  end
end

# Allow Heroku deploys to build the site (for previewing)
namespace :assets do
  task :precompile => :build
end
