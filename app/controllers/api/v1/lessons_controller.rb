module Api
  module V1
    class LessonsController < ApplicationController
      include Commentable
      before_action :set_lesson, only: %i[show destroy update]
      before_action :set_course, only: %i[index create]

      def index
        respond_with(@lessons = @course.lessons)
      end

      def show
        respond_with(@lesson.to_json(include: :comments))
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
