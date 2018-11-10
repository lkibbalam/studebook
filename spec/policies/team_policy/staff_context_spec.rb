# frozen_string_literal: true

require 'rails_helper.rb'

describe TeamPolicy do
  subject { described_class.new(staff, team) }

  let(:team) { create(:team) }

  context 'staff accessing a team' do
    let(:staff) { create(:user, :staff) }

    it { is_expected.to permit_actions(%i[index show]) }
    it { is_expected.to forbid_actions(%i[create update destroy]) }
  end

  context 'inactive staff accessing a team' do
    let(:staff) { create(:user, :staff, status: :inactive) }

    it { is_expected.to forbid_actions(%i[index show create update destroy]) }
  end
end
