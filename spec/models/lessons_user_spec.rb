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

  describe '.unlocked_next_lesson' do
    let(:lessons_user_count) { 3 }
    let!(:lessons_user) { create_list(:lessons_user, lessons_user_count, status: :locked) }
    let(:course) { lessons_user.first.lesson.course }
    let(:student) { lessons_user.first.student }
    let!(:course_user) { create(:courses_user, student: student, course: course) }
    let!(:unlock) { lessons_user.first.update(status: :unlocked) }

    it 'should unlock next lesson in course for student when current are done' do
      expect do
        lessons_user.first.update(status: :done)
      end.to change(lessons_user.second, :status).from('locked').to('unlocked')
      # TODO: finish, course have only one lesson, that  why dont work
    end
  end
end
