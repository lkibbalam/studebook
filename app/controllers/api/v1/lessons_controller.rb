# frozen_string_literal: true

module Api
  module V1
    class LessonsController < ApplicationController
      include Commentable
      before_action :load_lesson, only: %i[show destroy update done]
      before_action :load_course, only: %i[index create]

      def index
        @lessons = @course.lessons
        respond_with(@lessons)
      end

      def show
        authorize @lesson
        respond_with(@lesson)
      end

      def create
        @lesson = @course.lessons.create(lesson_params)
        authorize @lesson
        render json: @lesson
      end

      def update
        authorize @lesson
        @lesson.update(lesson_params)
        render json: @lesson
      end

      def destroy
        authorize @lesson
        respond_with(@lesson.delete)
      end

      private
        def load_lesson
          @lesson = Lesson.find(params[:id])
        end

        def load_course
          @course = Course.find(params[:course_id])
        end

        def lesson_params
          params.require(:lesson).permit(:title, :description, :material, :poster, :video)
        end
    end
  end
end
