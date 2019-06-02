# frozen_string_literal: true

module Users
  class Create
    include Callable

    def initialize(params:)
      @params = params
    end

    def call
      ActiveRecord::Base.transaction do
        user = create_user
        send_welcome
        user
      end
    end

    private

    attr_reader :params

    def create_user
      User.create!(params)
    end

    def send_welcome
      UserMailer.with(user_params: params).welcome.deliver_now
    end
  end
end
