# frozen_string_literal: true

module Users
  class CreateUser
    include Callable

    def initialize(params)
      params.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    def call
      create_user
    end

    private

    attr_reader :email, :password, :first_name, :last_name, :nickname, :phone,
                :role, :avatar, :github_url, :mentor_id, :status, :team

    def create_user
      return if email_occupied?

      User.create(email: email, password: password, team: team,
                  first_name: first_name, last_name: last_name,
                  nickname: nickname, phone: phone, role: role,
                  avatar: avatar, github_url: github_url,
                  mentor_id: mentor_id, status: status)
    end

    def email_occupied?
      User.exists?(email: email)
    end
  end
end
