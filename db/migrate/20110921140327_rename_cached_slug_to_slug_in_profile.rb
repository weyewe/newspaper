class RenameCachedSlugToSlugInProfile < ActiveRecord::Migration
  def up
    rename_column :profiles, :cached_slug, :slug
    add_index :profiles, :slug, :unique => true
  end

  def down
  end
end
