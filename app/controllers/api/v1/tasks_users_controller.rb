# frozen_string_literal: true

module Api
  module V1
    class TasksUsersController < ApplicationController
      before_action :load_task_user, only: %i[show update]
      # before_action :load_task, only: %i[update]

      def index
        # TODO: Rewrite for concreta course
        user = User.find(params[:id])
        @tasks_user = user.tasks_users
        respond_with(@tasks_user)
      end

      def show
        authorize @task_user
        respond_with(@task_user)
      end

      def update
        authorize @task_user
        TasksUsers::Update
          .call(current_user: current_user,
                params: task_user_params,
                task_user: @task_user)
        render json: @task_user
      end

      private
        def load_task
          @task = Task.find(params[:id])
        end

        def load_task_user
          @task_user = TasksUser.find(params[:id])
        end

        def task_user_params
          params.require(:task).permit(:github_url, :status, :comment)
        end
    end
  end
end
