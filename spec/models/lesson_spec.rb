# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Lesson, type: :model do
  it { should belong_to(:course) }
  it { should have_many(:lessons_users).dependent(:destroy) }
  it { should have_many(:students).through(:lessons_users) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:videos).dependent(:destroy) }
end
