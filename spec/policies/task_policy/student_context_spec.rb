# frozen_string_literal: true

require "rails_helper"

describe TaskPolicy do
  subject { described_class.new(student, task) }

  let(:task) { create(:task) }

  context "active student accessing a task" do
    let(:student) { create(:user, :student) }

    it { is_expected.to forbid_actions(%i[show create update destroy]) }
  end

  context "inactive student accessing a task" do
    let(:student) { create(:user, :student, :inactive) }

    it { is_expected.to forbid_actions(%i[show create update destroy]) }
  end
end
