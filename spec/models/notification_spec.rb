# frozen_string_literal: true

require "rails_helper"

RSpec.describe Notification, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:tasks_user) }
end
