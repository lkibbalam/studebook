# frozen_string_literal: true

require 'rails_helper.rb'

describe TeamPolicy do
  subject { described_class.new(leader, team) }

  let(:team) { create(:team) }

  context 'leader accessing not own team with own one' do
    let(:leader) { create(:user, :leader) }

    it { is_expected.to permit_actions(%i[show]) }
    it { is_expected.to forbid_actions(%i[update create destroy]) }
  end

  context 'leader accessing an own team' do
    let(:leader) { create(:user, :leader, team: team) }

    it { is_expected.to permit_actions(%i[create show update destroy]) }
  end

  context 'inactive leader accessing a team' do
    let(:leader) { create(:user, :leader, status: :inactive) }

    it { is_expected.to forbid_actions(%i[show create update destroy]) }
  end
end
