class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.bigint :lesson_id, index: true
      t.string :title
      t.string :src

      t.timestamps
    end

    add_index :comments, %i[commentable_type commentable_id]
    remove_column :lessons, :video
  end
end
