# frozen_string_literal: true

# frozent_string_literal: true

require "rails_helper"

module Users
  describe SignIn do
    let(:key) { Rails.application.credentials.dig(:secret_key_base) }
    let(:user) { create(:user) }
    let(:fake) { create(:user) }

    let(:decode_jwt) { JWT.decode(sign_in_user.dig(:token), key) }

    context "valid email and password" do
      let(:sign_in_user) do
        described_class.call(email: user.email, password: user.password)
      end

      it { expect(sign_in_user).to include(:errors, :me, :token) }
      it { expect(sign_in_user.dig(:errors)).to be_empty }
      it { expect(sign_in_user.dig(:me)).to eq(user) }
      it { expect(sign_in_user.dig(:token)).to be_kind_of(String) }

      it "response JWT have correct user id" do
        expect(decode_jwt.first["sub"]).to eq(user.id)
      end
    end

    context "invalid email or password" do
      context "email" do
        let(:sign_in_user) do
          described_class.call(email: fake.email, password: user.password)
        end

        it { expect(sign_in_user).to include(:errors) }
        it { expect(sign_in_user.dig(:errors)).not_to be_empty }
        it { expect(sign_in_user.dig(:me)).to be_nil }
        it { expect(sign_in_user.dig(:token)).to be_nil }
        it { expect(sign_in_user.dig(:errors).first["message"]).to eq("email or password is invalid") }
      end
    end
  end
end
