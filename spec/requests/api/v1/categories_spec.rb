require 'rails_helper'

RSpec.describe "Api::V1::Categories", type: :request do
  describe 'GET /api/v1/categories' do
    before do
      stub_request(:get, "https://www.themealdb.com/api/json/v1/1/categories.php").to_return(status: 200, body: File.read('spec/fixtures/categories.json'), headers: { 'Content-Type' => 'application/json' })
      get '/api/v1/categories'
    end

    it 'returns categories' do
      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(14)
      expect(json_response.first['id']).to eq("1")
      expect(json_response.first['name']).to eq("Beef")
    end
  end
end
