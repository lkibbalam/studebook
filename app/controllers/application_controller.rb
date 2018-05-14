require 'application_responder'

class ApplicationController < ActionController::API
  include Knock::Authenticable
  include Pundit
  self.responder = ApplicationResponder
  before_action :authenticate_user
  #  protect_from_forgery

  respond_to :json
end
