class AddUserId < ActiveRecord::Migration
  def up
    add_column :profiles, :user_id, :integer 
  end

  def down
    remove_column :profiles, :user_id
  end
end
