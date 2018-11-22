# frozen_string_literal: true

require 'rails_helper'

describe NotificationPolicy do
  let(:user) { create(:user) }
  let!(:mentor) { create(:user, :staff) }
  let!(:student) { create(:user, :student, mentor: mentor) }
  let!(:task_user) { create(:tasks_user, user: student) }

  subject { described_class }

  permissions :update? do
    it 'mentor can update status to seen own notification' do
      expect(subject).to permit(mentor, create(:notification, tasks_user: task_user, user: mentor, status: :seen))
    end
  end
end
