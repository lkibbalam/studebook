# frozen_string_literal: true

module Api
  module V1
    class CoursesController < ApplicationController
      include Commentable
      before_action :set_course, only: %i[show update destroy start_course update_poster get_poster]
      before_action :set_team, only: %i[index create]

      def index
        respond_with(@courses = @team.courses.all)
      end

      def all
        respond_with(@courses = Course.all)
      end

      def show
        respond_with(@course.as_json(include: :lessons))
      end

      def create
        @course = @team.courses.create(set_params)
        render json: @course
      end

      def update
        @course.update(set_params)
        render json: @course
      end

      def update_poster
        @course.poster.attach(params['poster'])
        render json: rails_blob_url(@course.poster)
      end

      def get_poster
        respond_with(poster: rails_blob_url(@course.poster)) if @course.poster.attached?
      end

      def destroy
        @course.delete
      end

      def start_course
        @course_user = @course.courses_users.new(student: current_user)
        render json: @course_user.as_json(only: :status) if @course_user.save
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
