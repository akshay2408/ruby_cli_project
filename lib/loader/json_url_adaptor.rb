require 'open-uri'
require 'json'

module Loader
  class JsonUrlAdaptor
    def initialize(url)
      @url = url
    end

    def load
      json_data = URI.open(@url).read
      JSON.parse(json_data)
    end
  end
end
