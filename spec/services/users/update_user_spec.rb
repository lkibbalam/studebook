# frozen_string_literal: true

require 'rails_helper'

module Users
  describe UpdateUser do
    let(:update_user) do
      described_class.call(user: user, params: params)
    end
    let(:user) { create(:user, password: 'current_password') }

    context 'user try update' do
      context 'with valid data' do
        let(:params) do
          { nickname: 'updated_nickname',
            first_name: 'updated_first_name',
            last_name: 'updated_last_name',
            team_id: create(:team).id,
            mentor_id: create(:user).id,
            role: 'staff',
            phone: Faker::PhoneNumber.phone_number,
            github_url: Faker::Internet.url('github.com'),
            status: 'inactive',
            email: Faker::Internet.email,
            password: Faker::Internet.password(8) }
        end

        %w[nickname first_name last_name team_id mentor_id phone github_url status email role].each do |attribute|
          it "user #{attribute} was updated" do
            expect(update_user.send(attribute)).to eq(params.dig(attribute.to_sym))
          end
        end
      end

      context 'change password' do
        let(:new_password) { Faker::Internet.password(8) }
        let(:params) do
          { current_password: 'current_password',
            new_password: new_password,
            password_confirmation: new_password }
        end

        it 'should change password' do
          expect(BCrypt::Password.new(update_user.password_digest)).to eq(new_password)
        end
      end
    end
  end
end
