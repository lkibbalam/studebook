require 'rails_helper'

describe 'get all courses' do
  let!(:user) { create(:user) }
  let!(:courses) { create_list(:course, 10, author: user) }
  let!(:course) { courses.first }

  describe 'GET #index' do
    before { get "/api/v1/teams/#{course.team_id}/courses" }

    it 'returns all teams' do
      expect(JSON.parse(response.body).size).to eq 10
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    before { get "/api/v1/courses/#{course.id}" }

    it 'returns 200 status success' do
      expect(response).to be_success
    end

    %w[id team_id author_id description title created_at updated_at].each do |attr|
      it "check course json contain, #{attr}" do
        expect(response.body).to be_json_eql(course.send(attr.to_sym).to_json).at_path(attr)
      end
    end
  end
end
