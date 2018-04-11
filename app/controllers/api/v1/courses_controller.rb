module Api
  module V1
    class CoursesController < ApplicationController
      before_action :set_course, only: :show

      def index
        respond_with(@courses = Course.all)
      end

      def show
        respond_with(@course)
      end

      private

      def set_course
        @course = Course.find(params[:id])
      end
    end
  end
end
