FactoryBot.define do
  factory :user, aliases: %i[author mentor student] do
    first_name 'MyFirst_name'
    last_name 'MyLast_name'
    phone 9999
    role 1
    team
  end
end
