# frozen_string_literal: true

require 'rails_helper'

describe TasksUserPolicy do
  subject { described_class.new(visitor, task_user) }

  let(:visitor) { nil }
  let(:resolved_scope) do
    described_class::Scope.new(visitor, TasksUser.all).resolve
  end

  context 'visitor accessing a task user' do
    let(:task_user) { create(:tasks_user) }

    it 'should be empty' do
      expect(resolved_scope).to be_empty
    end

    it { is_expected.to forbid_actions(%i[show update]) }
  end
end
