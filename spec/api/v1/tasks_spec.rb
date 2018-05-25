# frozen_string_literal: true

require 'rails_helper'

describe 'tasks_controller_spec' do
  let!(:user) { create(:user) }
  let!(:task_user) { create(:tasks_user, user: user, task: create(:task)) }

  describe 'GET #padawan_tasks' do
    context 'non authenticate request' do
      before { get "/api/v1/padawans/#{user.id}/tasks" }

      it_behaves_like 'non authenticate request'
    end

    context 'authenticate request' do
      let!(:task_user) { create_list(:tasks_user, 10, user: user, task: create(:task)) }

      before { get "/api/v1/padawans/#{user.id}/tasks", headers: authenticated_header(user) }

      it_behaves_like 'authenticate request'
      it_behaves_like 'response body with 10 objects'
    end
  end

  describe 'SHOW #padawan_task' do
    context 'non-authenticate request' do
      before { get "/api/v1/padawans/#{task_user.id}/task" }

      it_behaves_like 'non authenticate request'
    end

    context 'authenticate request' do
      before { get "/api/v1/padawans/#{task_user.id}/task", headers: authenticated_header(user) }

      it_behaves_like 'authenticate request'

      %w[id user_id task_id github_url mark status created_at updated_at].each do |attr|
        it "task_user object contains #{attr}" do
          expect(response.body).to be_json_eql(task_user.send(attr.to_sym).to_json).at_path(attr)
        end
      end
    end
  end

  describe 'PATCH #padawan_tasks' do
    context 'non authenticate request' do
    end

    context 'authenticate request' do
    end
  end

  describe 'PATCH #task_to_verify' do
    context 'non authenticate request' do
    end

    context 'authenticate request' do
    end
  end
end
