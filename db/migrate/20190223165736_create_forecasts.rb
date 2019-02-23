class CreateForecasts < ActiveRecord::Migration[5.1]
  def change
    create_table :forecasts do |t|
      t.string :day_summary
      t.string :week_summary
      t.references :city, foreign_key: true

      t.timestamps
    end
  end
end
