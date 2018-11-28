# frozen_string_literal: true

module Api
  module V1
    class CoursesUsersController < ApplicationController
      before_action :load_padawan, only: %i[padawan_courses]
      before_action :load_course, only: :create

      def index
        @courses_user = current_user.courses_users
        respond_with(@courses_user)
      end

      def padawan_courses
        @courses_user = @padawan.courses_users
        respond_with(@courses_user)
      end

      def show
        @course_user = current_user.courses_users.find_by(course_id: params[:id])
        if @course_user
          authorize @course_user
          respond_with(@course_user)
        else
          @course = Course.find(params[:id])
          authorize @course
          respond_with(@course)
        end
      end

      def create
        @course_user = CoursesUsers::Create.call(user: current_user, course: @course)
        authorize @course_user
        render json: @course_user
      end

      private

      def load_course
        @course = Course.find(params[:id])
      end

      def load_padawan
        @padawan = User.find(params[:id])
      end
    end
  end
end
