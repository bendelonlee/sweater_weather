class CreateDayWeathers < ActiveRecord::Migration[5.1]
  def change
    create_table :day_weathers do |t|
      t.string :icon
      t.string :summary
      t.datetime :time
      t.decimal :tempurature
      t.decimal :feels_like
      t.decimal :humidity
      t.decimal :visibility
      t.integer :uv_index

      t.timestamps
    end
  end
end
