require 'net/http'
require 'logger'

class GraphqlRequestHelper
  def self.get_data(address, query)
    uri = URI(address)
    puts ENV['GITHUB_ACCESS_TOKEN']
    begin
      http = Net::HTTP.new uri.host, uri.port
      http.use_ssl = true
      http.read_timeout = 30
      response = http.post("#{uri.path}?#{uri.query.to_s}", 
                           query,
                           {'Content-Type' => 'application/json', 'Authorization' => "bearer #{ENV['GITHUB_ACCESS_TOKEN']}"}
      )

      data = JSON.parse(response.body)

      if data['data'].nil? || data['data']['search'].nil?
        []
      else
        data['data']['search']['edges'] || []
      end
    rescue Net::ReadTimeout => exception
      logger = Logger.new(STDERR)
      logger.error "#{uri.host}:#{uri.port} is NOT reachable (ReadTimeout)"
      []
    end
  end
end
