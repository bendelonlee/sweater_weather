class CreateBackgroundKeywords < ActiveRecord::Migration[5.1]
  def change
    create_table :background_keywords do |t|
      t.string :word
      
      t.timestamps
    end
  end
end
