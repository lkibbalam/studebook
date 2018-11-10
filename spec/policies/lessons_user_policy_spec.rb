# frozen_string_literal: true

require 'rails_helper'

describe LessonsUserPolicy do
  let(:mentor) { create(:user, :staff) }
  let(:admin) { create(:user, :admin) }
  let(:lead) { create(:user, :leader) }
  let!(:student) { create(:user, :student, mentor: mentor) }
  let!(:lessons_user) { create(:lessons_user, student: student) }

  subject { described_class }

  permissions :show? do
    it 'admin lead can see user lesson' do
      expect(subject).to permit(admin, lessons_user)
      expect(subject).to permit(lead, lessons_user)
    end

    it 'user can see own lesson' do
      expect(subject).to permit(student, lessons_user)
    end

    it 'mentor can see padawan`s lesson' do
      expect(subject).to permit(mentor, lessons_user)
    end
  end

  permissions :update? do
    it 'admin mentor can approve user lesson' do
      expect(subject).to permit(mentor, lessons_user)
      expect(subject).to permit(admin, lessons_user)
    end
  end
end
