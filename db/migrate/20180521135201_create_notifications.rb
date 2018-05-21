class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.bigint :user_id, index: true
      t.bigint :tasks_user_id, index: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
