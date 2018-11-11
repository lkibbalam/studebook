# frozen_string_literal: true

require 'rails_helper'

describe CoursePolicy do
  subject { described_class.new(admin, course) }

  let(:course) { create(:course, :published) }

  let(:resolved_scope) do
    described_class::Scope.new(admin, Course.all).resolve
  end

  context 'admin with active status accessing' do
    let(:admin) { create(:user, :admin) }

    it 'includes in resolved scope' do
      expect(resolved_scope).to include(course)
    end

    it { is_expected.to permit_actions(%i[show create update destroy]) }
  end

  context 'admin with inactive status' do
    let(:admin) { create(:user, :admin, status: :inactive) }

    context 'accessing a course' do
      it { is_expected.to forbid_actions(%i[show create update destroy]) }
    end
  end
end
