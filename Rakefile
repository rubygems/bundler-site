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
    Dir.chdir("bundler") { system "git pull" }
  else
    system "git clone git://github.com/carlhuda/bundler.git"
  end

  FileUtils.mkdir_p("site/man")
  Dir.chdir("bundler") { system "ronn -5 man/*.ronn" }
  FileUtils.cp(Dir["bundler/man/*.html"], "site/man")
end

desc "Build the static site"
task :build do
  system "staticmatic build ."
end

desc "Prepare a site release"
task :release => [:build, :man] do
  if File.exists?("gh-pages")
    Dir.chdir("gh-pages") { system "git pull" }
  else
    system "git clone git://github.com/carlhuda/bundler.git gh-pages --branch gh-pages"
  end

  Dir.chdir("gh-pages") do
    system "rm -rf *"
    File.open("CNAME", "w") { |file| file.puts "gembundler.com" }
    system "cp -r ../site/* ."
    system "git push origin gh-pages"
  end
end

namespace :assets do
  task :precompile => [:build, :man]
end
