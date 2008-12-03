class AddUserToRideTypes < ActiveRecord::Migration
  def self.up
    add_column :ride_types, :user_id, :integer
  end

  def self.down
    remove_column :ride_types, :user_id
  end
end
