# frozen_string_literal: true

require "rails_helper"

describe CoursesUserPolicy do
  subject { described_class.new(leader, course_user) }

  let(:resolved_scope) do
    described_class::Scope.new(leader, CoursesUser.all).resolve
  end

  context "leader accessing own course_user" do
    let(:leader) { create(:user, :leader) }
    let(:course_user) { create(:courses_user, student: leader) }

    it "includes course user in resolved scope" do
      expect(resolved_scope).to include(course_user)
    end

    it { is_expected.to permit_actions(%i[show create]) }
  end

  context "leader accessing not own" do
    let(:leader) { create(:user, :leader) }

    context "not own padawan" do
      let(:course_user) { create(:courses_user) }

      it "excludes course user from resolved scope" do
        expect(resolved_scope).not_to include(course_user)
      end

      it { is_expected.to permit_actions(%i[create]) }
      it { is_expected.to forbid_actions(%i[show]) }
    end

    context "own padawan" do
      let(:padawan) { create(:user, :student, mentors: [leader]) }
      let(:course_user) do
        create(:courses_user, student: padawan,
                              course: create(:course, team: leader.team))
      end

      it "include course user from resolved scope" do
        expect(resolved_scope).to include(course_user)
      end

      it { is_expected.to permit_actions(%i[show create]) }
    end

    context "own team" do
      let(:user) { create(:user, :student, team: leader.team) }
      let(:course_user) do
        create(:courses_user, student: user,
                              course: create(:course, team: leader.team))
      end

      it "include course user from resolved scope" do
        expect(resolved_scope).to include(course_user)
      end

      it { is_expected.to permit_actions(%i[show create]) }
    end
  end

  context "inactive leader accessing a course" do
    let(:leader) { create(:user, :leader, status: :inactive) }
    let(:course_user) { create(:courses_user, student: leader) }

    it { is_expected.to forbid_actions(%i[show create]) }
  end
end
