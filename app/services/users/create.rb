# frozen_string_literal: true

module Users
  class Create
    include Callable

    def initialize(params:)
      @params = params
    end

    def call
      create_user
    end

    private

    attr_reader :params

    def create_user
      User.create(params)
    end
  end
end
