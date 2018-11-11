# frozen_string_literal: true

module Api
  module V1
    class CoursesController < ApplicationController
      include Commentable
      before_action :load_course, only: %i[show update destroy start_course]
      before_action :load_team, only: %i[index]

      def index
        @courses = policy_scope(Course).where(team: @team)
        respond_with(@courses)
      end

      def all
        @courses = policy_scope(Course)
        respond_with(@courses)
      end

      def show
        authorize @course
        respond_with(@course)
      end

      def create
        @course = Course.create(course_params.merge(author: current_user))
        authorize @course
        render json: @course
      end

      def update
        authorize @course
        @course.update(course_params)
        render json: @course
      end

      def destroy
        authorize @course
        respond_with(@course.delete)
      end

      private

      def load_course
        @course = Course.find(params[:id])
      end

      def load_team
        @team = Team.find(params[:team_id])
      end

      def course_params
        params.require(:course).permit(:title, :description, :poster, :team_id)
      end
    end
  end
end
