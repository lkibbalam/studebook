# frozen_string_literal: true

require "rails_helper"

RSpec.describe Team, type: :model do
  it { should have_many(:courses) }
  it { should have_many(:users) }
end
