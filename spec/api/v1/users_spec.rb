require 'rails_helper'

describe 'get all teams route' do
  describe 'GET #index' do
    let!(:team) { create(:team) }
    let!(:team2) { create(:team) }
    let!(:users) { create_list(:user, 5, team: team) }
    context 'team users index' do
      before { get "/api/v1/teams/#{team.id}/users" }

      it 'returns all teams' do
        expect(JSON.parse(response.body).size).to eq 5
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end
    context 'it should be nothing' do
      before { get "/api/v1/teams/#{team2.id}/users" }

      it 'returns all teams' do
        expect(JSON.parse(response.body).size).to eq 0
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET #show' do
  end
end
