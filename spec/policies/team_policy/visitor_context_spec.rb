# frozen_string_literal: true

require 'rails_helper'

describe TeamPolicy do
  subject { described_class.new(user, team) }

  let(:user) { nil }

  context 'visitor try anything' do
    let(:team) { create(:team) }

    it { is_expected.to forbid_actions(%i[index show create update destroy]) }
  end
end
