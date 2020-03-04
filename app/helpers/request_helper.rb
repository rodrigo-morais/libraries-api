require 'net/http'

class RequestHelper
  def self.get_data(address, query = nil)
    uri = URI(address)
    begin
      http = Net::HTTP.new uri.host, uri.port
      http.use_ssl = true
      http.read_timeout = 30
      response = http.get("#{uri.path}?#{uri.query.to_s}", {'Content-Type' => 'application/json'})

      JSON.parse(response.body)
    rescue Net::ReadTimeout => exception
      logger = Logger.new(STDERR)
      logger.error "#{uri.host}:#{uri.port} is NOT reachable (ReadTimeout)"
      []
    end
  end
end
