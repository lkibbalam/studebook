# frozen_string_literal: true

require "rails_helper"

describe TaskPolicy do
  subject { described_class.new(visitor, task) }

  let(:visitor) { nil }

  context "visitor accessing a task" do
    let(:task) { create(:task) }

    it { is_expected.to forbid_actions(%i[show create update destroy]) }
  end
end
