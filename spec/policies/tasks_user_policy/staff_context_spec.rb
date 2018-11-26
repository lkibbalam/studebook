# frozen_string_literal: true

require 'rails_helper'

describe TasksUserPolicy do
  subject { described_class.new(staff, task_user) }

  let(:resolved_scope) do
    described_class::Scope.new(staff, TasksUser.all).resolve
  end

  context 'active staff accessing' do
    let(:staff) { create(:user, :staff) }

    context 'own task user' do
      let(:task_user) { create(:tasks_user, user: staff) }

      it 'includes task user in resolved scope' do
        expect(resolved_scope).to include(task_user)
      end

      it { is_expected.to permit_actions(%i[show update]) }
    end

    context 'own padawan task user' do
      let(:padawan) { create(:user, :student, mentor: staff) }
      let(:task_user) { create(:tasks_user, user: padawan) }

      it 'includes task user in resolved scope' do
        expect(resolved_scope).to include(task_user)
      end

      it { is_expected.to permit_actions(%i[show update]) }
    end

    context 'not own task user' do
      let(:task_user) { create(:tasks_user) }

      it 'excludes task user from resolved scope' do
        expect(resolved_scope).not_to include(task_user)
      end

      it { is_expected.to forbid_actions(%i[show update]) }
    end
  end

  context 'inactive student accessing a task user' do
    let(:staff) { create(:user, :staff, :inactive) }
    let(:task_user) { create(:tasks_user, user: staff) }

    it { is_expected.to forbid_actions(%i[show update]) }
  end
end
