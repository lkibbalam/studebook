# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoursesUser, type: :model do
  it { should belong_to(:course) }
  it { should belong_to(:student).class_name('User').with_foreign_key('student_id') }
  it { should have_many(:comments).dependent(:destroy) }

  let(:student) { create(:user) }
  let(:course_user) { create(:courses_user, student: student) }

  describe '.full_progress_for_archived' do
    let(:archive_course) { course_user.update(status: :archived) }

    it 'should full progress after archived course' do
      expect { archive_course }.to change(course_user, :progress).from(0).to(100)
    end
  end
end
