class CreateLessons < ActiveRecord::Migration[5.1]
  def change
    create_table :lessons do |t|
      t.bigint :course_id, index: true
      t.text :description
      t.text :material
      t.string :img
      t.string :title

      t.timestamps
    end
  end
end
