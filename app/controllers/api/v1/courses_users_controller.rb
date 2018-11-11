# frozen_string_literal: true

module Api
  module V1
    class CoursesUsersController < ApplicationController
      before_action :load_padawan, only: %i[padawan_courses]
      before_action :load_course, only: :start_course

      def index
        @courses_user = current_user.courses_users
        authorize @courses_user
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

      def padawan_courses
        @courses_user = @padawan.courses_users
        # authorize @courses_user
        respond_with(@courses_user)
      end

      def start_course
        @course_user = @course.courses_users.create(student: current_user)
        # TODO: authorize @course_user
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
