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

ActiveRecord::Schema.define(:version => 20120701204610) do

  create_table "events", :force => true do |t|
    t.datetime "st"
    t.datetime "en"
    t.string   "title"
    t.text     "desc"
    t.string   "where"
    t.boolean  "allday",   :default => false
    t.boolean  "alerted",  :default => false
    t.datetime "alert_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "digest"
    t.boolean  "changed",  :default => false
    t.datetime "start_at"
  end

end
