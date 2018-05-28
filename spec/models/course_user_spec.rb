# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoursesUser, type: :model do
  it { should belong_to(:course) }
  it { should belong_to(:student).class_name('User').with_foreign_key('student_id') }
  it { should have_many(:comments).dependent(:destroy) }

  describe 'create_course_lessons' do
    let(:lessons_count) { 20 }
    let(:student) { create(:user) }
    let(:course) { create(:course, lessons: create_list(:lesson, lessons_count)) }
    let(:course_user) { create(:courses_user, student: student, course: course) }

    it 'create list of lessons_user with count of course lessons' do
      expect { course_user }.to change(student.lessons_users, :count).by(lessons_count)
    end

    it 'first lessons_user should be unlocked' do
      course_user
      expect(LessonsUser.find_by(student: student,
                                 lesson: course_user.course.lessons.first).status).to eql('unlocked')
    end

    it 'second and bigger lessons_user should be locked' do
      course_user
      expect(LessonsUser.all.select(&:locked?).count).to eql(lessons_count - 1)
      expect(LessonsUser.all.select(&:unlocked?).count).to eql(1)
    end
  end
end
