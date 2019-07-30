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

ActiveRecord::Schema.define(version: 2019_07_30_141241) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id"
    t.string "commentable_type"
    t.bigint "commentable_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.index ["ancestry"], name: "index_comments_on_ancestry"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "author_id"
    t.text "description"
    t.string "title"
    t.integer "status", default: 0
    t.text "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_courses_on_author_id"
    t.index ["slug"], name: "index_courses_on_slug", unique: true
    t.index ["team_id"], name: "index_courses_on_team_id"
  end

  create_table "courses_users", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "course_id"
    t.integer "status", default: 0
    t.integer "mark", default: 0
    t.integer "progress", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id", "student_id"], name: "index_courses_users_on_course_id_and_student_id", unique: true
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "lessons", force: :cascade do |t|
    t.bigint "course_id"
    t.text "description"
    t.text "material"
    t.string "title"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_lessons_on_course_id"
  end

  create_table "lessons_users", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "lesson_id"
    t.integer "status", default: 0
    t.integer "mark", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id", "lesson_id"], name: "index_lessons_users_on_student_id_and_lesson_id", unique: true
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "tasks_user_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tasks_user_id"], name: "index_notifications_on_tasks_user_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "lesson_id"
    t.string "title"
    t.text "description"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_tasks_on_lesson_id"
  end

  create_table "tasks_users", force: :cascade do |t|
    t.bigint "task_id"
    t.bigint "user_id"
    t.string "github_url"
    t.integer "mark", default: 0
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "task_id"], name: "index_tasks_users_on_user_id_and_task_id", unique: true
  end

  create_table "teams", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.text "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_teams_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "mentor_id"
    t.string "first_name"
    t.string "last_name"
    t.integer "role", default: 1
    t.string "phone"
    t.string "github_url"
    t.integer "status", default: 0
    t.string "nickname"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["mentor_id"], name: "index_users_on_mentor_id"
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
    t.index ["team_id"], name: "index_users_on_team_id"
  end

end
