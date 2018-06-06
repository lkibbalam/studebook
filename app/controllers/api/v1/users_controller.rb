# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_team, only: %i[create]
      before_action :set_user, only: %i[show update destroy get_avatar]

      def current
        render json: current_user.as_json(only: %i[id email first_name last_name phone role], methods: :courses_users)
      end

      def all
        respond_with(@users = User.where(mentor: current_user))
      end

      def show
        respond_with(@user.as_json(only: %i[id email first_name last_name
                                            phone role password github_url], methods: :courses))
      end

      def mentors
        @users = User.select(&:staff?)
        respond_with(@users.as_json(only: %i[id last_name first_name]))
      end

      def index
        users = UserSerializer.new(User.all).serialized_json
        respond_with(users)
      end

      def create
        @user = @team.users.create(admin_permissions_params)
        render json: @user
      end

      def get_avatar
        if @user.avatar.attached?
          avatar_url = rails_blob_url(@user.avatar)
          respond_with(avatar: avatar_url.as_json)
        end
      end

      def update_avatar
        current_user.avatar.attach(params['avatar'])
        render json: rails_blob_url(current_user.avatar)
      end

      def update
        if params.dig(:user, :password) == params.dig(:user, :password_confirmation)
          @user.assign_attributes(current_user.admin? ? admin_permissions_params : user_permissions_update_params)
          render json: @user.as_json(only: %i[id email first_name last_name phone role password github_url]) if @user.save
        end
      end

      def destroy
        @user.delete
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
        params.require(:user).permit(:first_name, :last_name, :phone, :password, :github_url)
      end
    end
  end
end
