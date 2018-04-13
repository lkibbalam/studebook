module Api
  module V1
    class LessonsController < ApplicationController
      include Commentable
      before_action :set_lesson, only: :show
      before_action :set_course, only: %i[index create]

      def index
        respond_with(@lessons = @course.lessons)
      end

      def show
        respond_with(@lesson)
      end

      def create
        @lesson = @course.lessons.create(set_params)
        respond_with @lesson
      end

      private

      def set_lesson
        @lesson = Lesson.find(params[:id])
      end

      def set_course
        @course = Course.find(params[:course_id])
      end

      def set_params
        params.require(:lesson).permit(:video, :description, :material, :tasks)
      end
    end
  end
end
