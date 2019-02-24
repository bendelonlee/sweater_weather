class AddStateAndCountryToCity < ActiveRecord::Migration[5.1]
  def change
    add_column :cities, :state, :string
    add_column :cities, :country, :string
  end
end
