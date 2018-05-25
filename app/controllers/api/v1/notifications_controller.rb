# frozen_string_literal: true

module Api
  module V1
    class NotificationsController < ApplicationController
      def index
        respond_with(@notifications = current_user.notifications.as_json(include:
                                                                              [tasks_user: { include: %i[task user] }]))
      end

      def seen
        @notification = Notification.find(params[:id])
        @notification.assign_attributes(status: :seen)
        render json: @notification.as_json(only: :status) if @notification.save
      end
    end
  end
end
