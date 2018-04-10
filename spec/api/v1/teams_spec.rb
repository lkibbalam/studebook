require 'rails_helper'

describe 'get all teams route' do
  let!(:teams) { create_list(:team, 10) }

  before { get '/api/v1/teams' }

  it 'returns all teams' do
    expect(JSON.parse(response.body).size).to eq 10
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end
end
