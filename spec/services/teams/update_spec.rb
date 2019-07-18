# frozen_string_literal: true

require "rails_helper"

module Teams
  describe Update do
    let(:update_team) do
      described_class.call(team: team, params: params)
    end

    let(:team) { create(:team) }

    context "with valid data" do
      let(:params) do
        { title: Faker::Lorem.sentence,
          description: Faker::Lorem.paragraph }
      end

      %w[title description].each do |attribute|
        it "should update team #{attribute}" do
          expect(update_team.send(attribute)).to eq(params.dig(attribute.to_sym))
        end
      end
    end

    context "invalid data" do
      let(:params) do
        { title: "",
          description: "" }
      end

      %w[title description].each do |attribute|
        it "should not update team #{attribute}" do
          expect(update_team.send(attribute)).to eq(team.send(attribute))
        end
      end
    end
  end
end
