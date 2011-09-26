class AddCaption < ActiveRecord::Migration
  def up
    add_column :stories, :caption, :text
  end

  def down
    remove_column :stories, :caption
  end
end
