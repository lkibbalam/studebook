require 'rails_helper'
describe 'teams_controller_spec' do
  let!(:teams) { create_list(:team, 10) }
  let!(:user) { create(:user, team: teams.second) }

  describe 'GET #index' do
    context 'when non authenticate' do
      before { get '/api/v1/teams' }

      it_behaves_like 'non authenticate request'
    end

    context 'when authenticate' do
      before { get '/api/v1/teams', headers: authenticated_header(user) }

      it_behaves_like 'authenticate request'
      it_behaves_like 'resource contain'
    end
  end

  describe 'GET #show' do
    context 'when non authenticate' do
      before { get "/api/v1/teams/#{teams.first.id}" }

      it_behaves_like 'non authenticate request'
    end

    context 'when authenticate' do
      before { get "/api/v1/teams/#{teams.first.id}", headers: authenticated_header(user) }

      %w[id title description created_at updated_at].each do |attr|
        it "team object contains, #{attr}" do
          expect(response.body).to be_json_eql(teams.first.send(attr.to_sym).to_json).at_path(attr)
        end
      end
    end
  end

  describe 'POST #create' do
    context 'when non authenticate' do
      before { post '/api/v1/teams', params: { team: attributes_for(:team) } }

      it_behaves_like 'non authenticate request'
    end

    context 'when authenticate' do
      let(:create_team) do
        post '/api/v1/teams', params: { team: attributes_for(:team) },
                              headers: authenticated_header(user)
      end

      it { expect { create_team }.to change(Team, :count).by(1) }
    end
  end

  describe 'PATCH #update' do
    context 'when non authenticate' do
      before { patch "/api/v1/teams/#{teams.first.id}", params: { team: { title: 'NewTitle', description: 'NewDesc' } } }

      it_behaves_like 'non authenticate request'
    end

    before do
      patch "/api/v1/teams/#{teams.first.id}", params: { team: { title: 'NewTitle', description: 'NewDesc' } },
                                               headers: authenticated_header(user)
      teams.first.reload
    end

    it { expect(teams.first.title).to eql('NewTitle') }
    it { expect(teams.first.description).to eql('NewDesc') }
  end

  describe 'DELETE #destroy' do
    context 'when non authenticate' do
      before { delete "/api/v1/teams/#{teams.first.id}" }

      it_behaves_like 'non authenticate request'
    end

    context 'when authenticate' do
      let(:delete_team) { delete "/api/v1/teams/#{teams.first.id}", headers: authenticated_header(user) }

      it { expect { delete_team }.to change(Team, :count).by(-1) }
    end
  end
end
