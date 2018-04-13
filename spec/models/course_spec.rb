require 'rails_helper'

RSpec.describe Course, type: :model do
  it { should belong_to(:author).class_name('User').with_foreign_key('author_id') }
  it { should belong_to(:team) }
  it { should have_many(:courses_users).dependent(:destroy) }
  it { should have_many(:students).through(:courses_users) }
  it { should have_many(:lessons) }
  it { should have_many(:comments).dependent(:destroy) }
end
