# frozen_string_literal: true

require "rails_helper"

module Teams
  describe Destroy do
    let(:destroy_team) do
      described_class.call(team: team)
    end

    let!(:team) { create(:team) }

    context "when delete team" do
      it "schould change team count by -1" do
        expect { destroy_team }.to change(Team, :count).by(-1)
      end
    end
  end
end
