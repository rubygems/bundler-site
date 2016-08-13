require 'net/http'
require 'json'

namespace :travis do
  def fastly_cache_purge_uri
    URI("https://api.fastly.com/service/#{fastly_service_id}/purge_all")
  end

  def fastly_service_id
    ENV['FASTLY_SERVICE_ID']
  end

  def fastly_key
    ENV['FASTLY_API_KEY']
  end

  task :clean_fastly_cache do
    puts 'Making call to clear Fastly cache'

    body = { 'Fastly-Key': fastly_key, Accept: 'application/json' }

    req = Net::HTTP::Post.new(fastly_cache_purge_uri, 'Content-Type': 'application/json')
    req.body = body.to_json

    Net::HTTP.start(fastly_cache_purge_uri.hostname, fastly_cache_purge_uri.port) { |http| http.request(req) }
  end
end
