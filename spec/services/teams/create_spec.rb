# frozen_string_literal: true

require 'rails_helper'

module Teams
  describe Create do
    let(:create_team) do
      described_class.call(params: params)
    end

    context 'with valid data' do
      let(:params) do
        { title: Faker::Lorem.sentence,
          description: Faker::Lorem.paragraph }
      end

      it 'should change team count by 1' do
        expect { create_team }.to change(Team, :count).by(1)
      end
    end

    context 'with invalid data' do
      let(:params) do
        { title: '',
          description: '' }
      end

      it 'should not chnage team count' do
        expect { create_team }.to change(Team, :count).by(0)
      end
    end
  end
end
