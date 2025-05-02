module Search
  class Base
    class << self
      attr_reader :data
    end

    def self.load_data
      path_adaptor = Loader::JsonAdaptor.new(dataset[:path])
      url_adaptor = Loader::JsonUrlAdaptor.new(dataset[:url])
      loader = Loader::DataLoader.new(adaptor: url_adaptor)
      dataset = loader.load
      @data = dataset.map { |record| new(record) }
    end

    def self.dataset_path
    end
  end
end
