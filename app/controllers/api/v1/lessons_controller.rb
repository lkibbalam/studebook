module Api
  module V1
    class LessonsController < ApplicationController
      include Commentable
      before_action :set_lesson, only: %i[show destroy update done watch]
      before_action :set_course, only: %i[index create]

      def index
        @lessons = @course.lessons
        respond_with(lessons: @lessons.as_json(include: :videos),
                     course: @course, video: @lessons.first.videos.first)
        # TODO: update tests
      end

      def show
        @lesson_user = LessonsUser.find_by(student: current_user, lesson: @lesson)
        respond_with(lesson: @lesson.as_json(include: [:tasks, :videos, course:
            { methods: :lessons }]), lesson_user: @lesson_user.as_json(include: [comments: { methods: :user }]))
        # TODO: update tests
      end

      def create
        @lesson = @course.lessons.create(set_lesson_params)
        render json: @lesson
      end

      def update
        @lesson.update(set_lesson_params)
        render json: @lesson
      end

      def destroy
        @lesson.delete
      end

      def done
        @lesson_user = LessonsUser.find_by(student: current_user, lesson: @lesson)
        @lesson_user.update(status: 1)
        render json: @lesson_user
        # TODO: Test
      end

      def change_task_status
        task = Task.find(params[:id])
        @task_user = TasksUser.find_by(user: current_user, task: task)
        @task_user.update(set_task_verify_params)
        render json: @task_user
        # TODO: Test
      end

      private

      def set_lesson
        @lesson = Lesson.find(params[:id])
      end

      def set_course
        @course = Course.find(params[:course_id])
      end

      def set_lesson_params
        params.require(:lesson).permit(:video, :description, :material)
      end

      def set_task_verify_params
        params.require(:task).permit(:status, :github_url)
      end
    end
  end
end
