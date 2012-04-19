class CreatePictures < ActiveRecord::Migration
  def self.up
    create_table :pictures do |t|
      t.references :post
      t.string :description
      t.string :cover_image_uid
      t.string :cover_image_name

      t.timestamps
    end
  end

  def self.down
    drop_table :pictures
  end
end
