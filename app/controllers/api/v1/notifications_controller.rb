# frozen_string_literal: true

module Api
  module V1
    class NotificationsController < ApplicationController
      def index
        respond_with(current_user.notifications)
      end

      def seen
        @notification = Notification.find(params[:id])
        @notification.update(status: :seen)
        render json: @notification
      end
    end
  end
end
