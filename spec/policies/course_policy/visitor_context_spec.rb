# frozen_string_literal: true

require 'rails_helper'

describe CoursePolicy do
  subject { described_class.new(visitor, course) }

  let(:visitor) { nil }

  context 'visitor access to course' do
    let(:course) { create(:course) }

    it { is_expected.to forbid_actions(%i[index all show create update destroy]) }
  end
end
