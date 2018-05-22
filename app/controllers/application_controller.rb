# frozen_string_literal: true

require 'application_responder'

class ApplicationController < ActionController::API
  self.responder = ApplicationResponder
  include Knock::Authenticable
  include Pundit
  before_action :authenticate_user

  respond_to :json
end
