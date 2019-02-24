class CreateBackgroundImages < ActiveRecord::Migration[5.1]
  def change
    create_table :background_images do |t|
      t.string :source
      t.references :city, foreign_key: true

      t.timestamps
    end
  end
end
