module Search
  class Client < Base
    attr_reader :id, :full_name, :email

    def initialize(data)
      @id = data['id']
      @full_name = data['full_name']
      @email = data['email']&.downcase
    end

    def matches?(field, query)
      value = send(field)
      value.to_s.downcase.include?(query.to_s.downcase)
    end

    def self.matches?(field, query)
      data.find { |client| client.matches?(field, query) }
    end

    def self.duplicate
      data.group_by { |client| client.email }
                      .select { |email, group| email && group.size > 1 }
    end

    def self.dataset
      {
        path: File.expand_path('../../clients.json', __dir__),
        url: 'https://appassets02.shiftcare.com/manual/clients.json'
      }
    end
  end
end
