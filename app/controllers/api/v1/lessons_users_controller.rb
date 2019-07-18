# frozen_string_literal: true

module Api
  module V1
    class LessonsUsersController < ApplicationController
      include Commentable
      before_action :load_lesson_user, only: %i[update]

      def show
        @lesson_user = current_user.lessons_users.find_by(lesson_id: params[:id])
        authorize @lesson_user
        respond_with(@lesson_user)
      end

      def update
        authorize @lesson_user
        LessonsUsers::Update.call(lesson_user: @lesson_user, params: lesson_user_params)
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
