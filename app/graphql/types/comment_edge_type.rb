# frozen_string_literal: true

module Types
  class CommentEdgeType < GraphQL::Types::Relay::BaseEdge
    node_type(Types::CommentType)
  end
end
