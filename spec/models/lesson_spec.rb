require 'rails_helper'

RSpec.describe Lesson, type: :model do
  it { should belong_to(:course) }
  it { should have_many(:lessons_users).dependent(:destroy) }
  it { should have_many(:students).through(:lessons_users) }
end
