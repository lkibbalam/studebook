# frozen_string_literal: true

class CoursesUserSerializer < ActiveModel::Serializer
  attributes %i[status created_at updated_at]
end
