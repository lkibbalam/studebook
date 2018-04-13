require 'rails_helper'

describe 'get all teams route' do
  let!(:team) { create(:team) }
  let!(:team2) { create(:team) }
  let!(:users) { create_list(:user, 10, team: team) }

  describe 'GET #index' do
    context 'team users #index' do
      before { get "/api/v1/teams/#{team.id}/users" }

      it_behaves_like 'request'
      it_behaves_like 'resource contain'
    end

    context 'when resource don`t have a users' do
      before { get "/api/v1/teams/#{team2.id}/users" }

      it 'when get resource nested users' do
        expect(JSON.parse(response.body).size).to eq 0
      end

      it_behaves_like 'request'
    end
  end

  describe 'GET #show' do
    let(:user) { users.first }
    before { get "/api/v1/users/#{user.id}" }

    it_behaves_like 'request'

    %w[id team_id mentor_id role first_name last_name phone created_at updated_at].each do |attr|
      it "user object contains #{attr}" do
        expect(response.body).to be_json_eql(user.send(attr.to_sym).to_json).at_path(attr)
      end
    end
  end
end
