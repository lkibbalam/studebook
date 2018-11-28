# frozen_string_literal: true

require 'rails_helper'

module TasksUsers
  describe Update do
    let(:update_task_user) do
      described_class.call(task_user: task_user, params: params)
    end

    let(:user) { create(:user) }

    context 'student send task to verify' do
      let(:task_user) { create(:tasks_user, user: user) }
      let(:params) do
        { status: :verifying,
          github_url: Faker::Internet.url('github.com'),
          comment: Faker::Lorem.sentence }
      end

      %w[status github_url].each do |attribute|
        it "should update task #{attribute}" do
          expect(update_task_user.send(attribute)).to eq(params[attrbiute.to_sym].to_sym)
        end
      end
    end
  end
end
