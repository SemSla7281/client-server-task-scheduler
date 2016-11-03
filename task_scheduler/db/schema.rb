# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20161013041825) do

  create_table "agents", force: :cascade do |t|
    t.string   "secret_key", limit: 255, null: false
    t.string   "decode_key", limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.integer "agent_id",  limit: 4
    t.integer "lesson_id", limit: 4
  end

  create_table "gyms", force: :cascade do |t|
    t.string "name",    limit: 255
    t.string "address", limit: 255
  end

  create_table "lessons", force: :cascade do |t|
    t.integer  "gym_id",     limit: 4
    t.datetime "start_time"
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "name",       limit: 255,                       null: false
    t.string   "path",       limit: 255,                       null: false
    t.string   "arguments",  limit: 255
    t.datetime "start_time",                                   null: false
    t.datetime "end_time"
    t.string   "weekdays",   limit: 255,                       null: false
    t.string   "status",     limit: 255, default: "scheduled", null: false
    t.integer  "agent_id",   limit: 4,                         null: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.boolean  "is_active",  limit: 1,   default: false
  end

end
