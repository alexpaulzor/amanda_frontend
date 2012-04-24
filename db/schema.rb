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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120423222432) do

  create_table "amanda_configs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dle_run_tapes", :force => true do |t|
    t.integer  "dle_run_id"
    t.integer  "tape_id"
    t.integer  "size"
    t.integer  "overwritten_by_run_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dle_runs", :force => true do |t|
    t.integer  "run_id"
    t.integer  "dle_id"
    t.integer  "level"
    t.integer  "size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dles", :force => true do |t|
    t.string   "host"
    t.string   "disk"
    t.integer  "amanda_config_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "runs", :force => true do |t|
    t.datetime "date"
    t.integer  "amanda_config_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tapes", :force => true do |t|
    t.string   "name"
    t.integer  "amanda_config_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
