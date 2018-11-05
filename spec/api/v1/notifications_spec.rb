# frozen_string_literal: true

require 'rails_helper'

describe 'notifications_controller_spec' do
  let(:admin) { create(:user, :admin) }
  let(:student) { create(:student, mentor: create(:mentor, :staff)) }
  let(:tasks_user) { create(:tasks_user, user: student) }
  let(:notification) { create(:notification, tasks_user: tasks_user) }

  describe 'GET #index' do
    let!(:notifications) { create_list(:notification, 10, tasks_user: tasks_user, user: student) }

    context 'when non authenticate request' do
      before { get '/api/v1/notifications' }

      it_behaves_like 'non authenticate request'
    end

    context 'when authenticate request' do
      before { get '/api/v1/notifications', headers: authenticated_header(student) }

      it_behaves_like 'authenticate request'
      it_behaves_like 'response body with 10 objects'
    end
  end

  describe 'PATCH #seen' do
    context 'when non authenticate request' do
      before { patch "/api/v1/notifications/#{notification.id}/seen" }

      it_behaves_like 'non authenticate request'
    end

    context 'when authenticate request' do
      before { patch "/api/v1/notifications/#{notification.id}/seen", headers: authenticated_header(admin) }
      it_behaves_like 'authenticate request'

      it { expect(notification.reload.status).to eql('seen') }
    end
  end
end
