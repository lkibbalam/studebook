# frozen_string_literal: true

module Api
  module V1
    class TasksController < ApplicationController
      def index_padawan_tasks
        user = User.find(params[:id])
        respond_with(@tasks_user = user.tasks_users.as_json(include:
                                                                [task: { include: [lesson: { include: :course }] }]))
      end

      def show_padawan_task
        @task_user = TasksUser.find(params[:id])
        respond_with(@task_user.as_json(include: :task))
      end

      def task_to_verify
        # TODO: change better will to user TaskUser.find(params[:id])
        task = Task.find(params[:id])
        @task_user = TasksUser.find_by(user: current_user, task: task)
        @task_user.update(set_task_verify_params.merge(status: :verifying))
        render json: @task_user
      end

      def approve_or_change_task
        @task_user = TasksUser.find(params[:id])
        @task_user.update(set_task_verify_params)
        render json: @task_user
      end

      private

      def set_task_verify_params
        params.require(:task).permit(:github_url, :status)
      end
    end
  end
end
