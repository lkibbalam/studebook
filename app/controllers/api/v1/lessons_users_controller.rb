# frozen_string_literal: true

module Api
  module V1
    class LessonsUsersController < ApplicationController
      include Commentable
      before_action :load_lesson_user, only: %i[update]

      def show
        lesson = Lesson.find(params[:id])
        @lesson_user = LessonsUser.find_by(lesson: lesson, student: current_user)
        authorize @lesson_user
        respond_with(@lesson_user)
      end

      def update
        authorize @lesson_user
        @lesson_user.update(status: :done)
        render json: @lesson_user
      end

      private

      def load_lesson_user
        @lesson_user = LessonsUser.find(params[:id])
      end

      def lesson_user_params
        params.require(:lesson_user).permit(:status, :mark)
      end
    end
  end
end
