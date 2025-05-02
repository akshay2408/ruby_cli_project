require_relative 'loader/json_adaptor'
require_relative 'loader/json_url_adaptor'

module Loader
  class DataLoader
    def initialize(adaptor:)
      @adaptor = adaptor
    end

    def load
      @adaptor.load
    end
  end
end
