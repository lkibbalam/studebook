# frozen_string_literal: true

require 'rails_helper'

describe UserPolicy do
  subject { described_class.new(visitor, user) }

  let(:resolved_scope) do
    described_class::Scope.new(visitor, User.all).resolve
  end

  let(:visitor) { nil }

  context 'visitor accessing a team' do
    let(:user) { create(:user) }

    it 'excludes user from resolved scope' do
      expect(resolved_scope).not_to include(user)
    end

    it { is_expected.to forbid_actions(%i[show current create update destroy change_password]) }
  end
end
