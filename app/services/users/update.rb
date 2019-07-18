# frozen_string_literal: true

module Users
  class Update
    include Callable

    def initialize(user:, params:)
      @user = user
      params.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    def call
      update_user
    end

    private
      attr_reader :user, :email, :password, :first_name, :last_name, :nickname,
                  :phone, :role, :avatar, :github_url, :mentor_id, :status,
                  :team_id, :current_password, :new_password, :password_confirmation

      def update_user
        if password_attributes.any? && password_confirmed?
          user.update(attributes.merge(password: password_attributes.dig(:new_password)))
        else
          user.update(attributes)
        end
        user
      end

      def password_confirmed?
        return unless user.authenticate(password_attributes.dig(:current_password))

        password_attributes.dig(:new_password) == password_attributes.dig(:password_confirmation)
      end

      def attributes
        { email: email, password: password, team_id: team_id, phone: phone,
          first_name: first_name, last_name: last_name, role: role,
          nickname: nickname, avatar: avatar, github_url: github_url,
          mentor_id: mentor_id, status: status }.compact
      end

      def password_attributes
        { password_confirmation: password_confirmation,
          current_password: current_password,
          new_password: new_password }.compact
      end
  end
end
