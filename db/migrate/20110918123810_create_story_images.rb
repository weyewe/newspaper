class CreateStoryImages < ActiveRecord::Migration
  def change
    create_table :story_images do |t|
      t.string   :image_type
      t.text     :url
      t.integer  :story_id

      t.timestamps
    end
  end
end
