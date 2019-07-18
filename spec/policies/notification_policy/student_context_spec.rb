# frozen_string_literal: true

require "rails_helper"

describe NotificationPolicy do
  subject { described_class.new(student, notification) }

  let(:resolved_scope) do
    described_class::Scope.new(student, Notification.all).resolve
  end

  context "active student" do
    let(:student) { create(:user, :student) }

    context "own notifications" do
      let(:notification) { create(:notification, user: student) }

      it "include notification in resolved scope" do
        expect(resolved_scope).to include(notification)
      end

      it { is_expected.to permit_actions(%i[update]) }
    end

    context "not own notification" do
      let(:notification) { create(:notification) }

      it "excludes notification in resolved scope" do
        expect(resolved_scope).not_to include(notification)
      end

      it { is_expected.to forbid_actions(%i[update]) }
    end
  end

  context "inactive student" do
    let(:student) { create(:user, :student, :inactive) }
    let(:notification) { create(:notification, user: student) }

    it "excludes  notification in resolved scope" do
      expect(resolved_scope).to be_empty
    end
  end
end
