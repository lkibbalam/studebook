# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksUser, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:task) }
  it { should have_many(:notifications) }
end
