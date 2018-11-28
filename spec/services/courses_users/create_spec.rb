# frozen_string_literal: true

require 'rails_helper'

module CoursesUsers
  describe Create do
    let(:user) { create(:user) }
    let(:create_course_user) do
      described_class.call(course: course, user: user)
    end

    context 'user start course' do
      let(:course) { create(:course) }
      let(:lessons) { create_list(:lesson, 2, course: course) }
      let!(:tasks) { create_list(:task, 2, lesson: lessons.first) }

      it 'schould change course user' do
        expect { create_course_user }.to change(CoursesUser, :count).by(1)
      end

      it 'schould change lesson user' do
        expect { create_course_user }.to change(LessonsUser, :count).by(2)
      end

      it 'schould change task user' do
        expect { create_course_user }.to change(TasksUser, :count).by(2)
      end

      it 'first lesson user schould be unlocked' do
        create_course_user
        expect(user.lessons_users.first.status.to_sym).to eq(:unlocked)
      end
    end
  end
end
