# frozen_string_literal: true

module Api
  module V1
    class TeamsController < ApplicationController
      before_action :set_team, only: %i[show update destroy]

      def index
        @teams = Team.all
        authorize @teams
        respond_with(@teams)
      end

      def show
        authorize @team
        respond_with(@team)
      end

      def create
        @team = Team.create(team_params)
        authorize @team
        respond_with :api, :v1, @team
      end

      def update
        @team.update(team_params)
        authorize @team
        respond_with :api, :v1, @team
      end

      def destroy
        authorize @team
        respond_with(@team.delete)
      end

      private

      def team_params
        params.require(:team).permit(:title, :description)
      end

      def set_team
        @team = Team.find(params[:id])
      end
    end
  end
end
