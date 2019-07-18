# frozen_string_literal: true

require "rails_helper"

module Courses
  describe Update do
    let(:update_course) do
      described_class.call(course: course, params: params)
    end

    let(:course) { create(:course) }

    context "with valid attributes" do
      let(:params) do
        { title: Faker::Lorem.sentence,
          description: Faker::Lorem.paragraph,
          team_id: create(:team).id }
      end

      %w[title description team_id].each do |attribute|
        it "should update #{attribute} course" do
          expect(update_course.send(attribute)).to eq(params.dig(attribute.to_sym))
        end
      end
    end

    context "invalid data" do
      let(:params) do
        {
          title: "",
          description: "",
          team_id: ""
        }
      end

      %w[title description team_id].each do |attribute|
        it "should not update #{attribute} course" do
          expect(update_course.send(attribute)).to eq(course.send(attribute))
        end
      end
    end
  end
end
