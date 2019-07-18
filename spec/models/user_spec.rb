# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  it { should belong_to(:team).optional }
  it { should belong_to(:mentor).class_name("User").with_foreign_key("mentor_id").optional }
  it { should have_many(:padawans).class_name("User").with_foreign_key("mentor_id") }
  it { should have_many(:own_courses).class_name("Course").with_foreign_key("author_id") }
  it { should have_many(:courses_users).dependent(:destroy).with_foreign_key("student_id") }
  it { should have_many(:courses).through(:courses_users) }
  it { should have_many(:lessons_users).dependent(:destroy).with_foreign_key("student_id") }
  it { should have_many(:lessons).through(:lessons_users) }
  it { should have_many(:tasks_users).dependent(:destroy) }
  it { should have_many(:tasks).through(:tasks_users) }
  it { should have_many(:comments).class_name("Comment").with_foreign_key("user_id") }
end
