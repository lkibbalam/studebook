# frozen_string_literal: true

require 'application_responder'

class ApplicationController < ActionController::API
  self.responder = ApplicationResponder
  include Knock::Authenticable
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from Pundit::NotDefinedError, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record
  before_action :authenticate_user

  respond_to :json

  private

  def user_not_authorized
    render json: { message: 'You are not authorized to perform this action.' }, status: :unauthorized
  end

  def record_not_found
    render json: { message: 'You are not authorized to perform this action.' }, status: :not_found
  end

  def invalid_record(exeption)
    render json: { message: exeption.message }, status: :unprocessable_entity
  end
end
