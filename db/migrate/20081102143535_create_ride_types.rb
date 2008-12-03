class CreateRideTypes < ActiveRecord::Migration
  def self.up
    create_table :ride_types do |t|
      t.string :name
      t.string :description
      t.boolean :is_system_type
      t.timestamps
    end
  end

  def self.down
    drop_table :ride_types
  end
end
