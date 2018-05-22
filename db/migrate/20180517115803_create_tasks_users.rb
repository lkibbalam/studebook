# frozen_string_literal: true

class CreateTasksUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks_users do |t|
      t.bigint :task_id
      t.bigint :user_id
      t.string :github_url
      t.integer :mark, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
    add_index :tasks_users, %i[user_id task_id]
  end
end
