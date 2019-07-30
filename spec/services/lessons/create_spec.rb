# frozen_string_literal: true

require "rails_helper"

module Lessons
  describe Create do
    let(:create_lesson) do
      described_class.call(course: course, params: params)
    end
    let(:course) { create(:course) }

    context "create lesson with pavild data" do
      let(:params) do
        {
          title: Faker::Lorem.sentence,
          description: Faker::Lorem.paragraph,
          material: Faker::Lorem.paragraph
        }
      end

      it "expect to change course count in db" do
        expect { create_lesson }.to change(course.lessons, :count).by(1)
      end
      it "expect to have position 1" do
        expect(create_lesson.position).to eq(1)
      end
    end

    context "create course with invalid data" do
      let(:params) do
        {
          title: "",
          description: "",
          material: ""
        }
      end

      it "expect to not hange course count in db" do
        expect { create_lesson }.to change(course.lessons, :count).by(0)
      end
    end
  end
end
