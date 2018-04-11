require 'rails_helper'

describe 'lesson' do
  let!(:user) { create(:user) }
  let!(:course) { create(:course, author: user) }
  let!(:lessons) { create_list(:lesson, 10, course_id: course.id) }
  let!(:lesson) { lessons.first }
  describe 'GET #index' do
    before { get "/api/v1/courses/#{course.id}/lessons" }

    it 'should return 200 success' do
      expect(response).to be_success
    end

    it 'course contains ten lessons' do
      expect(JSON.parse(response.body).size).to eq 10
    end
  end

  describe 'GET #show' do
    before { get "/api/v1/lessons/#{lesson.id}" }
    it 'returns status 200 success' do
      expect(response).to be_success
    end

    %w[id course_id description material video task created_at updated_at].each do |attr|
      it "check contains lesson, #{attr}" do
        expect(response.body).to be_json_eql(lesson.send(attr.to_sym).to_json).at_path(attr)
      end
    end
  end
end
