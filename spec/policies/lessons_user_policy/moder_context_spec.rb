# frozen_string_literal: true

require "rails_helper"

describe LessonsUserPolicy do
  subject { described_class.new(moder, lesson_user) }

  let(:resolved_scope) do
    described_class::Scope.new(moder, LessonsUser.all).resolve
  end

  context "moder accessing own lesson user" do
    let(:moder) { create(:user, :moder) }
    let(:lesson_user) { create(:lessons_user, student: moder) }

    it "includes lessons user in resolved scope" do
      expect(resolved_scope).to include(lesson_user)
    end

    it { is_expected.to permit_actions(%i[show update]) }
  end

  context "moder accessing not own" do
    let(:moder) { create(:user, :moder) }

    context "not own team" do
      let(:lesson_user) { create(:lessons_user) }

      it "excludes lessons user from resolved scope" do
        expect(resolved_scope).not_to include(lesson_user)
      end

      it { is_expected.to forbid_actions(%i[show update]) }
    end

    context "own padawan" do
      let(:padawan) { create(:user, :student, mentor: moder) }
      let(:lesson_user) do
        create(:lessons_user, student: padawan,
                              lesson: create(:lesson, course: create(:course, team: moder.team)))
      end

      it "include lessons user from resolved scope" do
        expect(resolved_scope).to include(lesson_user)
      end

      it { is_expected.to permit_actions(%i[show update]) }
    end

    context "own team" do
      let(:user) { create(:user, :student, team: moder.team) }
      let(:lesson_user) do
        create(:lessons_user, student: user,
                              lesson: create(:lesson, course: create(:course, team: moder.team)))
      end

      it "include lessons user from resolved scope" do
        expect(resolved_scope).to include(lesson_user)
      end

      it { is_expected.to permit_actions(%i[show update]) }
    end
  end

  context "inactive moder accessing a lessons user" do
    let(:moder) { create(:user, :moder, status: :inactive) }
    let(:lesson_user) { create(:lessons_user, student: moder) }

    it { is_expected.to forbid_actions(%i[show update]) }
  end
end
