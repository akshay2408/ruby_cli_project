require 'json'

module Loader
  class JsonAdaptor
    def initialize(path)
      @path = path
    end

    def load
      json = File.read(@path)
      JSON.parse(json)
    end
  end
end
