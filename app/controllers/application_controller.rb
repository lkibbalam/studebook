require 'application_responder'

class ApplicationController < ActionController::API
  include Knock::Authenticable
  self.responder = ApplicationResponder
  # before_action :authenticate_user
  respond_to :json
end
