BRANCH_FOR_PAGES = "gh-pages".freeze

directory "vendor/ssh_bundler.github.io" => ["vendor"] do
  system "git clone --branch #{BRANCH_FOR_PAGES} --single-branch https://github.com/rubygems/bundler-site vendor/ssh_bundler.github.io"
end

namespace :ci do
  task update_ssh_site: "vendor/ssh_bundler.github.io" do
    Dir.chdir "vendor/ssh_bundler.github.io" do
      sh "git reset --hard HEAD"
      sh "git pull origin #{BRANCH_FOR_PAGES}"
    end
  end
end
