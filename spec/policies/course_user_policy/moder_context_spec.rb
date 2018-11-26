# frozen_string_literal: true

require 'rails_helper'

describe CoursesUserPolicy do
  subject { described_class.new(moder, course_user) }

  let(:resolved_scope) do
    described_class::Scope.new(moder, CoursesUser.all).resolve
  end

  context 'moder accessing own course_user' do
    let(:moder) { create(:user, :moder) }
    let(:course_user) { create(:courses_user, student: moder) }

    it 'includes course user in resolved scope' do
      expect(resolved_scope).to include(course_user)
    end

    it { is_expected.to permit_actions(%i[show create]) }
  end

  context 'moder accessing not own' do
    let(:moder) { create(:user, :moder) }

    context 'not own padawan' do
      let(:course_user) { create(:courses_user) }

      it 'excludes course user from resolved scope' do
        expect(resolved_scope).not_to include(course_user)
      end

      it { is_expected.to permit_actions(%i[create]) }
      it { is_expected.to forbid_actions(%i[show]) }
    end

    context 'own padawan' do
      let(:padawan) { create(:user, :student, mentor: moder) }
      let(:course_user) do
        create(:courses_user, student: padawan,
                              course: create(:course, team: moder.team))
      end

      it 'include course user from resolved scope' do
        expect(resolved_scope).to include(course_user)
      end

      it { is_expected.to permit_actions(%i[show create]) }
    end

    context 'own team' do
      let(:user) { create(:user, :student, team: moder.team) }
      let(:course_user) do
        create(:courses_user, student: user,
                              course: create(:course, team: moder.team))
      end

      it 'include course user from resolved scope' do
        expect(resolved_scope).to include(course_user)
      end

      it { is_expected.to permit_actions(%i[show create]) }
    end
  end

  context 'inactive moder accessing a course' do
    let(:moder) { create(:user, :moder, status: :inactive) }
    let(:course_user) { create(:courses_user, student: moder) }

    it { is_expected.to forbid_actions(%i[show create]) }
  end
end
