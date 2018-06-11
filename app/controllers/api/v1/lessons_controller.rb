# frozen_string_literal: true

module Api
  module V1
    class LessonsController < ApplicationController
      include Commentable
      before_action :set_lesson, only: %i[show destroy update done]
      before_action :set_course, only: %i[index create]

      def index
        @lessons = @course.lessons
        authorize @lessons
        respond_with(@lessons)
      end

      def show
        authorize @lesson
        respond_with(@lesson)
      end

      def create
        @lesson = @course.lessons.create(lesson_params)
        authorize @lesson
        respond_with :api, :v1, @lesson
      end

      def update
        @lesson.update(lesson_params)
        authorize @lesson
        respond_with(@lesson)
      end

      def destroy
        authorize @lesson
        respond_with(@lesson.delete)
      end

      private

      def set_lesson
        @lesson = Lesson.find(params[:id])
      end

      def set_course
        @course = Course.find(params[:course_id])
      end

      def lesson_params
        params.require(:lesson).permit(:title, :description, :material, :video, :poster)
      end
    end
  end
end
