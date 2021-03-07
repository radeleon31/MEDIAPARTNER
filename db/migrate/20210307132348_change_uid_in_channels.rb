class ChangeUidInChannels < ActiveRecord::Migration[6.0]
  def change
    rename_column :channels, :uid, :youtube_channel_id
  end
end
