require 'rails_helper'

RSpec.describe "Api::V1::Recipes", type: :request do
  describe 'GET /api/v1/recipes' do
    before do
      stub_request(:get, "https://www.themealdb.com/api/json/v1/1/filter.php?c=Beef").to_return(status: 200, body: File.read('spec/fixtures/recipes.json'), headers: { 'Content-Type' => 'application/json' })
      get '/api/v1/recipes', params: { category_name: 'Beef' }
    end

    it 'returns recipes' do
      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(46)
      expect(json_response.first['id']).to eq("52874")
      expect(json_response.first['name']).to eq("Beef and Mustard Pie")
    end

    context 'when category name is not provided' do
      before do
        get '/api/v1/recipes'
      end

      it 'returns an error' do
        expect(response).to have_http_status(400)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('Category name is required')
      end
    end
  end
end
