class AddThumbnailToPublishings < ActiveRecord::Migration[6.0]
  def change
    add_column :publishings, :thumbnail, :string
  end
end
