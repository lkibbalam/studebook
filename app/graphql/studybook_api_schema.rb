# frozen_string_literal: true

class StudybookApiSchema < GraphQL::Schema
  use GraphQL::Batch

  mutation(Types::MutationType)
  query(Types::QueryType)

  max_complexity 200
  max_depth 10
end
