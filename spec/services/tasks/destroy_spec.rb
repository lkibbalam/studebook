# frozen_string_literal: true

require "rails_helper"

module Tasks
  describe Destroy do
    let(:delete_task) do
      described_class.call(task: task)
    end

    let!(:task) { create(:task) }

    context "when delete task" do
      it "should change task count by -1" do
        expect { delete_task }.to change(Task, :count).by(-1)
      end
    end
  end
end
