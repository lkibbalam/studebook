# frozen_string_literal: true

require "rails_helper"

describe LessonPolicy do
  subject { described_class.new(visitor, lesson) }

  let(:visitor) { nil }

  context "visitor accessing a lesson" do
    let(:lesson) { create(:lesson) }

    it { is_expected.to forbid_actions(%i[show create update destroy]) }
  end
end
