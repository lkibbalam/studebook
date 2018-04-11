module Api
  module V1
    class CoursesController < ApplicationController
      def index
        @courses = Course.all
        render json: @courses
      end
    end
  end
end
