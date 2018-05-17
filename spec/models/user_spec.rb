require 'rails_helper'

RSpec.describe User, type: :model do
  it { should belong_to(:team) }
  it { should belong_to(:mentor).class_name('User').with_foreign_key('mentor_id') }
  it { should have_many(:wards).class_name('User').with_foreign_key('id') }
  it { should have_many(:own_courses).class_name('Course').with_foreign_key('author_id') }
  it { should have_many(:courses_users).dependent(:destroy).with_foreign_key('student_id') }
  it { should have_many(:courses).through(:courses_users) }
  it { should have_many(:lessons_users).dependent(:destroy).with_foreign_key('student_id') }
  it { should have_many(:lessons).through(:lessons_users) }
  it { should have_many(:tasks_users).dependent(:destroy) }
  it { should have_many(:tasks).through(:tasks_users) }
end
