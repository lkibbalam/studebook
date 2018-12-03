# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksUser, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:task) }
  it { should have_many(:notifications) }

  let(:mentor) { create(:user, :staff) }
  let(:student) { create(:user, :student, mentor: mentor) }
  let(:course) { create(:course, lessons: create_list(:lesson_with_3_tasks, 3)) }
  let!(:course_user) { create(:courses_user, student: student, course: course) }
end
