# frozen_string_literal: true

require "rails_helper"

module Users
  describe Create do
    let(:create_user) do
      described_class.call(params: params)
    end

    context "with valid data" do
      let(:params) do
        { email: Faker::Internet.email,
          password: Faker::Internet.password(8) }
      end

      it "schould create a user and sends an email" do
        expect { create_user }.to change(User, :count).by(1)
                                                      .and change { UserMailer.deliveries.count }.by(1)
      end
    end

    context "with invalid data" do
      let(:params) do
        { email: "",
          password: "" }
      end

      it "raise Record Invalid and doesn't send an email" do
        expect { create_user }
          .to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Email empty, Password can't be blank")
          .and change { UserMailer.deliveries.count }.by(0)
      end
    end

    context "with already exist email" do
      let!(:user) { create(:user) }

      let(:params) do
        { email: user.email,
          password: Faker::Internet.password(8) }
      end

      it "raise Record Invalid and doesn't send an email" do
        expect { create_user }
          .to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Email has already been taken")
          .and change { UserMailer.deliveries.count }.by(0)
      end
    end
  end
end
