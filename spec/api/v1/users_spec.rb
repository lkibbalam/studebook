require 'rails_helper'

describe 'get all teams route' do
  let!(:team) { create(:team) }
  let!(:team2) { create(:team) }
  let!(:users) { create_list(:user, 5, team: team) }

  describe 'GET #index' do
    context 'team users #index' do
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
    let(:user) { users.first }
    before { get "/api/v1/users/#{user.id}" }

    it 'returns status code 200' do
      expect(response).to be_success
    end

    %w[id team_id mentor_id role first_name last_name phone created_at updated_at].each do |attr|
      it "user object contains #{attr}" do
        expect(response.body).to be_json_eql(user.send(attr.to_sym).to_json).at_path(attr)
      end
    end
  end
end
