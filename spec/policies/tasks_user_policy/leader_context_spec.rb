# frozen_string_literal: true

require 'rails_helper'

describe TasksUserPolicy do
  subject { described_class.new(leader, task_user) }

  let(:resolved_scope) do
    described_class::Scope.new(leader, TasksUser.all).resolve
  end

  context 'active leader accessing' do
    let(:leader) { create(:user, :leader) }

    context 'own task user' do
      let(:task_user) { create(:tasks_user, user: leader) }

      it 'includes task user in resolved scope' do
        expect(resolved_scope).to include(task_user)
      end

      it { is_expected.to permit_actions(%i[show update]) }
    end

    context 'own team task user' do
      let(:task) do
        create(:task, lesson: create(:lesson, course: create(:course, team: leader.team)))
      end

      let(:padawan) { create(:user, :student, mentor: leader) }
      let(:task_user) { create(:tasks_user, task: task) }

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
    let(:leader) { create(:user, :leader, :inactive) }
    let(:task_user) { create(:tasks_user, user: leader) }

    it { is_expected.to forbid_actions(%i[show update]) }
  end
end
