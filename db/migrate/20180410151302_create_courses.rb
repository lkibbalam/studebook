class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.bigint :team_id, index: true
      t.bigint :author_id, index: true
      t.text :description
      t.string :title

      t.timestamps
    end
  end
end
