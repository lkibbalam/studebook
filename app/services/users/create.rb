# frozen_string_literal: true

module Users
  class Create
    include Callable

    def initialize(params:)
      params.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    def call
      create_user
    end

    private

    attr_reader :email, :password, :first_name, :last_name, :nickname, :phone,
                :role, :avatar, :github_url, :mentor_id, :status, :team_id

    def create_user
      return if email_occupied?

      User.create(attributes)
    end

    def email_occupied?
      User.exists?(email: email)
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
