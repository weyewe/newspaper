class AddShortDescriptionProfile < ActiveRecord::Migration
  def up
    add_column :profiles, :short_description, :string 
  end

  def down
    remove_column :profiles, :short_description
  end
end
