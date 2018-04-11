module Api
  module V1
    class LessonsController < ApplicationController
      before_action :set_lesson, only: :show
      before_action :set_course, only: :index

      def index
        respond_with(@lessons = @course.lessons)
      end

      def show
        respond_with(@lesson)
      end

      private

      def set_lesson
        @lesson = Lesson.find(params[:id])
      end

      def set_course
        @course = Course.find(params[:course_id])
      end
    end
  end
end
