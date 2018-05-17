class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.bigint :lesson_id, index: true
      t.bigint :course_id, index: true
      t.string :title
      t.string :src
      t.integer :duration

      t.timestamps
    end
  end
end
