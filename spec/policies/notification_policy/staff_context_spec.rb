# frozen_string_literal: true

require 'rails_helper'

describe NotificationPolicy do
  subject { described_class.new(staff, notification) }

  let(:resolved_scope) do
    described_class::Scope.new(staff, Notification.all).resolve
  end

  context 'active staff' do
    let(:staff) { create(:user, :staff) }

    context 'own notifications' do
      let(:notification) { create(:notification, user: staff) }

      it 'include notification in resolved scope' do
        expect(resolved_scope).to include(notification)
      end

      it { is_expected.to permit_actions(%i[update]) }
    end

    context 'not own notifications' do
      let(:notification) { create(:notification) }

      it 'exclude notification in resolved scope' do
        expect(resolved_scope).not_to include(notification)
      end

      it { is_expected.to forbid_actions(%i[update]) }
    end

    context 'own padawan notification' do
      let(:padawan) { create(:user, :student, mentor: staff) }
      let(:notification) { create(:notification, user: padawan) }

      it 'exclude notification in resolved scope' do
        expect(resolved_scope).not_to include(notification)
      end

      it { is_expected.to forbid_actions(%i[update]) }
    end
  end

  context 'inactive staff' do
    let(:staff) { create(:user, :staff, :inactive) }
    let(:notification) { create(:notification, user: staff) }

    it 'resolved scope should be empty' do
      expect(resolved_scope).to be_empty
    end

    it { is_expected.to forbid_actions(%i[update]) }
  end
end
