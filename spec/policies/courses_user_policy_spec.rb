# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoursesUserPolicy do
  let(:admin) { User.new(role: :admin) }
  let(:lead) { User.new(role: :leader) }
  let(:moder) { User.new(role: :moder) }
  let(:staff) { User.new(role: :staff) }
  let(:student) { User.new(role: :student) }
  let(:another_student) { User.new(role: :student) }

  subject { described_class }

  permissions :index? do
    it 'can index if admin or lead' do
      expect(subject).to permit(admin)
      expect(subject).to permit(lead)
    end
  end

  permissions :show? do
    it 'can see own courses' do
      expect(subject).to permit(student, CoursesUser.new(student: student))
    end

    it 'other students cant see courses of student' do
      expect(subject).to_not permit(another_student, CoursesUser.new(student: student))
    end

    it 'admin lead can see course' do
      expect(subject).to permit(admin, CoursesUser.new(student: student))
      expect(subject).to permit(lead, CoursesUser.new(student: student))
    end
  end

  permissions :padawan_courses? do
    it 'approve  can student mentor' do
      expect(subject).to permit(staff)
    end
  end
end
