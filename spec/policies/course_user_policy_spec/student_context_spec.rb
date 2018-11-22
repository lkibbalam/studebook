# frozen_string_literal: true

require 'rails_helper'

describe CoursesUserPolicy do
  subject { described_class.new(student, course_user) }

  let(:resolved_scope) do
    described_class::Scope.new(student, CoursesUser.all).resolve
  end

  context 'student accessing own course_user' do
    let(:student) { create(:user, :student) }
    let(:course_user) { create(:courses_user, student: student) }

    it 'includes course user in resolved scope' do
      expect(resolved_scope).to include(course_user)
    end

    it { is_expected.to permit_actions(%i[show create]) }
  end

  context 'student accessing not own' do
    let(:student) { create(:user, :student) }
    let(:course_user) { create(:courses_user) }

    it 'excludes course user from resolved scope' do
      expect(resolved_scope).not_to include(course_user)
    end

    it { is_expected.to permit_actions(%i[create]) }
    it { is_expected.to forbid_actions(%i[show]) }
  end

  context 'inactive student accessing a course' do
    let(:student) { create(:user, :student, status: :inactive) }
    let(:course_user) { create(:courses_user, student: student) }

    it { is_expected.to forbid_actions(%i[show create]) }
  end
end
