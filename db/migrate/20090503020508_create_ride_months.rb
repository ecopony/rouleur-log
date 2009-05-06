class CreateRideMonths < ActiveRecord::Migration
  def self.up
    create_table :ride_months do |t|
      t.integer :month
      t.integer :year
      t.float :distance
      t.integer :ride_count
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :ride_months
  end
end
