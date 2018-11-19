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
        @user = Users::CreateUser.call(params: user_params)
        authorize @user
        render json: @user
      end

      def update
        authorize @user
        Users::UpdateUser.call(user: @user, params: user_params)
        render json: @user
      end

      def change_password
        authorize current_user
        Users::UpdateUser.call(user: current_user, params: user_params)
      end

      def destroy
        authorize @user
        respond_with(Users::DestroyUser.call(user: @user))
      end

      private

      def load_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user)
              .permit(UserPolicy.new(current_user, @user).permitted_attributes)
      end
    end
  end
end
