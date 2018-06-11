# frozen_string_literal: true

module Api
  module V1
    class LessonsController < ApplicationController
      include Commentable
      before_action :set_lesson, only: %i[show destroy update done]
      before_action :set_course, only: %i[index create]

      def index
        @lessons = @course.lessons
        course_user = @course.courses_users.find_by(student: current_user)
        status = course_user.status if course_user
        respond_with(lessons: @lessons, status: status, course: @course)
        # TODO: update tests, serializer!!!!
      end

      def show
        authorize @lesson
        respond_with(@lesson)
      end

      def create
        @lesson = @course.lessons.create(set_lesson_params)
        authorize @lesson
        respond_with :api, :v1, @lesson
      end

      def update
        @lesson.update(set_lesson_params)
        authorize @lesson
        respond_with(@lesson)
      end

      def destroy
        authorize @lesson
        respond_with(@lesson.delete)
      end

      def done
        @lesson_user = LessonsUser.find_by(student: current_user, lesson: @lesson)
        @lesson_user.update(status: :done)
        respond_with :api, :v1, @lesson_user
        # TODO: what it do?
      end

      private

      def set_lesson
        @lesson = Lesson.find(params[:id])
      end

      def set_course
        @course = Course.find(params[:course_id])
      end

      def set_lesson_params
        params.require(:lesson).permit(:title, :description, :material, :video, :poster)
      end
    end
  end
end
