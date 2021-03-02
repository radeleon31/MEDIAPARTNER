class CreatePublishings < ActiveRecord::Migration[6.0]
  def change
    create_table :publishings do |t|
      t.string :video
      t.string :title
      t.string :description
      t.string :status
      t.string :uid

      t.timestamps
    end
  end
end
