class Channel < ApplicationRecord
    validates :uid, presence: true
    belongs_to :user
    has_many :publishings, through: :user

end
