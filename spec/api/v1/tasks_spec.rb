# frozen_string_literal: true

require 'rails_helper'

describe 'tasks_controller_spec' do
  let(:admin) { create(:user, :admin) }
  let!(:lesson) { create(:lesson) }

  describe 'POST #create' do
    context 'when non-authenticate' do
      before { post "/api/v1/lessons/#{lesson.id}/tasks", params: { lesson: attributes_for(:lesson) } }

      it_behaves_like 'non authenticate request'
    end
    context 'when authenticate' do
      let(:create_task) do
        post "/api/v1/lessons/#{lesson.id}/tasks", params: { task: attributes_for(:task) },
                                                   headers: authenticated_header(admin)
      end
      let(:create_task2) do
        post "/api/v1/lessons/#{lesson.id}/tasks", params: { task: attributes_for(:task) },
                                                   headers: authenticated_header(admin)
      end
      let(:create_task3) do
        post "/api/v1/lessons/#{lesson.id}/tasks", params: { task: attributes_for(:task) },
                                                   headers: authenticated_header(admin)
      end

      it 'schould create one task' do
        expect { create_task }.to change(Task, :count).by(1)
      end

      it 'schould make task with position' do
        create_task
        create_task2
        create_task3
        expect(lesson.tasks.first.position).to eql(1)
        expect(lesson.tasks.second.position).to eql(2)
        expect(lesson.tasks.third.position).to eql(3)
      end
    end
  end
end
