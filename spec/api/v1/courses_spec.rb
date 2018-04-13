require 'rails_helper'

describe 'course' do
  let!(:user) { create(:user) }
  let!(:courses) { create_list(:course, 10, author: user) }
  let!(:course) { courses.first }

  describe 'GET #index' do
    before { get "/api/v1/teams/#{course.team_id}/courses" }

    it_behaves_like 'request'
    it_behaves_like 'resource contain'
  end

  describe 'GET #show' do
    before { get "/api/v1/courses/#{course.id}" }

    it_behaves_like 'request'

    %w[id team_id author_id description title created_at updated_at].each do |attr|
      it "user object contains #{attr}" do
        expect(response.body).to be_json_eql(course.send(attr.to_sym).to_json).at_path(attr)
      end
    end
  end

  describe 'Nested comments' do
    let!(:subject) { create(:course) }

    describe 'GET #comments' do
      it_behaves_like 'Commentable_comment'
    end

    describe 'POST #create_comment' do
      it_behaves_like 'Commentable_create'
    end

    describe 'PATCH #update_comment' do
      it_behaves_like 'Commentable_update'
    end

    describe 'DELETE #destroy_comment' do
      it_behaves_like 'Commentable_destroy'
    end
  end
end
