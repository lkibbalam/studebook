# frozen_string_literal: true

require 'rails_helper'

describe NotificationMailer, type: :mailer do
  describe 'notify' do
    let(:user) { create(:user) }
    let(:task_user) { create(:tasks_user) }
    let(:mail) { NotificationMailer.notification_email(user, task_user) }

    it 'renders the headers' do
      expect(mail.subject)
        .to eq("Your padawan #{task_user.user.first_name} #{task_user.user.last_name} waiting for task approve")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['notifications@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Welcome')
    end
  end
end
