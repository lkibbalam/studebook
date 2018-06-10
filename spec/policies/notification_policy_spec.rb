# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotificationPolicy do
  let(:user) { User.new }
  let!(:mentor) { User.new(role: :staff) }
  let!(:student) { User.new(role: :student, mentor: mentor) }
  let!(:task_user) { TasksUser.new(task: Task.new, user: student) }

  subject { described_class }

  permissions :index? do
    it 'mentor can see all own notifications' do
      expect(subject).to permit(mentor, Notification.new(tasks_user: task_user, user: mentor))
    end
  end

  permissions :seen? do
    it 'mentor can update status to seen own notification' do
      expect(subject).to permit(mentor, Notification.new(tasks_user: task_user, user: mentor, status: :seen))
    end
  end
end
