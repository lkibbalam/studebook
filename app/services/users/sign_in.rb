# frozen_string_literal: true

module Users
  class SignIn
    include Callable

    def initialize(email:, password:)
      @email = email
      @password = password
    end

    def call
      authenticate_user
    end

    private
      attr_reader :email, :password

      def authenticate_user
        user = find_user(email, password)

        return { errors: [UserError.new("email or password is invalid")] } unless user

        token = Knock::AuthToken.new(payload: { sub: user.id }).token

        {
          token: token,
          errors: []
        }
      end

      def find_user(email, password)
        return if email.blank? || password.blank?

        user = User.find_by(email: email)
        return unless user&.authenticate(password)

        user
      end
  end
end
