# frozen_string_literal: true

require 'rails_helper'

describe EmailValidator, type: :validator do
  context 'user' do
    context 'valid email' do
      let(:user) { build(:user, email: Faker::Internet.email) }

      it { expect(user).to be_valid }
    end

    context 'invalid' do
      context 'empty email' do
        let(:user) { build(:user, email: '') }

        it { expect(user).not_to be_valid }
      end

      context 'incorrect email' do
        let(:user) { build(:user, email: '#@%^%#$@#$@#.com') }

        it { expect(user).not_to be_valid }
      end
    end
  end
end
