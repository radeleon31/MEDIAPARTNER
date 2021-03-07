class ChangeUidInPublishings < ActiveRecord::Migration[6.0]
  def change
    rename_column :publishings, :uid, :youtube_video_id
  end
end
