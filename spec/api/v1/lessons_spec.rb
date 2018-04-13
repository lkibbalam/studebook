require 'rails_helper'

describe 'lesson' do
  let!(:course) { create(:course) }
  let!(:lessons) { create_list(:lesson, 10, course_id: course.id) }
  let!(:lesson) { lessons.first }

  describe 'GET #index' do
    before { get "/api/v1/courses/#{course.id}/lessons" }

    it_behaves_like 'request'
    it_behaves_like 'resource contain'
  end

  describe 'GET #show' do
    before { get "/api/v1/lessons/#{lessons.first.id}" }

    it_behaves_like 'request'

    %w[id course_id description material video task created_at updated_at].each do |attr|
      it "user object contains #{attr}" do
        expect(response.body).to be_json_eql(lesson.send(attr.to_sym).to_json).at_path(attr)
      end
    end
  end

  describe 'Nested comments' do
    let!(:subject) { create(:lesson) }

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
