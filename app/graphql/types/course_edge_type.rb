# frozen_string_literal: true

module Types
  class CourseEdgeType < GraphQL::Types::Relay::BaseEdge
    node_type(Types::CourseType)
  end
end
