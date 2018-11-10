# frozen_string_literal: true

require 'rails_helper'

describe TasksUserPolicy do
  let(:admin) { create(:user, :admin) }
  let(:lead) { create(:user, :leader) }
  let(:moder) { create(:user, :moder) }
  let!(:staff) { create(:user, :staff) }
  let!(:student) { create(:student, mentor: staff) }
  let(:task_user) { create(:tasks_user, user: student) }

  subject { described_class }

  # permissions :index? do
  # end

  permissions :show? do
    it 'user can see own task' do
      expect(subject).to permit(student, task_user)
    end

    it 'admin can see all task' do
      expect(subject).to permit(admin, task_user)
    end

    it 'mentor can see task own student' do
      expect(subject).to permit(staff, task_user)
    end
  end

  permissions :update? do
    it 'student can update own task to verifying' do
      expect(subject).to permit(student, create(:tasks_user, user: student, status: :verifying))
    end

    it 'student can`t update own task to change accept' do
      expect(subject).to_not permit(student, create(:tasks_user, user: student, status: :accept))
      expect(subject).to_not permit(student, create(:tasks_user, user: student, status: :change))
    end

    it 'mentor can update task of his student to change accept' do
      expect(subject).to permit(staff, create(:tasks_user, user: student, status: :accept))
      expect(subject).to permit(staff, create(:tasks_user, user: student, status: :change))
    end
  end
end
