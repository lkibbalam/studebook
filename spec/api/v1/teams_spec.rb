require 'rails_helper'

describe 'teams' do
  let!(:teams) { create_list(:team, 10) }
  before { get '/api/v1/teams' }

  it_behaves_like 'request'
  it_behaves_like 'resource contain'
end
