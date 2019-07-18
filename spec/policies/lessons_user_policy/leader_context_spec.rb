# frozen_string_literal: true

require "rails_helper"

describe LessonsUserPolicy do
  subject { described_class.new(leader, lesson_user) }

  let(:resolved_scope) do
    described_class::Scope.new(leader, LessonsUser.all).resolve
  end

  context "leader accessing own lesson user" do
    let(:leader) { create(:user, :leader) }
    let(:lesson_user) { create(:lessons_user, student: leader) }

    it "includes lessons user in resolved scope" do
      expect(resolved_scope).to include(lesson_user)
    end

    it { is_expected.to permit_actions(%i[show update]) }
  end

  context "leader accessing not own" do
    let(:leader) { create(:user, :leader) }

    context "not own team" do
      let(:lesson_user) { create(:lessons_user) }

      it "excludes lesson user from resolved scope" do
        expect(resolved_scope).not_to include(lesson_user)
      end

      it { is_expected.to forbid_actions(%i[show update]) }
    end

    context "own padawan" do
      let(:padawan) { create(:user, :student, mentor: leader) }
      let(:lesson_user) do
        create(:lessons_user, student: padawan,
                              lesson: create(:lesson, course: create(:course, team: leader.team)))
      end

      it "include lesson user from resolved scope" do
        expect(resolved_scope).to include(lesson_user)
      end

      it { is_expected.to permit_actions(%i[show update]) }
    end

    context "own team" do
      let(:user) { create(:user, :student, team: leader.team) }
      let(:lesson_user) do
        create(:lessons_user, student: user,
                              lesson: create(:lesson, course: create(:course, team: leader.team)))
      end

      it "include lesson user from resolved scope" do
        expect(resolved_scope).to include(lesson_user)
      end

      it { is_expected.to permit_actions(%i[show update]) }
    end
  end

  context "inactive leader accessing a lesson user" do
    let(:leader) { create(:user, :leader, status: :inactive) }
    let(:lesson_user) { create(:lessons_user, student: leader) }

    it { is_expected.to forbid_actions(%i[show update]) }
  end
end
