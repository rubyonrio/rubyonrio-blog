class AddOldSlugOnPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :old_slug, :string
  end

  def self.down
    remove_column :posts, :old_slug
  end
end
