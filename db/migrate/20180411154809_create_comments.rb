class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.bigint :user_id, index: true
      t.string :commentable_type
      t.bigint :commentable_id
      t.text :body

      t.timestamps
    end
  end
end
