# frozen_string_literal: true

module Types
  class NotificationEdgeType < GraphQL::Types::Relay::BaseEdge
    node_type(Types::NotificationType)
  end
end
