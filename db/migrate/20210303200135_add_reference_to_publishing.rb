class AddReferenceToPublishing < ActiveRecord::Migration[6.0]
  def change
    add_reference :publishings, :user, null: false, foreign_key: true
  end
end
