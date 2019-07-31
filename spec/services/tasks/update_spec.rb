# frozen_string_literal: true

require "rails_helper"

module Tasks
  describe Update do
    let(:update_task) do
      described_class.call(task: task, params: params)
    end

    let(:lesson_with_tasks) { create(:lesson_with_tasks, tasks_count: 5) }
    let(:task) { lesson_with_tasks.tasks.fourth }
    let(:first_task) { lesson_with_tasks.tasks.first }
    let(:second_task) { lesson_with_tasks.tasks.second }
    let(:third_task) { lesson_with_tasks.tasks.third }
    let(:fifth_task) { lesson_with_tasks.tasks.fifth }

    context "update with valid attributes" do
      let(:params) do
        { title: Faker::Lorem.sentence(2),
          description: Faker::Lorem.paragraph,
          position:  2 }
      end

      %w[title description position].each do |attribute|
        it "should update #{attribute} task" do
          expect(update_task.send(attribute)).to eq(params.dig(attribute.to_sym))
        end
      end

      it "should change position from 4 to 2" do
        expect { update_task }.to change { task.reload.position }.from(4).to(2)
      end

      it "should not change position first task" do
        expect { update_task }.not_to change { first_task.reload.position }
      end

      it "should change position from 2 to 3" do
        expect { update_task }.to change { second_task.reload.position }.from(2).to(3)
      end

      it "should change position from 3 to 4" do
        expect { update_task }.to change { third_task.reload.position }.from(3).to(4)
      end

      it "should not change fifth position task" do
        expect { update_task }.not_to change { fifth_task.reload.position }
      end
    end

    context "update with invalid data" do
      let(:params) do
        {
          title: "",
          description: "",
        }
      end

      %w[title description].each do |attribute|
        it "should not update #{attribute} task" do
          expect(update_task.send(attribute)).to eq(task.send(attribute))
        end
      end
    end
  end
end
