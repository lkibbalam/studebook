# frozen_string_literal: true

require "rails_helper.rb"

describe TeamPolicy do
  subject { described_class.new(student, team) }

  let(:team) { create(:team) }

  context "student accessing a team" do
    let(:student) { create(:user, :student) }

    it { is_expected.to permit_actions(%i[show]) }
    it { is_expected.to forbid_actions(%i[create update destroy]) }
  end

  context "inactive student accessing a team" do
    let(:student) { create(:user, :student, status: :inactive) }

    it { is_expected.to forbid_actions(%i[show create update destroy]) }
  end
end
