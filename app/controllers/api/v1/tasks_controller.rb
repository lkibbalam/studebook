module Api
  module V1
    class TasksController < ApplicationController
      def task_to_verify
        task = Task.find(params[:id])
        @task_user = TasksUser.find_by(user: current_user, task: task)
        @task_user.update(set_task_verify_params.merge(status: 1))
        render json: @task_user
        # TODO: Test
      end

      private

      def set_task_verify_params
        params.require(:task).permit(:github_url)
      end
    end
  end
end
