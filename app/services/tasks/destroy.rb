# frozen_string_literal: true

module Tasks
  class Destroy
    include Callable

    def initialize(task:)
      @task = task
    end

    def call
      destroy_task
    end

    private
      attr_reader :task

      def destroy_task
        task.destroy
      end
  end
end
