# frozen_string_literal: true

module Types
  class TeamEdgeType < GraphQL::Types::Relay::BaseEdge
    node_type(Types::TeamType)
  end
end
