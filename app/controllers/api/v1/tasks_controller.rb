# frozen_string_literal: true

module Api
  module V1
    class TasksController < ApplicationController
      before_action :set_task, only: %i[show update destroy]

      def show
        authorize @task
        respond_with(@task)
      end

      def create
        @lesson = Lesson.find(params[:lesson_id])
        @task = @lesson.tasks.create(task_params)
        authorize @task
        respond_with :api, :v1, @task
      end

      def update
        @task.update(task_params)
        authorize @task
        respond_with :api, :v1, @task
      end

      def destroy
        authorize @task
        respond_with(@task.delete)
      end

      private

      def task_params
        params.require(:task).permit(:title, :description)
      end

      def set_task
        @task = Task.find(params[:id])
      end
    end
  end
end
