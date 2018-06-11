# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LessonPolicy do
  let(:user) { User.new }
  let(:admin) { User.new(role: :admin) }
  let(:lead) { User.new(role: :leader) }
  let(:moder) { User.new(role: :moder) }
  let(:staff) { User.new(role: :staff) }
  let(:student) { User.new(role: :student) }

  subject { described_class }

  permissions :show? do
    it 'if user present can see lesson' do
      expect(subject).to permit(user, Lesson.new)
    end
  end

  permissions :create? do
    it 'create new lessons can admin' do
      expect(subject).to permit(admin, Lesson.new)
    end

    it 'cant create lesson' do
      expect(subject).to_not permit(student, Lesson.new)
    end
  end

  permissions :update? do
    it 'create new lessons can admin' do
      expect(subject).to permit(admin, Lesson.new)
    end

    it 'cant create lesson' do
      expect(subject).to_not permit(student, Lesson.new)
    end
  end

  permissions :destroy? do
    it 'create new lessons can admin' do
      expect(subject).to permit(admin, Lesson.new)
    end

    it 'cant create lesson' do
      expect(subject).to_not permit(student, Lesson.new)
    end
  end
end
