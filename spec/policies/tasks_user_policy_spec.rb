# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksUserPolicy do
  let(:admin) { User.new(role: :admin) }
  let(:lead) { User.new(role: :leader) }
  let(:moder) { User.new(role: :moder) }
  let!(:staff) { User.new(role: :staff) }
  let!(:student) { User.new(role: :student, mentor: staff) }
  let!(:user) { User.new }

  subject { described_class }

  # permissions :index? do
  # end

  permissions :show? do
    it 'user can see own task' do
      expect(subject).to permit(student, TasksUser.new(user: student))
    end

    it 'admin can see all task' do
      expect(subject).to permit(admin, TasksUser.new(user: student))
    end

    it 'mentor can see task own student' do
      expect(subject).to permit(staff, TasksUser.new(user: student))
    end
  end

  permissions :update? do
    it 'student can update own task to verifying' do
      expect(subject).to permit(student, TasksUser.new(user: student, status: :verifying))
    end

    it 'student can`t update own task to change accept' do
      expect(subject).to_not permit(student, TasksUser.new(user: student, status: :accept))
      expect(subject).to_not permit(student, TasksUser.new(user: student, status: :change))
    end

    it 'mentor can update task of his student to change accept' do
      expect(subject).to permit(staff, TasksUser.new(user: student, status: :accept))
      expect(subject).to permit(staff, TasksUser.new(user: student, status: :change))
    end
  end
end
