# frozen_string_literal: true

require 'rails_helper'

describe CoursePolicy do
  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }

  subject { described_class }
  permissions :show?, :index?, :all? do
    it 'all users can see courses list' do
      expect(subject).to permit(user)
    end
  end

  permissions :create? do
    it 'admin can create courses' do
      expect(subject).to permit(admin, create(:course))
    end
  end

  permissions :update? do
    it 'admin can create courses' do
      expect(subject).to permit(admin, create(:course))
    end
  end

  permissions :destroy? do
    it 'admin can create courses' do
      expect(subject).to permit(admin, create(:course))
    end
  end
end
