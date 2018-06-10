# frozen_string_literal: true

module Api
  module V1
    class TasksUsersController < ApplicationController
      before_action :set_task_user, only: %i[show update]

      def index
        user = User.find(params[:id])
        @tasks_user = user.tasks_users
        authorize @tasks_user
        respond_with(@tasks_user)
      end

      def show
        authorize @task_user
        respond_with(@task_user)
      end

      def update
        @task_user.update(task_user_params)
        authorize @task_user
        render json: @task_user
      end

      private

      def set_task_user
        @task_user = TasksUser.find(params[:id])
      end

      def task_user_params
        params.require(:task).permit(:github_url, :status)
      end
    end
  end
end
