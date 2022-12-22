desc "Regenerate file with contributor's information that our team page will display"
namespace :contributors do
  task :update do
    def small_avatar(url)
      connector = url.include?("?") ? "&" : "?"
      [url, "s=40"].join(connector)
    end

    core_team = %w[
      colby-swandale
      deivid-rodriguez
      greysteil
      hsbt
      indirect
      rubymorillo
      segiddins
    ]
    credited_elsewhere = core_team + %w[homu bundlerbot]

    require "octokit"
    require "yaml"
    options = { auto_paginate: true }
    options[:access_token] = ENV["GITHUB_TOKEN"] if ENV["GITHUB_TOKEN"]
    client = Octokit::Client.new(**options)
    contributors = client.contributors("rubygems/rubygems", false)
    contributors.reject!{|c| credited_elsewhere.include?(c[:login]) }
    contributors.map! do |c|
      {
        avatar_url: small_avatar(c[:avatar_url]),
        commits: c[:contributions],
        href: c[:html_url],
        name: c[:login]
      }
    end
    contributors.sort_by! {|c| [-c[:commits], c[:name].downcase] }

    File.write("data/contributors.yml", YAML.dump(contributors))
  end
end
