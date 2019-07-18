# frozen_string_literal: true

require "rails_helper"

describe LessonsUserPolicy do
  subject { described_class.new(admin, lesson_user) }

  let(:lesson_user) { create(:lessons_user) }

  let(:resolved_scope) do
    described_class::Scope.new(admin, LessonsUser.all).resolve
  end

  context "admin with active status accessing" do
    let(:admin) { create(:user, :admin) }

    it "includes in resolved scope" do
      expect(resolved_scope).to include(lesson_user)
    end

    it { is_expected.to permit_actions(%i[show update]) }
  end

  context "admin with inactive status" do
    let(:admin) { create(:user, :admin, status: :inactive) }

    context "accessing a course" do
      it { is_expected.to forbid_actions(%i[show update]) }
    end
  end
end
