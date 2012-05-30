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

ActiveRecord::Schema.define(:version => 20120530084127) do

  create_table "event_updates", :force => true do |t|
    t.integer  "facebook_event_id"
    t.integer  "attending"
    t.integer  "maybe"
    t.integer  "invited"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facebook_events", :force => true do |t|
    t.string   "name"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "location"
    t.text     "description"
    t.datetime "updated_time"
    t.string   "identifier"
    t.string   "picture"
    t.string   "small_picture"
    t.string   "normal_picture"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "page_identifier"
    t.string   "name"
    t.string   "link"
    t.string   "category"
    t.integer  "likes"
    t.string   "website"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "picture"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
