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
  FileUtils.mv(Dir["bundler/man/*.html"], "site/man")
end

