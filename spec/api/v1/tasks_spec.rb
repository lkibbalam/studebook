# frozen_string_literal: true

require 'rails_helper'

describe 'tasks_controller_spec' do
  let(:mentor) { create(:user) }
  let(:padawan) { create(:user, mentor: mentor) }
  let(:task_user) { create(:tasks_user, user: padawan, task: create(:task)) }

  describe 'GET #index_padawan_tasks' do
    context 'non authenticate request' do
      before { get "/api/v1/padawans/#{padawan.id}/tasks" }

      it_behaves_like 'non authenticate request'
    end

    context 'authenticate request' do
      let!(:task_user) { create_list(:tasks_user, 10, user: padawan, task: create(:task)) }

      before { get "/api/v1/padawans/#{padawan.id}/tasks", headers: authenticated_header(mentor) }

      it_behaves_like 'authenticate request'
      it_behaves_like 'response body with 10 objects'
    end
  end

  describe 'GET #show_padawan_task' do
    context 'non-authenticate request' do
      before { get "/api/v1/padawans/#{task_user.id}/task" }

      it_behaves_like 'non authenticate request'
    end

    context 'authenticate request' do
      before { get "/api/v1/padawans/#{task_user.id}/task", headers: authenticated_header(mentor) }

      it_behaves_like 'authenticate request'

      %w[id user_id task_id github_url mark status created_at updated_at].each do |attr|
        it "task_user object contains #{attr}" do
          expect(response.body).to be_json_eql(task_user.send(attr.to_sym).to_json).at_path(attr)
        end
      end
    end
  end

  describe 'PATCH #task_to_verify' do
    context 'non authenticate request' do
      before do
        patch "/api/v1/tasks/#{task_user.task.id}/task_to_verify",
              params: { task: { github_url: 'www.leningrad.ru', status: :verifying } }
      end

      it_behaves_like 'non authenticate request'
    end

    context 'authenticate request' do
      before do
        patch "/api/v1/tasks/#{task_user.task.id}/task_to_verify",
              params: { task: { github_url: 'www.leningrad.ru', status: :verifying } },
              headers: authenticated_header(padawan)
      end

      it_behaves_like 'authenticate request'
      it { expect(task_user.reload.status).to eql('verifying') }
      it { expect(task_user.reload.github_url).to eql('www.leningrad.ru') }
    end
  end

  describe 'PATCH #approve_or_change_task' do
    let(:padawan_task) { create(:tasks_user, user: padawan, task: create(:task), status: :verifying) }

    context 'non authenticate request' do
      before { patch "/api/v1/padawans/#{padawan_task.id}/task" }

      it_behaves_like 'non authenticate request'
    end

    context 'authenticate request' do
      describe 'when mentor accept task' do
        before do
          patch "/api/v1/padawans/#{padawan_task.id}/task", params: { task: { status: :accept } },
                                                            headers: authenticated_header(mentor)
        end

        it_behaves_like 'authenticate request'
        it { expect(padawan_task.reload.status).to eql('accept') }
      end

      describe 'when mentor denied task, and switch to change it' do
        before do
          patch "/api/v1/padawans/#{padawan_task.id}/task", params: { task: { status: :change } },
                                                            headers: authenticated_header(mentor)
        end

        it_behaves_like 'authenticate request'
        it { expect(padawan_task.reload.status).to eql('change') }
      end
    end
  end
end
