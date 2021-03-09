class Publishing < ApplicationRecord
  has_one_attached :video
  belongs_to :user
  belongs_to :channel
  validates  :title, :status, presence: true
  include PgSearch::Model
  pg_search_scope :search_by_all_publishing_metrics_and_properties,
    against: [ :title, :description, :status, :likes, :views, :shares, :dislikes, :comments, :impressions, :avg_watch_sec, :percent_watch, :scheduled_at, :published_at ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }

end
