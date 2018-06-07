# frozen_string_literal: true

module Api
  module V1
    class LessonsController < ApplicationController
      include Commentable
      before_action :set_lesson, only: %i[show destroy update done watch poster update_poster update_video video watch]
      before_action :set_course, only: %i[index create]

      def index
        @lessons = @course.lessons
        course_user = @course.courses_users.find_by(student: current_user)
        status = course_user.status if course_user
        respond_with(lessons: @lessons, status: status, course: @course)
        # TODO: update tests, serializer!!!!
      end

      def show
        respond_with(@lesson)
      end

      def create
        @lesson = @course.lessons.create(set_lesson_params)
        respond_with(@lesson)
      end

      def update
        @lesson.update(set_lesson_params)
        respond_with(@lesson)
      end

      def destroy
        respond_with(@lesson.delete)
      end

      def update_poster
        @lesson.poster.attach(params[:poster])
        render json: rails_blob_url(@lesson.poster)
      end

      def poster
        respond_with(rails_blob_url(@lesson.poster)) if @lesson.poster.attached?
      end

      def update_video
        @lesson.video.attach(params[:video])
        render json: rails_blob_url(@lesson.video)
      end

      def video
        respond_with(rails_blob_url(@lesson.video)) if @lesson.video.attached?
      end

      def done
        @lesson_user = LessonsUser.find_by(student: current_user, lesson: @lesson)
        @lesson_user.update(status: :done)
        respond_with :api, :v1, @lesson_user
      end

      private

      def set_lesson
        @lesson = Lesson.find(params[:id])
      end

      def set_course
        @course = Course.find(params[:course_id])
      end

      def set_lesson_params
        params.require(:lesson).permit(:title, :description, :material)
      end
    end
  end
end
