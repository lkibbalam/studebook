module Api
  module V1
    class LessonsController < ApplicationController
      include Commentable
      before_action :set_lesson, only: %i[show destroy update done watch]
      before_action :set_course, only: %i[index create]

      def index
        respond_with(@lessons = @course.lessons)
      end

      def show
        @lesson_user = LessonsUser.find_by(student: current_user, lesson: @lesson)
        respond_with(@lesson.as_json(include: [:videos, :comments, course: { methods: :lessons }]).merge(@lesson_user.as_json))
        # TODO: update tests
      end

      def create
        @lesson = @course.lessons.create(set_params)
        render json: @lesson
      end

      def update
        @lesson.update(set_params)
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

      #  def watch
      #    @lesson_user = LessonsUser.find_by(student: current_user, lesson: @lesson)
      #    respond_with(@lesson_user.as_json(include: { lesson: { methods: { course: { methods: :lessons } } } } ))
      #  end

      private

      def set_lesson
        @lesson = Lesson.find(params[:id])
      end

      def set_course
        @course = Course.find(params[:course_id])
      end

      def set_params
        params.require(:lesson).permit(:video, :description, :material, :task)
      end
    end
  end
end
