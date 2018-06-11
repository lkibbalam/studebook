# frozen_string_literal: true

module Api
  module V1
    class CoursesUsersController < ApplicationController
      before_action :set_user, only: %i[padawan_courses]
      before_action :set_course_user, only: %i[show]

      def index
        @courses_user = current_user.courses_users
        authorize @courses_user
        respond_with(@courses_user)
      end

      def show
        authorize @course_user
        respond_with(@course_user)
      end

      def padawan_courses
        @courses_user = @user.courses_users
        authorize @courses_user
        respond_with(@courses_user)
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def set_course_user
        @course_user = CoursesUser.find(params[:id])
      end
    end
  end
end
