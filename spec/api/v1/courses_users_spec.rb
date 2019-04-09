# frozen_string_literal: true

require 'rails_helper'

describe 'courses_users_spec' do
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user, :student) }
  let!(:course) { create(:course, :published) }
  let!(:lessons) { create_list(:lesson, 3, course: course) }
  let!(:tasks_list1) { create_list(:task, 3, lesson: lessons.first) }
  let!(:tasks_list2) { create_list(:task, 3, lesson: lessons.second) }
  let!(:tasks_list3) { create_list(:task, 3, lesson: lessons.third) }

  describe 'GET #index' do
    context 'non-authenticate request' do
      before { get '/api/v1/' }

      it_behaves_like 'non authenticate request'
    end

    context 'authenticate request' do
      before { get '/api/v1/', headers: authenticated_header(admin) }

      it_behaves_like 'authenticate request'
    end
  end

  describe 'POST #create' do
    context 'when non authenticate request' do
      before { post "/api/v1/courses/#{course.id}/start_course" }

      it_behaves_like 'non authenticate request'
    end

    context 'when authenticate request' do
      let(:start_course) do
        post "/api/v1/courses/#{course.id}/start_course", headers: authenticated_header(user)
      end

      it { expect { start_course }.to change(CoursesUser, :count).by(1) }
    end
  end
end
