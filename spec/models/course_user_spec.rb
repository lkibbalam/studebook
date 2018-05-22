# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoursesUser, type: :model do
  it { should belong_to(:course) }
  it { should belong_to(:student).class_name('User').with_foreign_key('student_id') }
end
