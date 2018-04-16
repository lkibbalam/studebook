require 'rails_helper'

describe 'users' do
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

  describe 'POST #create' do
    let(:create_user) { post "/api/v1/teams/#{team.id}/users", params: { user: attributes_for(:user) } }
    it { expect { create_user }.to change(User, :count).by(1) }
  end

  describe 'PATCH #update' do
    let!(:user) { create(:user) }

    before do
      patch "/api/v1/users/#{user.id}", params: { user: { first_name: 'NewFirst', last_name: 'NewLast', phone: 0 } }
      user.reload
    end

    it { expect(user.first_name).to eql('NewFirst') }
    it { expect(user.last_name).to eql('NewLast') }
    it { expect(user.phone).to eql(0) }
  end

  describe 'DELETE #destroy' do
    let!(:user) { create(:user) }

    it { expect { delete "/api/v1/users/#{user.id}" }.to change(User, :count).by(-1) }
  end
end
