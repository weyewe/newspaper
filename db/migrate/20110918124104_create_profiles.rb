class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.text :description
      t.string :twitter_url
      t.string :facebook_url
      t.string :linked_in_url
      t.string :cached_slug
      
      t.timestamps
    end
  end
end
