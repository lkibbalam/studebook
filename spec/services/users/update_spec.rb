# frozen_string_literal: true

require "rails_helper"

module Users
  describe Update do
    let(:update_user) do
      described_class.call(user: user, params: params)
    end
    let(:current_password) { "current_password" }
    let(:user) { create(:user, password: current_password) }

    context "user try update" do
      context "with valid data" do
        let(:params) do
          { nickname: "updated_nickname",
            first_name: "updated_first_name",
            last_name: "updated_last_name",
            team_id: create(:team).id,
            mentor_id: create(:user).id,
            role: "staff",
            phone: Faker::PhoneNumber.phone_number,
            github_url: Faker::Internet.url("github.com"),
            status: "inactive",
            email: Faker::Internet.email,
            password: Faker::Internet.password(8) }
        end

        %w[nickname first_name last_name team_id mentor_id phone github_url status email role].each do |attribute|
          it "user #{attribute} was updated" do
            expect(update_user.send(attribute)).to eq(params.dig(attribute.to_sym))
          end
        end
      end

      context "change password" do
        let(:new_password) { Faker::Internet.password(8) }

        context "when correct data" do
          let(:params) do
            { current_password: current_password,
              new_password: new_password,
              password_confirmation: new_password }
          end

          it "should to change password" do
            expect(BCrypt::Password.new(update_user.password_digest)).to eq(new_password)
          end
        end

        context "when incorrect current_password" do
          let(:params) do
            { current_password: "incorrect_password",
              new_password: new_password,
              password_confirmation: new_password }
          end

          it "should to not change password" do
            expect(BCrypt::Password.new(update_user.password_digest)).not_to eq(new_password)
          end

          it "password should to be equel current password" do
            expect(BCrypt::Password.new(update_user.password_digest)).to eq(current_password)
          end
        end

        context "when new and confiermed password are not equel" do
          let(:params) do
            { current_password: current_password,
              new_password: new_password,
              password_confirmation: "#{new_password}mistake" }
          end

          it "should to not change password" do
            expect(BCrypt::Password.new(update_user.password_digest)).not_to eq(new_password)
          end

          it "password should to be equel current password" do
            expect(BCrypt::Password.new(update_user.password_digest)).to eq(current_password)
          end
        end
      end
    end
  end
end
