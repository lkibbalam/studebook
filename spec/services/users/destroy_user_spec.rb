# frozen_string_literal: true

require 'rails_helper'

module Users
  describe DestroyUser do
    let(:destroy_user) { described_class.call(user: user) }

    context 'destroy user' do
      let!(:user) { create(:user) }
      let(:courses_user) { create_list(:courses_user, 3, student: user) }
      let(:lessons_user) { create_list(:lessons_user, 3, student: user) }
      let(:tasks_user) { create_list(:tasks_user, 3, user: user) }

      it 'should be success' do
        expect { destroy_user }.to change(User, :count).by(-1)
      end

      it 'should delete courses users record related with user' do
        courses_user
        expect { destroy_user }.to change(CoursesUser, :count).by(-3)
      end

      it 'should delete lessons users record related with user' do
        lessons_user
        expect { destroy_user }.to change(LessonsUser, :count).by(-3)
      end

      it 'should delete task users record related with user' do
        tasks_user
        expect { destroy_user }.to change(TasksUser, :count).by(-3)
      end
    end
  end
end
