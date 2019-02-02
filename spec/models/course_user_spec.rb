# frozen_string_literal: true

require 'rails_helper'

describe CoursesUser, type: :model do
  it { should belong_to(:course) }
  it { should belong_to(:student).class_name('User').with_foreign_key('student_id') }
  it { should have_many(:comments).dependent(:destroy) }

  let(:course) { create(:course) }
  let(:lessons) { create_list(:lesson, 3, course: course) }
  let(:student) { create(:user, :student) }
  let!(:course_user) { create(:courses_user, course: course, student: student) }
  let!(:lesson_user_1) { create(:lessons_user, :unlocked, lesson: lessons.first, student: student) }
  let!(:lesson_user_2) { create(:lessons_user, :unlocked, lesson: lessons.second, student: student) }
  let!(:lesson_user_3) { create(:lessons_user, :unlocked, lesson: lessons.third, student: student) }

  describe '#change_progress!' do
    context 'when all of course lessons user are done' do
      let(:lessons_user) { student.lessons_users.where(lesson: lessons) }
      let(:done_all_lessons_user) { lessons_user.update_all(status: :done) }

      it 'should change course_user progress' do
        done_all_lessons_user
        expect { course_user.update_progress! }
          .to change { course_user.progress }.from(0).to(100)
      end

      it 'should change course_user status' do
        done_all_lessons_user
        expect { course_user.update_progress! }
          .to change(course_user, :status).from('current').to('archived')
      end
    end

    context 'when only one of three course lessons user are done' do
      it 'should change course_user progress' do
        lesson_user_1.done!
        expect { course_user.update_progress! }
          .to change(course_user, :progress).from(0).to(33)
      end

      it 'should not change course_user status' do
        lesson_user_1.done!
        expect { course_user.update_progress! }.to_not change(course_user, :status)
      end
    end

    context 'when only one of three course lessons user are done' do
      it 'should change course_user progress' do
        lesson_user_1.done!
        lesson_user_2.done!
        expect { course_user.update_progress! }
          .to change(course_user, :progress).from(0).to(66)
      end

      it 'should not change course_user status' do
        lesson_user_1.done!
        lesson_user_2.done!
        expect { course_user.update_progress! }.to_not change(course_user, :status)
      end
    end
  end
end
