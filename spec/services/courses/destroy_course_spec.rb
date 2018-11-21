# frozen_string_literal: true

require 'rails_helper'

module Courses
  describe DestroyCourse do
    let(:delete_course) do
      described_class.call(course: course)
    end

    let!(:course) { create(:course) }

    context 'when delete course' do
      it 'should change courses count by -1' do
        expect { delete_course }.to change(Course, :count).by(-1)
      end
    end
  end
end
