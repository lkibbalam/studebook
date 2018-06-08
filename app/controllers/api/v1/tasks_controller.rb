# frozen_string_literal: true

module Api
  module V1
    class TasksController < ApplicationController
      before_action :set_task, only: %i[show update destroy]

      def show
        respond_with(@task)
      end

      def create
        @lesson = Lesson.find(params[:lesson_id])
        @task = @lesson.tasks.create(set_params)
        respond_with :api, :v1, @task
      end

      def update
        @task.update(set_params)
        respond_with :api, :v1, @task
      end

      def destroy
        respond_with(@task.delete)
      end

      private

      def set_params
        params.require(:task).permit(:title, :description)
      end

      def set_task
        @task = Task.find(params[:id])
      end
    end
  end
end
