# frozen_string_literal: true

require "rails_helper"

module TasksUsers
  describe Update do
    let(:update_task_user) do
      described_class.call(task_user: task_user, current_user: user, params: params)
    end

    context "student send task to verify" do
      let(:mentor) { create(:user, :staff) }
      let(:user) { create(:user, :student, mentors: [mentor]) }
      let(:task_user) { create(:tasks_user, :undone, user: user) }
      let(:params) do
        { status: "verifying",
          github_url: Faker::Internet.url("github.com"),
          comment: Faker::Lorem.sentence }
      end

      %w[status github_url].each do |attribute|
        it "should update task`s #{attribute}" do
          expect(update_task_user.send(attribute)).to eq(params[attribute.to_sym])
        end
      end

      it "mentor should have notification" do
        expect { update_task_user }.to change(mentor.notifications, :count).by(1)
      end

      it "should add comment" do
        expect { update_task_user }.to change(user.comments, :count).by(1)
      end

      it "body comment should be" do
        update_task_user
        expect(user.comments.first.body).to eq(params[:comment])
      end
    end

    context "mentor" do
      let(:user) { create(:user, :staff) }
      let(:student) { create(:user, :student, mentors: [user]) }
      let(:course_with_lessons_with_tasks) { create(:course_with_lessons_with_tasks, lessons_count: 2, tasks_count: 2) }
      let!(:subscribe_user_to_course) do
        CoursesUsers::Create.call(course: course_with_lessons_with_tasks, user: student)
      end
      let(:task_user) do
        task_user = TasksUser.find_by(task: course_with_lessons_with_tasks.lessons.first.tasks.first, user: student)
        task_user.update(status: :verifying) && task_user.reload
      end

      context "send task to change" do
        let(:params) do
          { status: "change",
            github_url: Faker::Internet.url("github.com"),
            comment: Faker::Lorem.sentence }
        end

        %w[status github_url].each do |attribute|
          it "should update task`s #{attribute}" do
            expect(update_task_user.send(attribute)).to eq(params[attribute.to_sym])
          end
        end

        it "mentor should have notification" do
          expect { update_task_user }.to change(student.notifications, :count).by(1)
        end

        it "should add comment" do
          expect { update_task_user }.to change(user.comments, :count).by(1)
        end

        it "body comment should be" do
          update_task_user
          expect(user.comments.first.body).to eq(params[:comment])
        end
      end

      context "send task to accept" do
        let(:params) do
          { status: "accept",
            github_url: Faker::Internet.url("github.com"),
            comment: Faker::Lorem.sentence }
        end

        %w[status github_url].each do |attribute|
          it "should update task`s #{attribute}" do
            expect(update_task_user.send(attribute)).to eq(params[attribute.to_sym])
          end
        end

        it "student should have notification" do
          expect { update_task_user }.to change(student.notifications, :count).by(1)
        end

        it "should add comment" do
          expect { update_task_user }.to change(user.comments, :count).by(1)
        end

        it "body comment should be" do
          update_task_user
          expect(user.comments.first.body).to eq(params[:comment])
        end

        context "if all lesson`s tasks user accept" do
          let(:course_with_lessons_with_tasks) do
            create(:course_with_lessons_with_tasks, lessons_count: 2, tasks_count: 2)
          end
          let!(:subscribe_user_to_course) do
            CoursesUsers::Create.call(course: course_with_lessons_with_tasks, user: student)
          end
          let!(:course_user_lessons) do
            LessonsUser.where(student: student, lesson: course_with_lessons_with_tasks.lessons)
          end
          let!(:done_first_task) do
            TasksUser.find_by(user: student, task: course_with_lessons_with_tasks.lessons.first.tasks.first)
                     .update(status: :accept)
          end
          let(:task_user) do
            TasksUser.find_by(user: student, task: course_with_lessons_with_tasks.lessons.first.tasks.second)
          end

          it "should unlock next lesson user if accept all tasks user of lesson" do
            expect { update_task_user && course_user_lessons.second.reload }
              .to change(course_user_lessons.second, :status).from("locked").to("unlocked")
          end
        end
      end
    end
  end
end
