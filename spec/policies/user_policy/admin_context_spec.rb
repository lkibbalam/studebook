# frozen_string_literal: true

require "rails_helper"

describe UserPolicy do
  subject { described_class.new(admin, user) }

  let(:user) { create(:user) }

  let(:resolved_scope) do
    described_class::Scope.new(admin, User.all).resolve
  end

  context "admin with active status accessing" do
    let(:admin) { create(:user, :admin) }

    it "includes in resolved scope" do
      expect(resolved_scope).to include(user)
    end

    it { is_expected.to permit_actions(%i[show create update destroy change_password]) }
  end

  context "admin with inactive status" do
    let(:admin) { create(:user, :admin, :inactive) }

    context "accessing a user" do
      it { is_expected.to forbid_actions(%i[show create update destroy change_password]) }
    end
  end

  describe "permitted attributes for admin" do
    let(:admin) { create(:user, :admin) }
    let(:user) { create(:user) }

    it do
      is_expected
        .to permit_mass_assignment_of(%i[team_id mentor_id status role password
                                         email first_name last_name
                                         nickname phone avatar github_url
                                         current_password new_password
                                         password_confirmation])
    end
  end
end
