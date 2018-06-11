# frozen_string_literal: true

require 'rails_helper'

describe 'courses_users_spec' do
  let!(:admin) { create(:user, :admin) }
  let!(:user) { create(:user) }
  let(:lessons) { create_list(:lesson, 3, tasks: create_list(:task, 3)) }
  let!(:course) { create(:course, lessons: lessons) }
  let!(:course_user) { create(:courses_user, student: user, course: course) }

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
end
