class AddUidAndUserReferenceToChannels < ActiveRecord::Migration[6.0]
  def change
    add_column :channels, :uid, :string
    add_reference :channels, :user, null: false, foreign_key: true
  end
end
