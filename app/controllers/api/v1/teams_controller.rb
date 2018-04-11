module Api
  module V1
    class TeamsController < ApplicationController
      def index
        respond_with(@teams = Team.all)
      end
    end
  end
end
