# frozen_string_literal: true

module Tasks
  class Update
    include Callable

    def initialize(task:, params:)
      @task = task
      @params = params
    end

    def call
      update_task
    end

    private
      attr_reader :task, :params

      def update_task
        task.update(params.except(:position)) &&
          change_position if params[:position]
        task
      end

      def change_position
        task.insert_at(params[:position])
      end
  end
end
