# spec/client_spec.rb
require_relative '../lib/search/base'
require_relative '../lib/search/client'

RSpec.describe Search::Client do
  let(:sample_data) do
    [
      described_class.new({ 'id' => 1, 'full_name' => 'Alice Smith', 'email' => 'alice@example.com' }),
      described_class.new({ 'id' => 2, 'full_name' => 'Bob Johnson', 'email' => 'bob@example.com' }),
      described_class.new({ 'id' => 3, 'full_name' => 'Alice Brown', 'email' => 'alice@example.com' })
    ]
  end

  before do
    described_class.instance_variable_set(:@data, sample_data)
  end

  after do
    described_class.remove_instance_variable(:@data) if described_class.instance_variable_defined?(:@data)
  end

  describe '#matches?' do
    it 'returns true if field matches query (case insensitive)' do
      client = sample_data.first
      expect(client.matches?('full_name', 'alice')).to be true
    end

    it 'returns false if field does not match query' do
      client = sample_data.first
      expect(client.matches?('full_name', 'charlie')).to be false
    end
  end

  describe '.matches?' do
    it 'returns first matching client by field and query' do
      result = described_class.matches?('full_name', 'alice')
      expect(result).not_to be_nil
      expect(result.full_name.downcase).to include('alice')
    end

    it 'returns nil if no match found' do
      result = described_class.matches?('full_name', 'charlie')
      expect(result).to be_nil
    end
  end

  describe '.duplicate' do
    it 'returns grouped duplicates by email' do
      duplicates = described_class.duplicate
      expect(duplicates.keys).to include('alice@example.com')
      expect(duplicates['alice@example.com'].size).to eq(2)
    end

    it 'returns empty hash if no duplicates' do
      described_class.instance_variable_set(:@data, [
        described_class.new({ 'id' => 1, 'full_name' => 'Alice Smith', 'email' => 'alice@example.com' }),
        described_class.new({ 'id' => 2, 'full_name' => 'Bob Johnson', 'email' => 'bob@example.com' }),
        described_class.new({ 'id' => 3, 'full_name' => 'Charlie Brown', 'email' => 'charlie@example.com' })
      ])

      duplicates = described_class.duplicate
      expect(duplicates).to eq({})
    end
  end

  describe '.dataset with path' do
    it 'returns the expected dataset path' do
      path = described_class.dataset[:path]
      expect(path).to end_with('clients.json')
      expect(File.extname(path)).to eq('.json')
    end
  end

  describe '.dataset with url' do
    it 'returns the expected dataset path' do
      url = described_class.dataset[:url]
      expect(url).to end_with('clients.json')
      expect(File.extname(url)).to eq('.json')
    end
  end
end
