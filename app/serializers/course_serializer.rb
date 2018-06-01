# frozen_string_literal: true

class CourseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :team_id
end
