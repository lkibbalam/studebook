# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :load_user, only: %i[show update destroy get_avatar]

      def index
        respond_with(User.all)
      end

      def current
        @user = current_user
        authorize @user
        respond_with(@user)
      end

      def padawans
        @users = current_user.padawans
        respond_with(@users)
      end

      def show
        authorize @user
        respond_with(@user)
      end

      def mentors
        @users = current_user.team.users.select(&:staff?)
        respond_with(@users)
      end

      def create
        @user = Users::CreateUser.call(params: admin_permissions_params)
        authorize @user
        render json: @user
      end

      def update
        authorize @user
        Users::UpdateUser.call(user: @user, params: current_user.admin? ? admin_permissions_params : user_permissions_update_params)
        render json: @user
      end

      def change_password
        Users::UpdateUser.call(user: @user, params: current_user.admin? ? admin_permissions_params : user_permissions_update_params)
      end

      def destroy
        authorize @user
        respond_with(@user.delete)
      end

      private

      def load_user
        @user = User.find(params[:id])
      end

      def admin_permissions_params
        params.require(:user).permit(:first_name, :last_name, :phone, :email,
                                     :password, :status, :role, :avatar, :github_url,
                                     :mentor_id, :nickname, :team_id, :new_password,
                                     :current_password, :password_confirmation)
      end

      def user_permissions_update_params
        params.require(:user).permit(:first_name, :last_name, :phone, :password, :github_url, :avatar)
      end
    end
  end
end
