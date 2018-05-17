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

ActiveRecord::Schema.define(version: 20_180_517_115_803) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'comments', force: :cascade do |t|
    t.bigint 'user_id'
    t.string 'commentable_type'
    t.bigint 'commentable_id'
    t.text 'body'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'ancestry'
    t.index ['ancestry'], name: 'index_comments_on_ancestry'
    t.index %w[commentable_type commentable_id], name: 'index_comments_on_commentable_type_and_commentable_id'
    t.index ['user_id'], name: 'index_comments_on_user_id'
  end

  create_table 'courses', force: :cascade do |t|
    t.bigint 'team_id'
    t.bigint 'author_id'
    t.text 'description'
    t.string 'title'
    t.string 'img'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['author_id'], name: 'index_courses_on_author_id'
    t.index ['team_id'], name: 'index_courses_on_team_id'
  end

  create_table 'courses_users', force: :cascade do |t|
    t.bigint 'student_id'
    t.bigint 'course_id'
    t.text 'opinion'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[course_id student_id], name: 'index_courses_users_on_course_id_and_student_id'
  end

  create_table 'lessons', force: :cascade do |t|
    t.bigint 'course_id'
    t.text 'description'
    t.text 'material'
    t.string 'img'
    t.string 'title'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['course_id'], name: 'index_lessons_on_course_id'
  end

  create_table 'lessons_users', force: :cascade do |t|
    t.bigint 'student_id'
    t.bigint 'lesson_id'
    t.integer 'status', default: 0
    t.integer 'mark', default: 0
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[student_id lesson_id], name: 'index_lessons_users_on_student_id_and_lesson_id'
  end

  create_table 'tasks', force: :cascade do |t|
    t.bigint 'lesson_id'
    t.string 'title'
    t.text 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['lesson_id'], name: 'index_tasks_on_lesson_id'
  end

  create_table 'tasks_users', force: :cascade do |t|
    t.bigint 'task_id'
    t.bigint 'user_id'
    t.string 'github_url'
    t.integer 'mark', default: 0
    t.integer 'status', default: 0
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[user_id task_id], name: 'index_tasks_users_on_user_id_and_task_id'
  end

  create_table 'teams', force: :cascade do |t|
    t.string 'title'
    t.string 'img'
    t.text 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.bigint 'team_id'
    t.bigint 'mentor_id'
    t.string 'first_name'
    t.string 'last_name'
    t.integer 'role', default: 1
    t.integer 'phone'
    t.string 'img'
    t.string 'github_url'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'email'
    t.string 'password_digest'
    t.index ['mentor_id'], name: 'index_users_on_mentor_id'
    t.index ['team_id'], name: 'index_users_on_team_id'
  end

  create_table 'videos', force: :cascade do |t|
    t.bigint 'lesson_id'
    t.bigint 'course_id'
    t.string 'title'
    t.string 'src'
    t.integer 'duration'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['course_id'], name: 'index_videos_on_course_id'
    t.index ['lesson_id'], name: 'index_videos_on_lesson_id'
  end
end
