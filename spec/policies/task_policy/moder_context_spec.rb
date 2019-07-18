# frozen_string_literal: true

require "rails_helper"

describe TaskPolicy do
  subject { described_class.new(moder, task) }

  context "moder with active status accessing" do
    context "a published course" do
      let(:moder) { create(:user, :moder) }
      let(:task) { create(:task, lesson: create(:lesson, course: create(:course, :published))) }

      context "not own team task" do
        it { is_expected.to permit_actions(%i[show]) }
        it { is_expected.to forbid_actions(%i[create update destroy]) }
      end

      context "own team task" do
        let(:moder) { create(:user, :moder, team: task.lesson.course.team) }

        it { is_expected.to permit_actions(%i[show update]) }
        it { is_expected.to forbid_actions(%i[create destroy]) }
      end
    end

    context "an unpublished course" do
      let(:task) { create(:task, lesson: create(:lesson, course: create(:course, :unpublished))) }

      context "own team task" do
        let(:moder) { create(:user, :moder, team: task.lesson.course.team) }

        it { is_expected.to permit_actions(%i[show update]) }
        it { is_expected.to forbid_actions(%i[create destroy]) }
      end

      context "not own team task" do
        let(:moder) { create(:user, :moder) }

        it { is_expected.to forbid_actions(%i[show update create destroy]) }
      end
    end
  end

  context "moder with inactive status" do
    let(:moder) { create(:user, :moder, status: :inactive) }
    let(:task) { create(:task, lesson: create(:lesson, course: create(:course, :published))) }

    context "accessing a task" do
      it { is_expected.to forbid_actions(%i[show create update destroy]) }
    end
  end
end
