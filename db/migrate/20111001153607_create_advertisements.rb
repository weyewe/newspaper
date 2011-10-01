class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.integer :category_id
      t.text :content
      t.integer :position
      

      t.timestamps
    end
  end
end
