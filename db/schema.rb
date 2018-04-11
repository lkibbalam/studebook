# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_180_411_135_637) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'courses', force: :cascade do |t|
    t.bigint 'team_id'
    t.bigint 'author_id'
    t.text 'description'
    t.string 'title'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['team_id'], name: 'index_courses_on_team_id'
  end

  create_table 'courses_users', force: :cascade do |t|
    t.bigint 'student_id'
    t.bigint 'course_id'
    t.text 'opinion'
    t.string 'chat'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[course_id student_id], name: 'index_courses_users_on_course_id_and_student_id'
    t.index ['course_id'], name: 'index_courses_users_on_course_id'
    t.index ['student_id'], name: 'index_courses_users_on_student_id'
  end

  create_table 'lessons', force: :cascade do |t|
    t.bigint 'course_id'
    t.text 'description'
    t.string 'video'
    t.text 'material'
    t.text 'task'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['course_id'], name: 'index_lessons_on_course_id'
  end

  create_table 'teams', force: :cascade do |t|
    t.string 'title'
    t.text 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.bigint 'team_id'
    t.bigint 'mentor_id'
    t.string 'first_name'
    t.string 'last_name'
    t.integer 'role'
    t.integer 'phone'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['mentor_id'], name: 'index_users_on_mentor_id'
    t.index ['team_id'], name: 'index_users_on_team_id'
  end
end
