# frozen_string_literal: true

require 'rails_helper'

describe LessonsUserPolicy do
  subject { described_class.new(visitor, lesson_user) }

  let(:visitor) { nil }

  context 'visitor accessing a lesson user' do
    let(:lesson_user) { create(:lessons_user) }

    it { is_expected.to forbid_actions(%i[show update]) }
  end
end
