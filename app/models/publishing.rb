class Publishing < ApplicationRecord
  has_one_attached :video
  belongs_to :user
  validates :video, :title, :description, :status, presence: true

end
