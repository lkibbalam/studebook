# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoursePolicy do
  let(:user) { User.new }
  let(:admin) { User.new(role: :admin) }

  subject { described_class }
  permissions :show?, :index?, :all? do
    it 'all users can see courses list' do
      expect(subject).to permit(user)
    end
  end

  permissions :create? do
    it 'admin can create courses' do
      expect(subject).to permit(admin, Course.new)
    end
  end

  permissions :update? do
    it 'admin can create courses' do
      expect(subject).to permit(admin, Course.new)
    end
  end

  permissions :destroy? do
    it 'admin can create courses' do
      expect(subject).to permit(admin, Course.new)
    end
  end
end
