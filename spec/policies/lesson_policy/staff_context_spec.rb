# frozen_string_literal: true

require "rails_helper"

describe LessonPolicy do
  subject { described_class.new(staff, lesson) }

  let(:lesson) { create(:lesson) }

  context "staff accessing" do
    context "to own team lesson actions" do
      let(:staff) { create(:user, :staff, team: lesson.course.team) }

      it { is_expected.to forbid_actions(%i[show create update show]) }
    end

    context "not own team lesson actions" do
      let(:staff) { create(:user, :staff) }

      it { is_expected.to forbid_actions(%i[show create update show]) }
    end
  end

  context "inactive staff accessing to lesson" do
    let(:staff) { create(:user, :staff) }

    it { is_expected.to forbid_actions(%i[show create update show]) }
  end
end
