# frozen_string_literal: true

module Users
  class Destroy
    include Callable

    def initialize(user:)
      @user = user
    end

    def call
      destroy_user
    end

    private

    attr_reader :user

    def destroy_user
      user.destroy
    end
  end
end
