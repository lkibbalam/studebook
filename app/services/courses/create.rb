# frozen_string_literal: true

module Courses
  class Create
    include Callable

    def initialize(params:)
      @params = params
    end

    def call
      create_course
    end

    private

    attr_reader :params

    def create_course
      Course.create(params)
    end
  end
end
