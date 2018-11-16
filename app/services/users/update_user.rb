# frozen_string_literal: true

module Users
  class UpdateUser
    include Callable

    def initialize(user:, params:)
      @user = user
      params.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    def call
      update_user
    end

    private

    attr_reader :user, :email, :password, :first_name, :last_name, :nickname, :phone,
                :role, :avatar, :github_url, :mentor_id, :status, :team_id

    def update_user
      user.update(attributes)
      user
    end

    def attributes
      { email: email, password: password, team_id: team_id,
        first_name: first_name, last_name: last_name,
        nickname: nickname, phone: phone, role: role,
        avatar: avatar, github_url: github_url,
        mentor_id: mentor_id, status: status }.compact
    end
  end
end
