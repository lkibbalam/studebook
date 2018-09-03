# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :load_team, only: %i[create]
      before_action :load_user, only: %i[show update destroy get_avatar]

      def index
        respond_with(User.all)
      end

      def current
        @user = current_user
        authorize @user
        respond_with(@user)
      end

      def all
        @users = User.where(mentor: current_user)
        authorize @users
        respond_with(@users)
      end

      def show
        authorize @user
        respond_with(@user)
      end

      def mentors
        @users = current_user.team.users.select(&:staff?)
        # authorize @users
        respond_with(@users)
      end

      def create
        @user = @team.users.create(admin_permissions_params)
        authorize @user
        render json: @user
      end

      def update
        authorize @user
        @user.update(current_user.admin? ? admin_permissions_params : user_permissions_update_params)
        render json: @user
      end

      def change_password
        return unless current_user.authenticate(params.dig(:user, :current_password))
        return unless params.dig(:user, :new_password) == params.dig(:user, :password_confirmation)
        current_user.update(password: params.dig(:user, :new_password))
      end

      def destroy
        authorize @user
        respond_with(@user.delete)
      end

      private

      def load_user
        @user = User.find(params[:id])
      end

      def load_team
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
