require 'rails_helper'

RSpec.describe UserPolicy do

  let(:admin) { User.new(role: :admin) }
  let(:lead) { User.new(role: :leader) }
  let(:moder) { User.new(role: :moder) }
  let(:staff) { User.new(role: :staff) }
  let(:student) { User.new(role: :student) }
  let!(:user) { User.new }

  subject { described_class }

  permissions :current? do
    it 'all users can see own profile' do
      expect(subject).to permit(user)
    end
  end

  permissions :all? do
    it 'only staff mentor can see own padawans' do
      expect(subject).to permit(staff)
    end
  end

  permissions :show? do
    it 'only lead admin can see profiles others users' do
      expect(subject).to permit(admin)
      expect(subject).to permit(lead)
    end

    it 'student staff moder can`t see other profiles' do
      expect(subject).to_not permit(student)
      expect(subject).to_not permit(staff)
      expect(subject).to_not permit(moder)
    end
  end

  permissions :mentors? do
    it 'only lead admin can see new mentors' do
      expect(subject).to permit(admin)
      expect(subject).to permit(lead)
    end

    it 'staff student moder can`t see mentors' do
      expect(subject).to_not permit(student)
      expect(subject).to_not permit(staff)
      expect(subject).to_not permit(moder)
    end
  end

  permissions :create? do
    it 'only lead admin can create new user' do
      expect(subject).to permit(admin)
      expect(subject).to permit(lead)
    end

    it 'staff student moder can`t create user' do
      expect(subject).to_not permit(student)
      expect(subject).to_not permit(staff)
      expect(subject).to_not permit(moder)
    end
  end

  permissions :update? do
    it 'admin can update all user' do
      expect(subject).to permit(admin)
    end

    it 'user can update own profile' do
      expect(subject).to permit(user, user)
    end
  end

  permissions :destroy? do
    it 'admin can destroy user' do
      expect(subject).to permit(admin)
    end

    it 'staff lead moder student can`t destroy users' do
      expect(subject).to_not permit(lead)
      expect(subject).to_not permit(moder)
      expect(subject).to_not permit(staff)
      expect(subject).to_not permit(student)
    end
  end
end
