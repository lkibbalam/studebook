# frozen_string_literal: true

module Api
  module V1
    class TasksUsersController < ApplicationController
      before_action :load_task_user, only: %i[show update]
      # before_action :load_task, only: %i[update]

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
        @task_user.assign_attributes(task_user_params)
        authorize @task_user
        unless params.dig(:task, :comment).empty?
          @task_user.comments.create(body: params.dig(:task, :comment), user: current_user)
        end
        render json: @task_user if @task_user.save
      end

      private

      def load_task
        @task = Task.find(params[:id])
      end

      def load_task_user
        @task_user = TasksUser.find(params[:id])
      end

      def task_user_params
        params.require(:task).permit(:github_url, :status)
      end
    end
  end
end
