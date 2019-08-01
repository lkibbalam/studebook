# frozen_string_literal: true

require "rails_helper"

describe LessonsUserPolicy do
  subject { described_class.new(staff, lesson_user) }

  let(:staff) { create(:user) }

  context "staff accessing a lesson user" do
    context "own lesson" do
      let(:lesson_user) { create(:lessons_user, student: staff) }

      it { is_expected.to permit_actions(%i[show update]) }
    end

    context "padawans lessons" do
      let(:padawan) { create(:user, :student, mentors: [staff]) }
      let(:lesson_user) { create(:lesson_user, user: padawan) }
    end

    context "not own lesson" do
      let(:lesson_user) { create(:lessons_user) }

      it { is_expected.to forbid_actions(%i[show update]) }
    end
  end

  context "inactive staff accessing a lesson user" do
    let(:lesson_user) { create(:lessons_user, student: staff) }
    let(:staff) { create(:user, :staff, :inactive) }

    it { is_expected.to forbid_actions(%i[show update]) }
  end
end
