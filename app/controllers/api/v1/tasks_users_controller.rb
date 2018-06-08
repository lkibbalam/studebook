# frozen_string_literal: true

module Api
  module V1
    class TasksUsersController < ApplicationController
      before_action :set_task_user, only: %i[approve_or_change_task task_to_verify padawan_task]

      def padawan_tasks
        user = User.find(params[:id])
        @tasks_user = user.tasks_users
        respond_with(@tasks_user)
      end

      def padawan_task
        respond_with(@task_user)
      end

      def task_to_verify
        @task_user.update(set_task_verify_params.merge(status: :verifying))
        render json: @task_user
      end

      def approve_or_change_task
        @task_user.update(set_task_verify_params)
        render json: @task_user
      end

      private

      def set_task_user
        @task_user = TasksUser.find(params[:id])
      end

      def set_task_verify_params
        params.require(:task).permit(:github_url, :status)
      end
    end
  end
end
