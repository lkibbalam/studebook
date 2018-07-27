module Types
  UserType = GraphQL::ObjectType.define do
    name 'User'

    field :id, !types.ID
    field :first_name, !types.String
    field :last_name, !types.String
    field :email, !types.String
    field :phone, !types.String

    field :mentor do
      type Types::UserType
      description 'User mentor'
      resolve ->(obj, args, ctx) { obj.mentor }
    end

    field :team do
      type Types::TeamType
      description 'User team'
      resolve ->(obj, args, ctx) { obj.team }
    end
  end
end
