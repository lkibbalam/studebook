# frozen_string_literal: true

module Api
  module V1
    class TasksController < ApplicationController
      before_action :set_task, only: %i[show update destroy]

      def show
        respond_with(@task.as_json)
      end

      def create
        @lesson = Lesson.find(params[:lesson_id])
        @task = @lesson.tasks.build(set_params)
        render json: @task.as_json if @task.save
      end

      def update
        @task.assign_attributes(set_params)
        render json: @task.as_json if @task.save
      end

      def destroy
        @task.delete
      end

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

      def set_params
        params.require(:task).permit(:title, :description)
      end

      def set_task
        @task = Task.find(params[:id])
      end
    end
  end
end
