# frozen_string_literal: true

require 'rails_helper'
describe 'teams_controller_spec' do
  let!(:team) { create(:team) }
  let!(:admin) { create(:user, :admin, team: team) }

  describe 'GET #index' do
    let!(:teams) { create_list(:team, 9) }

    context 'when non authenticate' do
      before { get '/api/v1/teams' }

      it_behaves_like 'non authenticate request'
    end

    context 'when authenticate' do
      before { get '/api/v1/teams', headers: authenticated_header(admin) }

      it_behaves_like 'authenticate request'
      it_behaves_like 'response body with 10 objects'
    end
  end

  describe 'GET #show' do
    context 'when non authenticate' do
      before { get "/api/v1/teams/#{team.id}" }

      it_behaves_like 'non authenticate request'
    end

    context 'when authenticate' do
      before { get "/api/v1/teams/#{team.id}", headers: authenticated_header(admin) }

      %w[title description].each do |attr|
        it "team object contains, #{attr}" do
          expect(response.body).to be_json_eql(team.send(attr.to_sym).to_json).at_path("data/attributes/#{attr}")
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
                              headers: authenticated_header(admin)
      end

      it { expect { create_team }.to change(Team, :count).by(1) }
    end
  end

  describe 'PATCH #update' do
    let(:params) do
      { team: { title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph } }
    end

    context 'when non authenticate' do
      before do
        patch "/api/v1/teams/#{team.id}", params: params
      end

      it_behaves_like 'non authenticate request'
    end

    before do
      patch "/api/v1/teams/#{team.id}", params: params, headers: authenticated_header(admin)
    end

    it { expect(team.reload.title).to eq(params.dig(:team, :title)) }
    it { expect(team.reload.description).to eq(params.dig(:team, :description)) }
  end

  describe 'DELETE #destroy' do
    context 'when non authenticate' do
      before { delete "/api/v1/teams/#{team.id}" }

      it_behaves_like 'non authenticate request'
    end

    context 'when authenticate' do
      let(:delete_team) { delete "/api/v1/teams/#{team.id}", headers: authenticated_header(admin) }

      it { expect { delete_team }.to change(Team, :count).by(-1) }
    end
  end
end
