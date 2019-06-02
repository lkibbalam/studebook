# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'welcome email after user create' do
    let(:user_attributes) { attributes_for(:user) }
    let(:mail) { UserMailer.with(user_params: user_attributes).welcome.deliver_now }

    it 'renders the headers' do
      expect(mail.subject).to eq('Welcome to StudyBook')
      expect(mail.to).to eq([user_attributes[:email]])
      expect(mail.from).to eq(['studybook.ml'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(format('Your password %<password>s', user_attributes))
    end
  end
end
