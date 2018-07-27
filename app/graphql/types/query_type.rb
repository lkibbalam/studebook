module Types
  QueryType = GraphQL::ObjectType.define do
    name 'Query'
    
    field :users do
      type !types[Types::UserType]
      description 'All users'
      resolve ->(obj, args, ctx) { User.all }
    end

    field :user do
      type Types::UserType
      description 'Find user by ID'
      argument :id, !types.ID
      resolve ->(obj, args, ctx) { User.find(args[:id]) }
    end
  end
end
