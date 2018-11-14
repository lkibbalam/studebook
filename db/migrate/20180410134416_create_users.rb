# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.bigint :team_id, index: true
      t.bigint :mentor_id, index: true
      t.string :first_name
      t.string :last_name
      t.integer :role, default: 1
      t.string :phone
      t.string :github_url
      t.integer :status, default: 0
      t.string :nickname
      t.string :email
      t.string :password_digest
      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :nickname, unique: true
  end
end
