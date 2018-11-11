# frozen_string_literal: true

require 'rails_helper.rb'

describe TeamPolicy do
  subject { described_class.new(moder, team) }

  let(:team) { create(:team) }

  context 'moder accessing a not own team' do
    let(:moder) { create(:user, :moder) }

    it { is_expected.to permit_actions(%i[show]) }
    it { is_expected.to forbid_actions(%i[create update destroy]) }
  end

  context 'moder accessing an own team' do
    let(:moder) { create(:user, :moder, team: team) }

    it { is_expected.to permit_actions(%i[show update]) }
    it { is_expected.to forbid_actions(%i[create destroy]) }
  end

  context 'inactive moder accessing a team' do
    let(:moder) { create(:user, :moder, status: :inactive) }

    it { is_expected.to forbid_actions(%i[show create update destroy]) }
  end
end
