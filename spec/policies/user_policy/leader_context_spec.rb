# frozen_string_literal: true

require "rails_helper"

describe UserPolicy do
  subject { described_class.new(leader, user) }

  let(:resolved_scope) do
    described_class::Scope.new(leader, User.all).resolve
  end

  context "active leader accessing actions" do
    let(:leader) { create(:user, :leader) }

    context "own team user" do
      let(:user) { create(:user, team: leader.team) }

      it "includes user in resolved scope" do
        expect(resolved_scope).to include(user)
      end

      it { is_expected.to permit_actions(%i[show create update destroy change_password]) }
    end

    context "own padawans" do
      let(:user) { create(:user, mentor: leader, team: leader.team) }

      it "includes user in resolved scope" do
        expect(resolved_scope).to include(user)
      end

      it { is_expected.to permit_actions(%i[show create update destroy change_password]) }
    end

    context "users from foreign team" do
      let(:user) { create(:user) }

      it "exludes user in resolved scope" do
        expect(resolved_scope).not_to include(user)
      end

      it { is_expected.to forbid_actions(%i[show current create update destroy change_password]) }
    end
  end

  context "inactive leader access to actions" do
    let(:leader) { create(:user, :leader, :inactive) }
    let(:user) { create(:user) }

    it "excludes user in resolved scope" do
      expect(resolved_scope).not_to include(user)
    end

    it { is_expected.to forbid_actions(%i[show create update change_password]) }
  end

  describe "permitted attributes for moder" do
    let(:leader) { create(:user, :leader) }
    let(:user) { create(:user, team: leader.team) }

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
