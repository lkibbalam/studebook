# frozen_string_literal: true

class StudybookApiSchema < GraphQL::Schema
  mutation Types::MutationType
  query Types::QueryType
  use GraphQL::Guard.new
  use GraphQL::Batch
  max_complexity 200
  max_depth 10
end
