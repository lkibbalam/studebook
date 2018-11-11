# frozen_string_literal: true

require 'rails_helper'

describe CoursePolicy do
  subject { described_class.new(student, course) }

  let(:resolved_scope) do
    described_class::Scope.new(student, Course.all).resolve
  end

  context 'student accessing a published course' do
    let(:student) { create(:user, :student) }
    let(:course) { create(:course, :published) }

    it 'includes course in resolved scope' do
      expect(resolved_scope).to include(course)
    end

    it { is_expected.to permit_actions(%i[show]) }
    it { is_expected.to forbid_actions(%i[create update destroy]) }
  end

  context 'student accessing an unpunlished course' do
    let(:student) { create(:user, :student) }
    let(:course) { create(:course, :unpublished) }

    it 'excludes course from resolved scope' do
      expect(resolved_scope).not_to include(course)
    end

    it { is_expected.to forbid_actions(%i[show create update destroy]) }
  end

  context 'inactive student accessing a course' do
    let(:student) { create(:user, :student, status: :inactive) }
    let(:course) { create(:course, :published) }

    it { is_expected.to forbid_actions(%i[show create update destroy]) }
  end
end
