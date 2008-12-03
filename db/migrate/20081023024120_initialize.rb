class Initialize < ActiveRecord::Migration
  def self.up
    create_table "bikes", :force => true do |t|
      t.string   "name"
      t.string   "description"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "commutes", :force => true do |t|
      t.string   "name"
      t.float    "distance_to"
      t.float    "distance_from"
      t.boolean  "auto_log"
      t.string   "days_of_the_week"
      t.date     "start_date"
      t.date     "end_date"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "rides", :force => true do |t|
      t.float    "distance"
      t.string   "time"
      t.string   "average_speed"
      t.integer  "bike_id"
      t.date     "ride_on"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "route_id"
      t.text     "comments"
    end

    create_table "routes", :force => true do |t|
      t.string   "name"
      t.string   "description"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

  def self.down
    drop_table :bikes
    drop_table :commutes
    drop_table :routes
    drop_table :rides
  end
end
