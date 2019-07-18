# frozen_string_literal: true

require "rails_helper"

describe TaskPolicy do
  subject { described_class.new(staff, task) }

  let(:task) { create(:task) }

  context "staff accessing" do
    context "to own team task actions" do
      let(:staff) { create(:user, :staff, team: task.lesson.course.team) }

      it { is_expected.to forbid_actions(%i[show create update show]) }
    end

    context "not own team task actions" do
      let(:staff) { create(:user, :staff) }

      it { is_expected.to forbid_actions(%i[show create update show]) }
    end
  end

  context "inactive staff accessing to task" do
    let(:staff) { create(:user, :staff) }

    it { is_expected.to forbid_actions(%i[show create update show]) }
  end
end
