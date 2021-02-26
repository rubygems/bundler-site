directory "vendor/ssh_bundler.github.io" => ["vendor"] do
  system "git clone git@github.com:bundler/bundler.github.io vendor/ssh_bundler.github.io"
end

namespace :ci do
  task :update_ssh_site => ["vendor/ssh_bundler.github.io"] do
    Dir.chdir "vendor/ssh_bundler.github.io" do
      sh "git checkout master"
      sh "git reset --hard HEAD"
      sh "git pull origin master"
    end
  end
end
