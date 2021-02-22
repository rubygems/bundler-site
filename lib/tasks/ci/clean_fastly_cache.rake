require 'net/http'
require 'json'
require 'openssl'

namespace :ci do
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

    net_http = Net::HTTP.new(fastly_cache_purge_uri.hostname, fastly_cache_purge_uri.port)
    net_http.use_ssl = true
    net_http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    net_http.start { |http| http.request(req) }
  end
end
