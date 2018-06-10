# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TaskPolicy do
  let(:user) { User.new }
  let(:admin) { User.new(role: :admin) }

  subject { described_class }

  permissions :show? do
    it 'admin can watch task' do
      expect(subject).to permit(admin, Task.new)
    end
  end

  permissions :create? do
    it 'admin can create task' do
      expect(subject).to permit(admin, Task.new)
    end
  end

  permissions :update? do
    it 'admin can update task' do
      expect(subject).to permit(admin, Task.new)
    end
  end

  permissions :destroy? do
    it 'admin cant destroy' do
      expect(subject).to permit(admin, Task.new)
    end
  end
end
