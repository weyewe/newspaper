class AddAvatarUrlProfile < ActiveRecord::Migration
  def up
    add_column :profiles, :avatar_url , :string
    add_column :profiles, :cropped_avatar_url, :string
  end

  def down
    remove_column :profiles, :avatar_url 
    remove_column :profiles, :cropped_avatar_url
  end
end
