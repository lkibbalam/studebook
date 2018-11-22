# frozen_string_literal: true

module Api
  module V1
    class TeamsController < ApplicationController
      before_action :load_team, only: %i[show update destroy]

      def index
        @teams = Team.all
        respond_with(@teams)
      end

      def show
        authorize @team
        respond_with(@team)
      end

      def create
        @team = Teams::CreateTeam.call(params: team_params)
        authorize @team
        respond_with :api, :v1, @team
      end

      def update
        authorize @team
        Teams::UpdateTeam.call(team: @team, params: team_params)
        respond_with :api, :v1, @team
      end

      def destroy
        authorize @team
        respond_with(@team.delete)
      end

      private

      def team_params
        params.require(:team).permit(:title, :description, :poster)
      end

      def load_team
        @team = Team.find(params[:id])
      end
    end
  end
end
