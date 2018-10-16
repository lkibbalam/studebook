# frozen_string_literal: true

module Types
  class NotificationsConnectionType < ::Types::BaseConnection
    edge_type(Types::NotificationEdgeType)
  end
end
