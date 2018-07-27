module Types
  TeamType = GraphQL::ObjectType.define do
    name 'Team'

    field :id, !types.ID
    field :title, !types.String
    field :body, !types.String

    field :users do
      type !types[Types::UserType]
      description 'All team users'
      resolve ->(obj, args, ctx) { obj.users }
    end

    field :courses do
      type !types[Types::CourseType]
      description 'All team courses'
      resolve ->(obj, args, ctx) { obj.courses }
    end
  end
end
