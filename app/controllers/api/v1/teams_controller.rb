module Api
  module V1
    class TeamsController < ApplicationController
      def index
        @teams = Team.all
        render json: @teams
      end
    end
  end
end
