# frozen_string_literal: true

require "rails_helper"

module Lessons
  describe Destroy do
    let(:delete_lesson) do
      described_class.call(lesson: lesson)
    end

    let!(:lesson) { create(:lesson) }

    context "when delete lesson" do
      it "should change lessons count by -1" do
        expect { delete_lesson }.to change(Lesson, :count).by(-1)
      end
    end
  end
end
