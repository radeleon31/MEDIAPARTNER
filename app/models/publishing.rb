class Publishing < ApplicationRecord

     validates :video, :title, :description, :status, :uid, presence: true

end
