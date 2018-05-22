# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Video, type: :model do
  it { should belong_to(:lesson) }
end
