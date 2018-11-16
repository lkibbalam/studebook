# frozen_string_literal: true

require 'rails_helper'

module Users
  describe CreateUser do
    let(:create_user) do
      described_class.call(params: params)
    end

    context 'with valid data' do
      let(:params) do
        { email: Faker::Internet.email,
          password: Faker::Internet.password(8) }
      end

      it { expect { create_user }.to change(User, :count).by(1) }
    end

    context 'with invalid data' do
      let(:params) do
        { email: '',
          password: '' }
      end

      it { expect { create_user }.to change(User, :count).by(0) }
    end

    context 'with already exist email' do
      let!(:user) { create(:user) }

      let(:params) do
        { email: user.email,
          password: Faker::Internet.password(8) }
      end

      it { expect { create_user }.to change(User, :count).by(0) }
    end
  end
end
