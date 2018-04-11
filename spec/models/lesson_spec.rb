require 'rails_helper'

RSpec.describe Lesson, type: :model do
  it { should belong_to(:course) }
end
