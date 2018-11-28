# frozen_string_literal: true

module TasksUsers
  class Update
    include Callable

    def initialize(task_user:, params:)
      @task_user = task_user
      params.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    def call
      update_task_user
    end

    private

    attr_reader :task_user, :status, :github_url, :comment

    def update_task_user
      task_user if task_user.update(attributes)
    end

    def attributes
      { status: status,
        github_url: github_url }.compact
    end
  end
end
