# frozen_string_literal: true

require 'rails_helper'

module CoursesUsers
  describe Create do
    let(:create_course_user) do
      described_class.call(course: course, user: user)
    end

    let(:user) { create(:user) }
    let(:course) { create(:course) }
    let(:lessons) { create_list(:lesson, 2, course: course) }
    let!(:tasks) { create_list(:task, 2, lesson: lessons.first) }

    context 'user start course' do

      it 'schould change course user' do
        expect { create_course_user }.to change(CoursesUser, :count).by(1)
      end

      it 'schould change lesson user' do
        expect { create_course_user }.to change(LessonsUser, :count).by(2)
      end

      it 'schould change task user' do
        expect { create_course_user }.to change(TasksUser, :count).by(2)
      end
    end
  end
end
