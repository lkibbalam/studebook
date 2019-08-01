# frozen_string_literal: true

require "rails_helper"

describe CoursesUserPolicy do
  subject { described_class.new(staff, course_user) }

  let(:resolved_scope) do
    described_class::Scope.new(staff, CoursesUser.all).resolve
  end

  context "staff accessing own course_user" do
    let(:staff) { create(:user, :staff) }
    let(:course_user) { create(:courses_user, student: staff) }

    it "includes course user in resolved scope" do
      expect(resolved_scope).to include(course_user)
    end

    it { is_expected.to permit_actions(%i[show create]) }
  end

  context "staff accessing not own" do
    let(:staff) { create(:user, :staff) }

    context "not own padawan" do
      let(:course_user) { create(:courses_user) }

      it "excludes course user from resolved scope" do
        expect(resolved_scope).not_to include(course_user)
      end

      it { is_expected.to permit_actions(%i[create]) }
      it { is_expected.to forbid_actions(%i[show]) }
    end

    context "own padawan" do
      let(:padawan) { create(:user, :student, mentors: [staff]) }
      let(:course_user) { create(:courses_user, student: padawan) }

      it "includes course user from resolved scope" do
        expect(resolved_scope).to include(course_user)
      end

      it { is_expected.to permit_actions(%i[show create]) }
    end
  end

  context "inactive staff accessing a course" do
    let(:staff) { create(:user, :staff, status: :inactive) }
    let(:course_user) { create(:courses_user, student: staff) }

    it { is_expected.to forbid_actions(%i[show create]) }
  end
end
