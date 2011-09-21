class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.text :teaser
      t.text :content
      t.integer :post_status , :default => 0
      t.boolean :processing
      t.string :video_url # most likely, it is gonna be youtube
      # t.string :cached_slug
      
      # user has_many stories
      t.integer :user_id
      # story belongs_to category
      t.integer :category_id 
      t.string   :slug

      t.timestamps
      
      

    end
    
    
    add_index :stories, :slug, :unique => true


  end
end
