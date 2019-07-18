# frozen_string_literal: true

require "rails_helper"

describe NotificationPolicy do
  subject { described_class.new(visitor, notification) }

  let(:visitor) { nil }
  let(:resolved_scope) do
    described_class::Scope.new(visitor, Notification.all).resolve
  end

  context "visitor accessing actions" do
    let(:notification) { create(:notification) }

    it "should resolve be empty" do
      expect(resolved_scope).to be_empty
    end

    it { is_expected.to forbid_actions(%i[update]) }
  end
end
