# frozen_string_literal: true

module Api
  module V1
    class CoursesController < ApplicationController
      include Commentable
      before_action :set_course, only: %i[show update destroy start_course update_poster get_poster]
      before_action :set_team, only: %i[index create]

      def index
        @courses = @team.courses.all
        authorize @courses
        respond_with(@courses)
      end

      def all
        @courses = Course.all
        respond_with(@courses)
      end

      def show
        authorize @course
        respond_with(@course)
      end

      def create
        @course = @team.courses.create(set_params)
        authorize @course
        respond_with :api, :v1, @course
      end

      def update
        @course.update(set_params)
        authorize @course
        respond_with :api, :v1, @course
      end

      def destroy
        authorize @course
        respond_with(@course.delete)
      end

      def start_course
        @course_user = @course.courses_users.create(student: current_user)
        respond_with @course_user, location: nil
      end

      private

      def set_course
        @course = Course.find(params[:id])
      end

      def set_team
        @team = Team.find(params[:team_id])
      end

      def set_params
        params.require(:course).permit(:title, :description, :poster).merge(author: current_user)
      end
    end
  end
end
