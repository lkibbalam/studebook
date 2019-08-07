# frozen_string_literal: true

describe UserDecorator, type: :mailer do
  let(:user) { create(:user) }
  let(:subject) { described_class.new(user) }
  describe "#full_name" do
    it "returns first and last names concatenation" do
      expect(subject.full_name).to eq("#{user.first_name} #{user.last_name}")
    end
  end
end
