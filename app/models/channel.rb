class Channel < ApplicationRecord
    validates :youtube_channel_id, presence: true
    belongs_to :user
    has_many :publishings, through: :user

end
