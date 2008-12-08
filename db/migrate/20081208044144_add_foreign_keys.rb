class AddForeignKeys < ActiveRecord::Migration
  extend MigrationHelper
  
  def self.up
    add_foreign_key(:bikes, :user_id, :users)
    add_foreign_key(:commutes, :user_id, :users)
    add_foreign_key(:ride_types, :user_id, :users)
    add_foreign_key(:routes, :user_id, :users)
    
    add_foreign_key(:rides, :bike_id, :bikes)
    add_foreign_key(:rides, :route_id, :routes)
    add_foreign_key(:rides, :user_id, :users)
    add_foreign_key(:rides, :ride_type_id, :ride_types)
  end

  def self.down
    remove_foreign_key(:bikes, :user_id)
    remove_foreign_key(:commutes, :user_id)
    remove_foreign_key(:ride_type, :user_id)
    remove_foreign_key(:routes, :user_id)
    
    remove_foreign_key(:rides, :bike_id)
    remove_foreign_key(:rides, :route_id)
    remove_foreign_key(:rides, :user_id)
    remove_foreign_key(:rides, :ride_type_id)
  end
end
