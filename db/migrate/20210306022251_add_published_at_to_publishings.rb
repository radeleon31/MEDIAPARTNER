class AddPublishedAtToPublishings < ActiveRecord::Migration[6.0]
  def change
    add_column :publishings, :published_at, :string
  end
end
