class ProductionGenerateRideMonths < ActiveRecord::Migration
  def self.up
    if RAILS_ENV == 'production'
      ruby "#{RAILS_ROOT}/script/runner #{RAILS_ROOT}/db/scripts/generate_ride_month_data.rb"
    end
  end

  def self.down
  end
end
