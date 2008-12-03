class AddUserKeys < ActiveRecord::Migration
  def self.up
    add_column :bikes, :user_id, :integer
    add_column :commutes, :user_id, :integer
    add_column :rides, :user_id, :integer
    add_column :routes, :user_id, :integer 
  end

  def self.down
    remove_column :bikes, :user_id
    remove_column :commutes, :user_id
    remove_column :rides, :user_id
    remove_column :routes, :user_id
  end
end
