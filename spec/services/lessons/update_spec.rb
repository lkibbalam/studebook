# frozen_string_literal: true

require "rails_helper"

module Lessons
  describe Update do
    let(:update_lesson) do
      described_class.call(lesson: lesson, params: params)
    end

    let(:course_with_lessons) { create(:course_with_lessons, lessons_count: 5) }
    let(:lesson) { course_with_lessons.lessons.fourth }
    let(:first_lesson) { course_with_lessons.lessons.first }
    let(:second_lesson) { course_with_lessons.lessons.second }
    let(:third_lesson) { course_with_lessons.lessons.third }
    let(:fifth_lesson) { course_with_lessons.lessons.fifth }

    context "update with valid attributes" do
      let(:params) do
        { title: Faker::Lorem.sentence(2),
          description: Faker::Lorem.paragraph,
          material: Faker::Lorem.paragraph,
          position:  2 }
      end

      %w[title description material position].each do |attribute|
        it "should update #{attribute} lesson" do
          expect(update_lesson.reload.send(attribute)).to eq(params.dig(attribute.to_sym))
        end
      end

      it "should change position from 4 to 2" do
        expect { update_lesson }.to change { lesson.reload.position }.from(4).to(2)
      end

      it "should not change position first lesson" do
        expect { update_lesson }.not_to change { first_lesson.reload.position }
      end

      it "should change position from 2 to 3" do
        expect { update_lesson }.to change { second_lesson.reload.position }.from(2).to(3)
      end

      it "should change position from 3 to 4" do
        expect { update_lesson }.to change { third_lesson.reload.position }.from(3).to(4)
      end

      it "should not change fifth position lesson" do
        expect { update_lesson }.not_to change { fifth_lesson.reload.position }
      end
    end

    context "invalid data" do
      let(:params) do
        {
          title: "",
          description: "",
          material: ""
        }
      end

      %w[title description material].each do |attribute|
        it "should not update #{attribute} lesson" do
          expect(update_lesson.send(attribute)).to eq(lesson.send(attribute))
        end
      end
    end
  end
end
