# frozen_string_literal: true

require "rails_helper"

describe TaskPolicy do
  subject { described_class.new(admin, task) }

  let(:task) { create(:task, lesson: create(:lesson, course: create(:course, :published))) }

  context "admin with active status accessing" do
    let(:admin) { create(:user, :admin) }

    it { is_expected.to permit_actions(%i[show create update destroy]) }
  end

  context "admin with inactive status" do
    let(:admin) { create(:user, :admin, status: :inactive) }

    context "accessing a task" do
      it { is_expected.to forbid_actions(%i[show create update destroy]) }
    end
  end
end
