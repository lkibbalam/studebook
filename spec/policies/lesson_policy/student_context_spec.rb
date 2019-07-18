# frozen_string_literal: true

require "rails_helper"

describe LessonPolicy do
  subject { described_class.new(student, lesson) }

  let(:lesson) { create(:lesson) }

  context "active student accessing a lesson" do
    let(:student) { create(:user, :student) }

    it { is_expected.to forbid_actions(%i[show create update destroy]) }
  end

  context "inactive student accessing a lesson" do
    let(:student) { create(:user, :student, :inactive) }

    it { is_expected.to forbid_actions(%i[show create update destroy]) }
  end
end
