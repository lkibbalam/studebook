# frozen_string_literal: true

module Api
  module V1
    class NotificationsController < ApplicationController
      def index
        @notifications = current_user.notifications
        authorize @notifications
        respond_with(@notifications)
      end

      def seen
        @notification = Notification.find(params[:id])
        @notification.update(status: :seen)
        authorize @notification
        render json: @notification
      end
    end
  end
end
