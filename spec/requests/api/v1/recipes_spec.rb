require 'rails_helper'

RSpec.describe "Api::V1::Recipes", type: :request do
  describe 'GET /api/v1/recipes' do
    context 'when the category name is provided' do
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
        expect(json_response.first['instructions']).to be_nil
      end
    end

    context 'when the category name is invalid' do
      before do
        stub_request(:get, "https://www.themealdb.com/api/json/v1/1/filter.php?c=Spam").to_return(status: 200, body: '{"meals": null}', headers: { 'Content-Type' => 'application/json' })
        get '/api/v1/recipes', params: { category_name: 'Spam' }
      end

      it 'returns an error' do
        expect(response).to have_http_status(404)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('Category not found')
      end
    end

    context 'when the category name is not provided' do
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

  describe 'GET /api/v1/recipes/:id' do
    context 'when the recipe id exists' do
      before do
        stub_request(:get, "https://www.themealdb.com/api/json/v1/1/lookup.php?i=52874").to_return(status: 200, body: File.read('spec/fixtures/recipe.json'), headers: { 'Content-Type' => 'application/json' })
        get '/api/v1/recipes/52874'
      end

      it 'returns the recipe' do
        expect(response).to have_http_status(200)
        json_response = JSON.parse(response.body)
        expect(json_response['id']).to eq("52874")
        expect(json_response['name']).to eq("Beef and Mustard Pie")
        expect(json_response['category']).to eq("Beef")
        expect(json_response['ingredients'].length).to eq(15)
        expect(json_response['ingredients'][0]).to eq("1kg Beef")
        expect(json_response['ingredients'][1]).to eq("2 tbs Plain Flour")
      end
    end

    context 'when the recipe id doesnt exist' do
      before do
        stub_request(:get, "https://www.themealdb.com/api/json/v1/1/lookup.php?i=9999999999").to_return(status: 200, body: '{"meals": null}', headers: { 'Content-Type' => 'application/json' })
        get '/api/v1/recipes/9999999999'
      end

      it 'returns an error' do
        expect(response).to have_http_status(404)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('Recipe not found')
      end
    end
  end
end
