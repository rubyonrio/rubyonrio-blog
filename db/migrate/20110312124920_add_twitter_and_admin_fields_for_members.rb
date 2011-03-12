class AddTwitterAndAdminFieldsForMembers < ActiveRecord::Migration
  def self.up
    add_column :members, :twitter, :string
    add_column :members, :admin, :boolean
  end

  def self.down
    remove_column :members, :admin
    remove_column :members, :twitter
  end
end
