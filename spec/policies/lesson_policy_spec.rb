# frozen_string_literal: true

require 'rails_helper'

describe LessonPolicy do
  let(:admin) { create(:user, :admin) }
  let(:lead) { create(:user, :leader) }
  let(:moder) { create(:user, :moder) }
  let(:staff) { create(:user, :staff) }
  let(:student) { create(:user, :student) }
  let(:lesson) { create(:lesson) }

  subject { described_class }

  permissions :show? do
    it 'if user present can see lesson' do
      expect(subject).to permit(student, lesson)
    end
  end

  permissions :create? do
    it 'create new lessons can admin' do
      expect(subject).to permit(admin, lesson)
    end

    it 'cant create lesson' do
      expect(subject).to_not permit(student, lesson)
    end
  end

  permissions :update? do
    it 'create new lessons can admin' do
      expect(subject).to permit(admin, lesson)
    end

    it 'cant create lesson' do
      expect(subject).to_not permit(student, lesson)
    end
  end

  permissions :destroy? do
    it 'create new lessons can admin' do
      expect(subject).to permit(admin, lesson)
    end

    it 'cant create lesson' do
      expect(subject).to_not permit(student, lesson)
    end
  end
end
