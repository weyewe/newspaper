class CreateFeaturedStatuses < ActiveRecord::Migration
  def change
    create_table :featured_statuses do |t|
      t.integer :story_id
      t.integer :position 
      t.integer :order 
      t.boolean :is_published , :default => false  # false
      
      t.datetime :update_time, :default => Time.now

      t.timestamps
    end
  end
end
