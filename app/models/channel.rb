class Channel < ApplicationRecord
    validates :uid, presence: true
    belongs_to :user

end
