require "bundler/setup"

desc "Install oniguruma"
task :install_onig do
  if `which wget`.empty?
    puts "You need wget to install oniguruma. Please install it."
    exit
  end

  system "curl -O http://www.geocities.jp/kosako3/oniguruma/archive/onig-5.8.0.tar.gz"
  system "tar zxvf onig-5.8.0.tar.gz"

  Dir.chdir("onig-5.8.0") do
    system "./configure"
    system "make"
    system "sudo make install"
  end
end

desc "Pull in the man pages"
task :man do
  if File.exists?("bundler")
    Dir.chdir("bundler") { system "git fetch" }
  else
    system "git clone git://github.com/carlhuda/bundler.git"
  end

  %w(v1.0 v1.1 v1.2 v1.3).each do |version|
    FileUtils.mkdir_p("site/#{version}/man")
    FileUtils.rm(Dir["bundler/man/*.html"])
    branch = (version[1..-1].split(".") + %w(stable)).join("-")
    Dir.chdir("bundler") do
      system "git checkout origin/#{branch}"
      system "ronn -5 man/*.ronn"
    end
    FileUtils.cp(Dir["bundler/man/*.html"], "site/#{version}/man")
  end
end

desc "Build the static site"
task :build do
  system "staticmatic build ."
end

desc "Prepare a site release"
task :release => [:build, :man] do
  commit = `git rev-parse HEAD`.chomp
  if File.exists?("gh-pages")
    Dir.chdir("gh-pages") { system "git pull" }
  else
    system "git clone git@github.com:carlhuda/bundler.git gh-pages --branch gh-pages"
  end

  Dir.chdir("gh-pages") do
    system "rm -rf *"
    File.open("CNAME", "w") { |file| file.puts "gembundler.com" }
    system "cp -r ../site/* ."
    system "git add -A ."
    system "git commit -m \"carlhuda/bundler-site@#{commit}\""
    system "git push origin gh-pages"
  end
end

namespace :assets do
  task :precompile => [:build, :man]
end
