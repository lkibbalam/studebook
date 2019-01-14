# frozen_string_literal: true

module Api
  module V1
    class LdapController < ApplicationController::API
      skip_before_action :authenticate_user

      def create
        email = params[:email].downcase
        password = params[:password]

        ldap = Net::LDAP.new(
          host: 'ldap.something.com', # TODO: get ldap params
          auth: { method: :simple, email: email, password: password }
        )
        return unless ldap.bind

        user = User.find_by(email: email)
        user ||= User.create(email: email, password: password)
        token = Knock::AuthToken.new(payload: { sub: user.id }).token

        render json: { token: token }, status: 200
      end
    end
  end
end
