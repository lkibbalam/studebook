# frozen_string_literal: true

require 'rails_helper'

module TasksUsers
  describe Update do
    let(:update_task_user) do
      described_class.call(task_user: task_user, current_user: user, params: params)
    end

    context 'student send task to verify' do
      let(:mentor) { create(:user, :staff) }
      let(:user) { create(:user, :student, mentor: mentor) }
      let(:task_user) { create(:tasks_user, :undone, user: user) }
      let(:params) do
        { status: 'verifying',
          github_url: Faker::Internet.url('github.com'),
          comment: Faker::Lorem.sentence }
      end

      %w[status github_url].each do |attribute|
        it "should update task`s #{attribute}" do
          expect(update_task_user.send(attribute)).to eq(params[attribute.to_sym])
        end
      end

      it 'mentor should have notification' do
        expect { update_task_user }.to change(mentor.notifications, :count).by(1)
      end

      it 'should add comment' do
        expect { update_task_user }.to change(user.comments, :count).by(1)
      end

      it 'body comment should be' do
        update_task_user
        expect(user.comments.first.body).to eq(params[:comment])
      end
    end

    context 'mentor' do
      let(:user) { create(:user, :staff) }
      let(:student) { create(:user, :student, mentor: user) }
      let(:task_user) { create(:tasks_user, :verifying, user: student) }

      context 'send task to change' do
        let(:params) do
          { status: 'change',
            github_url: Faker::Internet.url('github.com'),
            comment: Faker::Lorem.sentence }
        end

        %w[status github_url].each do |attribute|
          it "should update task`s #{attribute}" do
            expect(update_task_user.send(attribute)).to eq(params[attribute.to_sym])
          end
        end

        it 'mentor should have notification' do
          expect { update_task_user }.to change(student.notifications, :count).by(1)
        end

        it 'should add comment' do
          expect { update_task_user }.to change(user.comments, :count).by(1)
        end

        it 'body comment should be' do
          update_task_user
          expect(user.comments.first.body).to eq(params[:comment])
        end
      end

      context 'send task to accept' do
        let(:params) do
          { status: 'accept',
            github_url: Faker::Internet.url('github.com'),
            comment: Faker::Lorem.sentence }
        end

        %w[status github_url].each do |attribute|
          it "should update task`s #{attribute}" do
            expect(update_task_user.send(attribute)).to eq(params[attribute.to_sym])
          end
        end

        it 'student should have notification' do
          expect { update_task_user }.to change(student.notifications, :count).by(1)
        end

        it 'should add comment' do
          expect { update_task_user }.to change(user.comments, :count).by(1)
        end

        it 'body comment should be' do
          update_task_user
          expect(user.comments.first.body).to eq(params[:comment])
        end

        context 'if all lesson`s tasks user accept' do
          let(:course) { create(:course) }
          let(:lesson_first) { create(:lesson, course: course) }
          let(:lesson_second) { create(:lesson, course: course) }
          let!(:first_lesson_tasks) { create_list(:task, 2, lesson: lesson_first) }
          let!(:second_lesson_tasks) { create_list(:task, 2, lesson: lesson_second) }
          let!(:create_course_user) do
            CoursesUsers::Create.call(course: course, user: student)
          end

          let!(:first_task_user) do
            student.tasks_users.where(task: first_lesson_tasks).first.update(status: :accept)
          end
          let!(:second_lesson_user) { LessonsUser.find_by(student: student, lesson: second_lesson_tasks.first.lesson) }

          let!(:task_user) { student.tasks_users.where(task: first_lesson_tasks).second }
          it 'should unlock next lesson user if accept all tasks user of lesson' do
            expect do
              binding.pry
              update_task_user
              second_lesson_user.reload
            end.to change(second_lesson_user, :status).from('locked').to('unlocked')
          end
        end
      end
    end
  end
end
