# frozen_string_literal: true

require 'rails_helper'

describe TaskPolicy do
  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }
  let(:task) { create(:task) }

  subject { described_class }

  permissions :show? do
    it 'admin can watch task' do
      expect(subject).to permit(admin, task)
    end
  end

  permissions :create? do
    it 'admin can create task' do
      expect(subject).to permit(admin, task)
    end
  end

  permissions :update? do
    it 'admin can update task' do
      expect(subject).to permit(admin, task)
    end
  end

  permissions :destroy? do
    it 'admin cant destroy' do
      expect(subject).to permit(admin, task)
    end
  end
end
