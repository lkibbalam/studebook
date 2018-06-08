# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TeamPolicy do
  subject { described_class }

  permissions :show?, :index? do
    it 'if user present' do
      expect(subject).to permit(User.new)
    end

    it 'denied if user inactive' do
      expect(subject).to_not permit(User.new(status: :inactive))
    end

    it 'denied if user not authorized' do
      expect(subject).to_not permit(nil)
    end
  end

  permissions :create?, :update?, :destroy? do
    it 'allow to create if role of author is admin' do
      expect(subject).to permit(User.new(role: :admin))
    end

    it 'denied if user is inactive' do
      expect(subject).to_not permit(User.new(status: :inactive))
    end

    it 'denied if user is not admin role' do
      expect(subject).to_not permit(User.new(role: :student))
      expect(subject).to_not permit(User.new(role: :staff))
      expect(subject).to_not permit(User.new(role: :leader))
      expect(subject).to_not permit(User.new(role: :moder))
    end
  end
end
