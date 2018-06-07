# frozen_string_literal: true

module Api
  module V1
    class CoursesController < ApplicationController
      include Commentable
      before_action :set_course, only: %i[show update destroy start_course update_poster get_poster]
      before_action :set_team, only: %i[index create]

      def index
        respond_with(@team.courses.all)
      end

      def all
        respond_with(Course.all)
      end

      def show
        respond_with(@course)
      end

      def create
        @course = @team.courses.create(set_params)
        respond_with :api, :v1, @course
      end

      def update
        @course.update(set_params)
        respond_with :api, :v1, @course
      end

      def update_poster
        @course.poster.attach(params['poster'])
        render json: rails_blob_url(@course.poster)
        # TODO: fix this shit
      end

      def poster
        respond_with(poster: rails_blob_url(@course.poster)) if @course.poster.attached?
        # TODO: fix this shit
      end

      def destroy
        respond_with(@course.delete)
      end

      def start_course
        @course_user = @course.courses_users.create(student: current_user)
        respond_with :api, :v1, @course_user
      end

      private

      def set_course
        @course = Course.find(params[:id])
      end

      def set_team
        @team = Team.find(params[:team_id])
      end

      def set_params
        params.require(:course).permit(:title, :description).merge(author: current_user)
        # TODO: update test
      end
    end
  end
end
