class CreateBackgroundTaggings < ActiveRecord::Migration[5.1]
  def change
    create_table :background_taggings do |t|
      t.references :image, index: true
      t.references :keyword, index: true

      t.timestamps
    end

    add_foreign_key :background_taggings, :background_keywords, column: :keyword_id
    add_foreign_key :background_taggings, :background_images, column: :image_id
  end
end
