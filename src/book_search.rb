require 'net/http'
require 'concurrent'
require 'json'

module GoogleBookSearch
  BASE_PATH = 'https://www.googleapis.com/books/'

  class FullText
    # The base url for full text search
    API_URL = URI(BASE_PATH + 'v1/volumes?q=%s')
    # The http object used to send requests
    HTTP = Net::HTTP.new(API_URL.host, API_URL.port)
    # The api requires it to be encrypted
    HTTP.use_ssl = true

    # Search for a term in google books.
    # Returns a Future which executes the request on
    # the global thread-pool
    def self.search(term, params={})
      # Escape the search term, e.g "Hello World" => "Hello%20World"
      query = URI::escape(term)
      # Turn the parameter map into an Uri String, e.g {lite: true} => "&lite=true"
      qparams = URI.encode_www_form(params)
      # Construct the request url with the query and the parameters
      request_url = (API_URL.request_uri % query) + '&' + qparams
      puts "Requesting with the following api call: #{request_url}"
      # Construct the request with the formatted url
      request = Net::HTTP::Get.new(request_url)
      # Send the request on a global thread-pool and return the Future
      Concurrent::Future.execute do
        response = HTTP.request(request)
        # Parse the result as json
        JSON.parse(response.body)
      end
    end
  end

end
