class AddTimezoneToCity < ActiveRecord::Migration[5.1]
  def change
    add_column :cities, :timezone_offset, :integer, default: 0
  end
end
