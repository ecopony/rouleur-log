class ChangeSystemTypeToIsCommute < ActiveRecord::Migration
  def self.up
    rename_column :ride_types, :is_system_type, :is_commute
  end

  def self.down
    rename_column :ride_types, :is_commute, :is_system_type
  end
end
