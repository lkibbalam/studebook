require 'rails_helper'
describe 'teams' do
  describe 'GET #index' do
    let!(:teams) { create_list(:team, 10) }
    before { get '/api/v1/teams' }

    it_behaves_like 'request'
    it_behaves_like 'resource contain'
  end

  describe 'GET #show' do
    let!(:team) { create(:team) }
    before { get "/api/v1/teams/#{team.id}" }

    %w[id title description created_at updated_at].each do |attr|
      it "team object contains, #{attr}" do
        expect(response.body).to be_json_eql(team.send(attr.to_sym).to_json).at_path(attr)
      end
    end
  end

  describe 'POST #create' do
    it { expect { post '/api/v1/teams', params: { team: attributes_for(:team) } }.to change(Team, :count).by(1) }
  end

  describe 'PATCH #update' do
    let!(:team) { create(:team) }
    before do
      patch "/api/v1/teams/#{team.id}", params: { team: { title: 'NewTitle', description: 'NewDesc' } }
      team.reload
    end

    it { expect(team.title).to eql('NewTitle') }
    it { expect(team.description).to eql('NewDesc') }
  end

  describe 'DELETE #destroy' do
    let!(:team) { create(:team) }

    it { expect { delete "/api/v1/teams/#{team.id}" }.to change(Team, :count).by(-1) }
  end
end
