# frozen_string_literal: true

require 'rails_helper'

describe 'lessons_users_spec' do
  let(:mentor) { create(:user, :staff) }
  let(:student) { create(:user, :student, mentor: mentor) }
  let(:course) { create(:course) }
  let(:lesson) { create(:lesson, course: course) }
  let!(:course_user) { create(:courses_user, student: student, course: course) }
  let!(:lesson_user) { create(:lessons_user, student: student, lesson: lesson) }

  describe 'PATCH #approve_lesson' do
    context 'when non authenticate request' do
      before { patch "/api/v1/lesson_user/#{lesson_user.id}/approve" }

      it_behaves_like 'non authenticate request'
    end

    context 'when authenticate request' do
      before do
        patch "/api/v1/lesson_user/#{lesson_user.id}/approve", params: { lesson_user: { status: :done, mark: 100 } },
                                                               headers: authenticated_header(mentor)
      end
      it_behaves_like 'authenticate request'

      it { expect(lesson_user.reload.status.to_sym).to eql(:done) }
      it { expect(lesson_user.reload.mark).to eql(100) }
    end
  end
end
