# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should belong_to(:lesson) }
  it { should have_db_column(:title) }
  it { should have_db_column(:description) }
  it { should have_db_column(:lesson_id) }
  it { should have_db_index(:lesson_id) }
  it { should have_many(:users).through(:tasks_users) }
  it { should have_many(:tasks_users).dependent(:destroy) }
end
