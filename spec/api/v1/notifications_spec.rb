# frozen_string_literal: true

# frozen_string_literal = true

require 'rails_helper'

describe 'notifications_controller_spec' do
  let(:mentor) { create(:user) }
  let(:notification) { create(:notification) }

  describe 'PATCH #seen' do
    context 'when non authenticate request' do
      before { patch "/api/v1/notifications/#{notification.id}/seen" }

      it_behaves_like 'non authenticate request'
    end

    context 'when authenticate request' do
      before { patch "/api/v1/notifications/#{notification.id}/seen", headers: authenticated_header(mentor) }

      it_behaves_like 'authenticate request'

      it { expect(notification.reload.status).to eql('seen') }
    end
  end

  describe 'GET #index' do
    let!(:notifications) { create_list(:notification, 10, user: mentor) }

    context 'when non authenticate request' do
      before { get '/api/v1/notifications' }

      it_behaves_like 'non authenticate request'
    end

    context 'when authenticate request' do
      before { get '/api/v1/notifications', headers: authenticated_header(mentor) }

      it_behaves_like 'authenticate request'
      it_behaves_like 'response body with 10 objects'
    end
  end
end
