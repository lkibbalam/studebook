# frozen_string_literal: true

require 'rails_helper'

describe CoursesUserPolicy do
  subject { described_class.new(visitor, course_user) }

  let(:visitor) { nil }

  context 'visitor accessing a course user' do
    let(:course_user) { create(:courses_user) }

    it { is_expected.to forbid_actions(%i[show create]) }
  end
end
