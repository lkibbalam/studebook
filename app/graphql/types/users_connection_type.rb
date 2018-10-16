# frozen_string_literal: true

module Types
  class UsersConnectionType < ::Types::BaseConnection
    edge_type(Types::UserEdgeType)
  end
end
