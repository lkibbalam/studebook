# frozen_string_literal: true

module Types
  class CourseUserEdgeType < GraphQL::Types::Relay::BaseEdge
    node_type(Types::CourseUserType)
  end
end
