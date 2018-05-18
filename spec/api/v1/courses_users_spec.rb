require 'rails_helper'

describe 'courses_users_spec' do
  let!(:user) { create(:user) }
  let!(:course) { create(:course) }
  let!(:course_user) { create(:courses_user, student: user, course: course) }

  describe 'GET #show' do
    context 'non-authenticate request' do
      before { get "/api/v1/course_user/#{course.id}" }

      it 'when request' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'authenticate request' do
      before { get "/api/v1/course_user/#{course.id}", headers: authenticated_header(user) }

      it 'when request' do
        expect(response).to have_http_status(:success)
      end
    end
  end
end
