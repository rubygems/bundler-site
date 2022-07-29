namespace :ci do
  def encrypted_key
    ENV["encrypted_key"]
  end

  def encrypted_iv
    ENV["encrypted_iv"]
  end

  def commit_author_email
    ENV["COMMIT_AUTHOR_EMAIL"]
  end

  def configure_ssh_deploy_key
    sh "openssl aes-256-cbc -K #{encrypted_key} -iv #{encrypted_iv} -in deploy_key.enc -out deploy_key -d"
    sh "chmod 600 deploy_key"
    sh "ssh-add deploy_key"
    sh "rm deploy_key"
  end

  task deploy: [:build, "vendor/ssh_bundler.github.io"] do
    configure_ssh_deploy_key

    commit = `git rev-parse HEAD`.chomp

    Dir.chdir "vendor/ssh_bundler.github.io" do
      rm_rf FileList["*"]
      cp_r FileList["../../build/*"], "./"
      File.write("CNAME", "bundler.io")

      # Copy gitconfig prepared by actions/checkout Action from .git/config
      # to get configuration for `git push`
      cp "../../.git/config", ".git/config"

      sh "git add -A ."

      sh "git config user.name 'GitHub Actions'"
      sh "git config user.email '#{commit_author_email}'"

      sh "git commit -m 'rubygems/bundler-site@#{commit}'"
      sh "git push origin #{BRANCH_FOR_PAGES}"
    end
  end
end
