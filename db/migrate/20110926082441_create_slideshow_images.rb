class CreateSlideshowImages < ActiveRecord::Migration
  def change
    create_table :slideshow_images do |t|
      t.string :image_url
      t.string :caption
      t.integer :story_id 
      
      
      t.timestamps
    end
  end
end
