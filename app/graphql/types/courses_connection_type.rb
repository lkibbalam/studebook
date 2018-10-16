# frozen_string_literal: true

module Types
  class CoursesConnectionType < ::Types::BaseConnection
    edge_type(Types::CourseEdgeType)
  end
end
