class AddIsInsideToRideTypes < ActiveRecord::Migration
  def self.up
    add_column :ride_types, :is_inside, :boolean
  end

  def self.down
    remove_column :ride_types, :is_inside
  end
end
