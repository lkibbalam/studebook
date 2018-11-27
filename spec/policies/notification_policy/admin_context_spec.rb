# frozen_string_literal: true

require 'rails_helper'

describe NotificationPolicy do
  subject { described_class.new(admin, notification) }

  let(:resolved_scope) do
    described_class::Scope.new(admin, Notification.all).resolve
  end

  context 'active admin accessing actions' do
    let(:admin) { create(:user, :admin) }
    let(:notification) { create(:notification) }

    it 'includes notifications in resolved scope' do
      expect(resolved_scope).to include(notification)
    end

    it { is_expected.to permit_actions(%i[update]) }
  end

  context 'inactive admin accessing actions' do
    let(:admin) { create(:user, :admin, :inactive) }
    let(:notification) { create(:notification) }

    it 'includes notifications in resolved scope' do
      expect(resolved_scope).to be_empty
    end

    it { is_expected.to forbid_actions(%i[update]) }
  end
end
