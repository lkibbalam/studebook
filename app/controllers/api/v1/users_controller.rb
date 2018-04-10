module Api::V1
  class UsersController < ApplicationController
    before_action :set_team, only: :index
    before_action :set_user, only: :show

    def show
      render json: @user
    end

    def index
      @users = @team.users
      render json: @users
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def set_team
      @team = Team.find(params[:team_id])
    end
  end
end
