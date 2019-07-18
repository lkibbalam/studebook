# frozen_string_literal: true

require "rails_helper.rb"

describe TeamPolicy do
  subject { described_class.new(admin, team) }

  let(:team) { create(:team) }

  context "admin accessing not own team with own one" do
    let(:admin) { create(:user, :admin) }

    it { is_expected.to permit_actions(%i[show update create destroy]) }
  end

  context "inactive admin accessing a team" do
    let(:admin) { create(:user, :admin, status: :inactive) }

    it { is_expected.to forbid_actions(%i[show create update destroy]) }
  end
end
