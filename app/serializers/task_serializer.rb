# frozen_string_literal: true

class TaskSerializer < ActiveModel::Serializer
  attributes %i[title description]
end
