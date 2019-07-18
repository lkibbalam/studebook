# frozen_string_literal: true

require "rails_helper"

describe TaskPolicy do
  subject { described_class.new(leader, task) }

  context "leader with active status accessing" do
    context "a published course" do
      let(:leader) { create(:user, :leader) }
      let(:task) { create(:task, lesson: create(:lesson, course: create(:course, :published))) }

      context "not own team task" do
        it { is_expected.to permit_actions(%i[show]) }
        it { is_expected.to forbid_actions(%i[create update destroy]) }
      end

      context "own team task" do
        let(:leader) { create(:user, :leader, team: task.lesson.course.team) }

        it { is_expected.to permit_actions(%i[show update create destroy]) }
      end
    end

    context "an unpublished course" do
      let(:task) { create(:task, lesson: create(:lesson, course: create(:course, :unpublished))) }

      context "own team task" do
        let(:leader) { create(:user, :leader, team: task.lesson.course.team) }

        it { is_expected.to permit_actions(%i[show update create destroy]) }
      end

      context "not own team task" do
        let(:leader) { create(:user, :leader) }

        it { is_expected.to forbid_actions(%i[show update create destroy]) }
      end
    end
  end

  context "leader with inactive status" do
    let(:leader) { create(:user, :leader, status: :inactive) }
    let(:task) { create(:task, lesson: create(:lesson, course: create(:course, :published))) }

    context "accessing a task" do
      it { is_expected.to forbid_actions(%i[show create update destroy]) }
    end
  end
end
