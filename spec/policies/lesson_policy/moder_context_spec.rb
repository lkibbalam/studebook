# frozen_string_literal: true

require "rails_helper"

describe LessonPolicy do
  subject { described_class.new(moder, lesson) }

  context "moder with active status accessing" do
    context "a published" do
      let(:moder) { create(:user, :moder) }
      let(:lesson) { create(:lesson, course: create(:course, :published)) }

      context "not own team lesson" do
        it { is_expected.to permit_actions(%i[show]) }
        it { is_expected.to forbid_actions(%i[create update destroy]) }
      end

      context "own team lesson" do
        let(:moder) { create(:user, :moder, team: lesson.course.team) }

        it { is_expected.to permit_actions(%i[show update]) }
        it { is_expected.to forbid_actions(%i[create destroy]) }
      end
    end

    context "an unpublished" do
      let(:lesson) { create(:lesson, course: create(:course, :unpublished)) }

      context "own team lesson" do
        let(:moder) { create(:user, :moder, team: lesson.course.team) }

        it { is_expected.to permit_actions(%i[show update]) }
        it { is_expected.to forbid_actions(%i[create destroy]) }
      end

      context "not own team lesson" do
        let(:moder) { create(:user, :moder) }

        it { is_expected.to forbid_actions(%i[show update create destroy]) }
      end
    end
  end

  context "moder with inactive status" do
    let(:moder) { create(:user, :moder, status: :inactive) }
    let(:lesson) { create(:lesson, course: create(:course, :published)) }

    context "accessing a lesson" do
      it { is_expected.to forbid_actions(%i[show create update destroy]) }
    end
  end
end
