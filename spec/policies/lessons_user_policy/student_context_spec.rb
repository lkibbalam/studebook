# frozen_string_literal: true

require "rails_helper"

describe LessonsUserPolicy do
  subject { described_class.new(student, lesson_user) }

  let(:student) { create(:user) }

  context "student accessing a lesson user" do
    context "own lesson" do
      let(:lesson_user) { create(:lessons_user, student: student) }

      it { is_expected.to permit_actions(%i[show update]) }
    end

    context "not own lesson" do
      let(:lesson_user) { create(:lessons_user) }

      it { is_expected.to forbid_actions(%i[show update]) }
    end
  end

  context "inactive student accessing a lesson user" do
    let(:lesson_user) { create(:lessons_user, student: student) }
    let(:student) { create(:user, :student, :inactive) }

    it { is_expected.to forbid_actions(%i[show update]) }
  end
end
