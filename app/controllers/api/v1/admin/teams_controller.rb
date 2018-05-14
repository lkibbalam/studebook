module Api
  module V1
    module Admin
      class TeamsController < ApplicationController
        def index
          respond_with(@teams = Team.all)
        end
      end
    end
  end
end
