class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.bigint :team_id, index: true
      t.bigint :mentor_id, index: true
      t.string :first_name
      t.string :last_name
      t.integer :role, default: 1
      t.integer :phone
      t.string :img
      t.string :github_url

      t.timestamps
    end
  end
end
