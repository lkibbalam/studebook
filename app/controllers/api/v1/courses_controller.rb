module Api
  module V1
    class CoursesController < ApplicationController
      include Commentable
      before_action :set_course, only: %i[show update destroy]
      before_action :set_team, only: %i[create index]

      def index
        respond_with(@courses = @team.courses.all)
      end

      def all
        respond_with(@courses = Course.all)
      end

      def show
        respond_with(@course)
      end

      def create
        @course = @team.courses.create(set_params)
        render json: @course
      end

      def update
        @course.update(set_params)
        render json: @course
      end

      def destroy
        @course.delete
      end

      private

      def set_course
        @course = Course.find(params[:id])
      end

      def set_team
        @team = Team.find(params[:team_id])
      end

      def set_params
        params.require(:course).permit(:title, :description)
      end
    end
  end
end
