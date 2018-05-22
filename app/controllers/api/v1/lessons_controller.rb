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

      # def show
      #   @lesson_user = LessonsUser.find_by(student: current_user, lesson: @lesson)
      #   @lesson_tasks_user = current_user.tasks_users.where(task: @lesson.tasks)
      #   respond_with(lesson_tasks_user: @lesson_tasks_user.as_json, lesson: @lesson.as_json(include: [:tasks, :videos, course:
      #       { methods: :lessons }]), lesson_user: @lesson_user.as_json(include: [comments: { include: :user }]))
      #   # TODO: update tests
      # end

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
    end
  end
end
