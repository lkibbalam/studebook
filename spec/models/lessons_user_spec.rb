# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LessonsUser, type: :model do
  it { should belong_to(:student).class_name('User').with_foreign_key('student_id') }
  it { should belong_to(:lesson) }
  it { should have_many(:comments).dependent(:destroy) }

  let(:tasks_count) { 3 }
  let(:lesson) { create(:lesson, tasks: create_list(:task, tasks_count)) }
  let(:lesson_user) { create(:lessons_user, lesson: lesson) }

  describe '.create_tasks_user' do
    it 'should create task_user list for lesson_user when created' do
      expect { lesson_user }.to change(TasksUser, :count).to(tasks_count)
    end
  end

  describe 'when mentor approve lesson for user' do
    let(:lessons_count) { 10 }
    let(:student) { create(:user, :student) }
    let(:course) { create(:course, lessons: create_list(:lesson, lessons_count)) }
    let!(:course_user) { create(:courses_user, student: student, course: course) }
    let(:lesson_user_first) { student.lessons_users.first }
    let(:lesson_user_second) { student.lessons_users.second }

    describe '.unlocked_next_lesson' do
      it 'should unlock next lesson in course for student when current are done' do
        expect do
          lesson_user_first.update(status: :done)
          lesson_user_second.reload
        end.to change(lesson_user_second, :status).from('locked').to('unlocked')
      end
    end

    describe '.change_course_progress' do
      it 'should adds course user progress when lesson has been approve' do
        expect do
          lesson_user_first.update(status: :done)
          course_user.reload
        end.to change(course_user, :progress).from(0).to(100 / lessons_count)
      end
    end
  end
end
