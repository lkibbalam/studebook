# frozen_string_literal: true

require 'rails_helper'

describe TeamPolicy do
  let(:user) { create(:student) }
  let(:admin) { create(:user, :admin) }
  let(:lead) { create(:user, :leader) }
  let(:staff) { create(:user, :staff) }
  let(:moder) { create(:user, :moder) }
  let(:inactive_user) { create(:user, :inactive) }

  subject { described_class }

  permissions :show?, :index? do
    it 'if user present' do
      expect(subject).to permit(user)
    end

    it 'denied if user inactive' do
      expect(subject).to_not permit(inactive_user)
    end

    it 'denied if user not authorized' do
      expect(subject).to_not permit(nil)
    end
  end

  permissions :create?, :update?, :destroy? do
    it 'allow to create if role of author is admin' do
      expect(subject).to permit(admin)
    end

    it 'denied if user is inactive' do
      expect(subject).to_not permit(inactive_user)
    end

    it 'denied if user is not admin role' do
      expect(subject).to_not permit(user)
      expect(subject).to_not permit(staff)
      expect(subject).to_not permit(lead)
      expect(subject).to_not permit(moder)
    end
  end

  context 'for a visitor' do
    subject { TeamPolicy.new(user, team) }
    let(:user) { nil }
    let(:team) { create(:team) }

    it { is_expected.to forbid_actions(%i[show index create update delete]) }
  end
end
