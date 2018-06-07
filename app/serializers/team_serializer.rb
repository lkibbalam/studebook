# frozen_string_literal: true

class TeamSerializer < ActiveModel::Serializer
  attributes %i[title description]
end
