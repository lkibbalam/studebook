# frozen_string_literal: true

module Users
  class Update
    include Callable

    def initialize(user:, params:)
      @user = user
      @params = params
    end

    def call
      update_user
    end

    private
      attr_reader :user, :params

      def update_user
        if password_confirmed?
          user.update(params.except(*password_attributes).merge(password: params.dig(:new_password)))
        else
          user.update(params.except(*password_attributes))
        end
        user
      end

      def password_confirmed?
        return unless user.authenticate(params.dig(:current_password))

        params.dig(:new_password) == params.dig(:password_confirmation)
      end

      def password_attributes
        [ :password_confirmation, :current_password, :new_password ]
      end
  end
end
