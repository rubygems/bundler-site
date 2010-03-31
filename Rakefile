desc "Install oniguruma"
task :install_onig do
  system "wget http://www.geocities.jp/kosako3/oniguruma/archive/onig-5.8.0.tar.gz"
  system "tar zxvf onig-5.8.0.tar.gz"
  
  Dir.chdir("onig-5.8.0") do
    system "./configure"
    system "make"
    system "sudo make install"
  end
end