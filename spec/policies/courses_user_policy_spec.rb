# frozen_string_literal: true

require 'rails_helper'

describe CoursesUserPolicy do
  let(:admin) { create(:user, :admin) }
  let(:lead) { create(:user, :leader) }
  let(:moder) { create(:user, :moder) }
  let(:staff) { create(:user, :staff) }
  let(:student) { create(:student) }
  let(:another_student) { create(:student) }
  let(:course_user) { create(:courses_user, student: student) }

  subject { described_class }

  permissions :index? do
    it 'can index if admin or lead' do
      expect(subject).to permit(admin)
      expect(subject).to permit(lead)
    end
  end

  permissions :show? do
    it 'can see own courses' do
      expect(subject).to permit(student, course_user)
    end

    it 'other students cant see courses of student' do
      expect(subject).to_not permit(another_student, course_user)
    end

    it 'admin lead can see course' do
      expect(subject).to permit(admin, course_user)
      expect(subject).to permit(lead, course_user)
    end
  end

  permissions :padawan_courses? do
    it 'approve  can student mentor' do
      expect(subject).to permit(staff)
    end
  end
end
