class AddSubscribersToChannels < ActiveRecord::Migration[6.0]
  def change
    add_column :channels, :subscibers, :integer
  end
end
