require 'rails_helper'

RSpec.describe LessonsUser, type: :model do
  it { should belong_to(:student).class_name('User').with_foreign_key('student_id') }
  it { should belong_to(:lesson) }
end
