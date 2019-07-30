# frozen_string_literal: true

class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :lessons, :order_number, :position
    rename_column :tasks, :order_number, :position

    Course.find_each do |course|
      course.lessons.order(:updated_at).each.with_index(1) do |lesson, index|
        lesson.update_column :position, index
      end
    end

    Lesson.find_each do |lesson|
      lesson.tasks.order(:updated_at).each.with_index(1) do |task, index|
        task.update_column :position, index
      end
    end
  end
end
