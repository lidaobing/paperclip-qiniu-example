class AddMetaToImages < ActiveRecord::Migration
  def change
    add_column :images, :file_meta, :text
  end
end
