# frozen_string_literal: true

require "rails_helper"

describe TasksUserPolicy do
  subject { described_class.new(student, task_user) }

  let(:resolved_scope) do
    described_class::Scope.new(student, TasksUser.all).resolve
  end

  context "student accessing own task user" do
    let(:student) { create(:user, :student) }
    let(:task_user) { create(:tasks_user, user: student) }

    it "includes course user in resolved scope" do
      expect(resolved_scope).to include(task_user)
    end

    it { is_expected.to permit_actions(%i[show update]) }
  end

  context "student accessing not own" do
    let(:student) { create(:user, :student) }
    let(:task_user) { create(:tasks_user) }

    it "excludes task user from resolved scope" do
      expect(resolved_scope).not_to include(task_user)
    end

    it { is_expected.to forbid_actions(%i[show update]) }
  end

  context "inactive student accessing a task user" do
    let(:student) { create(:user, :student, :inactive) }
    let(:task_user) { create(:tasks_user, user: student) }

    it { is_expected.to forbid_actions(%i[show update]) }
  end
end
