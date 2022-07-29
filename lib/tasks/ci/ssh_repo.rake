directory "vendor/ssh_bundler.github.io" => ["vendor"] do
  system "git clone https://github.com/rubygems/bundler-site.git vendor/ssh_bundler.github.io"
end

namespace :ci do
  task update_ssh_site: "vendor/ssh_bundler.github.io" do
    Dir.chdir "vendor/ssh_bundler.github.io" do
      BRANCH_FOR_PAGES = "gh-pages".freeze

      sh "git checkout #{BRANCH_FOR_PAGES}"
      sh "git reset --hard HEAD"
      sh "git pull origin #{BRANCH_FOR_PAGES}"
    end
  end
end
