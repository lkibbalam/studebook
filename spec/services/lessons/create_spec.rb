# frozen_string_literal: true

require "rails_helper"

module Lessons
  describe Create do
    let(:create_lesson) do
      described_class.call(course: course, params: params)
    end
    let(:course) { create(:course) }
    let(:lesson) { course.lessons.create(params) }

    context "create lesson with valid data" do
      let(:params) do
        {
          title: Faker::Lorem.sentence(2),
          description: Faker::Lorem.paragraph,
          material: Faker::Lorem.paragraph
        }
      end

      it "expect to change lesson count in db" do
        expect { create_lesson }.to change { course.lessons.count }.by(1)
      end

      it "expect to have position 1" do
        expect(create_lesson.position).to eq(1)
      end

      it "second created lesson expect to have position 2" do
        lesson
        expect(create_lesson.position).to eq(2)
      end
    end

    context "create lesson with invalid data" do
      let(:params) do
        {
          title: "",
          description: "",
          material: ""
        }
      end

      it "expect to not сhange lesson count in db" do
        expect { create_lesson }.to change(course.lessons, :count).by(0)
      end
    end
  end
end
