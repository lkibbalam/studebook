# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_team, only: %i[create mentors index]
      before_action :set_user, only: %i[show update destroy get_avatar]

      def current
        respond_with(current_user)
      end

      def all
        respond_with(User.where(mentor: current_user))
      end

      def show
        respond_with(@user)
      end

      def mentors
        respond_with(@team.users.select(&:staff?))
      end

      def index
        respond_with(@team.users)
      end

      def create
        @user = @team.users.create(admin_permissions_params)
        respond_with :api, :v1, @user
      end

      def update
        return unless params.dig(:user, :password) == params.dig(:user, :password_confirmation)
        @user.update(current_user.admin? ? admin_permissions_params : user_permissions_update_params)
        respond_with :api, :v1, @user
      end

      def destroy
        respond_with(@user.delete)
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def set_team
        @team = Team.find(params[:team_id])
      end

      def admin_permissions_params
        params.require(:user).permit(:first_name, :last_name, :phone, :email,
                                     :password, :status, :role, :avatar, :github_url, :mentor_id)
      end

      def user_permissions_update_params
        params.require(:user).permit(:first_name, :last_name, :phone, :password, :github_url, :avatar)
      end
    end
  end
end
