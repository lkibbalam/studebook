# frozen_string_literal: true

require 'rails_helper'

module Users
  describe DestroyUser do
    let(:destroy_user) { described_class.call(user: user) }

    context 'destroy user' do
      let!(:user) { create(:user) }

      it 'should be success' do
        expect { destroy_user }.to change(User, :count).by(-1)
      end
    end
  end
end
