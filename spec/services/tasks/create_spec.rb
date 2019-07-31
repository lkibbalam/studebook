# frozen_string_literal: true

require "rails_helper"

module Tasks
  describe Create do
    let(:create_task) do
      described_class.call(lesson: lesson, params: params)
    end
    let(:lesson) { create(:lesson) }
    let(:task) { lesson.tasks.create(params) }

    context "create task with valid data" do
      let(:params) do
        {
          title: Faker::Lorem.sentence(2),
          description: Faker::Lorem.paragraph,
        }
      end

      it "expect to change tasks count in db" do
        expect { create_task }.to change { lesson.tasks.count }.by(1)
      end

      it "expect to have position 1" do
        expect(create_task.position).to eq(1)
      end

      it "second created lesson expect to have position 2" do
        task
        expect(create_task.position).to eq(2)
      end
    end

    context "create task with invalid data" do
      let(:params) do
        {
          title: "",
          description: "",
        }
      end

      it "expect to not hange task count in db" do
        expect { create_task }.to  change(lesson.tasks, :count).by(0)
      end
    end
  end
end
