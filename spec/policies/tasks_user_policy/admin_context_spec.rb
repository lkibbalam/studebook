# frozen_string_literal: true

require 'rails_helper'

describe TasksUserPolicy do
  subject { described_class.new(admin, task_user) }

  let(:task_user) { create(:tasks_user) }

  let(:resolved_scope) do
    described_class::Scope.new(admin, TasksUser.all).resolve
  end

  context 'admin with active status accessing' do
    let(:admin) { create(:user, :admin) }

    it 'includes in resolved scope' do
      expect(resolved_scope).to include(task_user)
    end

    it { is_expected.to permit_actions(%i[show update]) }
  end

  context 'admin with inactive status' do
    let(:admin) { create(:user, :admin, status: :inactive) }

    context 'accessing a course' do
      it { is_expected.to forbid_actions(%i[show update]) }
    end
  end
end
