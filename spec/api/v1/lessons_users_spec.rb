# frozen_string_literal: true

# frozen_string_literal = true

require 'rails_helper'

describe 'lessons_users_spec' do
  let(:mentor) { create(:user) }
  let(:lessons_user) { create(:lessons_user, student: create(:user), lesson: create(:lesson)) }

  describe 'PATCH #approve_lesson' do
    context 'when non authenticate request' do
      before { patch "/api/v1/lesson_user/#{lessons_user.id}/approve" }

      it_behaves_like 'non authenticate request'
    end

    context 'when authenticate request' do
      before { patch "/api/v1/lesson_user/#{lessons_user.id}/approve", headers: authenticated_header(mentor) }
      it_behaves_like 'authenticate request'

      it { expect(lessons_user.status).to eql('done') }
    end
  end
end
