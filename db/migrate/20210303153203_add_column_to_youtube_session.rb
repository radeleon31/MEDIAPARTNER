class AddColumnToYoutubeSession < ActiveRecord::Migration[6.0]
  def change
    add_reference :youtube_sessions, :user, null: false, foreign_key: true
  end
end
