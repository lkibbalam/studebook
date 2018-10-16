# frozen_string_literal: true

module Types
  class CommentsConnectionType < ::Types::BaseConnection
    edge_type(Types::CommentEdgeType)
  end
end
