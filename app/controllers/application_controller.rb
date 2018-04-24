require 'application_responder'

class ApplicationController < ActionController::API
  include Knock::Authenticable
  self.responder = ApplicationResponder
  respond_to :json
end
