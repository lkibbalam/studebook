# frozen_string_literal: true

module Types
  class TeamsConnectionType < ::Types::BaseConnection
    edge_type(Types::TeamEdgeType)
  end
end
