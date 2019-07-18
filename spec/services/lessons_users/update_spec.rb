# frozen_string_literal: true

require "rails_helper"

module LessonsUsers
  describe Update do
    let(:update_lesson_user) do
      described_class.call(lesson_user: lesson_user, params: params)
    end

    let(:user) { create(:user) }

    context "change lesson user status" do
      let(:lesson_user) { create(:lessons_user, student: user) }
      let(:params) do
        { mark: 100,
          status: :done }
      end

      it "schould change status to done" do
        expect(update_lesson_user.status.to_sym).to eq(:done)
      end

      it "schould change mark to 100" do
        expect(update_lesson_user.mark).to eq(100)
      end
    end
  end
end
