# frozen_string_literal: true

module Api
  module V1
    class LessonsController < ApplicationController
      include Commentable
      before_action :set_lesson, only: %i[show destroy update done watch poster update_poster update_video video]
      before_action :set_course, only: %i[index create]

      def index
        @lessons = @course.lessons
        course_user = @course.courses_users.find_by(student: current_user)
        status = course_user.status if course_user
        respond_with(lessons: @lessons.as_json(include: :videos), course: @course, status: status)
        # TODO: update tests, serializer!!!!
      end

      # def show
      #   @lesson_user = LessonsUser.find_by(student: current_user, lesson: @lesson)
      #   @lesson_tasks_user = current_user.tasks_users.where(task: @lesson.tasks)
      #   respond_with(lesson_tasks_user: @lesson_tasks_user.as_json,
      #                                                 lesson: @lesson.as_json(include: [:tasks, :videos, course:
      #       { methods: :lessons }]), lesson_user: @lesson_user.as_json(include: [comments: { include: :user }]))
      #   # TODO: update tests
      # end

      def show
        respond_with(@lesson.as_json(include: :tasks))
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
        render json: @lesson_user
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
