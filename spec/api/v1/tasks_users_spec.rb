# frozen_string_literal: true

require 'rails_helper'

describe 'tasks_users_controller' do
  let(:mentor) { create(:mentor, :staff) }
  let(:padawan) { create(:student, mentor: mentor) }
  let(:task_user) { create(:tasks_user, user: padawan) }

  describe 'GET #padawan_tasks' do
    context 'non authenticate request' do
      before { get "/api/v1/padawans/#{padawan.id}/tasks" }

      it_behaves_like 'non authenticate request'
    end

    context 'authenticate request' do
      let!(:task_user) { create_list(:tasks_user, 10, user: padawan) }

      before { get "/api/v1/padawans/#{padawan.id}/tasks", headers: authenticated_header(mentor) }

      it_behaves_like 'authenticate request'
      it_behaves_like 'response body with 10 objects'
    end
  end

  describe 'GET #padawan_task' do
    context 'non-authenticate request' do
      before { get "/api/v1/padawans/#{task_user.id}/task" }

      it_behaves_like 'non authenticate request'
    end

    context 'authenticate request' do
      before { get "/api/v1/padawans/#{task_user.id}/task", headers: authenticated_header(mentor) }

      it_behaves_like 'authenticate request'

      %w[user_id task_id github_url mark status created_at updated_at].each do |attr|
        it "task_user object contains #{attr}" do
          expect(response.body).to be_json_eql(task_user.send(attr.to_sym).to_json).at_path("data/attributes/#{attr.camelize(:lower)}")
        end
      end
    end
  end

  describe 'PATCH #update' do
    context 'non authenticate request' do
      before do
        patch "/api/v1/tasks/#{task_user.id}/task_to_verify",
              params: { task: { github_url: 'www.leningrad.ru', status: :verifying } }
      end

      it_behaves_like 'non authenticate request'
    end

    context 'authenticate request' do
      let(:course_with_lessons_with_tasks) { create(:course_with_lessons_with_tasks, lessons_count: 2, tasks_count: 2) }
      let!(:subscribe_user_to_course) { CoursesUsers::Create.call(course: course_with_lessons_with_tasks, user: padawan) }
      let(:user_task) { TasksUser.find_by(task: course_with_lessons_with_tasks.lessons.first.tasks.first, user: padawan) }
      let(:user_verifying_task) { user_task.update(status: :verifying) && user_task.reload }

      describe 'when mentor accept task' do
        before do
          patch "/api/v1/padawans/#{user_verifying_task.id}/task", params: { task: { status: :accept } },
                                                                   headers: authenticated_header(mentor)
        end

        it_behaves_like 'authenticate request'
        it { expect(user_verifying_task.reload.status).to eql('accept') }
      end

      describe 'when mentor denied task, and switch to change it' do
        before do
          patch "/api/v1/padawans/#{user_verifying_task.id}/task", params: { task: { status: :change } },
                                                                   headers: authenticated_header(mentor)
        end

        it_behaves_like 'authenticate request'
        it { expect(user_verifying_task.reload.status).to eql('change') }
      end
      describe 'when student send task to verifying' do
        before do
          patch "/api/v1/tasks/#{task_user.id}/task_to_verify",
                params: { task: { github_url: 'www.leningrad.ru', status: :verifying } },
                headers: authenticated_header(padawan)
        end

        it_behaves_like 'authenticate request'
        it { expect(task_user.reload.status).to eql('verifying') }
        it { expect(task_user.reload.github_url).to eql('www.leningrad.ru') }
      end
    end
  end
end
