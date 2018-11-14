# frozen_string_literal: true

require 'rails_helper'

describe UserPolicy do
  subject { described_class.new(staff, user) }

  let(:resolved_scope) do
    described_class::Scope.new(staff, User.all).resolve
  end

  context 'active staff accessing to actions' do
    let(:staff) { create(:user, :staff) }

    context 'own team user' do
      let(:user) { create(:user, team: staff.team) }

      it 'includes user in resolved scope' do
        expect(resolved_scope).to include(user)
      end

      it { is_expected.to permit_actions(%i[show]) }
      it { is_expected.to forbid_actions(%i[create update destroy]) }
    end

    context 'own padawans' do
      let(:user) { create(:user, mentor: staff) }

      it 'includes user in resolved scope' do
        expect(resolved_scope).to include(user)
      end

      it { is_expected.to permit_actions(%i[show]) }
      it { is_expected.to forbid_actions(%i[create update destroy]) }
    end

    context 'users from foreign team' do
      let(:user) { create(:user) }

      it 'exludes user in resolved scope' do
        expect(resolved_scope).not_to include(user)
      end

      it { is_expected.to forbid_actions(%i[show current create update destroy change_password]) }
    end
  end

  context 'inactive staff accessing to actions' do
    let(:staff) { create(:user, :staff, :inactive) }
    let(:user) { create(:user) }

    it 'excludes user in resolved scope' do
      expect(resolved_scope).not_to include(user)
    end

    it { is_expected.to forbid_actions(%i[show current create update destroy change_password]) }
  end
end
