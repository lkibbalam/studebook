# frozen_string_literal: true

require 'rails_helper'

describe CoursePolicy do
  subject { described_class.new(staff, course) }

  let(:resolved_scope) do
    described_class::Scope.new(staff, Course).resolve
  end

  context 'staff accessing a publised course' do
    let(:staff) { create(:user, :staff) }
    let(:course) { create(:course, status: :published) }

    it 'incudes course in resolved scope' do
      expect(resolved_scope).to include(course)
    end

    it { is_expected.to permit_actions(%i[show]) }
    it { is_expected.to forbid_actions(%i[create update destroy]) }
  end

  context 'staff accessing an unpublished course' do
    let(:staff) { create(:user, :staff) }
    let(:course) { create(:course, :unpublished) }

    it 'excludes course in resolved scope' do
      expect(resolved_scope).not_to include(course)
    end

    it { is_expected.to forbid_actions(%i[show create update destroy]) }
  end

  context 'inactive staff accessing to course' do
    let(:staff) { create(:user, :staff, status: :inactive) }
    let(:course) { create(:course, :published) }

    it 'excludes course if resolved scope' do
      expect(resolved_scope).not_to include(course)
    end

    it { is_expected.to forbid_actions(%i[show create update destroy]) }
  end
end
