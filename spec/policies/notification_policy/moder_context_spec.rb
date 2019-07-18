# frozen_string_literal: true

require "rails_helper"

describe NotificationPolicy do
  subject { described_class.new(moder, notification) }

  let(:resolved_scope) do
    described_class::Scope.new(moder, Notification.all).resolve
  end

  context "active moder" do
    let(:moder) { create(:user, :moder) }

    context "own notifications" do
      let(:notification) { create(:notification, user: moder) }

      it "include notification in resolved scope" do
        expect(resolved_scope).to include(notification)
      end

      it { is_expected.to permit_actions(%i[update]) }
    end

    context "not own notifications" do
      let(:notification) { create(:notification) }

      it "exclude notification in resolved scope" do
        expect(resolved_scope).not_to include(notification)
      end

      it { is_expected.to forbid_actions(%i[update]) }
    end

    context "own padawan notification" do
      let(:padawan) { create(:user, :student, mentor: moder) }
      let(:notification) { create(:notification, user: padawan) }

      it "exclude notification in resolved scope" do
        expect(resolved_scope).not_to include(notification)
      end

      it { is_expected.to forbid_actions(%i[update]) }
    end

    context "own team users" do
      let(:user) { create(:user, :student, team: moder.team) }
      let(:notification) { create(:notification, user: user) }

      it "exclude notification in resolved scope" do
        expect(resolved_scope).not_to include(notification)
      end

      it { is_expected.to forbid_actions(%i[update]) }
    end
  end

  context "inactive moder" do
    let(:moder) { create(:user, :moder, :inactive) }
    let(:notification) { create(:notification, user: moder) }

    it "resolved scope should be empty" do
      expect(resolved_scope).to be_empty
    end

    it { is_expected.to forbid_actions(%i[update]) }
  end
end
