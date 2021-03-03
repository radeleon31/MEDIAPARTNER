class Publishing < ApplicationRecord
  has_one_attached :video
  validates :video, :title, :description, :status, :uid, presence: true

end
