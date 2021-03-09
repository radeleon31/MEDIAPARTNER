class AddChannelReferenceToPublishing < ActiveRecord::Migration[6.0]
  def change
    add_reference :publishings, :channel, null: false, foreign_key: true
  end
end
