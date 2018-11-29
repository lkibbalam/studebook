# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksUser, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:task) }
  it { should have_many(:notifications) }

  let(:mentor) { create(:user, :staff) }
  let(:student) { create(:user, :student, mentor: mentor) }
  let(:course) { create(:course, lessons: create_list(:lesson_with_3_tasks, 3)) }
  let!(:course_user) { create(:courses_user, student: student, course: course) }

  describe '.unlock_next_lesson' do
    let(:chang_all_tasks) { student.tasks_users.where(task: course.lessons.first.tasks).update_all(status: :verifying) }
    let(:approve_all_tasks) { student.tasks_users.where(task: course.lessons.first.tasks).each(&:accept!) }
    let!(:lesson_user) { student.lessons_users.second }

    it 'when approve last task of lesson' do
      chang_all_tasks
      approve_all_tasks
      expect do
        lesson_user.reload
      end.to change(lesson_user, :status).from('locked').to('unlocked')
    end
  end
end
