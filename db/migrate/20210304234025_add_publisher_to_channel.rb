class AddPublisherToChannel < ActiveRecord::Migration[6.0]
  def change
     add_reference :publishings, :channels, foreign_key: true
  end
end
