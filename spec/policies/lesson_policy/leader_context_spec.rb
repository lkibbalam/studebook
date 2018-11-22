# frozen_string_literal: true

require 'rails_helper'

describe LessonPolicy do
  subject { described_class.new(leader, lesson) }

  context 'leader with active status accessing' do
    context 'a published' do
      let(:leader) { create(:user, :leader) }
      let(:lesson) { create(:lesson, course: create(:course, :published)) }

      context 'not own team lesson' do
        it { is_expected.to permit_actions(%i[show]) }
        it { is_expected.to forbid_actions(%i[create update destroy]) }
      end

      context 'own team lesson' do
        let(:leader) { create(:user, :leader, team: lesson.course.team) }

        it { is_expected.to permit_actions(%i[show update create destroy]) }
      end
    end

    context 'an unpublished' do
      let(:lesson) { create(:lesson, course: create(:course, :unpublished)) }

      context 'own team lesson' do
        let(:leader) { create(:user, :leader, team: lesson.course.team) }

        it { is_expected.to permit_actions(%i[show update create destroy]) }
      end

      context 'not own team lesson' do
        let(:leader) { create(:user, :leader) }

        it { is_expected.to forbid_actions(%i[show update create destroy]) }
      end
    end
  end

  context 'leader with inactive status' do
    let(:leader) { create(:user, :leader, status: :inactive) }
    let(:lesson) { create(:lesson, course: create(:course, :published)) }

    context 'accessing a lesson' do
      it { is_expected.to forbid_actions(%i[show create update destroy]) }
    end
  end
end
