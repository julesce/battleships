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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120809151600) do

  create_table "boards", :force => true do |t|
    t.integer  "game_id"
    t.integer  "size",       :default => 10
    t.string   "type_of"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "boards", ["game_id"], :name => "index_boards_on_game_id"
  add_index "boards", ["type_of"], :name => "index_boards_on_type_of"

  create_table "co_ordinates", :force => true do |t|
    t.integer  "x"
    t.integer  "y"
    t.integer  "parent_id"
    t.string   "parent_type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "games", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ship_types", :force => true do |t|
    t.string   "name"
    t.integer  "size"
    t.integer  "starting_quantity"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "ships", :force => true do |t|
    t.integer  "ship_type_id"
    t.integer  "board_id"
    t.boolean  "is_sunk",      :default => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ships", ["board_id"], :name => "index_ships_on_board_id"
  add_index "ships", ["ship_type_id"], :name => "index_ships_on_ship_type_id"

  create_table "shots", :force => true do |t|
    t.integer  "board_id"
    t.integer  "x"
    t.integer  "y"
    t.boolean  "is_hit"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "shots", ["board_id"], :name => "index_shots_on_board_id"

end
