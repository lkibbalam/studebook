# frozen_string_literal: true

module Types
  class CoursesUserConnectionType < ::Types::BaseConnection
    edge_type(Types::CourseUserEdgeType)
  end
end
