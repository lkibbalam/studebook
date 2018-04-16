module Api
  module V1
    class TeamsController < ApplicationController
      before_action :set_team, only: %i[show update destroy]

      def index
        respond_with(@teams = Team.all)
      end

      def show
        respond_with(@team)
      end

      def create
        @team = Team.create(set_params)
        render json: @team
      end

      def update
        @team.update(set_params)
        render json: @team
      end

      def destroy
        @team.delete
      end

      private

      def set_params
        params.require(:team).permit(:title, :description)
      end

      def set_team
        @team = Team.find(params[:id])
      end
    end
  end
end
