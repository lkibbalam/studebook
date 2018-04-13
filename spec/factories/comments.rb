FactoryBot.define do
  factory :comment do
    commentable_type 'MyString'
    commentable_id ''
    body 'MyText'
    user
    parent_id nil
  end
end
