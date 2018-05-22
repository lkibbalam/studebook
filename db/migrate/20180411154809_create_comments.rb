# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.bigint :user_id, index: true
      t.string :commentable_type
      t.bigint :commentable_id
      t.text :body

      t.timestamps
    end
    add_index :comments, %i[commentable_type commentable_id]
  end
end
