class Channel < ApplicationRecord
    validates :youtube_channel_id, presence: true
    belongs_to :user
    has_many :publishings, through: :user

    include PgSearch::Model
    pg_search_scope :search_by_all_publishing_channel_and_properties,
    against: [ :title, :description, :status, :likes, :views, :shares, :dislikes, :comments, :impressions, :avg_watch_sec, :percent_watch, :scheduled_at, :published_at ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }

end
