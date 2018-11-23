# frozen_string_literal: true

require 'rails_helper'

describe CoursesUserPolicy do
  subject { described_class.new(admin, course_user) }

  let(:course_user) { create(:courses_user) }

  let(:resolved_scope) do
    described_class::Scope.new(admin, CoursesUser.all).resolve
  end

  context 'admin with active status accessing' do
    let(:admin) { create(:user, :admin) }

    it 'includes in resolved scope' do
      expect(resolved_scope).to include(course_user)
    end

    it { is_expected.to permit_actions(%i[show create]) }
  end

  context 'admin with inactive status' do
    let(:admin) { create(:user, :admin, status: :inactive) }

    context 'accessing a course' do
      it { is_expected.to forbid_actions(%i[show create]) }
    end
  end
end
